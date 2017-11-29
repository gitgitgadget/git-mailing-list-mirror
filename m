Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5232020C11
	for <e@80x24.org>; Wed, 29 Nov 2017 06:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdK2GrH (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 01:47:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59891 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751054AbdK2GrG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 01:47:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7996FB4382;
        Wed, 29 Nov 2017 01:47:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T9K0YqTZ2bbjGkL3PIy5WnwTTA4=; b=GnBlhL
        ckXCTZU2yh2bwomdSqRQea2NFD/aJMXP594NfGhmUS5BK1LxNrbbGve8Cd2syAwY
        6VSsDLvHqckREQob+HyMdmKJD0B9ez4QobctZ3tIrMbLi9kzh+9l3V6LVQYA4NNO
        GcYkOMfG6S5uYN3b9nejt3jv4fql3n1PaSIno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DDuj1G/klpYZkNAaIDI0+STiwtcIKxq/
        AIliNDKUNi0c5le5IsCI+mEDiqjsFbzOjfjIlLgVkiP3yLpYKbnoVawNiUmrBlTS
        ZAbfmK9LmEmxfUpnjCWFGBHDmjfjwVq7EtRU5XZt74VhkKAj1GYIU2P7ZU2oilvV
        QonsRBYXWwU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 718E8B4381;
        Wed, 29 Nov 2017 01:47:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2371B4380;
        Wed, 29 Nov 2017 01:47:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] rebase: give precise error message
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
        <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
        <xmqqpo8387hz.fsf@gitster.mtv.corp.google.com>
        <1511877882.10193.2.camel@gmail.com>
        <xmqqzi7654hx.fsf@gitster.mtv.corp.google.com>
        <1511925118.2486.2.camel@gmail.com>
Date:   Wed, 29 Nov 2017 15:47:03 +0900
In-Reply-To: <1511925118.2486.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 29 Nov 2017 08:41:58 +0530")
Message-ID: <xmqqshcx4m54.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C7EA5E4-D4D1-11E7-8ABE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

>> I do not think the above is a good change in the first place for at
>> least two reasons.  By saying <ref>, the updated text says "not just
>> branches but you can also give tags and remote-tracking branches".
>
> I used <ref> as you could actually use tags, remote-tracking branches
> and even "notes" ...
> ...
> It just works (of course, I couldn't understand what it did)! I didn't
> want to lie to the user. So, I used <ref>. So, should we just update
> the <branch> part of the doc or should we update the code for 'rebase'?
> I'm unsure.

By saying <ref>, you are not covering these cases

	git rebase master HEAD^0
	git rebase master pu^2

where the command gets non refs.

Most of the time, people use a <branch>, and rare cases like these
what a user can give is not restricted to a <ref>, so there is *no*
value in replacing <branch> with <ref>.  If we needed to replace it
with something, replacing <branch> with [<branch> | <commit-ish>] is
not wrong per-se, but I do not think it is an improvement.

As <branch> is merely a kind of <commit-ish>, it may be tempting to
instead replace <branch> with <commit-ish>, but I do not think it is
a good idea, either.  No matter what you write there in the synopsis
(and let's call it X), the description would have to say "when X is
the name of a branch, that branch is checked out, its history gets
rebased, and at the end, the tip of that branch points at the
result.  When X is not a branch but just a commit-ish, the HEAD is
detached at that commit, its history gets rebased and you'll be left
in that state".  Having <branch> in that sentence is clear enough
and any intelligent reader would understand what we mean by that
notation: we are showing there can be various things that can come
on the command line depicted in the SYNOPSIS section at the point
where we have a placeholder called <branch>, and the argument does
not necessarily have to be the name of a branch.


