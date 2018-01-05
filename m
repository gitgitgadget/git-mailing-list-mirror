Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F481F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeAEU3R (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:17 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36881 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeAEU2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:51 -0500
Received: by mail-it0-f67.google.com with SMTP id d137so2981310itc.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PzdWhWzIsKQwRXySszDsBU/m9872vTjeP1DlpVzSRqk=;
        b=aOsBwLNJkxoDrVjhoVDcDG6eU7MLcoLS9cF7I2ElcGJmoWfsLoFUHIU/8h0iYtUlpD
         h3RKktDVmlEWT5J7gWPjpEnDYuWnVw8mDIVgA0RZZ9WhDlibrgHXSzxoJpupwFpNGixg
         afuNXEDU9SMdR2V7vBLc0bVdiqBXPJofW3y015FyLdlxqQoiTFzAeNWGWdptgbNd7RQK
         hw5MEF5zuKPowuhCnCV4XeH5X0c8KXwdokyPQB2+jkFSTnZb5+P3nXgxtz4UmR5hhLIJ
         mUgKG5kw/f3UVIcMu+aai3tz5kEn2lmgcOnAV1Ej0u3iIbDQ21op3zt0O8hkcZ0qa4hT
         GpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PzdWhWzIsKQwRXySszDsBU/m9872vTjeP1DlpVzSRqk=;
        b=YFbj354G/ld/nvIn+LJwzKGkUFM0lGMjLeali/Q0MMJSZC6FHcAmwFTd5lhsfU45wC
         1nT7AEyjxO4vrFJcdTKqHpn7pVJ2pLJfmhyaidscVZ3huKwp3Fov4VRWLbDoxzG9uewn
         7dPOmZi4uqojIf4V50RM5wtyRB/0X+UkPLVzgi5M5adJDk65azFjIuBU5JfHzMBJ6OD1
         LYCvBwUaTwDajeuAY+3mjmseFUuDU5tbrg9SBztlKz23nG3Qf8jnvRavS56V3YBrV6Hz
         q8bjHF/Le2vqGK3E77fCe3KaAU2fcDWyJaLWLJ5QC1tIbAhT6Zv2jOBu8SfWu3JohJYH
         slGA==
X-Gm-Message-State: AKGB3mKPWSSIfsz2o6dqTGp3hwOpByfcSQlYA0DPE0WNph34Oqr+aGqH
        rBHD6nFdbW2L8vq3rXDjYYgQoMyL
X-Google-Smtp-Source: ACJfBotN0bw6LpQMmR68z9zHjFAS0k8gh/UOsoELM26EriTzG5acjK3lD5FG/M1ZiLAlMGkGLhqUqw==
X-Received: by 10.36.108.10 with SMTP id w10mr4484728itb.7.1515184130884;
        Fri, 05 Jan 2018 12:28:50 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:50 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 24/31] merge-recursive: when comparing files, don't include trees
Date:   Fri,  5 Jan 2018 12:27:04 -0800
Message-Id: <20180105202711.24311-25-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
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
2.14.2

