From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 35/41] refs.c: pack all refs before we start to rename a ref
Date: Tue, 27 May 2014 13:25:54 -0700
Message-ID: <1401222360-21175-36-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxI-0002RS-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbaE0U0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:34 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:54592 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so1507078pbb.3
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG3X/Ac2vE0pkYnhjIn3v66DfVNrtVUOJ1zofkdl5Zc=;
        b=dIG2SstbBKbXJkdTUr63sjezYJKp+UABQio97oDGYgA5Xf+Ee/GapbBffjTSG6O52X
         O+fSpp3VEvP9dEKnLss8OkCplzPKWj/bUJsjDNXL6x2oIKWnkUWQp5Hq6/FmS+EJYMr2
         PiqnJBqt02G1+2y85jB/OV5rUoSjdXY19G5XEyTHgAEwSGOrnScwZxIOq7iCqKJPVOsi
         h+KqVSnODlAZOYqhD0g+411x4uxrtQA57Sq0yJwy3CyPJKl1AdzWnNgO+VKEqWokH3mB
         aKHOvDGrUtCZCUS2BaCoaOuKPDaLt/jfEPp7KRwBOJNsFuYa8C/IFNhoLFkS+7JRCjSv
         Rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG3X/Ac2vE0pkYnhjIn3v66DfVNrtVUOJ1zofkdl5Zc=;
        b=dFcgJONmBnsnkzkv2rqajX1CuVNAFa7WRRdiVGbVnaDTtajvCGxlH93RG8Y76r+CnA
         gRCgcOy0nPNEeWY7HArQosJRfdAWNn30Gzfe2M1sSxz9s7afs30J+FYvI9j37bEZbVe6
         Nqgg1jLBKBr13fkDL+5i97MUXsSXGXPHnTXWVttldGjpmFLSw/bXwMeFLBd3rLefL5fV
         tSxInbgaKNJDiddT8Y49liVNmiDECUsqonJ7v/MUF2V8LNyZhVEUUbBiZj6tggzvm2Wn
         ss3G0VVl8eVzw47tK/HZzVLASulOAeikrfVr6rgiQ3DJg+6dPrVRdPx+8oyYI3mJXQDT
         iDiw==
X-Gm-Message-State: ALoCoQkC/C3skwUeNuvXMwTTw64/Sj45lgmJorE1T94PN7iWHEH6rQQta650y7BF8SiDxw9Yo+jm
X-Received: by 10.66.230.226 with SMTP id tb2mr14162798pac.41.1401222365367;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1283656yhg.2.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 30E8F2F4AC1;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0CF07E14EA; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250204>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename.

We want to do this to make it easier to handle atomic renames in rename_ref for
the case 'git branch -m foo/bar foo'. If we can guarantee that foo/bar does not
exist as a loose ref we can avoid locking foo/bar.lock during transaction
commit and thus make it possible to delete the foo directory and re-create
it as a file(branch) in a single transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 3cdfc72..08dde5b 100644
--- a/refs.c
+++ b/refs.c
@@ -2637,6 +2637,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
2.0.0.rc3.474.g0203784
