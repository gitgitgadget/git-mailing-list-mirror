Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD8C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF9122AAA
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgLXWV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:21:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51509 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLXWV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 17:21:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE60FA207A;
        Thu, 24 Dec 2020 17:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tkgObC+OluVTYbT8RnEcmhTEfN4=; b=BRcuop
        HQTq3qCsg/H4sF1JCiqoDl1jFZYAHr3njId4eJVUvSjTRGjy5sOusTZWAaOoPrBW
        TjUNNdih5mLbHMGfCtk79F1rE2IcaJ39Ojsnrk8OfLYgibRkLC0PXbFo83j+88cj
        KPhUDIEdShY73Yf8KeDtZq2UqCb2X+EeABKqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ehHPuVcZqj+vZJeNLrpi+oQ5+0KJMrQB
        OW9Zb2HQb9xb/UvdF2dHsnEYYzh3Dajbo0LisOHElOJdBIXnF8eluW5UxuJ+ey96
        pajIPs+VgyiGvLSuaJO9Pp56Ur4BkCwD7iEJ+NUKsMF9qw/Fy5nfN2trsyuTodKi
        +VLT+STg50w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E663AA2079;
        Thu, 24 Dec 2020 17:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70DABA2078;
        Thu, 24 Dec 2020 17:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
        <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
        <xmqqczz05b4x.fsf@gitster.c.googlers.com>
        <CAM0jFOfSE3_TQ7WXiR_G6eHOZnr-0ryv=CniXs4sxs1=JnucUg@mail.gmail.com>
        <ab835195-0c69-830b-c7cb-71d50b4ce4db@kdbg.org>
Date:   Thu, 24 Dec 2020 14:21:11 -0800
In-Reply-To: <ab835195-0c69-830b-c7cb-71d50b4ce4db@kdbg.org> (Johannes Sixt's
        message of "Thu, 24 Dec 2020 10:16:00 +0100")
Message-ID: <xmqq8s9m3kx4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 548030E6-4636-11EB-AE35-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> But consider a situation like this, which I find myself in regularly:
>
>     $ work
>     $ git commit -m "WIP begin feature"
>     $ work -- ah, this can be done independently:
>     $ git commit -m "refactor stuff"
>     $ do the real feature (takes time, many commits)
>     # finally:
>     $ git commit -m "the real feature"
>
> Here I wish that the final commit carries an author date that should be
> after the "refactor" commit to be realistic. But 'squash' takes
> authorship including the date from the first commit (the "WIP" commit in
> this example). That is where the suggested feature could help. I admit,
> though, that it's not a huge deal.

Yeah, I actually find that an interesting scenario.

In such a workflow, you'd want to view all the previous steps
building pieces as preparing for the final step that makes the
cumulative effort into presentable whole.  Whether you want to use
the log message only from the last step or want to use the "squash"
to collect pieces from all the WIP commits, you would want the other
aspects of the resulting single commit to be more similar to the
final one rather than the earlier one(s), as if you did something
like "commit --reset-author --amend" (yes, I am including the case
where the work on the branch was a team effort and the one that
collects them into a single resulting commit would become the
"corresponding author").

I wonder if we deliberately designed how each insn you can write in
the todo list should come up with the authorship data (i.e. ident
and timestamp), or if we are just using the natural consequence of
how the implementation happens to work?  I think it makes sense for
"fixup", as an instruction used to make a small tweak to the bulk of
work you've done some time ago, to use the authorship information of
the original commit that gets fixed up. I don't know offhand what
other insns like "edit", "reword", etc. do, and if there is a room
to improve them.

