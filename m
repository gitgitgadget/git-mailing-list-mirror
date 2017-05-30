Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D182027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdE3RcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:08 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36447 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdE3RcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:02 -0400
Received: by mail-pf0-f170.google.com with SMTP id m17so78259916pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLxyYNEtxf2393uNO9OqzxDKowNPhiUwVcTyeT+cGRs=;
        b=v2e1fWi5i2Ee8TfTgj6sWrckbZGOHMRqCCKqmvK4gCqK3q2qNcs14iob00aHPbDuea
         H54sFyBoh3acGoluNUS2+akU6s5MgGa+8wdYSvlmMbI37vYcvsXYkNrH/mCaJY6Ve47q
         CVpm/e9Zhpx6LParSGikNL7GnZTbGtNL9HYIyK30JL4XyiSizigkeynNJD+i+22oyrXx
         +a9xRZJ13LM4cdxQgS60CEMKPEWyvTyHr95fKhrVmlZC2AxiZuZ8R5VoJGirLU8d6C5E
         I6yQ55fVEZeVYKkP/RIxXimzMwJ7jzLvcjhC76BoA20BP5bbT0UbStvvcXzP6zgmivX4
         GPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eLxyYNEtxf2393uNO9OqzxDKowNPhiUwVcTyeT+cGRs=;
        b=O9Q8iNCRDzsA5zGmA+w4Vy5/MLi8flEHcvPa8GcUAx3asFveobmP08BB22gKnw83Fa
         v+CO2dqGNBM2SN120wlW8H2F/0Cu57l6fW5WgvVXNXY450j0FtxICYOIq4pzOt6oNRXL
         eok3AEUkMR1s5Q/GdpVthr/yf3egVrFN9HWmhEfLWzjfWfZE26+g+pAnO7SBywns4wjD
         3ecUQg75iLb0/HS6/560AqVOKiEthQffuQMlfQNUVtxIV/q5Q3lLiJYY4DaieNA4zIhZ
         BO8P+f383W6slYMOT4KwdPa/tZL0hqNHx8kTeNEHGw5iER2b+Lp1Xz7Tyi3zXJJETK+2
         gB4A==
X-Gm-Message-State: AODbwcBNC9YpO74XhdcS61J0UPZHlDnA7a+r2YdBba7JHqFO4b+YD153
        UBgMikHzg6VYQkZH5NJFCw==
X-Received: by 10.98.2.85 with SMTP id 82mr24521532pfc.52.1496165505779;
        Tue, 30 May 2017 10:31:45 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 20/33] combine-diff: convert find_paths_* to struct object_id
Date:   Tue, 30 May 2017 10:30:56 -0700
Message-Id: <20170530173109.54904-21-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert find_paths_generic and find_paths_multitree to use struct
object_id.


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 combine-diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 84981df75..c82364510 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1311,7 +1311,7 @@ static const char *path_path(void *obj)
 
 
 /* find set of paths that every parent touches */
-static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
+static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 	const struct oid_array *parents, struct diff_options *opt)
 {
 	struct combine_diff_path *paths = NULL;
@@ -1336,7 +1336,7 @@ static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
 			opt->output_format = stat_opt;
 		else
 			opt->output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_tree_sha1(parents->oid[i].hash, sha1, "", opt);
+		diff_tree_sha1(parents->oid[i].hash, oid->hash, "", opt);
 		diffcore_std(opt);
 		paths = intersect_paths(paths, i, num_parent);
 
@@ -1360,7 +1360,7 @@ static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
  * rename/copy detection, etc, comparing all trees simultaneously (= faster).
  */
 static struct combine_diff_path *find_paths_multitree(
-	const unsigned char *sha1, const struct oid_array *parents,
+	const struct object_id *oid, const struct oid_array *parents,
 	struct diff_options *opt)
 {
 	int i, nparent = parents->nr;
@@ -1376,7 +1376,7 @@ static struct combine_diff_path *find_paths_multitree(
 	paths_head.next = NULL;
 
 	strbuf_init(&base, PATH_MAX);
-	diff_tree_paths(&paths_head, sha1, parents_sha1, nparent, &base, opt);
+	diff_tree_paths(&paths_head, oid->hash, parents_sha1, nparent, &base, opt);
 
 	strbuf_release(&base);
 	free(parents_sha1);
@@ -1448,11 +1448,11 @@ void diff_tree_combined(const struct object_id *oid,
 		 * diff(sha1,parent_i) for all i to do the job, specifically
 		 * for parent0.
 		 */
-		paths = find_paths_generic(oid->hash, parents, &diffopts);
+		paths = find_paths_generic(oid, parents, &diffopts);
 	}
 	else {
 		int stat_opt;
-		paths = find_paths_multitree(oid->hash, parents, &diffopts);
+		paths = find_paths_multitree(oid, parents, &diffopts);
 
 		/*
 		 * show stat against the first parent even
-- 
2.13.0.219.gdb65acc882-goog

