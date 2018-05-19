Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FA31F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeESF2p (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36538 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeESF2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id t129-v6so16883774lff.3
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tMZGh11fMtjtfMEQD+evzOxXMcNvO0cjUGJqWFr/a08=;
        b=L6FH9DWxjdJQhwBDEIO9l7dTB3j4oB4a3Iq+GEAUjPi8TIwmZn2vxzveVVRIfMIIoV
         i8wx6L+kpSEgaXj3jwdYgTwctMtS3kWpLYRpxyqNWrliAxkcRKtQXbbRhCHvd6iMNAGU
         S6Y9y3XpkyPN/BO0DO/jcKI3886TA92Ft3ZuvBtzakkfMHBOvlLyZtMYUQrkgLxqousF
         8jYd1iOlq8I+DAUAyQ3NkXKCRpR1zy/knqfQvKADNA49htwy8pZzlie6Iup5o8odmArV
         sWDJdnJHV6XPagq7lVTjIbpi5hGxXVOPKTHvN/sbb/a8VPJA0em5oMQT/mJHKGBuv1DK
         HO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tMZGh11fMtjtfMEQD+evzOxXMcNvO0cjUGJqWFr/a08=;
        b=s1Jy8MXlOQcVEFA2fA58oSXm0Xx53sqNVqEW8RZoGKJV9Lart9OAedZWGYxmivmfWj
         hi5K8jZubZ31nLsZMwxp1nCPtVpqbdPTj9Cfzqo0ZxB64yXBl6Uk7ME9hKFEoOYjjb9m
         1N8tb1U8VlOYDefhcxhnOdwtHFEgCala7H9LxMckpofRuVitk7lGB33bjNTiVDPjoKuj
         9zEZvV184qy+327hMn43QZow42PvtNffssy/DwmilZMN2uSa7XX1Pb9ay1SIqePlcdiQ
         lKot8/FqedV3hV9bvb7aysmf2IvcZO3fg61nO4wLVfLItB9QoZwyZj3MvX7aAAHjN161
         S7AA==
X-Gm-Message-State: ALKqPwf36Jutl2qp7MawutSp9l18Vn9G16qdGI1ApD9m2l8hwuyeFc9t
        76s8HSlHdmiL/MOWdn4rIki41g==
X-Google-Smtp-Source: AB8JxZpJi0SAoiuOVR3JOknmVcizq0LEg9IlovVyt1CxuCOm+WGO3MY8uNVpax5WBo2RnpchdPfp/g==
X-Received: by 2002:a2e:700c:: with SMTP id l12-v6mr7627987ljc.68.1526707719968;
        Fri, 18 May 2018 22:28:39 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 04/15] describe: use commit-slab for commit names instead of commit->util
Date:   Sat, 19 May 2018 07:28:20 +0200
Message-Id: <20180519052831.12603-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.
---
 builtin/describe.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b5afc45846..1b6ca42553 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -15,9 +15,12 @@
 #include "run-command.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "commit-slab.h"
 
 #define MAX_TAGS	(FLAG_BITS - 1)
 
+define_commit_slab(commit_names, struct commit_name *);
+
 static const char * const describe_usage[] = {
 	N_("git describe [<options>] [<commit-ish>...]"),
 	N_("git describe [<options>] --dirty"),
@@ -37,6 +40,7 @@ static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *suffix, *dirty, *broken;
+static struct commit_names commit_names;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -321,11 +325,14 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n = hashmap_iter_first(&names, &iter);
+		struct commit_name *n;
+
+		init_commit_names(&commit_names);
+		n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
 			c = lookup_commit_reference_gently(&n->peeled, 1);
 			if (c)
-				c->util = n;
+				*commit_names_at(&commit_names, c) = n;
 		}
 		have_util = 1;
 	}
@@ -336,8 +343,11 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	while (list) {
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
+		struct commit_name **slot;
+
 		seen_commits++;
-		n = c->util;
+		slot = commit_names_peek(&commit_names, c);
+		n = slot ? *slot : NULL;
 		if (n) {
 			if (!tags && !all && n->prio < 2) {
 				unannotated_cnt++;
-- 
2.17.0.705.g3525833791

