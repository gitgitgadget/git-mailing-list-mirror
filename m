Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FD11F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbdL1EO7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:59 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43891 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbdL1EO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:29 -0500
Received: by mail-io0-f193.google.com with SMTP id k202so28893259ioe.10
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ij76iHcqJAwWnMrktCw1TfADfbfWPyBFSyo9zNjkOe8=;
        b=dGZ6tVpR5bExtIN6FAV5LXCR+XxcUZe2V3RHK4qJyx3bNIhsibTd0gy66wZMyY0TX/
         llBhqLQbpn+SrZU8VHHitCWZiwOd9lzsmp72ybJLIIs7yXDXL7ancZAs8gGR4HGF8DOt
         EkpnhyDw80Ty+8+7CGNxBytUq7z7qj8GElgtPxdb6kz3a2T7Et8pm1P/kQE4ePXFa43O
         Oyay4A1cubqCX4FjQxpLAB0xZrAf7ZP6brDzoOHfuvDJVX7u9vXQ/gdh1pYqUDNty/cL
         5pUS+WitPsJLfs+9XzzF9Gr2vlxA9O/sYMsiOONncbzE5E0IsVm1ytTiZq+COWY+3CTe
         yA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ij76iHcqJAwWnMrktCw1TfADfbfWPyBFSyo9zNjkOe8=;
        b=qJGaRk50ShWd0VcuTXwIhjSL91HsGdRrB/8PsHXw7v2Hh3FCydslAIywtPWTHlVDhd
         HFM5ka2YXI073YUdYJbDonqaNlIVyzaOOiXfcxX3ctr0inAsaGFcWkchf5zhUW6/a1nG
         kgvWzUySn1VflzJEcSHso/DVoEH4wiKzbll4ka3uORBhtGyWdt2CuKqSbPJES8aPHVnt
         +HaT0IJZa3avjOA/7hsGUL+q3E87bXxAUxv9R/qDjLqAXmrWMzKEH7ymGNq/EK2sjxH7
         p4MEWX2ImSNnnWgFqVHqdz4Y7IAzvBloEEVSFdxdbConRcsMEpJIQJrA2iqZUPkLskey
         vXJw==
X-Gm-Message-State: AKGB3mJLrv26GEh0wUCHf+AC7x2OzN5G9HwnrZRJ51Y/8U9AKn5VcUow
        CcaW373MQa2vPX1F0y8jLNw/ng==
X-Google-Smtp-Source: ACJfBottvtl5zX2Gzq8z/2PBHIWtf1aS+eKLnmSOlaPEn4q5bTxoS1W837YMT+yDLq0bWyg5KMOdHw==
X-Received: by 10.107.139.207 with SMTP id n198mr34098148iod.32.1514434469040;
        Wed, 27 Dec 2017 20:14:29 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:27 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 27/34] merge-recursive: when comparing files, don't include trees
Date:   Wed, 27 Dec 2017 20:13:45 -0800
Message-Id: <20171228041352.27880-28-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_renames() would look up stage data that already existed (populated
in get_unmerged(), taken from whatever unpack_trees() created), and if
it didn't exist, would call insert_stage_data() to create the necessary
entry for the given file.  The insert_stage_data() fallback becomes
much more important for directory rename detection, because that creates
a mechanism to have a file in the resulting merge that didn't exist on
either side of history.  However, insert_stage_data(), due to calling
get_tree_entry() loaded up trees as readily as files.  We aren't
interested in comparing trees to files; the D/F conflict handling is
done elsewhere.  This code is just concerned with what entries existed
for a given path on the different sides of the merge, so create a
get_tree_entry_if_blob() helper function and use it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 78f707d0d..01934bc1e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -418,6 +418,21 @@ static void get_files_dirs(struct merge_options *o, struct tree *tree)
 	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
 }
 
+static int get_tree_entry_if_blob(const unsigned char *tree,
+				  const char *path,
+				  unsigned char *hashy,
+				  unsigned int *mode_o)
+{
+	int ret;
+
+	ret = get_tree_entry(tree, path, hashy, mode_o);
+	if (S_ISDIR(*mode_o)) {
+		hashcpy(hashy, null_sha1);
+		*mode_o = 0;
+	}
+	return ret;
+}
+
 /*
  * Returns an index_entry instance which doesn't have to correspond to
  * a real cache entry in Git's index.
@@ -428,12 +443,12 @@ static struct stage_data *insert_stage_data(const char *path,
 {
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
-	get_tree_entry(o->object.oid.hash, path,
-			e->stages[1].oid.hash, &e->stages[1].mode);
-	get_tree_entry(a->object.oid.hash, path,
-			e->stages[2].oid.hash, &e->stages[2].mode);
-	get_tree_entry(b->object.oid.hash, path,
-			e->stages[3].oid.hash, &e->stages[3].mode);
+	get_tree_entry_if_blob(o->object.oid.hash, path,
+			       e->stages[1].oid.hash, &e->stages[1].mode);
+	get_tree_entry_if_blob(a->object.oid.hash, path,
+			       e->stages[2].oid.hash, &e->stages[2].mode);
+	get_tree_entry_if_blob(b->object.oid.hash, path,
+			       e->stages[3].oid.hash, &e->stages[3].mode);
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
-- 
2.15.0.408.g8e199d483

