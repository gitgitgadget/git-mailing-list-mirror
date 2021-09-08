Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D71C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D236115C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348652AbhIHPZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348669AbhIHPZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:39 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6C1C06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1851696wmi.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4WEpNsRtGsOLPdzFG29r+7FZrBMrdX51URTaA1o6hg=;
        b=SsRzU5CGz70NwTJyJCa2pTGulaQ0CzoTv+wliqlR3ANbgHxfn++YtLtmBY0idJAklO
         dw1o5BvDRS3ytgemKPVhG2/vta+sW7wXOpqgLgEAM15ox+gFIpRUrhUFJ1WjnPxJiGDj
         Ft3k2Cfgtr7Nc/nRoYyiRj3jHUjkR7T/bYEWNTpUb0ozXZYrGTU+HVB9DqnUGM7pIgNI
         ws/0jOfLWhNjXvh4rNO9dZdiP/vJJsHl2yMomfHbTAJSoZbJVstPrFjqzuy/8fBD1n3O
         Xa3CJAGtzF5SrIIt/w+N4XiHJk/3ZVrgr0lDK9KOfxzxpJa0sVhBqS8DSINyQic2WX2v
         FNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4WEpNsRtGsOLPdzFG29r+7FZrBMrdX51URTaA1o6hg=;
        b=SqgG5WrGIpsxDSie5O8Xcnh0cdKNs18pVGWjqvVyattV38iAT16F8r9xNSwUNbnJcM
         k6zBC7+kqhJBDx8nC/XxFC2PrHBmk4KsdD2BWzXerS7eshlRWoD+Mt+/+guWUyz1cy9E
         udi5htIeH34Ky2dMhsNcJ1YQaH+mPC9wFmWyk0Qe5nLnAIT+1ohvoNLHP9eUjituzyEl
         yC+mKG11aAxFUpjIzwSg+1l+9Aoz/sAz3R03J1QyVIYXfIHRkzATQrALOBp0YreGLjNq
         pkco4VIhre61lPC7uVRytgtPJWRoGmOxAZMj6FpqajuS7hcixXE3G1f6t8HdCDHWivLB
         csog==
X-Gm-Message-State: AOAM533SneRfa/hA1Ar2GhGC58pvY+PeLSarow5JEXGRBJkDXyIAcaUc
        uU60MYZEHKLsnitLgetL69CNuYHkymzAgg==
X-Google-Smtp-Source: ABdhPJzosTPbk0yL50i2TtUzBL4rF7it8vIOPm24A9Kj2PnV1HTwgBf2AwJUB1d8RLIitpCtC8bvKQ==
X-Received: by 2002:a05:600c:2114:: with SMTP id u20mr4233418wml.65.1631114669852;
        Wed, 08 Sep 2021 08:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] help: refactor "for_human" control flow in cmd_help()
Date:   Wed,  8 Sep 2021 17:24:20 +0200
Message-Id: <patch-4.6-e4bc7e57a6d-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of having two lines that call list_config_help(for_human)
let's setup the pager and print the trailer conditionally. This makes
it clearer at a glance how the two differ in behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 0f9dc31c40f..0737b22069b 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -574,13 +574,12 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (show_config) {
 		int for_human = show_config == 1;
 
-		if (!for_human) {
-			list_config_help(for_human);
-			return 0;
-		}
-		setup_pager();
+		if (for_human)
+			setup_pager();
 		list_config_help(for_human);
-		printf("\n%s\n", _("'git help config' for more information"));
+		if (for_human)
+			printf("\n%s\n", _("'git help config' for more information"));
+
 		return 0;
 	}
 
-- 
2.33.0.825.g2bf60429931

