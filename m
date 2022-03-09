Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72228C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiCIN0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiCIN0m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:26:42 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8716151C6A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:25:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so2812056edt.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nnHZRDbcFkjejEnPnhmTyaqZy/j/gIEQ+RdrOMoLt1c=;
        b=EvQBkDE8UAnYvTXA20x3RipE2OYvnKQYhNHwlMSeavxXrY7VaS6IAjmr14YaWdeKTB
         5lLh2TQ7gxy6BEgHV6gSsukJIxcDKkENQdFyTaNaofoKOHrwyPNU+wON7mHZ+dabxAWc
         8jkbC2vr0+DgHmS0dM/eq+qIXOuf1eprCz+wZuQApPqvBufh8bQ5RDoW62H89Ue76R6w
         L3UfETwvgTyi4oNnz4IXlk3bC5ULz5cah+n9HcJFR4piWY3FztbQYLtvS5FMCvPnWebT
         2G1wrGLl9nyL2H7LBKO+QwTXZiBMjiBZ6edquslAIUzUGxHVuClE3HJ9sziCWPlq5INv
         CFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nnHZRDbcFkjejEnPnhmTyaqZy/j/gIEQ+RdrOMoLt1c=;
        b=Pm8ODPFaO0ZIHWIxXGB4IP3TshleenAc9VZEJxBeShhE0MZAguVgYfssMyadATy/Vu
         hwVBdXvDw2RzjTl18Ir45M0ujjlfmWC4aPcmyU0diBIxIHyVDe5nqiTzNebM3YHSPQ7j
         qvbnddHnZFgJNsWNzj6jzxdT0UlvFQXusAKL/Q4bKuLOMSczIQTBL/bYSpo1i5I0kh5E
         F2pyR37EYbF8RfbQQ7X+hdqcdInTYwis+qOE9l+Jzcag+Te4mqJgEKdGqxE3oSMXiVWf
         wZGrEO0ekyIqsA6J1xWp4HSe9S7Qbtin3VOerFj2oisoMemMQj6lm0FovHUZ5m2MA1Wl
         z49w==
X-Gm-Message-State: AOAM533ib1XtsTNe2eCUSObZXnU3IBUy2TISI0PPuhMhsenVuecTv9CF
        ewy5zlCVHscLgjBZR0lSuAJRckayTuh/Hg==
X-Google-Smtp-Source: ABdhPJz102V8+R05NEsd7k8ISFCg5H79NVbjOxSJw4qN+kryhdJHwnQilpH62uxP15QvmRy2+OfCCA==
X-Received: by 2002:a50:9505:0:b0:416:4496:5ec4 with SMTP id u5-20020a509505000000b0041644965ec4mr15513581eda.309.1646832341922;
        Wed, 09 Mar 2022 05:25:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x18-20020a05640226d200b00416a502c147sm147676edd.10.2022.03.09.05.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:25:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRwJw-000AGu-Ox;
        Wed, 09 Mar 2022 14:25:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 05/12] list-objects: consolidate
 traverse_commit_list[_filtered]
Date:   Wed, 09 Mar 2022 14:24:13 +0100
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
 <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <bcb76a065bf977c53e32bdb52fb59087adf09159.1646750359.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bcb76a065bf977c53e32bdb52fb59087adf09159.1646750359.git.gitgitgadget@gmail.com>
Message-ID: <220309.86sfrrmf57.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
>  void traverse_commit_list_filtered(
> -	struct list_objects_filter_options *filter_options,
>  	struct rev_info *revs,
>  	show_commit_fn show_commit,
>  	show_object_fn show_object,
> @@ -444,7 +429,13 @@ void traverse_commit_list_filtered(
>  	ctx.show_object = show_object;
>  	ctx.show_commit = show_commit;
>  	ctx.show_data = show_data;
> -	ctx.filter = list_objects_filter__init(omitted, filter_options);
> +	if (revs->filter)
> +		ctx.filter = list_objects_filter__init(omitted, revs->filter);
> +	else
> +		ctx.filter = NULL;
> +

Purely an optional nit, but here we could also let the initializer take
care of the default NULL-ing:

diff --git a/list-objects.c b/list-objects.c
index 2f623f82115..52c19d54019 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -421,12 +421,14 @@ void traverse_commit_list(struct rev_info *revs,
 			  show_object_fn show_object,
 			  void *show_data)
 {
-	struct traversal_context ctx;
-	ctx.revs = revs;
-	ctx.show_commit = show_commit;
-	ctx.show_object = show_object;
-	ctx.show_data = show_data;
-	ctx.filter = NULL;
+	struct traversal_context ctx = {
+		.revs = revs,
+		.show_commit = show_commit,
+		ctx.show_object = show_object,
+		ctx.show_data = show_data,
+	};
+	if (revs->filter)
+		ctx.filter = ...;
 	do_traverse(&ctx);
 }
 
