Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF01C4160E
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7AD6502E
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhCFLFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhCFLFK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60970C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:10 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so858737wml.2
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Gk6aibshctaRp4JtLxKv/SM9m+9ARL7UvoPDZD/iZc=;
        b=hkZQdMrFzUoZfCrBWLr/4DuZiLoPqaaSNlxmNw/1iMfx9jUdwmRIB189V2EVpkIQ1X
         qOmPnvVV2jmaQAPJ6taHNsBu7TYASELekSJhdkEny4J8TnsqonYWghb6E3f1mIEnZ3nG
         R4iW6rsmxe7c2AQQuv7uCKYzm7kN5JbynCSSPOnw7XXiwmAr+ch1BJNE3EiLZdQyrz7L
         Ay5GVum/Qm9nWXOckJY+umBOqlSxy/aGISsli6nRqw5uy4ZWLGMKDeI4brfByOLe1y1F
         XoAZ3dY4v0dwMDfEK2kSoOyOaGh4/H+xvJbWlVyk/Q1GN2E16rpNv7U22lHA1unN2UFp
         aoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Gk6aibshctaRp4JtLxKv/SM9m+9ARL7UvoPDZD/iZc=;
        b=uY80abCkAkTPqmdJFl50WzdSmAJ2Fnz/geezuNRYazWFzIJLBDV3nUtc/HOq6l16kr
         SkxXWRduKJgQF52U5JH/6DpfOHnRkDH2h1e12fITlRweyD3k/D4irrjTNcSZmFhNqcYU
         08UmQg1gXyjh99lw8C/urbhydTvF7nHYJ3sfsPHukf48EcjvYhOLzkha08WAfsCNRsaJ
         VKCU7/4FlNEJYRBSUBX0pBNySHYSsGtaFcz0tV+F7Kz6hAtbcIfM0/+ve9AC9l5q7aKs
         3CQjQ6o3HZZTgRe3Up5JVSIP5EWwNA6w0+o0aakSGZzAAS2DuUdmRVHqh7rk0pDkmxpY
         SxkA==
X-Gm-Message-State: AOAM530dlhYmxzbhl7BPQdWvPS0Ht5q8xdn6qBHrtxjJ27NPCFFLUxK1
        WG7f5kcCeg28keqWiFZlTKX7gQPSr0y2cA==
X-Google-Smtp-Source: ABdhPJx5ZYEuT+m6J5gTVVhzzJj6tli5E7PIoaT379XwIy74fjsh9UgA9ALj2MP8bigRIDdVZr/EEQ==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr13248036wmj.149.1615028708929;
        Sat, 06 Mar 2021 03:05:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 21/22] fetch-pack: use file-scope static struct for fsck_options
Date:   Sat,  6 Mar 2021 12:04:38 +0100
Message-Id: <20210306110439.27694-22-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 5476e1efde (fetch-pack: print and use dangling
.gitmodules, 2021-02-22) so that we use a file-scoped "static struct
fsck_options" instead of defining one in the "fsck_gitmodules_oids()"
function.

We use this pattern in all of
builtin/{fsck,index-pack,mktag,unpack-objects}.c. It's odd to see
fetch-pack be the odd one out. One might think that we're using other
fsck_options structs in fetch-pack, or doing on fsck twice there, but
we're not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 53d7ef00856..f961c3067cd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -38,6 +38,7 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
+static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
@@ -991,15 +992,14 @@ static void fsck_gitmodules_oids(struct oidset *gitmodules_oids)
 {
 	struct oidset_iter iter;
 	const struct object_id *oid;
-	struct fsck_options fo = FSCK_OPTIONS_STRICT;
 
 	if (!oidset_size(gitmodules_oids))
 		return;
 
 	oidset_iter_init(gitmodules_oids, &iter);
 	while ((oid = oidset_iter_next(&iter)))
-		register_found_gitmodules(&fo, oid);
-	if (fsck_finish(&fo))
+		register_found_gitmodules(&fsck_options, oid);
+	if (fsck_finish(&fsck_options))
 		die("fsck failed");
 }
 
-- 
2.31.0.rc0.126.g04f22c5b82

