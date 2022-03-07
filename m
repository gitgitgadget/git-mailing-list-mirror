Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0074C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiCGLcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiCGLcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:32:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB49105
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 03:24:38 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p15so31166133ejc.7
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Q/kJWlTUl6MlBfPWQldnQiUo0hThlXyourRzN4fgGdY=;
        b=Cz9Gm1AMLhLCY6YU64NH2ebpbfZUSMGJhxsyWP5qHxHJh8D2FSC9t13RtZ8hu5Xppq
         lHg3x1skpDuT+68i2iUgsgs05tLXi6Wselb+yudYOrwrL8GvXdSVu4fdGK4MpVgE5Lfg
         FOxVFZulE28CFXr2OFE+YMv73eA8XSGKY71Pzrdy8pevKgqZzbAuEvpNLhRGC6rnwGXZ
         +BqafrAJWZM6iCyg+q32yqfkeW/kkUgeQ1zNpWH+AdnhvadTM40SeEQ6OA2JwglmsnUV
         mDC8LewyrglM8K9VwBSjthDJddl+AgfRjAk2NmYLcDFMVMhAGJ0IqASC6K1w8LE3Gtwy
         bxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Q/kJWlTUl6MlBfPWQldnQiUo0hThlXyourRzN4fgGdY=;
        b=1lA7JgrU4RuwwNjPCIFOBndiqfMUjOItejKDEDBpwpxbwTJPVseGHz1UIKvJtoVCa3
         Pm2AuOVQXUr7jyRU1cS14fe+RuLjiq9fq8vk6afv8tolwqGBq79L2eKcD3cxbDIr9hfU
         5s5/KJvoQV7mDY/EYOHnvtPyMdTp2vQjy/6lEDeab5Qkzp+73Kw1OHt4AyHsdimUf7bW
         9XlBQ5rZzgtJsEZT3FEx4fuLlpe93WMouDFfy7ZLxm61Y8c6FBIVJmsc9TCp/kcdl0u4
         DTT+dkqrgKO/QwPNoM7DPD9aRDok/VSX+wk+E7hrFdqam9xERWXAB/67xaEArqk3s/pV
         OKXQ==
X-Gm-Message-State: AOAM533qXwlnDU4WUhkfnSSrOH10l5P/tXeSC3HigpfbtY94z++A1RiC
        GwDGKl0jZm8S5dtbyNXyLHb8+kOJ0Jw=
X-Google-Smtp-Source: ABdhPJzQJiflpoYmp2KHm4qWuKFtCDrb3Z3hETGGaYZat6FPHL4I/ZVEKR9bIQuUUFiwhKV79OYW3g==
X-Received: by 2002:a17:906:b1d0:b0:6cd:fa02:b427 with SMTP id bv16-20020a170906b1d000b006cdfa02b427mr8679878ejb.99.1646652277103;
        Mon, 07 Mar 2022 03:24:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qt22-20020a170906ecf600b006da6ef9b820sm4632572ejb.112.2022.03.07.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:24:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRBTf-001ReY-5y;
        Mon, 07 Mar 2022 12:24:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 27/30] fsmonitor--daemon: use a cookie file to sync
 with file system
Date:   Mon, 07 Mar 2022 12:15:26 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <5b06eb5d0e60c7d23987d915609c07364e4f7372.1646160213.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5b06eb5d0e60c7d23987d915609c07364e4f7372.1646160213.git.gitgitgadget@gmail.com>
Message-ID: <220307.86r17e0zv0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +enum fsmonitor_cookie_item_result {
> +	FCIR_ERROR = -1, /* could not create cookie file ? */
> +	FCIR_INIT = 0,

nit: redundant = 0 assignment, i.e....

> +	FCIR_SEEN,
> +	FCIR_ABORT,

If we're going to make these implicit (which we usually do) let's do the
same for FCIR_INIT.

> +	strbuf_addf(&cookie_filename, "%i-%i", getpid(), my_cookie_seq);

For trace2 we encoded getpid() in the SID using a fixed-width encoding
format, maybe do the same here?

> +	/*
> +	 * Create the cookie file on disk and then wait for a notification
> +	 * that the listener thread has seen it.
> +	 */
> +	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
> +	if (fd >= 0) {
> +		close(fd);

Also check the return value of close()...

> +		unlink(cookie_pathname.buf);

...and unlink()? If we explicitly prefer not to, note why?
> +
> +		/*
> +		 * Technically, this is an infinite wait (well, unless another
> +		 * thread sends us an abort).  I'd like to change this to
> +		 * use `pthread_cond_timedwait()` and return an error/timeout
> +		 * and let the caller do the trivial response thing, but we
> +		 * don't have that routine in our thread-utils.
> +		 *
> +		 * After extensive beta testing I'm not really worried about
> +		 * this.  Also note that the above open() and unlink() calls
> +		 * will cause at least two FS events on that path, so the odds
> +		 * of getting stuck are pretty slim.
> +		 */
> +		while (cookie->result == FCIR_INIT)
> +			pthread_cond_wait(&state->cookies_cond,
> +					  &state->main_lock);
> +	} else {
> +		error_errno(_("could not create fsmonitor cookie '%s'"),
> +			    cookie->name);
> +
> +		cookie->result = FCIR_ERROR;

...more readable if we just:

    if (open(...) < 0) {
        ...;
        goto cleanup;

So no need to indent the comment/main logic of the function above?

> +	}
> +
> +	hashmap_remove(&state->cookies, &cookie->entry, NULL);
> +
> +	result = cookie->result;
> +
> +	free((char*)cookie->name);

Since the "name" here is always an allocated string we should just make
it "char *" in the struct and avoid these casts.

In other places we play this casting game because the struct is a public
API, but in this case it's all ours.
