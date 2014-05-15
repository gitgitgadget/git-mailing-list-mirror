From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 38/44] refs.c: pack all refs before we start to rename a ref
Date: Thu, 15 May 2014 10:29:53 -0700
Message-ID: <1400174999-26786-39-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVM-0001TL-80
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbaEORbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:09 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:46672 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so636170yha.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TZ0UbJkc4qyMa/8AaHT1DlcLZFIuWvWxRZMcKtl0kT0=;
        b=H9NHlOHfa6e76BH8e4W1FCJUC59ys1fTQTqqJmAmlD4w0qQ5uCK4Gv0y5V858YKWIK
         f6GtDXTZlmv4RN8w4ffrZa+CTKDczsFXmK0yDZbzmvNDHglomOnRH0yyvXTobNEvFJi1
         Syg7t4ucWeH6LilQwv8gecGGUEokStG1U2TOu8jLvRX2lhOl64RYWld7Nau8r6anQZ57
         qthglLN0UO6+fMOrrAky9TCiIIhsKSV7KE8MKFaRZ/I5E9Uk3yJD+l/1/dupsg1Ehy02
         ox6/wji4YPtu/3soFwZba0ZKhuJ0oDb7oNgasdXSNu18mGQwMqJdfkD2fQtPbfCR9KIS
         Tu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TZ0UbJkc4qyMa/8AaHT1DlcLZFIuWvWxRZMcKtl0kT0=;
        b=gDLarONKO/rRJIPX2R3j6JwtHbV0yc8lAf5G0PWy4LqWHfvoCwMBfCgWFxJEc3nftP
         RvHGBIXZL+wIeUZ9cC39E9JYTduLn9J95xnPbx7VBlNWwlWhdlrB8RSuPgSZTmThjVbw
         QY+ZdvlodamNVWFi1jZeRki443Z/9j03758CBbDINRJwIvzLgXKiZhQWIGpklKU1PkMB
         LSozHwXl3RAF49O6MiYvS6lIC2dovjxl/5BuWo7s+HSQWQco6uMmLGqUqUYuXONduNv/
         Gr88FKL4hpXPZ4XrIVotTBk0c/vDDS0bVLBkss0v0aOiYl3LQb6K63s2qQxfkJ2oJ34P
         6W+Q==
X-Gm-Message-State: ALoCoQkhv/To1Y5SBikjZozMKfvwH+5QgkYEIt0xDbVrmY1D7x6Nh0QjkLs4tG0m2zTd03rMc8b8
X-Received: by 10.58.38.199 with SMTP id i7mr3837814vek.6.1400175007725;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si274181yhj.0.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 77F1E5A427D;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3F6D3E1084; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249143>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 8105ee6..79d95db 100644
--- a/refs.c
+++ b/refs.c
@@ -2607,6 +2607,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
+	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
+		return error("unable to pack refs");
+
 	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..fafd38a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -289,7 +289,7 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
-	test_path_is_file .git/refs/heads/master &&
+	test_path_is_missing .git/refs/heads/master &&
 	test_path_is_missing .git/refs/heads/master3
 '
 
-- 
2.0.0.rc3.477.g0f8edf7
