Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8FC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F59A61077
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhIFXQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 19:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhIFXQi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 19:16:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646CBC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 16:15:32 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i6so11318692edu.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3kI6ezMyvcxv+bD7XrY7Neb9fKXRVL4NXZGZqEKA024=;
        b=JpkpembPTvLaON2zd1TPkrn63+mvFStSwqffl2p0GTcVw3eX8Yz5JUqW9kb35MxVPQ
         1kg4lnx3D/03qJDIo3FJUgV7ZKVS4JxXa/QTkwaKyeRJXlC475CUGMuDCaOs+9I9B5Gy
         Sew6kKK9RbjmBJSc7f7zdyemXgUoYM51v6B/WDi5vMoNKVYdeeNdXV2B7uqzkLIv/o+A
         Yyt22VX667XOSqh3zbZGVOL9CHv/gXfrDZDbgIaO71qkyjlRgLTPMHFSffoU/GppfA94
         Wup05Bxn0vmQXEAEcB/zgfSgRKxFUGbUfXeK/8/uhw1V97L2Fa4fL2w9h41QcmpjhNXK
         GX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3kI6ezMyvcxv+bD7XrY7Neb9fKXRVL4NXZGZqEKA024=;
        b=K2CTHXvq42EQ3GNayYi5TUB/9sshUvhAUUxMXV1FBR7klg9Kfyx0/FTQm5Pw3af/Yu
         U8dAk8ZCoaSZ1DQoaeG8lBz+I21u62fR0x0JcWmzdhy20eKjAAB8FA9uOBCxBTAkFIoK
         2pZcmrOXVTHEbzOy5DaioEnud/feoEdGAJrTHqf+rVITTr1pbkp9WVadcZUVl6V8Is7T
         aSyepK5GV4KD7bKxjkrNKo/XRuvGXTCjgFiEUe8FmJvOCiMpSxq9Hn95uWt5INXjQAjz
         hQN2WwurPi4Nkd4TNPL6x7by93J8c+Ske0Gx/FqhOM+G+pxfQ0Lj+/ZFzaad47Qs4GbB
         Cmdw==
X-Gm-Message-State: AOAM530i3HMLkEj/dfjmh4QmiVmgovLpHp0nTCedfot8JkhuuKDCJVne
        cLT+xcDaNayLHpKa4ceiXMeQnFqUuYG6zQ==
X-Google-Smtp-Source: ABdhPJzn0FsNOH7MrBt67n+f4Q9gIsORIv6YYIIXHlRdZVPWqLovuWsd55mskfBge887XN8qSQvBQw==
X-Received: by 2002:a05:6402:1913:: with SMTP id e19mr15390846edz.9.1630970129921;
        Mon, 06 Sep 2021 16:15:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x13sm4561182ejv.64.2021.09.06.16.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 16:15:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/5] RFC: refs: reflog entries aren't written based
 on reflog existence.
Date:   Tue, 07 Sep 2021 00:50:48 +0200
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <f6a7c5ad56efceef9c11226beb854b806ef54687.1630947142.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <f6a7c5ad56efceef9c11226beb854b806ef54687.1630947142.git.gitgitgadget@gmail.com>
Message-ID: <87v93dmh2n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 06 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> In CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com,

Nit: use <message-id> for quoting, not message-id.

> we came to the conclusion that this feature is probably a remnant from
> the time that reflogs weren't enabled by default, and it does not need
> to be kept.

Maybe some summary of the flexibily either Jeff King or Junio mentioned
we were losing (i.e. we can't selectively enable per-ref now), but that
we think it's OK because...

For the implementation:

> +	*logfd = -1;

Weird, more on this later...


> +	if (!force_create && !should_autocreate_reflog(refname))
> +		return 0;

OK, so we can early abort.

>  	files_reflog_path(refs, &logfile_sb, refname);
>  	logfile = strbuf_detach(&logfile_sb, NULL);
>  
> -	if (force_create || should_autocreate_reflog(refname)) {
> -		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
> -			if (errno == ENOENT)
> -				strbuf_addf(err, "unable to create directory for '%s': "
> -					    "%s", logfile, strerror(errno));

Here we use one indent/wrapping style...

> -			else if (errno == EISDIR)
> -				strbuf_addf(err, "there are still logs under '%s'",
> -					    logfile);
> -			else
> -				strbuf_addf(err, "unable to append to '%s': %s",
> -					    logfile, strerror(errno));
> -
> -			goto error;
> -		}
> -	} else {
> -		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
> -		if (*logfd < 0) {
> -			if (errno == ENOENT || errno == EISDIR) {
> -				/*
> -				 * The logfile doesn't already exist,
> -				 * but that is not an error; it only
> -				 * means that we won't write log
> -				 * entries to it.
> -				 */
> -				;
> -			} else {
> -				strbuf_addf(err, "unable to append to '%s': %s",
> -					    logfile, strerror(errno));
> -				goto error;
> -			}
> -		}
> +	if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
> +		if (errno == ENOENT)
> +			strbuf_addf(err,
> +				    "unable to create directory for '%s': "
> +				    "%s",
> +				    logfile, strerror(errno));

...but here it's changed while we're at it, this patch would be easier
to follow IMO if we just left the formatting alone (or did it as another
step). I'm aware that it ends us at over 79 columns, but that was the
case before...

> +		else if (errno == EISDIR)
> +			strbuf_addf(err, "there are still logs under '%s'",
> +				    logfile);
> +		else
> +			strbuf_addf(err, "unable to append to '%s': %s",
> +				    logfile, strerror(errno));
>  	}
>  
>  	if (*logfd >= 0)
>  		adjust_shared_perm(logfile);
>  
>  	free(logfile);
> -	return 0;
> -
> -error:
> -	free(logfile);
> -	return -1;
> +	return (*logfd < 0) ? -1 : 0;

On "more on this later": Since we just return -1, 0 or a valid fd now,
can't we just return the "fd" here and let the callers sort out -1, 0
and >0?
