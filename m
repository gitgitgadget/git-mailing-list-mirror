Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7871120248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfDPJgr (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:36:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45320 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfDPJgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:36:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so10041488pgk.12
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Au72nD0mzmIoTlJ4G9ZcHMEFQ21HgCU9A/l+x38acd4=;
        b=mhOWOqOo5lETmVW6e6icfCuOniFRWWjoCFROPwg2fy9M/G6mqwSQL9ZKqx8+Wi1Kn8
         q1huHu0+eU4Qz0s3vHDA6M6H8Daru9toaGExdHPnWFXGhCjzlkomMr44xx+IrEblSVZ0
         4E/k1jFD3bRocUPysKdx8lp+ZOVBp/JGrMv/rvT3iQpvjUJ7qjPHtCXrorHT14o/Dwey
         Y81RcgqTTmel5ydPtaj+8BYcLqn05YfLVy3rVG9p7b3WtoA0T5i2XZupiMxzHHi+Lr8Z
         BXxFm9kSNgMLkTTpYdHwyV8Q14qwKAdvomn63+SUyeWzAd6+BDPV2oNMynh2OELq4u15
         5nnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Au72nD0mzmIoTlJ4G9ZcHMEFQ21HgCU9A/l+x38acd4=;
        b=k84dU9h4zzNwsZGfKmBIpS8ZvbBgWZISqmiHeWJHIH0y3pCNx43OllKtm4Ngl0qkIq
         owBlWahZh1w0Q8Mx8Vm9q/edKoVxC3JCMka+qOHColhMwmxK+3WyROBLmelIemZUhab1
         GjL1yRwe0Fd05Ey7RbMOc+jWZODe500fKI3abGb8j3CrqtTtBF4Z1Jy3U8RgxONP0O3b
         qvVCUvu1EdLWVvDeX2ZWLHCJyIgrLVWIsbo0jZ55He4a1qGqNis871wV2dcKozO9N0WP
         niY32cB69wUh8ARdeRDF1pGdt3XE0XqjREgcowuv5b7yvXJcAiXDNBRgOW9BC7MWYxJb
         NtWg==
X-Gm-Message-State: APjAAAWVa2BKRYEVvpKAkjKL45YUwilIe4jHOPgeUGktUA+5Cv+cULHU
        OKCOx9o6HOjMOpRQDd50rbyNL2vJ
X-Google-Smtp-Source: APXvYqzEUrGHsSoopN+4cApq5t0ytMGwh1KelvRA5+fc+k8ube6XuMfNaMYxLd2mNm1msaTi2znbBA==
X-Received: by 2002:a62:1318:: with SMTP id b24mr80419031pfj.201.1555407406361;
        Tue, 16 Apr 2019 02:36:46 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id q74sm93130396pfc.111.2019.04.16.02.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:36:43 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:36:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 22/34] sha1-name.c: remove the_repo from get_oid_oneline()
Date:   Tue, 16 Apr 2019 16:33:29 +0700
Message-Id: <20190416093341.17079-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
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
2.21.0.682.g30d2204636

