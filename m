Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6076F207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbdEETyP (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:15 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34913 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdEETyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:54:12 -0400
Received: by mail-pg0-f44.google.com with SMTP id o3so7633819pgn.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDrHJ3G60zt7SiTcjzeQ7O2Q1EOjHNnM6+rIGTN70OM=;
        b=FSEBksvyYh55Nb+f6nl8PZUxgGAIDkoDTD8AOpw2gWfwJkRznrMyKznW5FJV6t1YYJ
         MxsDk+OE7nSNmOxKiN7xhwfLHVNwBFqRteclh49Rgews3WgpTeUvKxCEayttk6SxVwo6
         TItNOhEqHYpl1qgGaM2pY9JYzux4GgF6YB3thVNGz/arswB/PHfZ1FFz49Xx2RfQNJFX
         BjTYQj8CNMO3ewCvYS/1CnF0g7AyFM40zyvXt2zDhP5bFXCwzwT1+CfHDJy+qIEX4ql4
         siKi1/k/1E8WCZpzL/twfEJd0p5Xd6zyiIVAG5fyhgKgfGH+VQZL9O0Z4vwcu7JxzzBu
         qC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hDrHJ3G60zt7SiTcjzeQ7O2Q1EOjHNnM6+rIGTN70OM=;
        b=HoG3Isy/GrDhNdpXJDqRhxyDyeK15V3JCmy7l+bHC2zQi1bZ9tmMSywPXw7OGDzaCE
         LXBGqe1rn5GglkdDOI3qF9HsLTki+kvHUb2OiclJp0cj+59ZqhhnRdGcoi54Gngt6V3p
         reWN1cxCYA75TQqVDfVAkfU3v8hsjG3AVJnLt1t+qiXI50Hb+WtRS2AAL1pRhfXB1LRA
         yQZU0VBy9Lp2V0HD0myHBaDS2nSr4Z6ZbmISMFqO20xfNtRte6fYHi9oYCpih7swFUTD
         GNHK5z1jVz/sP1yrvi0JMpAdeIOC34eqXxMHTYWzWSH2BuGDdCP8fgjLdQvyyLEw1PLg
         RjQQ==
X-Gm-Message-State: AN3rC/4eYQIZUTSpY/Hpe4Sd/4qogV4TEtHWybFgL0ISIlB3rWBTCezE
        d/rq8o6c4p11SPWR
X-Received: by 10.98.220.25 with SMTP id t25mr19164986pfg.133.1494014041250;
        Fri, 05 May 2017 12:54:01 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:54:00 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 11/14] dir: convert open_cached_dir to take an index
Date:   Fri,  5 May 2017 12:53:31 -0700
Message-Id: <20170505195334.121856-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index a15da672c..f08d30ee4 100644
--- a/dir.c
+++ b/dir.c
@@ -1664,6 +1664,7 @@ static void add_untracked(struct untracked_cache_dir *dir, const char *name)
 
 static int valid_cached_dir(struct dir_struct *dir,
 			    struct untracked_cache_dir *untracked,
+			    struct index_state *istate,
 			    struct strbuf *path,
 			    int check_only)
 {
@@ -1678,7 +1679,7 @@ static int valid_cached_dir(struct dir_struct *dir,
 		return 0;
 	}
 	if (!untracked->valid ||
-	    match_stat_data_racy(&the_index, &untracked->stat_data, &st)) {
+	    match_stat_data_racy(istate, &untracked->stat_data, &st)) {
 		if (untracked->valid)
 			invalidate_directory(dir->untracked, untracked);
 		fill_stat_data(&untracked->stat_data, &st);
@@ -1699,10 +1700,10 @@ static int valid_cached_dir(struct dir_struct *dir,
 	 */
 	if (path->len && path->buf[path->len - 1] != '/') {
 		strbuf_addch(path, '/');
-		prep_exclude(dir, &the_index, path->buf, path->len);
+		prep_exclude(dir, istate, path->buf, path->len);
 		strbuf_setlen(path, path->len - 1);
 	} else
-		prep_exclude(dir, &the_index, path->buf, path->len);
+		prep_exclude(dir, istate, path->buf, path->len);
 
 	/* hopefully prep_exclude() haven't invalidated this entry... */
 	return untracked->valid;
@@ -1711,12 +1712,13 @@ static int valid_cached_dir(struct dir_struct *dir,
 static int open_cached_dir(struct cached_dir *cdir,
 			   struct dir_struct *dir,
 			   struct untracked_cache_dir *untracked,
+			   struct index_state *istate,
 			   struct strbuf *path,
 			   int check_only)
 {
 	memset(cdir, 0, sizeof(*cdir));
 	cdir->untracked = untracked;
-	if (valid_cached_dir(dir, untracked, path, check_only))
+	if (valid_cached_dir(dir, untracked, istate, path, check_only))
 		return 0;
 	cdir->fdir = opendir(path->len ? path->buf : ".");
 	if (dir->untracked)
@@ -1789,7 +1791,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	strbuf_add(&path, base, baselen);
 
-	if (open_cached_dir(&cdir, dir, untracked, &path, check_only))
+	if (open_cached_dir(&cdir, dir, untracked, &the_index, &path, check_only))
 		goto out;
 
 	if (untracked)
-- 
2.13.0.rc1.294.g07d810a77f-goog

