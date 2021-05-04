Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98000C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA97613B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhEDRVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhEDRVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:21:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723BEC06174A
        for <git@vger.kernel.org>; Tue,  4 May 2021 10:20:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m11so8373964pfc.11
        for <git@vger.kernel.org>; Tue, 04 May 2021 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdQ0lRXjZaAg5E/v7kX3fzVpcSiv7r/l5LQc7HtJALM=;
        b=Y4F7zu0uVuE5MXo2K7V2z/LdJmvYrJB1LbGNhUYY9jve+SIP3YEb0jVO/m2uIo0h9G
         at0AQNhv51EYk54a84h9QI+bCylVwXqoA/pN+2jxyTyktHEFIhUL6ejtPn14MfngQZuM
         4snvDL8STv9wqpoDjfRc2JP99EX5yIV2OwOww91iCy4f1Gi1oK7FHmbgw0HMU8lpQVXb
         /vo0MTSSp9cKfKFIsw1TPjshsVXQ4Npl8eVQKnpvZuc8PN+8lJVEqqGdTpL25t0cRbKQ
         omBA13o27hDE5OOAtipMwMZgPxzQ44gL2cbD41qJ0QOAudnT3zQpkM/jebR0JPC5h/6r
         f31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdQ0lRXjZaAg5E/v7kX3fzVpcSiv7r/l5LQc7HtJALM=;
        b=kMe6iGR8r7ywPAS9EKjPxJ6iV8Fhf4LsUm6NJQoggQXhsZ3c59+9lcgP+0IEsgMxmP
         lSJPhMF76U3Q8uuGGXfRTKS4rrctdE1BMxAZh57FEEoYpJrJdhfWYEkvTy2dgdMV3o+Y
         8jRVtE8Y+/2rd4xRcF0q3dHoqE4Fb+szyaeeuO+rcdlkLLN3Jv21C9Qmg0kmAMhWq2pP
         tu2WI/fhj998Kfb0OA1//+gp9hl1tAHfPVwj/6FaAgpyoO7fr0hI/vlNCtk56nFzZiJj
         diiELhyy0d/MH8Rlkl9ZGJqPTMPWUdPSVSLA0je04vh0yLp2flu/0hxlb4ctn9mjJi1u
         nGdA==
X-Gm-Message-State: AOAM531jssgW/pQBCieeiWsjIlQc6GWSl3KIuxf4ZP1mwEtbk0AFw3TS
        Ygthvk7FQGv1qDWac+ZTZn9mzC8BH/FHbg==
X-Google-Smtp-Source: ABdhPJw0d49z9r9J14FqCnhH/vABOtn7mvAhoioILza3AQkmxRxXT8EwXK3HY+b0NAf3rIBHlLCR7g==
X-Received: by 2002:a17:90b:234d:: with SMTP id ms13mr6103256pjb.152.1620148814913;
        Tue, 04 May 2021 10:20:14 -0700 (PDT)
Received: from athena.localdomain ([27.75.102.31])
        by smtp.gmail.com with ESMTPSA id a18sm4019267pgg.51.2021.05.04.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:20:14 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/5] mailinfo: avoid magic number in option parsing
Date:   Wed,  5 May 2021 00:19:58 +0700
Message-Id: <e1e0d8196197d0eb3a39454a48b112a5843d33d7.1620148732.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.500.gbc6bbdd36b
In-Reply-To: <cover.1620148732.git.congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com> <cover.1620148732.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While current magic number is perfectly correct, in a later change,
we would like to parse for another option, namely "--quoted-cr".
Let's refactor a bit to remove that magic number.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/mailinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cfb667a594..b309badce5 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -24,6 +24,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	mi.metainfo_charset = def_charset;
 
 	while (1 < argc && argv[1][0] == '-') {
+		const char *str;
 		if (!strcmp(argv[1], "-k"))
 			mi.keep_subject = 1;
 		else if (!strcmp(argv[1], "-b"))
@@ -34,8 +35,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 			mi.metainfo_charset = def_charset;
 		else if (!strcmp(argv[1], "-n"))
 			mi.metainfo_charset = NULL;
-		else if (starts_with(argv[1], "--encoding="))
-			mi.metainfo_charset = argv[1] + 11;
+		else if (skip_prefix(argv[1], "--encoding=", &str))
+			mi.metainfo_charset = str;
 		else if (!strcmp(argv[1], "--scissors"))
 			mi.use_scissors = 1;
 		else if (!strcmp(argv[1], "--no-scissors"))
-- 
2.31.1.500.gbc6bbdd36b

