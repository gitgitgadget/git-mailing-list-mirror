Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D6E20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLIKpY (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33050 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLIKpX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so7135442ljd.0
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcJwQUrZ8Z3uQq5GtrJAQ3rKeQJPgXnit+2jw16rGeE=;
        b=bVXl0szb9U9muJF/sJPNiwNQz7IyxlbXxoMBnzO18ZPMcpd3ZRLELyUZIXIwS48v+P
         w2iM4QTC50s2FlHbwMmbr7JsvnsiDCxyUDsAnaRP7K4Zxz9IwrjvJEZlahZb04k7ueqm
         JknGusMg+53QMBiKPEmU8FBv1Q2/EI58US82EK7/zMFvIRKkXRQ20E/JO4A9bsY4NBt6
         XCNquR1Ak0wHdYIlATGgKomx+uZefrNmJ5ysCnWwaM4I3JXzZaksfjtE6AOxQligj8Rv
         OqjoVZpObQp8yjoNE1OKc0jwyTOz4ydEy8sw12ox1IJaG2tlvdxya8xxSPe6AQUJVz0A
         p9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcJwQUrZ8Z3uQq5GtrJAQ3rKeQJPgXnit+2jw16rGeE=;
        b=cSO9ihFyUgsilXfvwZFnJr7jOSd2q6MWs60uWd+muQ1NcIdPX2QJut8udUH/zkxrZy
         cB2Z5UdXbxP6WxuSimDtj7H9QEnNFx7qXUNeJBhEdbXQzqLOUH0CpcDfzmvMR2rHFi1+
         ETsbTaKdSbIo31pf57gSBM862+7dgLgiuFlF3OUjRW1nYYd1bk6Yc7P8Uc841iaY6qbk
         2OjiyAMK1qmFKJvkAjghgrXaZdOukxjoerHsrv32NoKO66vWhP5shVizywAr8DvIt55V
         tQIUh3Bjrw7fwn0iUjTZ5EuAfJKnenmG6ACpOHO4uymEIu0jdbdMj9irXv7g0lWNt4An
         IqUA==
X-Gm-Message-State: AA+aEWanebBK8tv4DHrDCE9iXCxKLBNU/8tWQK7ZC4ZipEQnyUc9k3/S
        EFR5woTXhVR4MuW+1nt/QsXMbHG6
X-Google-Smtp-Source: AFSGD/VbIrmMvfaZDlcVxmVt/K4BlKx+6v3mzwVEBqDqpuEVtZIDszyF8M5aFUL95bFDiQXlPmcdGA==
X-Received: by 2002:a2e:1603:: with SMTP id w3-v6mr4816373ljd.33.1544352320795;
        Sun, 09 Dec 2018 02:45:20 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:20 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/24] refs: keep backup of deleted reflog
Date:   Sun,  9 Dec 2018 11:44:13 +0100
Message-Id: <20181209104419.12639-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in git-backup-log.txt a long time ago, this is mostly meant
for recovering a branch immediately after an accidental deletion.

References from the deleted reflog will not be included in
reachability tests and they will be deleted at the next gc. At that
point, this deleted reflog becomes useless.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c  | 32 ++++++++++++++++++++++++++++++++
 t/t2080-backup-log.sh | 12 ++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dd8abe9185..9afb274075 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -11,6 +11,7 @@
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "worktree.h"
+#include "backup-log.h"
 
 /*
  * This backend uses the following flags in `ref_update::flags` for
@@ -1873,6 +1874,35 @@ static int files_reflog_exists(struct ref_store *ref_store,
 	return ret;
 }
 
+static void backup_reflog(struct files_ref_store *refs,
+			  const char *reflog_path,
+			  const char *refname)
+{
+	int core_backup_log = 0;
+	struct stat st;
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct object_id old, new;
+
+	repo_config_get_bool(the_repository, "core.backuplog",
+			     &core_backup_log);
+	if (!core_backup_log)
+		return;
+	if (ref_type(refname) != REF_TYPE_NORMAL)
+		return;
+	if (lstat(reflog_path, &st) ||
+	    index_path(NULL, &old, reflog_path, &st, HASH_WRITE_OBJECT))
+		return;
+
+	strbuf_addf(&path, "logs/%s", refname);
+	oidclr(&new);
+	bkl_append(&line, path.buf, &old, &new);
+	strbuf_release(&path);
+	mkdir_in_gitdir(git_path("common"));
+	bkl_write(git_path("common/gitdir.bkl"), &line);
+	strbuf_release(&line);
+}
+
 static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
@@ -1882,6 +1912,7 @@ static int files_delete_reflog(struct ref_store *ref_store,
 	int ret;
 
 	files_reflog_path(refs, &sb, refname);
+	backup_reflog(refs, sb.buf, refname);
 	ret = remove_path(sb.buf);
 	strbuf_release(&sb);
 	return ret;
@@ -2797,6 +2828,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		    !(update->flags & REF_IS_PRUNING)) {
 			strbuf_reset(&sb);
 			files_reflog_path(refs, &sb, update->refname);
+			backup_reflog(refs, sb.buf, update->refname);
 			if (!unlink_or_warn(sb.buf))
 				try_remove_empty_parents(refs, update->refname,
 							 REMOVE_EMPTY_PARENTS_REFLOG);
diff --git a/t/t2080-backup-log.sh b/t/t2080-backup-log.sh
index dbd19db757..710df1ec8b 100755
--- a/t/t2080-backup-log.sh
+++ b/t/t2080-backup-log.sh
@@ -178,4 +178,16 @@ test_expect_success 'config --edit makes a backup' '
 	grep $NEW .git/common/gitdir.bkl
 '
 
+test_expect_success 'deleted reflog is kept' '
+	git checkout -b foo &&
+	git commit -am everything-else &&
+	test_commit two &&
+	test_commit three &&
+	git checkout -f master &&
+	OLD=$(git hash-object .git/logs/refs/heads/foo) &&
+	git -c core.backupLog=true branch -D foo &&
+	grep logs/refs/heads/foo .git/common/gitdir.bkl &&
+	grep ^$OLD .git/common/gitdir.bkl
+'
+
 test_done
-- 
2.20.0.rc2.486.g9832c05c3d

