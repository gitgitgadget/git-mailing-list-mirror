Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A6FC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056EE2071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uL822v8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgE0QsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgE0QsM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3413BC03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so53900wmd.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4h3dhzIalKM779J1TMHqw2IMtT+aQ6BFTV4HKHQb8M=;
        b=uL822v8xKIXvTBSGPhyFetFpn/kcC5tx6nz+PmZflPAMVv26sxZ9CEti+Q9/urX/6u
         uWt1zDVP8nqEj1/j2zXZpCYrOeZqtEhg95mp1XTZNiEDEF/wnueV3xMtsK8XDeTy0VjM
         3vVKEbQkkhow4RTzSCHyOULC68kL4slPDj8ITYhhiQzUdDlifDHxyep4c8ifLx4lnh9u
         JbrbJ8KJhVEINH0VE1UhjvvgrZnP9OIjQUOg96JSaJmXA4FKJfTlbiFx/HtRy6+wmkAq
         wuvY1DJuuIvuxb5mgbO7FJy1VfI4byL72wFTiSqtKxQL8u3AYs6p4eRxuuPUpGGTyH5a
         8rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4h3dhzIalKM779J1TMHqw2IMtT+aQ6BFTV4HKHQb8M=;
        b=oW2f5yRHArLBhx+ibsVXEjIofMfekdrttsuYwm72xCafzEgm1rGgnzSVqPzHRkFLyL
         U8A7OnsBhGGlxKYrXmyglai8mKU1IjkxiULKP7SywG7QeCD1nVHZMMht/SzZ8zOHszrp
         T4sIamBd9E9ubYJVKsOH653KCPZMye7tjsW3fsNaZ2mP0InLfyyTfLTx5RFBdYwKluo1
         aN/uPYiPp0rFfExmyiR5qQKC14xN0u2AtI9JGTvOBOczI9M01jYs5mV/1fFJUoZvk3TG
         sFAJbT0rt/Ue7uBFRbmrtQ+mUwe3LC8gRynY38tqnKmO/NoQ6n76oEgkYT7MtwjByvo9
         qIuw==
X-Gm-Message-State: AOAM532wsTnJcY0EJESpJ68UjfDRzvsxVJPtkZmaY190GP24b680GTkf
        oixg7hC/mXtWXnMZF9H52+95tfi544Y=
X-Google-Smtp-Source: ABdhPJwaHv/Qz2QnRjIRxjtYbi+hgG6gdxZNRwYTIAQTFSFwnxEzOphWkvYxRCx7iuJ8rSbaY6nfLA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr5041897wmh.27.1590598090670;
        Wed, 27 May 2020 09:48:10 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/12] upload-pack: move allow_sideband_all to upload_pack_data
Date:   Wed, 27 May 2020 18:47:41 +0200
Message-Id: <20200527164742.23067-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.38.gc6b4ed14d2.dirty
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'allow_sideband_all' static
variable into this struct.

It is used only by protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b5647eb47c..becefd5bdc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,8 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_sideband_all;
-
 struct upload_pack_data {
 	struct string_list symref;
 	struct string_list wanted_refs;
@@ -99,6 +97,7 @@ struct upload_pack_data {
 
 	unsigned allow_filter : 1;
 	unsigned allow_ref_in_want : 1;
+	unsigned allow_sideband_all : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -1142,7 +1141,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		data->allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
-		allow_sideband_all = git_config_bool(var, value);
+		data->allow_sideband_all = git_config_bool(var, value);
 	} else if (!strcmp("core.precomposeunicode", var)) {
 		precomposed_unicode = git_config_bool(var, value);
 	}
@@ -1337,7 +1336,7 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
-		     allow_sideband_all) &&
+		     data->allow_sideband_all) &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

