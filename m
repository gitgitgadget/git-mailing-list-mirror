Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6921F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbcGKRXe (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35818 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755564AbcGKRX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so1955055wmg.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zr4fW2I3+yBU4sKKRPdrmIGOSEtDsGZqlmkPDWokOPA=;
        b=cxNYcw/xMtLXw+uPxkdjhX1clVvBjQmQSahBCPe8/EBC19hxeUQoXc/KvppkK0fGrf
         qkeI43pq+lpJO/iyP71AZWzEjYE0cslKBLgcFefgbLlXpxHWZ1m+gHfzz6RN01pcbR2n
         nVMM3IK/qb+7twBYRv6SXOGPYNvLehuX3i1/10bVcpOwAju5s+X5IvCVoPPOys4Wq8c7
         RFnFuvQ5A+1YmBXSNH8mbkFlxEewKE0DKGDFY/xxkn4V4/3vbIfcyBIgaIhcpHoxyHKX
         OJs+ag7Woisnk83Vr8xA2j1lKhZmMrpkuEZ9VqwsgyCQYconlJ5KrWL0wyQOqCMSA5zO
         hZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zr4fW2I3+yBU4sKKRPdrmIGOSEtDsGZqlmkPDWokOPA=;
        b=I+NuI/BHDmAO1uGYOzkn/No9wE9D5XA/pCzc9WpP8pWdqcchK3u/YKFF3/boKMQa1P
         q0FKHl3YJHATIunm9T825RXB8sRz4o3e5giLvdKIM1OLYnSSz6NDDQ7weqvbsoAx4RZn
         V44btY7hTgb+sMt48jIjmghbqcrlLkXbML5F0CQKwVM4IG2TuNUJKmlxRPTgoksObJ9T
         i0nyUk6JF/x1v9vpSgqDefu/L7qD0MvKZ1kKJliiySKtwJH1rqcRyk3clM+spBb6b3rO
         nyPOai3Zx563cr9AlZd7EDBCQhinyb5HpqhkPI0JaKxfZb1MSw6nHYGuZuj0LzrO7CIb
         ewTQ==
X-Gm-Message-State: ALyK8tLy3T1v6UNRAmbXspyTzAank/+eW5h8yLmqm53d03LGw1gF/oMIIsHC/92wFD1d4Q==
X-Received: by 10.194.25.67 with SMTP id a3mr838622wjg.25.1468257807262;
        Mon, 11 Jul 2016 10:23:27 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:26 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
Date:	Mon, 11 Jul 2016 19:22:54 +0200
Message-Id: <20160711172254.13439-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Everytime split index is turned on, it creates a "sharedindex.XXXX"
file in the git directory. This makes sure that old sharedindex
files are removed after a new one has been created.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c           | 27 ++++++++++++++++++++++++++-
 t/t1700-split-index.sh |  7 +++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index ae292d6..13aa058 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2166,6 +2166,28 @@ static int write_split_index(struct index_state *istate,
 	return ret;
 }
 
+static void clean_shared_index_files(const char *current_hex)
+{
+	struct dirent *de;
+	DIR *dir = opendir(get_git_dir());
+
+	if (!dir) {
+		error_errno("unable to open git dir: %s", get_git_dir());
+		return;
+	}
+
+	while ((de = readdir(dir)) != NULL) {
+		const char *sha1_hex;
+		if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
+			continue;
+		if (!strcmp(sha1_hex, current_hex))
+			continue;
+		if (unlink(git_path("%s", de->d_name)))
+			error_errno("unable to unlink: %s", git_path("%s", de->d_name));
+	}
+	closedir(dir);
+}
+
 static struct tempfile temporary_sharedindex;
 
 static int write_shared_index(struct index_state *istate,
@@ -2187,8 +2209,11 @@ static int write_shared_index(struct index_state *istate,
 	}
 	ret = rename_tempfile(&temporary_sharedindex,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
-	if (!ret)
+	if (!ret) {
 		hashcpy(si->base_sha1, si->base->sha1);
+		clean_shared_index_files(sha1_to_hex(si->base->sha1));
+	}
+
 	return ret;
 }
 
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f1af0d5..5036efa 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -237,4 +237,11 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'only one "sharedindex" files' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	test $(ls .git/sharedindex.* | wc -l) = 1
+'
+
 test_done
-- 
2.9.0.250.g7087ccc.dirty

