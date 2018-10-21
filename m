Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13F71F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJUQWq (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38729 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJUQWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id x24-v6so12331389lfe.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DpLvrt58z39wqrAIBLzt5dGOySDlIdXbtXQtwJjyg0=;
        b=Rfftcp3Prc8x49vcXQX1Ha8FhWXvctS8FU7vKCE+3Q6cRpJs2/n2n1sCME5GsX8whm
         ftxKRdi1tbDmzyV6JtZGI1Rrb2eC0KguS8FpFZXFgtrOOVYQT20hmFQOdGgamTSH18fa
         dqH5wjx/3LvJQA2DgKGSkEavB83jZSMuYbkPW69JPqMhG3EWRdBsneBRLNPaOApX5dwl
         JGe7JiAFdZrQ7zt2FuOU7VjwOF8WqxOxqUX8t9SyVu6VbiuiH02Lv9XkPAUy3aWjR0Ph
         T4ArtY4EkWG0IDbBnz8nk7XRcgiMwrBlQi2z51UULBA+CPaehrM1eiXBaR6fZ9VB+iv5
         bzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DpLvrt58z39wqrAIBLzt5dGOySDlIdXbtXQtwJjyg0=;
        b=Y+y8nACjzsbQ31eWuR1BeQ5Td/hwci/N/WHc5Ptld3kDYphDejSrGhPjQVWjm5tBUU
         H+eSChcvjxVbsNEHttygky+tkUMpO5UjcAwuja435OIak4YJS1dYbxfqgYKBtVvq6KDa
         OUFIacqOKiR/qNHQMvyWiSUPVHfqX4bcnHjsqoff8sGf+/+I+9tRITa1d7Ld2FhihCgJ
         oN4TMMAi14lCiTTQg2lW7PAWuLAjuZMzxezXSYkuWj0Vw6tBB3pUBLOykNrImc5n8zUI
         YFo07/VK8yUowh71ktds5zS4KYPTtP7qMLXP5JiiEfjaCQda0oeu7B+tRuETJ0FPKUnM
         YAhw==
X-Gm-Message-State: ABuFfojUCXczdG3eEq3t8OLfpr5ehqhm0IKU/UcXowM1IqoGdQtikaL6
        Is5yU7/rHckHrMhirjDNtkA=
X-Google-Smtp-Source: ACcGV60iAltaRtoNKjBzHr1wA4qjLikZjAVB55QUkILdSvLFTAknepYcMZ9K+TontUTKGYk1Numq8A==
X-Received: by 2002:a19:2b54:: with SMTP id r81mr444517lfr.34.1540109354169;
        Sun, 21 Oct 2018 01:09:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 6/8] fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
Date:   Sun, 21 Oct 2018 10:08:57 +0200
Message-Id: <20181021080859.3203-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181021080859.3203-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This will make it easier to check the HEAD of other worktrees from fsck.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..0d39462058 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -36,8 +36,6 @@ static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
 static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;
-static struct object_id head_oid;
-static const char *head_points_at;
 static int errors_found;
 static int write_lost_and_found;
 static int verbose;
@@ -484,8 +482,15 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid);
+
 static void get_default_heads(void)
 {
+	const char *head_points_at;
+	struct object_id head_oid;
+
+	fsck_head_link(&head_points_at, &head_oid);
 	if (head_points_at && !is_null_oid(&head_oid))
 		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
@@ -579,33 +584,34 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(void)
+static int fsck_head_link(const char **head_points_at,
+			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", 0, &head_oid, NULL);
-	if (!head_points_at) {
+	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
 		return error("Invalid HEAD");
 	}
-	if (!strcmp(head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (!starts_with(head_points_at, "refs/heads/")) {
+	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
 		return error("HEAD points to something strange (%s)",
-			     head_points_at);
+			     *head_points_at);
 	}
-	if (is_null_oid(&head_oid)) {
+	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
 			return error("HEAD: detached HEAD points at nothing");
 		}
 		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			head_points_at + 11);
+			*head_points_at + 11);
 	}
 	return 0;
 }
@@ -720,7 +726,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	git_config(fsck_config, NULL);
 
-	fsck_head_link();
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
-- 
2.19.1.647.g708186aaf9

