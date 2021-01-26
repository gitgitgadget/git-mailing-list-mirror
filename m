Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2F1C432C3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31F222EBD
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390703AbhAZNZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391692AbhAZJ6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 04:58:19 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B3C061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 01:57:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ox12so22155603ejb.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 01:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=E+HwaZhqaCEucOkEEG/b52cW7QH1jBbXczQ7MCRtXVE=;
        b=cq95l8b+DMM6PINFcNl6VZQOATEAMsJJUzk3PRAuzFh89NR8YHA4V4g9vnDeOkFSlS
         MMRVaGBi8Dqey35+dPaB80hetGqPaHCpdTRZc3G2+QeQ3ni1+qWBgWthG/bQKBX7/r2A
         oOq7tFH6x9XuuajGaTWqXuzMls8EOFmx8dhcQRYFL2Mz8azBCMpdgUCXuwMPUyVjqJ9S
         hiJG48DXmgiDdRe83Z8PNcyVkIMo/QIynOlyzNVZc0QA28mXZcIBT4qVk9Iuo9CW2CNi
         PewAsUd0G4aV95baC/ngMHDqjLKfRtvIxC1L1Zbp2hlyeIJ8I63N4DK/WsAcZbLJarRe
         YEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=E+HwaZhqaCEucOkEEG/b52cW7QH1jBbXczQ7MCRtXVE=;
        b=PnReh65d/sQ4H2bsmoGFdZN5dPeNQplk14XxxPB8dCMMXc0Nzq5VqZljUPIIsS1oDE
         WYESuzMN1X2inmznOYxyjyCB24Wmc5ClKuNaxC0nKf0e9sUTR5M+7uBr5XAPRu+URMVY
         yLLmNq4Ib4anhKAHLssGRdaZvRGE2VI/ch1Td87VfI188u1oxrPho9P1A4M+8baXLeEg
         sPrZhgOFxJfIAoFCwXXTJSmhKpCru2IywSzErDTzJZneAV4VU/koFwBaVeS6bfvHkWdT
         GN8PVGVrPpfFmYIc8AwQnq8DbyAjImkoewzEeN49VfpefMj7rR+BHWTMGi/UhD8So7At
         LDKg==
X-Gm-Message-State: AOAM533QM1WlNTozvI5rh+nqwrOMGatM1SRSU5eHWR0lsQCoODtULULd
        cVqzEQbUAbkMJiKqXW1fznk=
X-Google-Smtp-Source: ABdhPJzYbt39+I71jhyZWvArLQLDbiXx+sH+paAb1zHVQzGqUSbbntRdCOO7gKlg0zKg7Fie85F2zA==
X-Received: by 2002:a17:906:5958:: with SMTP id g24mr2887727ejr.377.1611655058057;
        Tue, 26 Jan 2021 01:57:38 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id q16sm8299638ejd.39.2021.01.26.01.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 01:57:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, gitster@pobox.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
 <20210125230952.15468-1-jacob@gitlab.com>
 <20210125230952.15468-2-jacob@gitlab.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210125230952.15468-2-jacob@gitlab.com>
Date:   Tue, 26 Jan 2021 10:57:36 +0100
Message-ID: <874kj46mwf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 26 2021, Jacob Vosmaer wrote:

> This fixes a bug that occurs when you combine partial clone and
> uploadpack.packobjectshook. You can reproduce it as follows:

Let's: 

 * Refer to the commit we're fixing a bug in, i.e. Junio's mention of
   10ac85c7 (upload-pack: add object filtering for partial clone,
   2017-12-08) upthread.

 * See also "imperative-mood" in SubmittingPatches. I.e. say "Fix a bug
   in ..." not "This fixes ... can be reproduced as"

 * uploadpack.packObjectsHook not uploadpack.packobjectshook except in C
   code.

> git clone -u 'git -c uploadpack.allowfilter '\
> '-c uploadpack.packobjectshook=env '\
> 'upload-pack' --filter=blob:none --no-local \
> src.git dst.git

This and the output below would be more readable indented.

> Be careful with the line endings because this has a long quoted string
> as the -u argument.
>
> The error I get when I run this is:
>
> Cloning into '/tmp/broken'...
> remote: fatal: invalid filter-spec ''blob:none''
> error: git upload-pack: git-pack-objects died with error.
> fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
> remote: aborting due to possible repository corruption on the remote side.
> fatal: early EOF
> fatal: index-pack failed

[...]

> The problem is an unnecessary and harmful layer of quoting. I tried
> digging through the history of this function and I think this quoting
> was there from the start.


...So looked at "git log" but didn't try to check out 10ac85c7 and see
if it had the same issue? If we're going to leave a note about this at
all probably better to help future source spelunkers by being able to
say the issue was there from the start.


> My best guess is that it stems from a
> misunderstanding what use_shell=1 means. The code seems to assume it
> means "arguments get joined into one big string, then fed to /bin/sh".
> But that is not what it means: use_shell=1 means that the first
> argument in the arguments array may be a shell script and if so should
> be passed to /bin/sh. All other arguments are passed as normal
> arguments.
>
> The solution is simple: never quote the filter spec.
>
> This commit removes the conditional quoting and adds a test for
> partial clone in t5544.
>

Thanks for hacking this up! Hopefully the above is helpful and not too
nitpicky. Mainly wanted to help you get future patches through more
easily...

> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  t/t5544-pack-objects-hook.sh | 9 +++++++++
>  upload-pack.c                | 9 +--------
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
> index 4357af1525..f5ba663d64 100755
> --- a/t/t5544-pack-objects-hook.sh
> +++ b/t/t5544-pack-objects-hook.sh
> @@ -59,4 +59,13 @@ test_expect_success 'hook does not run from repo config' '
>  	test_path_is_missing .git/hook.stdout
>  '
>  
> +test_expect_success 'hook works with partial clone' '
> +	clear_hook_results &&
> +	test_config_global uploadpack.packObjectsHook ./hook &&
> +	test_config_global uploadpack.allowFilter true &&
> +	git clone --bare --no-local --filter=blob:none . dst.git &&
> +	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
> +	grep "^?" objects
> +'
> +
>  test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index 3b66bf92ba..eae1fdbc55 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	if (pack_data->filter_options.choice) {
>  		const char *spec =
>  			expand_list_objects_filter_spec(&pack_data->filter_options);
> -		if (pack_objects.use_shell) {
> -			struct strbuf buf = STRBUF_INIT;
> -			sq_quote_buf(&buf, spec);
> -			strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
> -			strbuf_release(&buf);
> -		} else {
> -			strvec_pushf(&pack_objects.args, "--filter=%s", spec);
> -		}
> +		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
>  	}
>  	if (uri_protocols) {
>  		for (i = 0; i < uri_protocols->nr; i++)

