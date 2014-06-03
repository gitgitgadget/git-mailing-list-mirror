From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 35/41] refs.c: pack all refs before we start to rename a ref
Date: Tue,  3 Jun 2014 14:37:53 -0700
Message-ID: <1401831479-3388-36-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:39:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwQq-0006Kv-2r
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbaFCVjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:23 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:36547 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934295AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1534160obc.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m4gaGhVWAVsgt6XF/DFuTX7tHHUQ6loo86K5F04ZoZg=;
        b=Hn8ofhUD89HS/P/CGJsjnwo7KUuxvAwGAaku7TQ18N8ZyHmiYmHEtFk9Ce+tiiIaOc
         zYPUQL8ymlcFRC9q/afRm/rkK/zJxVjSR/tfOFDDet8p3kLa8L/E/JX6yjK8DL0fwdTT
         f3LutBelQQXkTeOyK5R8RoEQTdXexBVlv+Wip/z1qLcQE94nL2CnGVQGQxihcQv88lRc
         +Ib7TnIgrWhsAUnrNGXsnOqtPTJ+pJJ8jmbZ4NkuTqM4Qbz/eHQmVaY+nqS1ezE/agu2
         /GLvRTRpAf//Z4IRiBH+iazjiiFqQZ9voR/QwLG/10FJZzT2TMdO3goxTxhod5H15CUL
         sQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m4gaGhVWAVsgt6XF/DFuTX7tHHUQ6loo86K5F04ZoZg=;
        b=G3rrNwJFe3o3cM6rPT42JYdEBACK2rbe8bcclhigQo2aK/2aIcrNWfHudmoiA6CGlx
         03+8+nTQbujlfwpynICfk6MYnbSbDdkZtwEkcrzXDvTX1x6g5AlxJ0dzngYyGRr2lj3m
         OiA5Y9bV0UHk9yw3Yn0SrUaM8L8gisyHfQG7t7/2T+mzDZA4R4nR47K0abaCPE3+wC9L
         yPyDku7oi7TNPiMyEBCMmC5xSdK4zhkS15FxkBu9/JXa/I0L8/U5zdf6d9Fh8YVvgPpR
         zW+AR64xjfqEqxAyEGh/50jIvEk8kOawy+iw28CgnyBJm4v6cYsrFG6JYIFTPkmDkO2C
         fTUQ==
X-Gm-Message-State: ALoCoQkeeS9MNIliuYe5asmueT4XF/w10nI+VRw2mF8EB7w5oPSY3UxzGy2FWlHqucstoeWBxqH4
X-Received: by 10.42.86.145 with SMTP id u17mr17341317icl.11.1401831488451;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si28761yhp.6.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4B2AD31C425;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 27BD4E06DA; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250660>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename. This also makes the rename
itself slightly slower, but as it now results in all refs being packed future
commands accessing refs might become slightly faster.

We want to do this to make it easier to handle atomic renames in rename_ref for
the case 'git branch -m foo/bar foo'. If we can guarantee that foo/bar does not
exist as a loose ref we can avoid locking foo/bar.lock during transaction
commit and thus make it possible to delete the foo directory and re-create
it as a file(branch) in a single transaction.

There is a small race between when we pack all refs and we eventually remove
the old ref from the packed refs file. If a concurrent process deletes the old
ref from the packed refs file, then creates a new ref with that name and
finally repacks the packed refs file, then our transaction will delete the new
ref without realizing it had changed during the transaction. The window for this
is very short and is still a slightly less race than the ones in the old
code for ref_rename.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8848dbf..03cff59 100644
--- a/refs.c
+++ b/refs.c
@@ -2652,6 +2652,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
+	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
+		return error("unable to pack refs");
+
 	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..de0c2b9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -288,9 +288,9 @@ test_expect_success 'deleting a dangling symref' '
 test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
-	git symbolic-ref refs/heads/master2 &&
-	test_path_is_file .git/refs/heads/master &&
-	test_path_is_missing .git/refs/heads/master3
+	git rev-parse --verify refs/heads/master &&
+	test_must_fail git symbolic-ref refs/heads/master3 &&
+	test_must_fail git rev-parse refs/heads/master3
 '
 
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
-- 
2.0.0.567.g64a7adf
