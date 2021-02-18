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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC8AC43381
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D939C64E85
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhBRM04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED201C06178A
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id x4so2581090wmi.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlSv3FJGfnahlMf3GQa6RyUZQW2vxjTloj5EoPjtJv8=;
        b=IRINxIOB0GEfE8e1mfUkNT2THLr3AoJuWF1A5PY8/Wgzfn2KbsKCj1H3BcNBDpwZ6Y
         zLP8jkEGe2rRMOVrQiXtQ8GhhoFgo4+lvW+UEZ/GwSF44rbbU7yW+2nM7WsDJPNqQCgH
         13jOdfD98UKFFEfbGdsxNgvugovqrkzg1FSjcM9khOcQovhEHCgYsKCDrpM4RjtcbGDb
         rVePsZlxQQqm5lcbrzeaNYvwM7n9zKrymED3fiBHRXkLfiHrlfveP40yb0evGxhSTXmT
         hjl4BSDMEXODapRH6xTkREb5MgPj+p0CcqcjXuwBYIcG+Za1JTD7vPNw5EdkxdELXDJP
         snAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlSv3FJGfnahlMf3GQa6RyUZQW2vxjTloj5EoPjtJv8=;
        b=LgAVU/j2L/fXHGpQ0/PlK4ItHq++4wqATlCP9nJ7DXtQ6yFTkSG2/p8/tf3x2HW+0V
         Ta4L5k3spyVgwCuNIUgQffKJOnOEcmSXr5G4ASX4v0t8MFEDEazNpKe7X6GLWXu0Z59z
         MWzPgzgzVFVByKWk3aQ52L9wOgIMJKDuHUhh1iMb2f4oc6OmcWhMssNAwpZPhIvK4FDw
         w8eoZGvQkm0fFlVcIej/m2MEhV/Nmo1Yi01yw/+oIvswTWpJ6a3DUGYTSQ++nuGAHwjq
         GZhC1vyld05ee/eiq6qaKCsc+OfzNOK30WXbJgcQ2es6RBnXbbOY4ubYdMirf08Sru8D
         AU+Q==
X-Gm-Message-State: AOAM533G9Gbd0oAviB5djpgoWX7ElRumYIAwYtXQARVBFCqIsVrRA7Yy
        Sjn5nM8lsdx8Db15xB3rCGAxqNG98ijSTA==
X-Google-Smtp-Source: ABdhPJxij93lcTiELuDCdxClnxIS3lP3SiPQtAHFew2od50i0vsRmB/x69UPIk4jRZm7QPNGIDbP+Q==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr3102530wmq.118.1613645925346;
        Thu, 18 Feb 2021 02:58:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] fsck.c: rename variables in fsck_set_msg_type() for less confusion
Date:   Thu, 18 Feb 2021 11:58:33 +0100
Message-Id: <20210218105840.11989-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename variables in a function added in 0282f4dced0 (fsck: offer a
function to demote fsck errors to warnings, 2015-06-22).

It was needlessly confusing that it took a "msg_type" argument, but
then later declared another "msg_type" of a different type.

Let's rename that to "tmp", and rename "id" to "msg_id" and "msg_id"
to "msg_id_str" etc. This will make a follow-up change smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4b7f0b73d73..acccad243ec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,27 +203,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 }
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type)
+		const char *msg_id_str, const char *msg_type_str)
 {
-	int id = parse_msg_id(msg_id), type;
+	int msg_id = parse_msg_id(msg_id_str), msg_type;
 
-	if (id < 0)
-		die("Unhandled message id: %s", msg_id);
-	type = parse_msg_type(msg_type);
+	if (msg_id < 0)
+		die("Unhandled message id: %s", msg_id_str);
+	msg_type = parse_msg_type(msg_type_str);
 
-	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
-		die("Cannot demote %s to %s", msg_id, msg_type);
+	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
+		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
 
 	if (!options->msg_type) {
 		int i;
-		int *msg_type;
-		ALLOC_ARRAY(msg_type, FSCK_MSG_MAX);
+		int *tmp;
+		ALLOC_ARRAY(tmp, FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			msg_type[i] = fsck_msg_type(i, options);
-		options->msg_type = msg_type;
+			tmp[i] = fsck_msg_type(i, options);
+		options->msg_type = tmp;
 	}
 
-	options->msg_type[id] = type;
+	options->msg_type[msg_id] = msg_type;
 }
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
-- 
2.30.0.284.gd98b1dd5eaa7

