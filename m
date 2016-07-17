Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B598920195
	for <e@80x24.org>; Sun, 17 Jul 2016 11:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbcGQLAU (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 07:00:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:58424 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbcGQLAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 07:00:17 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LsfrR-1bDVQu3JVp-012KSS; Sun, 17 Jul 2016 12:59:45
 +0200
Date:	Sun, 17 Jul 2016 12:59:44 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] fsck: refactor how to describe objects
In-Reply-To: <cover.1468752290.git.johannes.schindelin@gmx.de>
Message-ID: <7056b23d0105b10efb0ea6d7fe168c72995baf15.1468752290.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <cover.1468752290.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Pm8L83ux6HrnSWqRNDrLzaB+uDlIEWKThg0F//VjfRLv3+Lk/3i
 OCZtetg4RQwzyUF++yubbk2K419dUP2zuUUjAn3DT7yfKVIt1HFAy2rjSOQ2f+K81QkDNxl
 gdiriN9nOSssFvtAUcyaJEDPQZCHuMgKWEK+RJRgBgew6KiL5Du4jjUddWOUpmPH6u5SFot
 6M3z5PDBw98aLewSAcp6w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:owJTl9FxRiA=:y/rrEVdwi60HgsXLgcp4pm
 IT7Ffa9EQ90Wpz0QNtfTTdVwZ06tMqZ32chlLYqVqjV7NlKGiaA5nuyFmmPWMu2bUajaaf3NN
 7H6WH5KuLuB0DV3mp757skmRdGNj0gHyVn9AnXu62jG9C7gsbL0Zo+CG+03vR/yhOpoVa+EdF
 iOkiX01/BKmruPvY7vB2GPFDjbWPzitRR2UjuJSOSiHluV7pPaQbCgeZSoT2855D5Qj9VBeDC
 eySDvV35jC3YY20joo8nFB+2fYn16mSUgbKhAptb72kYYd7TnBbJHiOw5FCTbdJTEGe+TfYQY
 SBhSlf5WPKGHuCkTc5Y00gfq0XRf+1rX3C5A6Qr7lFHLq6XC3bA7GybU+lVLO83RyD5/5zH0A
 3QOMJ3RgT1amNd58syZ7HCaFOgLNKzaSCBuiTi06GRcf031y4jvU/6sJcjtHBEt5O8Hu9pduZ
 UBcKMWwG9bOEqxJDUczH+lk2UATor7q2lFxpKN7dYmtyggNbprbyn1CratEaJKkjK81zwSTcm
 YKAEvjMoe5xUuOzXUcs3hdCpJSd7r8CMrWDGcRAPq34ek/eRZznwcXRVqvHRbfGJdavmHylqu
 S3J0U2go0gtD7OxCu2sUhVte/TzWhNkLPVVotImcTh2k1tLpbVigRbKL161EuksfTfJB62InW
 Th9xczXcWacui6uAtc+OLAWh3GcD/tMvLyZYE4mzynhwjzqJqS/r1dVzsuD/xi9vSVD7AH61+
 kXwdddDF4t5YdQBebY5WbghFd4wlW2N9jGwm1STCbH9GOgTnGuMx3DDa34U1EW5sz+2mgAQS7
 8cl7286
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In many places, we refer to objects via their SHA-1s. Let's abstract
that into a function.

For the moment, it does nothing else than what we did previously: print
out the 40-digit hex string. But that will change over the course of the
next patches.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsck.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3f27456..87df191 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -40,6 +40,11 @@ static int show_dangling = 1;
 #define ERROR_PACK 04
 #define ERROR_REFS 010
 
+static const char *describe_object(struct object *obj)
+{
+	return oid_to_hex(&obj->oid);
+}
+
 static int fsck_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -67,7 +72,7 @@ static void objreport(struct object *obj, const char *msg_type,
 			const char *err)
 {
 	fprintf(stderr, "%s in %s %s: %s\n",
-		msg_type, typename(obj->type), oid_to_hex(&obj->oid), err);
+		msg_type, typename(obj->type), describe_object(obj), err);
 }
 
 static int objerror(struct object *obj, const char *err)
