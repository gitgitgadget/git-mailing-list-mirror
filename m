Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B7C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A9764F10
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhCDVE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:04:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58629 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhCDVEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 16:04:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CF11974E6;
        Thu,  4 Mar 2021 16:03:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BzR9mVotBhF4490XGM/R3uoA23E=; b=fo/N9S
        Ow152gtG6kjaVZp/+FT6VbqMIMLytq8KaHjvAH8AMkEUFWRASZddnXK9ofFNBe9V
        OVtKmF3tdpccN2sokS8Zc7Uw6Hn7EhrPkbBJrI8x8eOhAYZjh1F5ByJ5K8cAnlCB
        XFGylnPcRXtHMfWFXTxc3sS8/O5V2wS1lc+zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HaT7WShogeY3ev+x1R1dh69L088Ce8/v
        /E7sL+huV28mTCdj3XlyFUQlOtQMPCRW825yYr25eEShz3+sbdVAAuQsCj8EGVGy
        5+XJBBW/xTOLS1iOWBq2n7NGSYsp/k8EqJnSf/hj9vlZXW6HOyH6dZW2Lm36vxRy
        IuL+5VP0lu0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32B9D974E5;
        Thu,  4 Mar 2021 16:03:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB4B3974E1;
        Thu,  4 Mar 2021 16:03:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches
 SKIP_WORKTREE entries
References: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
        <20210304152315.18498-1-matheus.bernardino@usp.br>
        <CABPp-BE9QA5RAwdebmAyK3b3wh1mGE+NF7sPS5RCf4FogYBV7A@mail.gmail.com>
Date:   Thu, 04 Mar 2021 13:03:53 -0800
In-Reply-To: <CABPp-BE9QA5RAwdebmAyK3b3wh1mGE+NF7sPS5RCf4FogYBV7A@mail.gmail.com>
        (Elijah Newren's message of "Thu, 4 Mar 2021 09:21:48 -0800")
Message-ID: <xmqq5z26eime.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2118B7FE-7D2D-11EB-A3B9-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I think it's kind of lame that git-add won't provide a warning for
> ignored files when the match is via glob/pattern; if git-add didn't
> end up adding anything, but an ignored file was matched, I think a
> warning is appropriate.

I am not so sure.  When I have this in my exclude list:

	tmp-*

and have this file in the working tree:

	tmp-000.txt

I am not sure if I want to see any such warning when I did

	$ git add "*.txt"

After all, I said that I never would want to worry about anything
that begins with "tmp-".  It would be a totally different issue if I
did

	$ git add tmp-000.txt

as I am contermanding my previous wish and saying that I care about
this particular file, even if its name begins with "tmp-".

So far, the flow of logic is simple, clear and straight-forward.

BUT.

What makes the whole thing tricky is that people don't do

	$ git add "*.txt"

The instead do

	$ git add *.txt

and "git add" cannot tell if the tmp-000.txt it sees is what the
user meant, or what the shell expanded.

If there were no shell glob expansion, then "warn only if a
glob/pattern did not match any" would have been an attractive
option, especially when we had another file in the working tree,
say, hello.txt, next to the tmp-000.txt.  Then

	$ git add "*.txt"

would add only hello.txt, and we won't see a warning about
tmp-000.txt.  But end-users will use shell expansion, i.e.

	$ git add *.txt

(1) warning against tmp-000.txt because the command line named it
    explicitly (from "git add"'s point of view, but never from the
    user's point of view) would be a disaster.  I think that is why
    your suggestion was "if git-add did not add anything then warn".
    but ...

(2) not warning, because the command line named hello.txt as well,
    i.e. "git add" added something, would make it inconsistent.
    Whether there is another file whose name ends with .txt, what
    the user typed (i.e. *.txt) to the command line is the same, and
    the exclude pattern (i.e. tmp-*) is the same, but the presence
    of an unrelated hello.txt affects if a warning is given for
    tmp-000.txt.

So, I dunno.
