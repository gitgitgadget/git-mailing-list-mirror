Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F97C432C3
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BBB2075C
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o9BfWUqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfK3R6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:58:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56963 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfK3R6U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 12:58:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29F879BC95;
        Sat, 30 Nov 2019 12:58:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5NxN2UGwa1DyQtg9JnPDHmwWiE=; b=o9BfWU
        qEiTZmioxniKo/iIKG487zepk3gA0SyuAw8PUy44nmfeVDricrkwbEpxoAhbj9Cq
        BGYGatxyRXevN/aGv9FpnQy28YgJi9e3gHRrILFoI0rZJbBR1F4Y+XqND48PDZTm
        m9CSL+lFZZ6SCPbfRbGlaWLSNfVLXDihA2FUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nRZWsV2/+lGi8d5odxNW8tWhY9bxU0jm
        1XBh687XeS5Jy+iALV+l9JO8zSnNItu4EqpaV+WWIkoEOroapR9dl+3r1yQUeZGa
        lv82jT6H0Dmqk6CV4FV0gTB2+AOpFPyfjvv5j0sMCOiru1BgoyU+crfbDeXLH2ma
        TNYJQVUvBY8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16D159BC94;
        Sat, 30 Nov 2019 12:58:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D552E9BC93;
        Sat, 30 Nov 2019 12:58:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Pavel Roskin <plroskin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-rebase produces incorrect output
References: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
        <CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com>
Date:   Sat, 30 Nov 2019 09:58:11 -0800
In-Reply-To: <CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com>
        (Elijah Newren's message of "Fri, 29 Nov 2019 20:22:37 -0800")
Message-ID: <xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA9FC862-139A-11EA-A602-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Sadly, I tried to force this with git rebase, but -C5 only affected
> the apply side and there's no option to pass to rebase to pass through
> -U5 to the diff logic.  Also, although there is a diff.context config
> option, git-am ignores it (Note that git_am_config() does not directly
> check that value and it calls git_default_config(), not
> git_diff_ui_config() or even git_diff_basic_config()).

Not essential but puzzled.  The context applies to the generation
side, not acceptance side, no?  IOW, I suspect that you are talking
about "git format-patch" that sits on the upstream side of the pipe
that feeds "git am".

> So, to summarize here:
>   * you have a case where the default 3 lines of context mess stuff
> up; but rebase --merge works great
>   * am doesn't have a -U option, and ignores the diff.context setting,
> making it impossible to force the am backend to work on your case
> and also:

I do not think it is super hard to teach "git rebase" to pass
backend specific options so that "git rebase--am" can be told to
work with wider context (which will reduce the risk of ambiguous
patch like this example, trading the increased risk of unnecessary
conflicts; it is a good trade-off most of the time for added safety,
as nobody wants a system that produces a wrong result silently and
quickly).

Having said that,

>   * rebase doesn't have an option to use the merge/interactive backend
> by default (nor an --am option to override it)

I think addition of rebase.backend would be a good first step for
eventually flipping the default, which by the way I have no trouble
with.

> Maybe we should just switch the default, for everyone?  (And provide
> an --am option to override it and a config setting to get the old
> default?)

Yes, that would be a sensible second step.  I actually think a
longer term goal is to deprecate the am backend.  It was invented
first and then kept to be the default backend for a long time
because the merge based backend historically has been noticeably
slow (it was expected to be---it was essentially a shell script that
run cherry-pick repeatedly in a loop).  In some future, it would
outlive its usefulness, and that I think that that future is just
around the corner.


