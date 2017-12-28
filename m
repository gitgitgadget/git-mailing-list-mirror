Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8641F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbdL1EOu (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:50 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:38276 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbdL1EOi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:38 -0500
Received: by mail-it0-f65.google.com with SMTP id r6so27465990itr.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gq6QvVxbqBLirPtAnawTWJk86FMNwmoM4KR1dT6vUGQ=;
        b=uf1PRFA0dkJUMN3y2cTdG0R/ozCpwf71C9JrpP1wcbVnjSY3xA3KJV1xYTLMyZt//o
         HgENoiNMFK/eKeShwGIxR8NC8TyfGmM5Wfo/UJR6KFrm1pfk0JIJ5vkSBJqHaajxYS0z
         V2uE19JFgAHivzRtLO3/QDcOz9pRs4XwwB5WlP9qBiX/vNizgY9UmgPz8fmcuafwoZIY
         pE7zIOkIivcTXETIvVyyxxf5auTmY8Wb5f6hzvwjVUPzTSqFK2KP+E3l2Eoa0htkFMbV
         FuKmHHTsRBLBVq1pQrdWhygkBg8OCZUE9WIMzuDGocEdGcgyYRq2wiRF+T9dNO0oGl0Q
         CJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gq6QvVxbqBLirPtAnawTWJk86FMNwmoM4KR1dT6vUGQ=;
        b=d042jhkZsefmlhpKOzw3sN2fIlguaVuBqYHLB14hPpH9pjz9LVw/c5FHOHYQYONITO
         TWroGcj2J+b6mPAc42pM8NC/MOI2ZJqElTsawd7LYQ+FGdH0jphIxmI+05SwTdu1hD1l
         i5UCmHjX8ntQ8HEA+u+uAUmaI/8ZMngSLlqFydtpemfMGbCe9WnRDJPKghnwIpKp4Hcf
         K4ncevNdSG40t3b3ja+akSWyl00qxUelSLp0iYFwYGkyx5aHIVebbli3ZvZhmQoFVmEe
         vXSHYHwxJ+7GL7cONvd6sX8Pjxyq4hMGnfX27k0mu1rL/dz13fqAkpzi9OKtG56hP2YE
         h9JA==
X-Gm-Message-State: AKGB3mKc4v8rnQJQNiN3WUUAzjhrCc9Xz5MAdSPNO1ObEDEY2z/GG2yE
        ENZ7y+mURnbStTDMBtDru2kRAQ==
X-Google-Smtp-Source: ACJfBota3wSGTgLw0Qk5476BU3gM9M6SomLS7wCQOT+BKeue91a3Uf/F2aKTMQsbcnWPNSB5hU1EVw==
X-Received: by 10.36.204.85 with SMTP id x82mr38686657itf.95.1514434477087;
        Wed, 27 Dec 2017 20:14:37 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:36 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 34/34] merge-recursive: ensure we write updates for directory-renamed file
Date:   Wed, 27 Dec 2017 20:13:52 -0800
Message-Id: <20171228041352.27880-35-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a file is present in HEAD before the merge and the other side of the
merge does not modify that file, we try to avoid re-writing the file and
making it stat-dirty.  However, when a file is present in HEAD before the
merge and was in a directory that was renamed by the other side of the
merge, we have to move the file to a new location and re-write it.
Update the code that checks whether we can skip the update to also work in
the presence of directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 4 +---
 t/t6043-merge-rename-directories.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d00786f71..16c52a434 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2732,7 +2732,6 @@ static int merge_content(struct merge_options *o,
 
 	if (mfi.clean && !df_conflict_remains &&
 	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
-		int path_renamed_outside_HEAD;
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
 		/*
 		 * The content merge resulted in the same file contents we
@@ -2740,8 +2739,7 @@ static int merge_content(struct merge_options *o,
 		 * are recorded at the correct path (which may not be true
 		 * if the merge involves a rename).
 		 */
-		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
-		if (!path_renamed_outside_HEAD) {
+		if (was_tracked(path)) {
 			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
 			return mfi.clean;
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index ccfe48596..f0af66b8a 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3713,7 +3713,7 @@ test_expect_success '12b-setup: Moving one directory hierarchy into another' '
 	)
 '
 
-test_expect_failure '12b-check: Moving one directory hierarchy into another' '
+test_expect_success '12b-check: Moving one directory hierarchy into another' '
 	(
 		cd 12b &&
 
-- 
2.15.0.408.g8e199d483

