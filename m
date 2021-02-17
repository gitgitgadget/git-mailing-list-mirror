Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15F364E45
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhBQT2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhBQT2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:28:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1DC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:27:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id i23so18004261ejg.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pXfvMiG2o2UJQ8Pui55lm9LmmlpkoOlxT+duC45+nvs=;
        b=Z+qZeawmFffO+DrSUhEab7eEl2GrPYj1/vqkxOFkhfykwqwU9SBdGU+7TIhXn1P3n6
         2PM2V+41xN0bljA7ZxGmBuWIhNEpbRfkO4XyrKN2ZsFkjFeS4hU+DiKZ4vsOjq3c4sOF
         UIk+CmiUkS5bz/ghjnWvWC8StH1tOsrHLOlWt0mMnNDOm7h9wjOI9njv14R/59WZ3fjr
         mpgY6WyW4gJfeW8EGAFACntJp3ek7r7SWLE4MQHueDvxa+0Hx7hGwGo5ion9nA8Cz09T
         p6JfvESSVkoDL4Pz6zejA8f0rAMWRoN5WOMoxdfsbj2AdVp++jQJrj4Dex/yAumz3ItV
         UXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pXfvMiG2o2UJQ8Pui55lm9LmmlpkoOlxT+duC45+nvs=;
        b=kV7UqkQ6ZCJAz59dJqjNuyW/c/GwShlQq87jcCYUyaIldLZSYHx2xoazisLz7rccID
         0gT7qX5kaM3rUKR9n8xopB/FgBroZWkGgM589d19LPXasoX+Ht+Ka3LcuTZrWddSWvL7
         QLCDbUvr+3CP5b4SDLc5S1F02ld4HnMM8jd+oN5/XvKq4ivRZEzI10rd8Ob8iUPqrWye
         vFedBqdrzkTRV2spxbCc7V+7NwEQHHhOfay5D6GK2xJMjZsw2DPqceQ/URVJuOAziEWo
         4V/czNmoQ175YeXVXAY0qH7cTu2xdOIQbV9NA5EwdTy6urRodm4DhFXoYKVjN7Uulb6C
         9tfA==
X-Gm-Message-State: AOAM530a04+cTw2BQ4WsEYgYBcnob7s/C2lGqff2P6gcb/VZgHgi9wjW
        jPEP4BwJWTe8Xikcx+wd11UCB+Gaw8+Aiw==
X-Google-Smtp-Source: ABdhPJw6OPSeRTkCX/tIELwsVLzpVPMgdgOnpoqJcBhTtCCYOsebyi8wR7IIuUJaPAoA8Qc9YgAefQ==
X-Received: by 2002:a17:906:2898:: with SMTP id o24mr461506ejd.215.1613590048432;
        Wed, 17 Feb 2021 11:27:28 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id u3sm1398600eje.63.2021.02.17.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:27:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1611455251.git.jonathantanmy@google.com>
 <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
Date:   Wed, 17 Feb 2021 20:27:27 +0100
Message-ID: <8735xua40w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 24 2021, Jonathan Tan wrote:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 557bd2f348..f995c15115 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1888,8 +1888,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	else
>  		close(input_fd);
>  
> -	if (do_fsck_object && fsck_finish(&fsck_options))
> -		die(_("fsck error in pack objects"));
> +	if (do_fsck_object) {
> +		struct fsck_options fo = FSCK_OPTIONS_STRICT;
> +
> +		fo.print_dangling_gitmodules = 1;
> +		if (fsck_finish(&fo))
> +			die(_("fsck error in pack objects"));
> +	}
> [...]
> +static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
> +{
> +	struct oidset_iter iter;
> +	const struct object_id *oid;
> +	struct fsck_options fo = FSCK_OPTIONS_STRICT;
> +
> +	if (!oidset_size(gitmodules_oids))
> +		return;
> +
> +	oidset_iter_init(gitmodules_oids, &iter);
> +	while ((oid = oidset_iter_next(&iter)))
> +		register_found_gitmodules(oid);
> +	if (fsck_finish(&fo))
> +		die("fsck failed");
> +}
> +

What's the need for STRICT here & can't the former use the existing
fsck_options in index-pack.c? With this on top we pass all tests:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 18531199242..5464edf4778 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1933,10 +1933,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		close(input_fd);
 
 	if (do_fsck_object) {
-		struct fsck_options fo = FSCK_OPTIONS_STRICT;
-
-		fo.print_dangling_gitmodules = 1;
-		if (fsck_finish(&fo))
+		fsck_options.print_dangling_gitmodules = 1;
+		if (fsck_finish(&fsck_options))
 			die(_("fsck error in pack objects"));
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 0a337a04f1f..a8754d97e3d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -997,7 +997,7 @@ static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 {
 	struct oidset_iter iter;
 	const struct object_id *oid;
-	struct fsck_options fo = FSCK_OPTIONS_STRICT;
+	struct fsck_options fo = FSCK_OPTIONS_DEFAULT;
 
 	if (!oidset_size(gitmodules_oids))
 		return;
