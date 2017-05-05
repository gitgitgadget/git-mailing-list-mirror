Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1699207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755972AbdEETyt (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:49 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33363 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdEETxu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:50 -0400
Received: by mail-pg0-f47.google.com with SMTP id y4so7703081pge.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ahs/h6Nxbc9NurCZ5tGwHHWH3eKzk/ewUrrEF2fE8co=;
        b=PHEbaHW+o320lXoIh6+Filx8evpWmYbZ4384mx3/4/oZ1ccNvGbbYB70au9ywyR7vG
         z7GO2Bw7BWmm/grdTDmz79PkBeBV4OPyanoaz9JA5zVGzPkqJbw64Z+rkLEA9Fe4IJnu
         puxGMUyLO0tTCyVXf5eyPgXX9cVFnPeqefDrwzM8Sv0hMl5e1S3R045KkJTmzImsbfmi
         cZnWC1vyvmUJha6o3YrzI8Lt0tE/dhxpXc2N/i001PiGEfa/Z8rCSRbOx+QqOGjsK8v4
         pPAkLgCdEgD8EXU3Pf69UcV6RjUI0KHeXLf3Y6JPPeR/g0Jg4V9EyDGZd/OSk1v5DlB5
         cJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ahs/h6Nxbc9NurCZ5tGwHHWH3eKzk/ewUrrEF2fE8co=;
        b=O1ztRoLqpFqwBngr1ZEn1LfhQ3vHZZ6utksu2QEICTd91qGDPTT4MhUtUiOYo45I3v
         3n+Qi7Pgq6wLmNtOuQjOTWDAeu7Mx8bjtLhsp6UdTVlqmY75AQotDMAdG4FyjbQ+AT7I
         26H8DhzHp3QCVvneAkd5C6AQALdGGPOSCnm/9UjM7Kq5q/kIIqTZPuTjIItUT06+DMZj
         KMeIVV8TJd4/Za+SZsx//8F8cpw5olX4Ho0xW/TFyVxrEiTEEzIhnTTTeP5xyUN7QYw9
         MGUOic6MbZe3Rm/d/hQU6wfUiw8r2myLAIUDvFGNd+r55RgCo/lzG3UQuC0k7iuB4fqi
         F5FQ==
X-Gm-Message-State: AN3rC/4XcIa5PoUwRTy73Gk1q/Og5S48k8qFBRIHkcRiNM2hJ3StBkz0
        Vrc8fuS52WBFwlVS
X-Received: by 10.99.63.141 with SMTP id m135mr5313380pga.195.1494014029297;
        Fri, 05 May 2017 12:53:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 03/14] dir: convert directory_exists_in_index to take index
Date:   Fri,  5 May 2017 12:53:23 -0700
Message-Id: <20170505195334.121856-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 44307b963..5c635198d 100644
--- a/dir.c
+++ b/dir.c
@@ -1264,14 +1264,15 @@ enum exist_status {
  * the directory name; instead, use the case insensitive
  * directory hash.
  */
-static enum exist_status directory_exists_in_index_icase(const char *dirname, int len)
+static enum exist_status directory_exists_in_index_icase(struct index_state *istate,
+							 const char *dirname, int len)
 {
 	struct cache_entry *ce;
 
-	if (index_dir_exists(&the_index, dirname, len))
+	if (index_dir_exists(istate, dirname, len))
 		return index_directory;
 
-	ce = index_file_exists(&the_index, dirname, len, ignore_case);
+	ce = index_file_exists(istate, dirname, len, ignore_case);
 	if (ce && S_ISGITLINK(ce->ce_mode))
 		return index_gitdir;
 
@@ -1285,18 +1286,19 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
  * the files it contains) will sort with the '/' at the
  * end.
  */
-static enum exist_status directory_exists_in_index(const char *dirname, int len)
+static enum exist_status directory_exists_in_index(struct index_state *istate,
+						   const char *dirname, int len)
 {
 	int pos;
 
 	if (ignore_case)
-		return directory_exists_in_index_icase(dirname, len);
+		return directory_exists_in_index_icase(istate, dirname, len);
 
-	pos = index_name_pos(&the_index, dirname, len);
+	pos = index_name_pos(istate, dirname, len);
 	if (pos < 0)
 		pos = -pos-1;
-	while (pos < the_index.cache_nr) {
-		const struct cache_entry *ce = the_index.cache[pos++];
+	while (pos < istate->cache_nr) {
+		const struct cache_entry *ce = istate->cache[pos++];
 		unsigned char endchar;
 
 		if (strncmp(ce->name, dirname, len))
@@ -1351,7 +1353,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	const struct pathspec *pathspec)
 {
 	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(dirname, len-1)) {
+	switch (directory_exists_in_index(&the_index, dirname, len-1)) {
 	case index_directory:
 		return path_recurse;
 
@@ -1554,7 +1556,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
 	    !has_path_in_index &&
-	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
+	    (directory_exists_in_index(&the_index, path->buf, path->len) == index_nonexistent))
 		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
-- 
2.13.0.rc1.294.g07d810a77f-goog

