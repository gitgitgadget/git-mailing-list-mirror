Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E5C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 08:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiCNIGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiCNIEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 04:04:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616D141FB1
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:02:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h13so18573692ede.5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gxyDdpK/iBocEHKpx3NYHX4oOxuCujbrxgk+pBr63cQ=;
        b=itSQN4oc1nv3nx9Iqjca212pTiBOo23SMR2mE49ym7V4ap32V1Nc0aOoS/yJ3aA9su
         whW2D++GO5saiFPOkdRI+u91nLVX+v+aP+Oc7Iz0frLqoiZiZ0uPZo6ofu0q78Sp16OQ
         xMU3faGjYASI5LUrr2aAXkzI/SMNLlKl0G197OxGVywt2yNGKaRuk+IPuR/YsoOuxbkl
         sFw1v821GhLMaoOV8SLE6VjerYff1L2STYmdH0A0QsqsK9Lyq2+ob4/5Qj1Hf8YGZocE
         AtavNygW1abH0TEtDrw5dRIOMPJHYQ3U+GhH4jeBoCn5e3uZs7Skeyjq7XvcODIM5pTm
         deqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gxyDdpK/iBocEHKpx3NYHX4oOxuCujbrxgk+pBr63cQ=;
        b=YI3XPWDDieweVDhwVjYLaWx1v6LpMi8QE4ne/jnKIsA3iy5UazQwE+9j/ky/UzKPlN
         kjBNyJNZcD2jznz1QGBI3MktOMYqMSLtELLT7TC68gpazCQ+Or1rdWSg+vqQ8Pr7yI0w
         soL13knuKxVIVhAEEg8rX9eWLbpu/sQGFKWaKS9/cLViVuiJi2a+daCyiuX9bqK3R7kD
         YX2KAY/EOG/LJWKoLvtfOFRZumqKxIFMpuvrSpHUxb+QzkrLTnsYNZtNGiFRZy4mgAfR
         Zn7l0G6Rfh55spYzgn/R0e7iiCza5Imr9js8MahAQI1faasHPqhuNokyFeRWwjSnoHPr
         ioyw==
X-Gm-Message-State: AOAM533TEp9HEyAnj//uK1qw90CkmzyA7Jkb6ElwMU3jv1P04CEVL+Jf
        qjct5xq/6ntNmSY6R+vDoowMPtTac7k=
X-Google-Smtp-Source: ABdhPJx2m2uh8plpvrUgDAs/mnJetX+QVmNkgQUv0yiw/5QehOQ6EpuVgYFjx566O3M7o2YOymah+w==
X-Received: by 2002:a05:6402:3589:b0:416:7de7:cdde with SMTP id y9-20020a056402358900b004167de7cddemr19453475edc.218.1647244893004;
        Mon, 14 Mar 2022 01:01:33 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lb14-20020a170907784e00b006d5c0baa503sm6380967ejc.110.2022.03.14.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:01:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nTfdz-000Ixp-Gn;
        Mon, 14 Mar 2022 09:01:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 05/16] fsmonitor--daemon: refactor cookie handling for
 readability
Date:   Mon, 14 Mar 2022 09:00:36 +0100
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <84df95be620c76afed73d1679722459e2ff32018.1647033303.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <84df95be620c76afed73d1679722459e2ff32018.1647033303.git.gitgitgadget@gmail.com>
Message-ID: <220314.86bky9ezdw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 11 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! fsmonitor--daemon: use a cookie file to sync with file system
>
> Use implicit definitions for FCIR_ enum values.
>
> Remove const from cookie->name.
>
> Reverse if then and else branches around open() to ease readability.
>
> Document that we don't care about errors from close() and unlink().
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/fsmonitor--daemon.c | 53 +++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 97ca2a356e5..02a99ce98a2 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -109,14 +109,14 @@ static int do_as_client__status(void)
>  
>  enum fsmonitor_cookie_item_result {
>  	FCIR_ERROR = -1, /* could not create cookie file ? */
> -	FCIR_INIT = 0,
> +	FCIR_INIT,
>  	FCIR_SEEN,
>  	FCIR_ABORT,
>  };
>  
>  struct fsmonitor_cookie_item {
>  	struct hashmap_entry entry;
> -	const char *name;
> +	char *name;
>  	enum fsmonitor_cookie_item_result result;
>  };
>  
> @@ -166,37 +166,44 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
>  	 * that the listener thread has seen it.
>  	 */
>  	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
> -	if (fd >= 0) {
> -		close(fd);
> -		unlink(cookie_pathname.buf);
> -
> -		/*
> -		 * Technically, this is an infinite wait (well, unless another
> -		 * thread sends us an abort).  I'd like to change this to
> -		 * use `pthread_cond_timedwait()` and return an error/timeout
> -		 * and let the caller do the trivial response thing, but we
> -		 * don't have that routine in our thread-utils.
> -		 *
> -		 * After extensive beta testing I'm not really worried about
> -		 * this.  Also note that the above open() and unlink() calls
> -		 * will cause at least two FS events on that path, so the odds
> -		 * of getting stuck are pretty slim.
> -		 */
> -		while (cookie->result == FCIR_INIT)
> -			pthread_cond_wait(&state->cookies_cond,
> -					  &state->main_lock);
> -	} else {
> +	if (fd < 0) {
>  		error_errno(_("could not create fsmonitor cookie '%s'"),
>  			    cookie->name);
>  
>  		cookie->result = FCIR_ERROR;
> +		goto done;
>  	}
>  
> +	/*
> +	 * Technically, close() and unlink() can fail, but we don't
> +	 * care here.  We only created the file to trigger a watch
> +	 * event from the FS to know that when we're up to date.
> +	 */
> +	close(fd);

It still seems odd to explicitly want to ignore close() return values.

I realize that we do in (too many) existing places, but why wouldn't we
want to e.g. catch an I/O error here early?
