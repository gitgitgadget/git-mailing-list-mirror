Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE2C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E9611C4
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhKFL1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFL1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 07:27:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81423C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 04:24:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y196so9130869wmc.3
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlW12D7ddIZnH3xQ0Ej8Ps/OshPo43onWHQr+YGH8O8=;
        b=dJ1UUy7HssIES3XtSiNqsHYXx1Gr6LSokvUT91L59Tis4HLD+KWbwHGuKCIosg7aUW
         GvIFqrsqeUSDChOh7/fdoT6qzvrY0YSExtnmuLFZW5T1uanRqCntPLYZd9qcFv3BzS6/
         O2PApeTZhy4q1IOqJwW5yLYR61MiEb1OaoGLHp9HDWrMrcNjGXx4JSriwKz2RU6b1bzY
         6qN1k76RGtvKV00Dk5fzf32a7+FzgIT1LSLH6bZmoHr4xer2rOYUukdxjXUQGTuzLeai
         EFfe6z9Nt0WG9jdHQvwJn4lV7rJsqnuLoCikve0uQX1dlR4qvt6oAVWapU5OcYVkbM3c
         LzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlW12D7ddIZnH3xQ0Ej8Ps/OshPo43onWHQr+YGH8O8=;
        b=MIWth1plB3a1NttRqariUxFWzh8jk3minTJaVkD81fXIhP5qLkoox1vOjvR+XpziRG
         H+jYVZmjTLqbtYgNljOqfSZYDaCgCiOu5W/cg+/88ZVZPtNJoS2K3wP8iCqm6uRCIHUV
         ybHGL3kkteakxJwtQn+ffkAgKCndpYayUEblevcEMkZ5gxdTT0n4yUjFEoKA4EQIxekq
         1i8MQzvc52TezjJIHk57eG5HxKl4YPeeVaPcc65oQjzPTE5q2mALXOAoOC2xbWKY1GHl
         XvJGSE+grLgjqpOhKn0wH7+cIEBaESlEp///zbQ5gR0TmB6Ov7JzDCyYUQ3xq+ccGwSS
         iWxw==
X-Gm-Message-State: AOAM5308l2dzvavjWMp+voEcmvm33ItwLhqI8YyOs2maaddD527RM811
        tpOIE2a1/np2K+77JIbv161ccNoQtUlElg==
X-Google-Smtp-Source: ABdhPJwywPkNJqpwxwJ0Ei51Orfudp1GFCoAac06X+7tpx+qtZgbDZUmlMJIXL2GGmq0WT4sUm+vXw==
X-Received: by 2002:a05:600c:1c8d:: with SMTP id k13mr34457529wms.177.1636197882123;
        Sat, 06 Nov 2021 04:24:42 -0700 (PDT)
Received: from gmail.com (62-47-8-237.adsl.highway.telekom.at. [62.47.8.237])
        by smtp.gmail.com with ESMTPSA id y6sm11108361wrh.18.2021.11.06.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:24:41 -0700 (PDT)
Date:   Sat, 6 Nov 2021 12:24:39 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rhodges@cisco.com, git@vger.kernel.org, rphodges@gmail.com
Subject: Re: Re* [PATCH v2] apply: make --intent-to-add not stomp index
Message-ID: <20211106112439.iw7asj4bq6uwcb3l@gmail.com>
References: <20211030204155.2500624-1-aclopte@gmail.com>
 <20211030205147.2503327-1-aclopte@gmail.com>
 <xmqqr1c0cray.fsf@gitster.g>
 <xmqqfssgcq1b.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfssgcq1b.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 12:07:28AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Can you study the code to decide if check_apply_state() is the right
> > place to do this instead?  I have this feeling that the following
> > bit in the function
> >
> > 	if (state->ita_only && (state->check_index || is_not_gitdir))
> > 		state->ita_only = 0;
> >
> > is simply _wrong_ to silently drop the ita_only bit when not in a
> > repository, or other index-touching options are in effect.  Rather,
> > I wonder if it should look more like the attached (the other parts
> > of the implementation of ita_only may be depending on the buggy
> > construct, which might result in other breakages if we did this
> > alone, though).
> 
> All the existing tests and your new test seem to pass with the "-N
> should imply --index" fix.  It could merely be an indication that
> our test coverage is horrible, but I _think_ the intent of "-N" is
> to behave like "--index" does, but handle creation part slightly
> differently.
> 
> Of course there is another possible interpretation for "-N", which
> is to behave unlike "--index" and touch _only_ the working tree
> files, but creations are recorded as if "git add -N" were run for
> new paths after such a "working tree only" application was done.
> 
> I cannot tell if that is what you wanted to implement; the new test
> in your patch seems to pass with the first interpretation.

I'm still not entirely sure, but the ita-implies-check_index seems simpler
overall, which is a good sign.
It will prevent "apply -N" from modifying untracked files, which seems like
a good safety measure.

> 
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] apply: --intent-to-add should imply --index
> 
> Otherwise we do not read the current index, and more importantly, we
> do not check with the current index, losing all the safety.

(The i-t-a bit should only trigger for added files, so a correct implementation
would preserve the index for all other entries.)

> 
> And the worst part of the story is that we still write the result
> out to the index, which loses all the files that are not mentioned
> in the incoming patch.
> 
> Reported-by: Ryan Hodges <rhodges@cisco.com>
> Test-by: Johannes Altmanninger <aclopte@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  apply.c               | 4 ++--
>  t/t2203-add-intent.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 43a0aebf4e..887465347b 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -146,6 +146,8 @@ int check_apply_state(struct apply_state *state, int force_apply)
>  	}
>  	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
>  		state->apply = 0;
> +	if (state->ita_only)
> +		state->check_index = 1;
>  	if (state->check_index && is_not_gitdir)
>  		return error(_("--index outside a repository"));
>  	if (state->cached) {
> @@ -153,8 +155,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
>  			return error(_("--cached outside a repository"));
>  		state->check_index = 1;
>  	}
> -	if (state->ita_only && (state->check_index || is_not_gitdir))
> -		state->ita_only = 0;

As you suspected earlier, adding "ita_only implies check_index" alone will
break the test case below, because other places assume
"ita_only implies none of --cached/--index/--threeway was given"

test_expect_success 'apply --index --intent-to-add ignores --intent-to-add, so it does not set i-t-a bit of touched file' '
	echo >file &&
	git add file &&
	git apply --index --intent-to-add <<-EOF &&
	diff --git a/file b/file
	deleted file mode 100644
	index f00c965..7e91ed5 100644
	--- a/file
	+++ /dev/null
	@@ -1 +0,0 @@
	-
	EOF
	git ls-files file >actual &&
	test_must_be_empty actual
'

A fix would be to say
"ita_only implies check_index, except if one of its older siblings is present"

	if (state->check_index)
		state->ita_only = 0;
	if (state->ita_only)
		state->check_index = 1;

This matches the documentation of git-apply, and puts ita_only in its place
as early as possible.

>  	if (state->check_index)
>  		state->unsafe_paths = 0;
>  
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index cf0175ad6e..035ce3a2b9 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -307,7 +307,7 @@ test_expect_success 'apply --intent-to-add' '
>  	grep "new file" expected &&
>  	git reset --hard &&
>  	git apply --intent-to-add expected &&
> -	git diff >actual &&
> +	(git diff && git diff --cached) >actual &&
>  	test_cmp expected actual
>  '
>  
> -- 
> 2.34.0-rc0-136-gecf67dd964
> 
