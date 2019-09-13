Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BFF1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbfIMNC5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:02:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37753 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbfIMNC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 09:02:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id i1so27021746edv.4
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdwQgh7pzl+xQZbSdut6vaCCldhq0LrCbRM8FplS/8E=;
        b=ER8D/UnwQ0W9HKzYFlNewEwgj0KxMwdBmmQbkghH5yHHaDu8PNgDe/yGcRHA118qlp
         1yZUf7Y5S3A773BMwiZbRLV7lcmNhTEi7uPCCpxFmi26QTnM9FaCLZJoahaZixki6uxh
         94ppG3EQT9otlaPudL5JXqaOJcCGZ1rt2UzD0Y1BtzuAT7bldrEimgNUT9XQf8ZwzZbG
         1tI0JlnxC5TlZNMKCEiXdf0rc0j93CvlcfOdkUUQClLBhIvg5v7a97UJtNAzqeo7Xhlv
         ir2F11/32V6JyfPoktx/x1Rrh2syXECWY6MzaWPX0A6Pq00u+vKGekT6qM393ORrbXL7
         PLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdwQgh7pzl+xQZbSdut6vaCCldhq0LrCbRM8FplS/8E=;
        b=Uy6a1KAr2ZFXQnZPNMv6j1Kgz8DU4OIg/XNJxEnCftifyi/mxPzWwd+FQz0YfyJuf6
         td1A4KLozqqjWydyxXy3eC6DY9pOKVRmmCHLpYdRUTgG9XMZLegweLR2X8hEPHgH7N6m
         gdxYUfH2GqaiNwpvOmVpHw0gs551vM5iBEqwOLMkY6Yqh6ZLc62XGaO2taUA/sP6P6uV
         U8nxlEzVcc9jFZrnG8Mu05uAbgjN3JGC7sqf+JnhNscYkmZnQWnC5NNJI5ixI0vrLdyI
         eUWFAMpXSwArQzNtD8CxHuMAvsL7Ac5mdYoqqH10nkWKZMM02Elu80qMb+BsYL+QBtWL
         3mwA==
X-Gm-Message-State: APjAAAVsMhrZFBcM6IlBYEKPpvBSSdDtjCUUUPQ97K7w8CMObiBuzL71
        NNjgYVrtQ/euUrzFnxzkVadFnge2
X-Google-Smtp-Source: APXvYqzfah16AKpOknv164EAUG2jhB0VD/jJbiPgyHM989c9JTF16vWSxqqie9+j7j8qg0Qt6TNaow==
X-Received: by 2002:aa7:c24f:: with SMTP id y15mr49157710edo.152.1568379775126;
        Fri, 13 Sep 2019 06:02:55 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id c14sm2846570ejx.31.2019.09.13.06.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 06:02:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 08/10] pack-objects: introduce pack.allowPackReuse
Date:   Fri, 13 Sep 2019 15:02:24 +0200
Message-Id: <20190913130226.7449-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.23.0.46.gd213b4aca1.dirty
In-Reply-To: <20190913130226.7449-1-chriscool@tuxfamily.org>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's make it possible to configure if we want pack reuse or not.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c11b2ea8d4..1664969c97 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -96,6 +96,7 @@ static off_t reuse_packfile_offset;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
+static int allow_pack_reuse = 1;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
 	WRITE_BITMAP_QUIET,
@@ -2719,6 +2720,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		sparse = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.allowpackreuse")) {
+		allow_pack_reuse = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3063,7 +3068,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 	if (!(bitmap_git = prepare_bitmap_walk(revs)))
 		return -1;
 
-	if (pack_options_allow_reuse() &&
+	if (allow_pack_reuse &&
+	    pack_options_allow_reuse() &&
 	    !reuse_partial_packfile_from_bitmap(
 			bitmap_git,
 			&reuse_packfile,
-- 
2.23.0.46.gd213b4aca1.dirty

