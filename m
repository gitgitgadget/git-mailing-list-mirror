Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D088C2D0F3
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E520772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XobNbaA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgDAESA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:18:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36064 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbgDAER5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so28859552wrs.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HLA1HBcBiLE3ShMGAN6HJmcYs5LuGGzpuyISBUypHmM=;
        b=XobNbaA4eE79vQmOz34WE4bpbvwkrTWuoTxwV8yk/o4a2TSvXmAS6tJG7ZpsYGuLjH
         8AbiDk3n0dbG8PT52FAN83HtCfUYZM+JeULIvInIfOnHKLuWRHMnBc4zsl4u0vb2yN4z
         tKyupZh0Ihewb+ROHg+zZQeezPolM8V4EWVerNn9fRtr51e9p6+x+FHV9wBVoplEeMbf
         RAUJRQ86LxqFg3jgZPaVPAMycX2Zd2oeHdTfhn8EC6TjVlN4pgS4ZYmEGi0Bzi0euv9r
         ufht0KnMbouQOzTI+kIBE5wGkoDEBLBIbqSeuGrog9dhGyGUw24nAkZMFheMtMA+Nd5A
         FrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HLA1HBcBiLE3ShMGAN6HJmcYs5LuGGzpuyISBUypHmM=;
        b=DQThWMaaVviPVjhpmXsgr24pu7ErL2FRIm4+wiNVEYlAD9FQanOgaREih3ayO2zq7b
         XkuH0MOmO4XjgPyv5mRYA4t6RwnjHkfZfMJNt//vu8I6MvurosTfU3uhwYyYtv3my/gh
         dmDQMiyljgeMftrqCMBmT9VEU08hhZeCrTbZW70o+EiFNGgYKIREHzLIjINoA/7clb54
         U12WJNfnJy4pqfciPigrx4brecwYhY5r8K//BybMUKHHLW272RK7YVA+8s2iOuLxUsKz
         hUFP99N33hPBsmQT1pARY0R1oC2dNOLU1HEchApLs/m9p4kh6tpP9M2RR5X0QNzU07PF
         yfog==
X-Gm-Message-State: ANhLgQ1QvIRQLHlsEjMKz0bMOCIKK9HoNKk+8qxT0x9YwEh+aB1KN75q
        8JeeBeNYQy+MCikHjiviNcJYCLFI
X-Google-Smtp-Source: ADFU+vudje535dAwYPv+quJc8sHIlbMSFzRrmL3oVNGzno3xydxzCbtsglWXN2IEX4YvtafBZ3j/nQ==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr25708997wrp.276.1585714675442;
        Tue, 31 Mar 2020 21:17:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm973281wme.17.2020.03.31.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:55 -0700 (PDT)
Message-Id: <08a108698169e0cad5ea27761b9476515eca1410.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:43 +0000
Subject: [PATCH v5 09/12] dir: include DIR_KEEP_UNTRACKED_CONTENTS handling in
 treat_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Handling DIR_KEEP_UNTRACKED_CONTENTS within treat_directory() instead of
as a post-processing step in read_directory():
  * allows us to directly access and remove the relevant entries instead
    of needing to calculate which ones need to be removed
  * keeps the logic for directory handling in one location (and puts it
    closer the the logic for stripping out extra ignored entries, which
    seems logical).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/dir.c b/dir.c
index 1b3c095b5a4..8be31df58c2 100644
--- a/dir.c
+++ b/dir.c
@@ -1665,7 +1665,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 *          you CAN'T DO BOTH.
 	 */
 	enum path_treatment state;
-	int nested_repo = 0, old_ignored_nr, check_only, stop_early;
+	int nested_repo = 0, check_only, stop_early;
+	int old_ignored_nr, old_untracked_nr;
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
 
@@ -1785,9 +1786,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 * --porcelain), without listing the individual ignored files
 	 * underneath.  To do so, we'll save the current ignored_nr, and
 	 * pop all the ones added after it if it turns out the entire
-	 * directory is ignored.
+	 * directory is ignored.  Also, when DIR_SHOW_IGNORED_TOO and
+	 * !DIR_KEEP_UNTRACKED_CONTENTS then we don't want to show
+	 * untracked paths so will need to pop all those off the last
+	 * after we traverse.
 	 */
 	old_ignored_nr = dir->ignored_nr;
+	old_untracked_nr = dir->nr;
 
 	/* Actually recurse into dirname now, we'll fixup the state later. */
 	untracked = lookup_untracked(dir->untracked, untracked,
@@ -1825,6 +1830,18 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		}
 	}
 
+	/*
+	 * We may need to ignore some of the untracked paths we found while
+	 * traversing subdirectories.
+	 */
+	if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
+	    !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
+		int i;
+		for (i = old_untracked_nr + 1; i<dir->nr; ++i)
+			FREE_AND_NULL(dir->entries[i]);
+		dir->nr = old_untracked_nr;
+	}
+
 	/*
 	 * If there is nothing under the current directory and we are not
 	 * hiding empty directories, then we need to report on the
@@ -2653,28 +2670,6 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
-	/*
-	 * If DIR_SHOW_IGNORED_TOO is set, read_directory_recursive() will
-	 * also pick up untracked contents of untracked dirs; by default
-	 * we discard these, but given DIR_KEEP_UNTRACKED_CONTENTS we do not.
-	 */
-	if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
-		     !(dir->flags & DIR_KEEP_UNTRACKED_CONTENTS)) {
-		int i, j;
-
-		/* remove from dir->entries untracked contents of untracked dirs */
-		for (i = j = 0; j < dir->nr; j++) {
-			if (i &&
-			    check_dir_entry_contains(dir->entries[i - 1], dir->entries[j])) {
-				FREE_AND_NULL(dir->entries[j]);
-			} else {
-				dir->entries[i++] = dir->entries[j];
-			}
-		}
-
-		dir->nr = i;
-	}
-
 	trace_performance_leave("read directory %.*s", len, path);
 	if (dir->untracked) {
 		static int force_untracked_cache = -1;
-- 
gitgitgadget

