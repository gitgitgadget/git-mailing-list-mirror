From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/27] update-ref --stdin: improve error messages for invalid values
Date: Mon,  7 Apr 2014 15:48:01 +0200
Message-ID: <1396878498-19887-11-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9wY-0003sP-Ei
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbaDGNu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:50:28 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50790 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755334AbaDGNso (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:44 -0400
X-AuditID: 1207440c-f79656d000003eba-c0-5342acbb80f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 33.35.16058.BBCA2435; Mon,  7 Apr 2014 09:48:43 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaH026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:41 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLt7jVOwwc5HShY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oztmxqZC15qVhw/fIKtgXGjUhcjJ4eEgInE6ueP
	WCBsMYkL99azdTFycQgJXGaUOPR4AwuEc4xJ4tX36cwgVWwCuhKLepqZQGwRATWJiW2HwIqY
	Ba4wSlz5uB1slLBAuMTGE7vZQWwWAVWJKR8XMILYvAKuEttPL2CFWCcncfLYZDCbEyg+49At
	sBohAReJ+2uOsUxg5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyT4
	eHYwflsnc4hRgINRiYd3xSHHYCHWxLLiytxDjJIcTEqivM+XOQUL8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuHlWg2U401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8FqD
	NAoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoiO+GBgfICkeoL1PV4HsLS5IzAWK
	QrSeYlSUEudlA0kIgCQySvPgxsJSyitGcaAvhXmNQbbzANMRXPcroMFMQIMNXcEGlyQipKQa
	GHX21KzhfmqReP/o6xvz2DjUlBtO8Xi1xzRazI+7ufyaH1faJ8u16tx7v1ktTBRd8cyaed/f
	lzMUpvg8f3o1/3glU0hFyJMXcvNZSq/0bAooT5NsUzsb8P0fX89qgY+b1UxKeuIT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245862>

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
1.9.1
