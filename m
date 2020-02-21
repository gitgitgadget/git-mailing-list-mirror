Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A03C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530C424656
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 01:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTFrwlwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgBUBso (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:48:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63607 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUBso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 20:48:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A4A448F48;
        Thu, 20 Feb 2020 20:48:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C2qqNKn+mptulSHCw0munIivn7o=; b=pTFrwl
        wjUzs8OdbxwzlpDj18a2zjPwfqdoPlg9KEx32pAgx+webZ4j10zZup0GDqwZSYqJ
        WPqMMndmd+xRGpEog3uQ6afo52vHqr7M6wMv8XBHSfG4dIwgrj5RA0g3ke+QszR/
        uGU3R5+Bcm1SfmYFtXoTtP/4S06EhP4P1sR7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=megHrP51KlcEgxID2Wviufz0rEEw6IZY
        nhva5GPL856T0RZZL71pRlmnAUvjge880NoiDM7Z3fiMKySQ2Zh4cgOh2is15TP9
        3egpxL6zJnVzBNWaOG2/kt1r7GqpMhiw8a999/54wsZLkYDpCM/obIFTGqV9klFd
        qsreLSLj7cM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F344D48F47;
        Thu, 20 Feb 2020 20:48:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D47248F46;
        Thu, 20 Feb 2020 20:48:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Adam Milazzo <Adam.Milazzo@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: BUG: git clean -d cannot remove files from read-only directories
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
        <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        <CABPp-BFwNMTRUUonbt3Di8yWDjyF7n2cNQVoLDfHEsk3RVEchQ@mail.gmail.com>
Date:   Thu, 20 Feb 2020 17:48:40 -0800
In-Reply-To: <CABPp-BFwNMTRUUonbt3Di8yWDjyF7n2cNQVoLDfHEsk3RVEchQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 20 Feb 2020 15:13:33 -0800")
Message-ID: <xmqq36b490cn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 495D31E6-544C-11EA-B78B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> should be and what it should do.  Your "put the repository back to a
> pristine state" isn't enough to really go on from an implementation.

Yeah, where does this "pristine state" come from?  Do we need to fix
the "git clean" documentation to reduce such a confusion (I didn't
check to see if the current text is prone to be misunderstood as
such yet).  "git clean" is to remove crufts, isn't it?  The
definition of "cruft" being untracked junk that are marked
expendable (aka "ignored")?  And it is not "remove crurfts no matter
what".

> angle from my previous response in what you've addressed here.  Let's
> say we did implement a new flag that said we should override standard
> permissions.  In such a case, shouldn't ACLs also be overridden?  ...
> what point do we give up?  What's the clear line...and why does that
> line not just get drawn at not changing permissions at all?

Yup.  Elsewhere in the thread you gave "rm -fr" not removing an
unwritable subdirectory, and that shows where others before us drew
the line that has been accepted by the end users.

> I'm sympathetic to "golang does a dumb thing I don't like" (the exact
> situation you hilight has bothered me before too), but it's not clear
> at all to me where or how git might help you cope with that.  To me,
> golang did a dumb and you have to manually undo the dumb.  If you want
> something smarter on the git side instead of the golang side, all the
> stuff I mentioned above are things that would need to be addressed in
> any possible solution that I'm just not seeing.

Amen.
