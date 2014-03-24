From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/27] update-ref --stdin: Improve error messages for invalid values
Date: Mon, 24 Mar 2014 18:56:43 +0100
Message-ID: <1395683820-17304-11-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS99F-0002Oo-52
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbaCXR6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:58:46 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51437 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753568AbaCXR5a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:30 -0400
X-AuditID: 1207440f-f79326d000003c9f-c7-533072096320
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E5.93.15519.90270335; Mon, 24 Mar 2014 13:57:29 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xg028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:27 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqMtZZBBscKJN3WLnOgmLrivdTBYN
	vVeYLebd3cVkcXvFfGaLHy09zBYfOxcwO7B7/H3/gclj56y77B6XXn5n8/j4bDm7x7PePYwe
	Fy8pe3zeJBfAHsVtk5RYUhacmZ6nb5fAndHSX13wUrNi7sE2tgbGjUpdjBwcEgImEqvvJXYx
	cgKZYhIX7q1n62Lk4hASuMwo0bbhHxOEc4JJYuvzPywgVWwCuhKLepqZQGwRATWJiW2HWECK
	mAWuMEpc+bgdrEhYIFxi4vbdzCA2i4CqxP+DvWwg23gFXCVmHTaA2CYnMeX3AnYQmxMovLX9
	MFi5kICLxI6PvUwTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJ
	O/4djF3rZQ4xCnAwKvHwRhgbBAuxJpYVV+YeYpTkYFIS5WXLBQrxJeWnVGYkFmfEF5XmpBYf
	YpTgYFYS4bUMB8rxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4pQuB
	GgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBcRFfDIwMkBQP0F4HkHbe4oLEXKAo
	ROspRkUpcd5rBUAJAZBERmke3FhYMnnFKA70pTCvGkg7DzARwXW/AhrMBDQ4vEkPZHBJIkJK
	qoHRzTDIcAIns/elB/Fz1wsXfwx8G2G5d3ec4zcfGUXmC6/vbxeaZHpgn+1HtwO7RAJa/3/Y
	YHjOeLVlZGmIjvK5nBV9B84+2nxOJsHZpvhok0lExke2/RteRV95l3SyqXCausz3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244853>

If an invalid value is passed to "update-ref --stdin" as <oldvalue> or
<newvalue>, include the command and the name of the reference at the
beginning of the error message.  Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 24 +++++++++++++-----------
 t/t1400-update-ref.sh |  8 ++++----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0dc2061..13a884a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -35,20 +35,22 @@ static struct ref_update *update_alloc(void)
 	return update;
 }
 
-static void update_store_new_sha1(struct ref_update *update,
+static void update_store_new_sha1(const char *command,
+				  struct ref_update *update,
 				  const char *newvalue)
 {
 	if (*newvalue && get_sha1(newvalue, update->new_sha1))
-		die("invalid new value for ref %s: %s",
-		    update->ref_name, newvalue);
+		die("%s %s: invalid new value: %s",
+		    command, update->ref_name, newvalue);
 }
 
-static void update_store_old_sha1(struct ref_update *update,
+static void update_store_old_sha1(const char *command,
+				  struct ref_update *update,
 				  const char *oldvalue)
 {
 	if (*oldvalue && get_sha1(oldvalue, update->old_sha1))
-		die("invalid old value for ref %s: %s",
-		    update->ref_name, oldvalue);
+		die("%s %s: invalid old value: %s",
+		    command, update->ref_name, oldvalue);
 
 	/* We have an old value if non-empty, or if empty without -z */
 	update->have_old = *oldvalue || line_termination;
@@ -165,12 +167,12 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		die("update line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1(update, newvalue.buf);
+		update_store_new_sha1("update", update, newvalue.buf);
 	else
 		die("update %s missing <newvalue>", update->ref_name);
 
 	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1(update, oldvalue.buf);
+		update_store_old_sha1("update", update, oldvalue.buf);
 		if (*next != line_termination)
 			die("update %s has extra input: %s", update->ref_name, next);
 	} else if (!line_termination)
@@ -191,7 +193,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1(update, newvalue.buf);
+		update_store_new_sha1("create", update, newvalue.buf);
 	else
 		die("create %s missing <newvalue>", update->ref_name);
 
@@ -216,7 +218,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1(update, oldvalue.buf);
+		update_store_old_sha1("delete", update, oldvalue.buf);
 		if (update->have_old && is_null_sha1(update->old_sha1))
 			die("delete %s given zero old value", update->ref_name);
 	} else if (!line_termination)
@@ -240,7 +242,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &value)) {
-		update_store_old_sha1(update, value.buf);
+		update_store_old_sha1("verify", update, value.buf);
 		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
 		die("verify %s missing [<oldvalue>] NUL", update->ref_name);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 00862bc..f6c6e96 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -518,14 +518,14 @@ test_expect_success 'stdin update ref fails with wrong old value' '
 test_expect_success 'stdin update ref fails with bad old value' '
 	echo "update $c $m does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	grep "fatal: update $c: invalid old value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with bad new value' '
 	echo "create $c does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	grep "fatal: create $c: invalid new value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -840,14 +840,14 @@ test_expect_success 'stdin -z update ref fails with wrong old value' '
 test_expect_success 'stdin -z update ref fails with bad old value' '
 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	grep "fatal: update $c: invalid old value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with bad new value' '
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	grep "fatal: create $c: invalid new value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
-- 
1.9.0
