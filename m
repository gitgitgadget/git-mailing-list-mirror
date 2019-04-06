Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9773520248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDFLhK (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:37:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33418 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLhK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:37:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so150587pfo.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvY2S7a8efdubnqZ497rHTpt8jwV5naQZUHDCe65xZU=;
        b=NhOcyjVpeQlj0hx2BCfCQRu0xHpJYk7bd7aaTh/sd3pKK43sgNXQYtvt7ibCgvpWiD
         7CJINQWq0Sw243Aq30CiOf1Ht1klULfPeDcqqojUfUVC7G85AgAqd1Y+c6gbQ/f/xjXg
         UDgQ05a5tM/PZleYcdpGeH337svgXRya1hg6PZ4RwD+HvUkrsmffZvpI2dYH/SP9yibT
         JzbHVjMvq2btS/a1sx9Zb/PvLGkJ5732nzEu0KVflixgADjT91HA8N0byxbZ4R5rSXrf
         8YIYqv85WG99vzA+UgGIUw27mUCO2IYxxrz149zRPVGstmB3ZBtkLT22DP4GirmhZ0/M
         /HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvY2S7a8efdubnqZ497rHTpt8jwV5naQZUHDCe65xZU=;
        b=MA/jknIINAD9KPIUdwcCuD7+G43+cb0hf4IzTxxjkmlNCNdXZ9eF9eZv+J/V1ZqX5U
         dfAVR0O3VdgTrSG5Ei7QeCnpjFf8pLDiKd/fFx5UTi/QK5Ze0GWGjuMim/zCWZwHKggS
         FNT5JLfCVJlLuW0HY4kLz3mL5hDjk40U80LQn6123fN0qgUIti3HJgRnR2pgimo2gJwP
         Jmt7UxGuGLpYrY6NG4ZbK113PqyD5J6rBvBQ40NlQmbM+vA/K59lHJF+mu1niDw04qqW
         MUe7d02RIr/iYjSzpzhF8pPQ1AV9YA2neBFu9SHzt/TcGrn7xM2AV/7+B778Ac7RZm0g
         T7BQ==
X-Gm-Message-State: APjAAAXohKM/qdzMxFVYDEoZrvDw2q2ttthYbCYBG7/+VWI6yerWL46d
        Tsn6qvBXAsWNSrfpRj3pwNs=
X-Google-Smtp-Source: APXvYqx5k3/BPwNn4+5adOYrObC9HrQ2ORLzinQHn/81eBGVXW1X7mDWtAT9KUbEcncpZ6DHd3ZtJg==
X-Received: by 2002:a65:50c2:: with SMTP id s2mr16611426pgp.112.1554550629794;
        Sat, 06 Apr 2019 04:37:09 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id o67sm46945777pga.55.2019.04.06.04.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:37:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:37:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 21/33] sha1-name.c: remove the_repo from get_oid_oneline()
Date:   Sat,  6 Apr 2019 18:34:41 +0700
Message-Id: <20190406113453.5149-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 49c62d5254..fb80306f1a 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -15,7 +15,7 @@
 #include "midx.h"
 #include "commit-reach.h"
 
-static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
+static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
 typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id *, void *);
 
@@ -1090,7 +1090,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 
 		prefix = xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
-		ret = get_oid_oneline(prefix, oid, list);
+		ret = get_oid_oneline(the_repository, prefix, oid, list);
 		free(prefix);
 		return ret;
 	}
@@ -1204,8 +1204,9 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	return 0;
 }
 
-static int get_oid_oneline(const char *prefix, struct object_id *oid,
-			    struct commit_list *list)
+static int get_oid_oneline(struct repository *r,
+			   const char *prefix, struct object_id *oid,
+			   struct commit_list *list)
 {
 	struct commit_list *backup = NULL, *l;
 	int found = 0;
@@ -1236,7 +1237,7 @@ static int get_oid_oneline(const char *prefix, struct object_id *oid,
 		int matches;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
-		if (!parse_object(the_repository, &commit->object.oid))
+		if (!parse_object(r, &commit->object.oid))
 			continue;
 		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
@@ -1760,7 +1761,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			for_each_ref(handle_one_ref, &list);
 			head_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
-			return get_oid_oneline(name + 2, oid, list);
+			return get_oid_oneline(repo, name + 2, oid, list);
 		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
-- 
2.21.0.479.g47ac719cd3

