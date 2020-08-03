Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ABC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0660B22B45
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 20:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ywh95P5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCUHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:07:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64441 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCUHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 16:07:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5997D84D7C;
        Mon,  3 Aug 2020 16:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDIEPdaA1sdglZFbAEqYupsKapw=; b=Ywh95P
        5x20ARFMdEPCJyTvf9KgyJFmxSZGZd/2ad3P8d2XkwmZoISiIoM8zcfkVMmJJTy5
        ePiYYbh8ASy+s4+v3lX1BdC1TQKMJUcoOJY+6IKAArypcms+bwSBpznxAZ7C+pm7
        tEPalr0asNvylDXdRcHoqOcoz/R2dvUvIoO2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hI3CFu6sJoAuAZCn1Ac8BJWBJpFFEgeW
        KhKC+ykeKKB3QTtcTMPNDkJ84m8tzGWZ54shnglj05RV07YxSENlNjZcssc0fFCU
        c49V7A8AHI/lQJoQ3y87JF4DTlP4NVFYnT1K61qxpBCTugZ1K/dU3So0guubszwD
        LotmLCkYuE0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 514AC84D7B;
        Mon,  3 Aug 2020 16:07:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8A0084D7A;
        Mon,  3 Aug 2020 16:07:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
        <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
        <xmqqpn8hgca7.fsf@gitster.c.googlers.com>
        <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
Date:   Mon, 03 Aug 2020 13:07:12 -0700
In-Reply-To: <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 3 Aug 2020 21:07:18 +0200")
Message-ID: <xmqqh7tjv6hb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB785C90-D5C4-11EA-8B6D-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> >> As the file is quite different from all the other pseudo references
>> >> in that it needs to store more than one object name and in that each
>> >> ref in it needs more than just the object name, I doubt that it
>> >> makes much sense to enhance the refs API so that its requirements
>> >> can be covered.
>> >
>> > I agree. Do we ever pretend that FETCH_HEAD is a ref today?
>>
>> "git rev-parse FETCH_HEAD", "git show FETCH_HEAD" etc. all should keep
>> working, so in that sense, it is treated as a ref.
>
> I added this to the last version of the full reftable patch series
> that I posted, as patches
> "Split off reading loose ref data in separate function" and "Read
> FETCH_HEAD as loose ref".
>
> Which other refs that aren't really refs should also be supported? The
> JGit source code suggests that MERGE_HEAD should also be special
> cased?

I'd think all .git/${SOMETHING}_HEAD are of transitory nature that
can be left as simple on-disk files that are read (and preferrably
written---except for FETCH_HEAD for obvious reasons) as if they are
loose refs handled by files backend.  It probably makes sense not to
even write reflog entries for them---it is not like the MERGE_HEAD
I see now in .git/ directory is an updated version of MERGE_HEAD I
had there yesterday. "git log -g MERGE_HEAD" gives no interesting
information.

>> "git merge FETCH_HEAD" is an interesting case---I haven't thought it
>> through.
>>
>> What should happen after "git pull origin foo bar" attempts to grab
>> two branches and make an octopus merge into the branch currently
>> checked out, and then "git reset --hard && git merge FETCH_HEAD" is
>> given?
>
> I don't understand this question.

The request "git pull origin foo bar" is "grab the tip of 'foo' and
'bar' branches from remote whose name is 'origin'; merge these two
commits into the commit that I have checked out".

To fulfill the request, "git pull" runs "git fetch", and the latter
leaves two lines of interest in .git/FETCH_HEAD file.  Each line
lists the name of the object at the ref, an optional "not-for-merge"
token (which in this case does not exist, as both records are for
merging), and piece of human-readable text to describe where that
object came from to help later step that computes the default
message for the resulting merge commit.

If the octopus merge does not finish correctly (e.g. due to
conflicts), with "git reset --hard", we can recover to the original
state and re-attempt the opeation with "git merge FETCH_HEAD".  Such
a merge using FETCH_HEAD will produce an octopus merge.

Which means that at least "git merge", FETCH_HEAD is not just a
regular ref where you can ask what object it points at and it gives
you a single object name back.

But to other commands like "git log master..FETCH_HEAD", it acts as
if there is only one object recorded.  That makes it an interesting
case.  Making it act as if "git log ^master origin/foo origin/bar"
were given might be a "bugfix" to make it behave more "correctly",
but I do not know how large a fallout such a change brings in.



