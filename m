Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5EE207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755562AbdEETxx (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:53:53 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34877 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdEETxv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:51 -0400
Received: by mail-pg0-f51.google.com with SMTP id o3so7632111pgn.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xhyxv8FSYFHmcTJuUUU0H/MBWufEwKGzp/s1t3vc8Rg=;
        b=Cr9E/DRQktZN3A3Dln4rqcw8RA+/D4czaZ0KMbCOXIS+bFNm0EgayQHtCFmwZtaBUN
         NfM/pfvQCgP0XJdUu79S3wxycMG+GGFBC0tHcps166/OPC+/VNE3BPFReeGgE3lmzW6k
         HJSgN0cdG1+nOZXh5K+fOPeBy0fnCHzwX7/mxSdOCgt+WmItDurascAK3UqoiOerQWCM
         Nhkq/N7OLP4sBykNiu+6xfzxi7i6kYwmIFp7IBQfFgF5D6SjZjqIBi/dCLwYu0ZU/iar
         NZtUaqiHAPXBZs0sMTGS8Bjk2S1XwsMr3Hmhi6eLFGuVOpPAUS8m1SAum74xcSwly/xu
         Wh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xhyxv8FSYFHmcTJuUUU0H/MBWufEwKGzp/s1t3vc8Rg=;
        b=PgXEySHy/7ZNiYILtSUQQMMdrSVrus9pSrCGRhSjSEqynNHpzXqQmItBSSa+Q2eD2f
         ZaWFy/xMLUnAmHGZO95+MZCy+KuNt6WZE08/+4PYESoobng/5Y5prIt8MIIKzHBamJLz
         IjCurkV4SC0O2hDTXv4aBE4yPc/RZ9eJwZZiJwuz2Wwl/Tp3LE7jlhClaI/ZqxkWQxvT
         /FFVijRs2ipHepONgjjFsEAx68Y9TOdsrPJIWwrgYs7SqcgPaZiUtcq8qGB16jX58KII
         iQpEx32oK9dz+8X45RZuOHn4HQ8TZdBwFtrnif0uhwWT5e/HVl3g8AGvsr2K4st+9cLk
         mVGg==
X-Gm-Message-State: AN3rC/4YSGTeM5O6L4Qwoa+JokOiLTYhDMDMtxb4GkIqC3/BVCQkMFoH
        HGITOa17GPMzkhy4
X-Received: by 10.84.176.129 with SMTP id v1mr66751533plb.192.1494014030872;
        Fri, 05 May 2017 12:53:50 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:49 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 04/14] dir: convert get_dtype to take index
Date:   Fri,  5 May 2017 12:53:24 -0700
Message-Id: <20170505195334.121856-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index 5c635198d..4515f0083 100644
--- a/dir.c
+++ b/dir.c
@@ -48,7 +48,8 @@ struct cached_dir {
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	const char *path, int len, struct untracked_cache_dir *untracked,
 	int check_only, const struct pathspec *pathspec);
-static int get_dtype(struct dirent *de, const char *path, int len);
+static int get_dtype(struct dirent *de, struct index_state *istate,
+		     const char *path, int len);
 
 int fspathcmp(const char *a, const char *b)
 {
@@ -975,7 +976,7 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
 
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype == DT_UNKNOWN)
-				*dtype = get_dtype(NULL, pathname, pathlen);
+				*dtype = get_dtype(NULL, &the_index, pathname, pathlen);
 			if (*dtype != DT_DIR)
 				continue;
 		}
@@ -1459,12 +1460,13 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 	return 0;
 }
 
-static int get_index_dtype(const char *path, int len)
+static int get_index_dtype(struct index_state *istate,
+			   const char *path, int len)
 {
 	int pos;
 	const struct cache_entry *ce;
 
-	ce = index_file_exists(&the_index, path, len, 0);
+	ce = index_file_exists(istate, path, len, 0);
 	if (ce) {
 		if (!ce_uptodate(ce))
 			return DT_UNKNOWN;
@@ -1478,12 +1480,12 @@ static int get_index_dtype(const char *path, int len)
 	}
 
 	/* Try to look it up as a directory */
-	pos = index_name_pos(&the_index, path, len);
+	pos = index_name_pos(istate, path, len);
 	if (pos >= 0)
 		return DT_UNKNOWN;
 	pos = -pos-1;
-	while (pos < the_index.cache_nr) {
-		ce = the_index.cache[pos++];
+	while (pos < istate->cache_nr) {
+		ce = istate->cache[pos++];
 		if (strncmp(ce->name, path, len))
 			break;
 		if (ce->name[len] > '/')
@@ -1497,14 +1499,15 @@ static int get_index_dtype(const char *path, int len)
 	return DT_UNKNOWN;
 }
 
-static int get_dtype(struct dirent *de, const char *path, int len)
+static int get_dtype(struct dirent *de, struct index_state *istate,
+		     const char *path, int len)
 {
 	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
 		return dtype;
-	dtype = get_index_dtype(path, len);
+	dtype = get_index_dtype(istate, path, len);
 	if (dtype != DT_UNKNOWN)
 		return dtype;
 	if (lstat(path, &st))
@@ -1529,7 +1532,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	int has_path_in_index = !!index_file_exists(&the_index, path->buf, path->len, ignore_case);
 
 	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, path->buf, path->len);
+		dtype = get_dtype(de, &the_index, path->buf, path->len);
 
 	/* Always exclude indexed files */
 	if (dtype != DT_DIR && has_path_in_index)
-- 
2.13.0.rc1.294.g07d810a77f-goog

