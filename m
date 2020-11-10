Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5F6C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F012D20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn97dguM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgKJVWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbgKJVWF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:05 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D237BC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:05 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id t16so16078524oie.11
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBs0yqmkj6oreqJAIV5pz6IDRsi60l3I+52qceKH+7o=;
        b=Bn97dguM4EQWbEU/X8bjS4jluDpGnIYcPpokyXDWoodhFhWyldS16tP8NFn8y4oGxt
         THvFC/8bnpvcUJeA256aZjc2TeBhQ0hPJcDRYqu1AqqVDEg0464yEl29Bx3sUqV3p63R
         cke9+e2eYH5rS4TjTQdLB/qLPJwjqIEw52ostdS4zDD3++bw6ZRIIEK3W8VCkvfb+xS9
         Nk0os5p0qyiwHso7RikaXgWOI7LuW8q3iIr4VM8yRzILsK0GUXshZH8EpZhdrW0PIBmh
         YsR4OqwlPIjR7abTXU86HbprncG5+/aCBnmsv1BIozoveC+45yryo1DPsC7qBMJ1JDYw
         C71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBs0yqmkj6oreqJAIV5pz6IDRsi60l3I+52qceKH+7o=;
        b=o1k6PD/qmBFlpLSyz1TyQRuMdqOTvh/ftl5IM07oF6d6GUtTaVFn1lxNe1Sj9uixfP
         WUxkNy3tws5as+ruSbS2WQEtlQxc4F9PzXHW/9CAZL7oKJwhULHnu4f/pM5ursMNlBWN
         ekzzgU6G4L8sCCBrPDRIgHlrx7r3YgV8EgICK7zTvGOHOo+tNqKG7ae5woqS5YslaPX5
         Whxe3vhUJbZqd4ur6mB36d3Sfk8VkNAbNqqVmxVlR7a5M7rQhXR02oj0GbMYJVeEFoD+
         5CgqrpXymu7WOly+kL93YAQVyjL/1N5RABkETTSA3V+GzOEfYZahq3wtJF6t4lcVzkDf
         3UbA==
X-Gm-Message-State: AOAM532OPjP7s/+VxH6CI6FlHPoHUCfaKdRzzY8rkVbg+KUKM2RPAbTj
        vvut0+3mbkmFzwvkVW1CI1UNddzeUPwm/A==
X-Google-Smtp-Source: ABdhPJwuE7H1HD90kx8iGfRQiebENkwHjELIzBXgvK7WS0Zq6viQPVUrjbKw3G2sD2CVELw8JDGoLQ==
X-Received: by 2002:aca:bc03:: with SMTP id m3mr47469oif.35.1605043325053;
        Tue, 10 Nov 2020 13:22:05 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v13sm308838oic.17.2020.11.10.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:22:04 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/26] completion: bash: simplify __gitcomp
Date:   Tue, 10 Nov 2020 15:21:23 -0600
Message-Id: <20201110212136.870769-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not possible for $cur_ to have anything more than --no- at this
point, so there's no need to add a suffix, nor check anything else.

All we are doing is checking that $cur_ matches --no, and adding a
completion if so.

This way the code reflects what we are doing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8b4308fc99..9f5dd4e3e7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -332,9 +332,8 @@ __gitcomp ()
 				continue
 			fi
 
-			c="--no-...${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				COMPREPLY[i++]="${2-}$c "
+			if [[ --no == "$cur_"* ]]; then
+				COMPREPLY[i++]="--no-... "
 			fi
 			break
 		fi
-- 
2.29.2

