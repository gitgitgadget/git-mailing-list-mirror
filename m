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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C7C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A577C60F58
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhHEB0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhHEB0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:26:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD35C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:25:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so2343774wms.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3v05HEgtqXTp9CTWEkXt5+nI7gfPruKXTu+nUiN2Wgc=;
        b=ZAdgjLiPzw8kyhENYOiaf/y3pN6ajLTcYLT2qOnaXuZop45uMhpSvgED+vRyoYmF9l
         xeK2fM/2C5gfXyfkGdoqBpaqWIYym7dStJmH2WN1p5jwMxeuQMQmh40wrDs2W2HQcQzG
         zMdFetdbDqNKHXmjONK5jJe7CqwjVOBYy05E8tsz1zvdyQq4yNTfjInDhHOAdD7ZL2dd
         GKyHu8key3Cqdoo7Idkuv2EGcp9TDdsu6ZOKyW6VOihGGWdgS3V7T1QlwIFdEEqztv8+
         1hLkOG+WeLfa9BS4fEuh75i0d5PFa0Np6JlCl4XzAAPTjED1ykkQsqDU4xwUBGohIhkz
         lLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3v05HEgtqXTp9CTWEkXt5+nI7gfPruKXTu+nUiN2Wgc=;
        b=snL5PpHdGoINjLuraei2VBxD6eDhf/xTICVzUDCvgx8KhdQDb74ejY90HKL7lDUZrY
         POPpERFIVHq604noy41bHDfvLFezVpSGJTnHMhPD8zfD5oczYZFvm5SdqqEwUoO0C1e5
         GbSHBkLJ6CWMZJ2btYbpNmV9otledlqjJILkx/a9mH1Us2DcCNFgOo4PFVqIEOrDrQXZ
         p0Y9bOWgxkp3Pc7Mxb0pRoyqz2VI4WUil1ibvSVwz9HxTbZB3ajCKbZMiDYpGTkFIONi
         IkRpH6Vdhh+NyBX1ZrL15UcElJZGgsWJbnybmvqy7nM8BP0XR4nH+hxzpnZ1nbLWVkQg
         xDGQ==
X-Gm-Message-State: AOAM533ep7tJZ7PQ+V/m+8Kqovx4i5SjyBnDlqMGjlVImq8NHs0EYyit
        M+usN/g8TUCU3NUMq1bkho1KuWEEzMWZ1g==
X-Google-Smtp-Source: ABdhPJwxzGIPS5qbmVNqGRcPIVLcmw36qPx6AA1RPE2JiS9DLnCY6UvaEA8KguCq65frDPSQtvFwlQ==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr8392295wml.18.1628126748019;
        Wed, 04 Aug 2021 18:25:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm4120176wru.50.2021.08.04.18.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:25:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/10] transport: use designated initializers
Date:   Thu,  5 Aug 2021 03:25:36 +0200
Message-Id: <patch-v4-03.10-d3d5818adda-20210805T011823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20210805T011823Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the assignments to the various transport_vtables to use
designated initializers, this makes the code easier to read and
maintain.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport-helper.c | 12 ++++++------
 transport.c        | 30 ++++++++++++------------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 8d445a8f3ee..e8dbdd11530 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1261,12 +1261,12 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 }
 
 static struct transport_vtable vtable = {
-	set_helper_option,
-	get_refs_list,
-	fetch_refs,
-	push_refs,
-	connect_helper,
-	release_helper
+	.set_option	= set_helper_option,
+	.get_refs_list	= get_refs_list,
+	.fetch_refs	= fetch_refs,
+	.push_refs	= push_refs,
+	.connect	= connect_helper,
+	.disconnect	= release_helper
 };
 
 int transport_helper_init(struct transport *transport, const char *name)
diff --git a/transport.c b/transport.c
index 3e8a27b0321..f9400b9b0bd 100644
--- a/transport.c
+++ b/transport.c
@@ -883,12 +883,10 @@ static int disconnect_git(struct transport *transport)
 }
 
 static struct transport_vtable taken_over_vtable = {
-	NULL,
-	get_refs_via_connect,
-	fetch_refs_via_pack,
-	git_transport_push,
-	NULL,
-	disconnect_git
+	.get_refs_list	= get_refs_via_connect,
+	.fetch_refs	= fetch_refs_via_pack,
+	.push_refs	= git_transport_push,
+	.disconnect	= disconnect_git
 };
 
 void transport_take_over(struct transport *transport,
@@ -1032,21 +1030,17 @@ void transport_check_allowed(const char *type)
 }
 
 static struct transport_vtable bundle_vtable = {
-	NULL,
-	get_refs_from_bundle,
-	fetch_refs_from_bundle,
-	NULL,
-	NULL,
-	close_bundle
+	.get_refs_list	= get_refs_from_bundle,
+	.fetch_refs	= fetch_refs_from_bundle,
+	.disconnect	= close_bundle
 };
 
 static struct transport_vtable builtin_smart_vtable = {
-	NULL,
-	get_refs_via_connect,
-	fetch_refs_via_pack,
-	git_transport_push,
-	connect_git,
-	disconnect_git
+	.get_refs_list	= get_refs_via_connect,
+	.fetch_refs	= fetch_refs_via_pack,
+	.push_refs	= git_transport_push,
+	.connect	= connect_git,
+	.disconnect	= disconnect_git
 };
 
 struct transport *transport_get(struct remote *remote, const char *url)
-- 
2.33.0.rc0.597.gc569a812f0a