@@ -97,7 +102,7 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf("broken link from %7s %s\n",
-			   typename(parent->type), oid_to_hex(&parent->oid));
+			   typename(parent->type), describe_object(parent));
 		printf("broken link from %7s %s\n",
 			   (type == OBJ_ANY ? "unknown" : typename(type)), "unknown");
 		errors_found |= ERROR_REACHABLE;
@@ -114,9 +119,9 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
-				 typename(parent->type), oid_to_hex(&parent->oid));
+				 typename(parent->type), describe_object(parent));
 			printf("              to %7s %s\n",
-				 typename(obj->type), oid_to_hex(&obj->oid));
+				 typename(obj->type), describe_object(obj));
 			errors_found |= ERROR_REACHABLE;
 		}
 		return 1;
@@ -190,7 +195,8 @@ static void check_reachable_object(struct object *obj)
 			return; /* it is in pack - forget about it */
 		if (connectivity_only && has_object_file(&obj->oid))
 			return;
-		printf("missing %s %s\n", typename(obj->type), oid_to_hex(&obj->oid));
+		printf("missing %s %s\n", typename(obj->type),
+			describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
 		return;
 	}
@@ -215,7 +221,8 @@ static void check_unreachable_object(struct object *obj)
 	 * since this is something that is prunable.
 	 */
 	if (show_unreachable) {
-		printf("unreachable %s %s\n", typename(obj->type), oid_to_hex(&obj->oid));
+		printf("unreachable %s %s\n", typename(obj->type),
+			describe_object(obj));
 		return;
 	}
 
@@ -234,11 +241,11 @@ static void check_unreachable_object(struct object *obj)
 	if (!obj->used) {
 		if (show_dangling)
 			printf("dangling %s %s\n", typename(obj->type),
-			       oid_to_hex(&obj->oid));
+			       describe_object(obj));
 		if (write_lost_and_found) {
 			char *filename = git_pathdup("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
-				oid_to_hex(&obj->oid));
+				describe_object(obj));
 			FILE *f;
 
 			if (safe_create_leading_directories_const(filename)) {
@@ -252,7 +259,7 @@ static void check_unreachable_object(struct object *obj)
 				if (stream_blob_to_fd(fileno(f), obj->oid.hash, NULL, 1))
 					die_errno("Could not write '%s'", filename);
 			} else
-				fprintf(f, "%s\n", oid_to_hex(&obj->oid));
+				fprintf(f, "%s\n", describe_object(obj));
 			if (fclose(f))
 				die_errno("Could not finish '%s'",
 					  filename);
@@ -271,7 +278,7 @@ static void check_unreachable_object(struct object *obj)
 static void check_object(struct object *obj)
 {
 	if (verbose)
-		fprintf(stderr, "Checking %s\n", oid_to_hex(&obj->oid));
+		fprintf(stderr, "Checking %s\n", describe_object(obj));
 
 	if (obj->flags & REACHABLE)
 		check_reachable_object(obj);
@@ -307,7 +314,7 @@ static int fsck_obj(struct object *obj)
 
 	if (verbose)
 		fprintf(stderr, "Checking %s %s\n",
-			typename(obj->type), oid_to_hex(&obj->oid));
+			typename(obj->type), describe_object(obj));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, "broken links");
@@ -326,15 +333,17 @@ static int fsck_obj(struct object *obj)
 		free_commit_buffer(commit);
 
 		if (!commit->parents && show_root)
-			printf("root %s\n", oid_to_hex(&commit->object.oid));
+			printf("root %s\n", describe_object(&commit->object));
 	}
 
 	if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
 
 		if (show_tags && tag->tagged) {
-			printf("tagged %s %s", typename(tag->tagged->type), oid_to_hex(&tag->tagged->oid));
-			printf(" (%s) in %s\n", tag->tag, oid_to_hex(&tag->object.oid));
+			printf("tagged %s %s", typename(tag->tagged->type),
+				describe_object(tag->tagged));
+			printf(" (%s) in %s\n", tag->tag,
+				describe_object(&tag->object));
 		}
 	}
 
-- 
2.9.0.281.g286a8d9


