From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 05/19] update-ref.c: use the error string from _commit to print better message
Date: Fri, 25 Apr 2014 09:14:40 -0700
Message-ID: <1398442494-23438-6-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdio6-0000rj-PH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbaDYQQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:43 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:59066 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbaDYQPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:01 -0400
Received: by mail-yh0-f73.google.com with SMTP id a41so629827yho.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jx/45nEXHFNb6cDGlOxyG5zrMht1Wx0iLNG5JXl05lI=;
        b=N0OOEZqh674NRNE0iKkfItjQ7O6LyzHH0GlW0PXVaSxRjMMEN21ajlq7WuKYRO8ScK
         MY3+5WL2OMYHwzN7sLjKcR5s78y5ZnkgDdRb2FSJWvgp24Mc4wODnltJsPWjQWGHeIQ4
         fkVG5BXzHZvx7vXV3qgM44q/hjvw8HTcrqpZnbPP+gwtXzSbNJzI0fIas/9Yu3YjRTui
         huamiPn0MyPXLcsyerm415SW+THvfsY+BJ/91aFOFX3mumk5p30V1/v7RfGPirZNhu4E
         8oxWMusC4F3115t45r/SKJRNl/EwVWZ1NeZRw7w5hP8ZukW9Hkt1nRWw+HkUoHbY+N8m
         d2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jx/45nEXHFNb6cDGlOxyG5zrMht1Wx0iLNG5JXl05lI=;
        b=BZTW3pQlKPqWVqW+ACV5RiN0+VzaeXgFgAU7HsCzMcWc4Af94MhzbB+Lw1Lu33XS4h
         epgmu5zkdxA2tczFZ4qLymgxOFR9x51317sCHQyKjNhwEkz0BxU1g2eyL8s6Whc4AWm0
         f/BEK6Njta/+ITAEdDDJf5H32pWufyvg3Wu18YBn+pZWz0cSFtxVWUorlt+tyeklgB8R
         2z/nlMnRZmhnCus+9D1byRLimhhgmfrT7f6uhzKbRHZC4mO8A1dy9WK60Fh4dIRlKG7r
         nUmtBDBgFqe+5gjYLLrXwI0ZJWy34pFG4vXylZmBHomcQDkS8POglfosyweEER8nJjTS
         05PA==
X-Gm-Message-State: ALoCoQkRWOpq8k5MQdCRSy3DUdo4ZzcQzgSlyJJb5pNQ1r/Ae8m0NxOEmw03OL6DJvmR1eXNagSdw0w+fGtdw1BkftGv5O6nZ7mPRlfWA1+w3h7lYaJ5qf/rt1jqOgD3mqUcM160Zgumgm/58qls+IZEzcMsY7G1B2kfOvc91PtXNYHo8S3qRM12jKbBf6SQFmI3c7PXxM44
X-Received: by 10.58.22.166 with SMTP id e6mr5114751vef.6.1398442501108;
        Fri, 25 Apr 2014 09:15:01 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si124470yhl.7.2014.04.25.09.15.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:01 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DE07D31C028;
	Fri, 25 Apr 2014 09:15:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A27F1E0855; Fri, 25 Apr 2014 09:15:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247061>

Call ref_transaction_commit with QUIET_ON_ERR and use the error string
that is returned to print a better log message if/after the transaction
fails.

Update the tests to reflect that the log message is now slightly different
  fatal: update_ref failed: Cannot lock the ref 'some ref'
versus from the previous
  fatal: Cannot lock the ref 'some ref'

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c  | 12 +++++++-----
 t/t1400-update-ref.sh | 16 ++++++++--------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aaa06aa..47c9b53 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	char *err;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,17 +360,18 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
+		if (!transaction)
+			die("failed to update refs");
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
-		return ret;
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("update_ref failed: %s", err);
+		return 0;
 	}
 
 	if (end_null)
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 48ccc4d..53ed0cb 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -453,7 +453,7 @@ test_expect_success 'stdin fails with duplicate refs' '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: update_ref failed: Multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin create ref works' '
@@ -511,7 +511,7 @@ test_expect_success 'stdin create ref works with path with space to blob' '
 test_expect_success 'stdin update ref fails with wrong old value' '
 	echo "update $c $m $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: update_ref failed: Cannot lock the ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -547,7 +547,7 @@ test_expect_success 'stdin update ref works with right old value' '
 test_expect_success 'stdin delete ref fails with wrong old value' '
 	echo "delete $a $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	grep "fatal: update_ref failed: Cannot lock the ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -634,7 +634,7 @@ test_expect_success 'stdin update refs fails with wrong old value' '
 	update $c  ''
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: update_ref failed: Cannot lock the ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
@@ -807,7 +807,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: update_ref failed: Multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin -z create ref works' '
@@ -847,7 +847,7 @@ test_expect_success 'stdin -z create ref works with path with space to blob' '
 test_expect_success 'stdin -z update ref fails with wrong old value' '
 	printf $F "update $c" "$m" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: update_ref failed: Cannot lock the ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -883,7 +883,7 @@ test_expect_success 'stdin -z update ref works with right old value' '
 test_expect_success 'stdin -z delete ref fails with wrong old value' '
 	printf $F "delete $a" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	grep "fatal: update_ref failed: Cannot lock the ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -952,7 +952,7 @@ test_expect_success 'stdin -z update refs fails with wrong old value' '
 	git update-ref $c $m &&
 	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: update_ref failed: Cannot lock the ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
-- 
1.9.1.521.g5dc89fa
