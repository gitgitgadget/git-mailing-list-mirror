Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC098C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E10E2076E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 10:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxB88/jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKMKCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 05:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgKMKCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 05:02:16 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0593C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 02:02:14 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id oq3so12502395ejb.7
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 02:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=XQuLr/4FVycz0o53PirIEuBwphX8rgRTPWJxj9pZaeU=;
        b=UxB88/jciIX8/L7I1ByTJSyIQBTWTDjglbmtggguGhqZxXeVod8Kwmyf8I/mMfkfX6
         mlpSQWz8sYrAkQr9INtm0RzdV+B6iLNqNoEcbJfwVzojKTfJ8IJSnw4ejQ9oqJUvEi2o
         LiRETu/YGliz2XTkpCPtjob6/+e3aHu9jlH7/vNbWopIwW3gl8b5pfAJdOoLJMr5Fbqh
         dpLOsbMAdPrlyzUgo/wjMk7uSUApj01qrAqRgFNGJvHdYMQVNQqHHlaqDxVP09VkC5/9
         h0q0v5clC0hpRSZus33J2+R3uuZZg6yDUsqTi6Mq2CynXF2mvaRhaYluZ5R5WQF7vaap
         w/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=XQuLr/4FVycz0o53PirIEuBwphX8rgRTPWJxj9pZaeU=;
        b=N7etkc11sJ5BdlZbAfU2tmrDshcQ8R+alRIqN09glOt/w3UKZAX98LRWTPYtaMrxz5
         q2KgwDM4ubGVxyZj4bFnrpCSKVib+z+1qxmenNpiYAb7SCSqWijESYCnSELwuUizxTit
         WIb7qBG7BMCXzUo7kUjvmLZjDppTTjqUuzSQwgHukPy6TaXq76xqkVi7d1q1weWrUSfk
         sV6SHLAg/yFPylXHGgETV/rl5fQRFBZebcZg6U9ve89SUnjYfCb3UGW1UzZTiJFR0Tp6
         tt9881L2teqbjt9fUgjsm5Dar+KnC2jL9oLckU7E9YVGi+2PvnsvYtc2u3HS/YKF5eLe
         1Mbw==
X-Gm-Message-State: AOAM533wlr4G7b9rWot78BSaxuV9KdTqnJ39WXGKsU2uK1EOFigqgjOz
        GHS5YOGXxh/E3fzNpKb+VrITEN4endg=
X-Google-Smtp-Source: ABdhPJxRVXV3xxz85xqLZP6UXPrbN55JZ6oNaunawicbcSDClA8K2703hYVloUvNLrBL25+8ML181w==
X-Received: by 2002:a17:906:3f93:: with SMTP id b19mr1261130ejj.497.1605261733647;
        Fri, 13 Nov 2020 02:02:13 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id mj17sm3144946ejb.59.2020.11.13.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:02:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 14/28] t55[23]*: adjust the references to the default branch name "main"
References: <pull.762.git.1605221038.gitgitgadget@gmail.com> <3aef39320e96aad10e133f1c97a9010aa85aa894.1605221039.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <3aef39320e96aad10e133f1c97a9010aa85aa894.1605221039.git.gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 11:02:12 +0100
Message-ID: <87sg9dfucb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 12 2020, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This trick was performed via
>
> 	$ (cd t &&
> 	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
> 		-e 's/Master/Main/g' -e 's/naster/nain/g' -- t55[23]*.sh)
>
> Note that t5533 contains a variation of the name `master` (`naster`)
> that we rename here, too.
>
> This commit allows us to define
> `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main` for that range of tests.

There's also a "naster" in t/t1402-check-ref-format.sh that's not
changed here and missed by 02/28 of this series.

Is there some meaning to the name "nain" and "naster" that I'm missing?
If not can we just call this "topic" or something while we're at it?
I.e. this on top (just s/nain/topic/g):

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 9fcec604c3..4e33ec1fb9 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -201,12 +201,12 @@ test_expect_success 'cover everything with default force-with-lease (protected)'
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git branch nain main^
+		git branch topic main^
 	) &&
 	git ls-remote src refs/heads/\* >expect &&
 	(
 		cd dst &&
-		test_must_fail git push --force-with-lease origin main main:nain
+		test_must_fail git push --force-with-lease origin main main:topic
 	) &&
 	git ls-remote src refs/heads/\* >actual &&
 	test_cmp expect actual
@@ -216,16 +216,16 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
 	setup_srcdst_basic &&
 	(
 		cd src &&
-		git branch nain main^
+		git branch topic main^
 	) &&
 	(
 		cd dst &&
 		git fetch &&
-		git push --force-with-lease origin main main:nain
+		git push --force-with-lease origin main main:topic
 	) &&
 	git ls-remote dst refs/heads/main |
-	sed -e "s/main/nain/" >expect &&
-	git ls-remote src refs/heads/nain >actual &&
+	sed -e "s/main/topic/" >expect &&
+	git ls-remote src refs/heads/topic >actual &&
 	test_cmp expect actual
 '
 
