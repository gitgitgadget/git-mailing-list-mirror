Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD90320196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbcGNPa0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:30:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:61839 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbcGNPaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:30:24 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LjquD-1aqJmP0cvZ-00brxm; Thu, 14 Jul 2016 17:30:20
 +0200
Date:	Thu, 14 Jul 2016 17:30:19 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] fsck: refactor how to describe objects
In-Reply-To: <cover.1468510191.git.johannes.schindelin@gmx.de>
Message-ID: <75cd5de6b5a027a32d6ed6b922aa601226d464e5.1468510191.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wyMon7WKVb7cXo2hJ0+uLC9wxkOp5lau70Ptcw+/61rp/s3gRO0
 0g63MSsytKx+z/H7YxLbpLi3DZ1cox4tKUI4OQgckk357J/0oqOol0ws3S062xVy68JHxYh
 D2SaDsudMiuwa1eWIW762xyPKaIRHYnecCISnISvHadFsq9u4yBK3l1D0DFA5WKv1QdbztM
 n3GKpq/W0tmcdGW+howWQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Sh3T+ZVMFts=:eN2dox8R+utP4+Bk4rghg4
 FM3XZG1ABujKZcaNolV6tbwJIEBAUZVkWuAnN4h7oXo4As65j1QGJWdfhIoZoDXptTUuXqsUp
 WAH7Q9P0rp2bo4iXwku2ITdVupgqPzIsGQ+e2dWeUy4dFVMRJhWeZXf/koxThnTt11OPEtZSo
 FDpn6+pOqpyecgj/U4TQT/BcfeDb0Nurebfgh3c6dWEcneVT/oBX/11qQ3oQL0giuJtjQ/X4T
 j49NLUa9iJOoB7edIbjqkqwlwEeR5YUsYVEbh2Cg99ESsj+2cJjJjA88cmd4W6HVmVJ7yVmlc
 Fn65JazcnKPCphgaz1k9Nz4caR7lZFTqrnd4Csk854jrdHK18stYDo3fBVKvYHRHemeG/yJdl
 DdsgpEhKDcUEbpuJqf96pn6Vy2UKT1hlGZYhMORs7lj6sxt5R1rPPRRztv38JbZY9heHxF9de
 kqOeuZd/Uu7Ix9ThN3oPk1+IzVeODh2mscsUSMlOpGsGj2zmwwJf4N07pMrMXYCtV5NcNm8ue
 WwOk8OOdt3en0eVzfk9MztJfU7dnjwg1EassERqG+mwa10+wTKl92UNI++AGtdMB4+nXrGUow
 VsO/MF1GERWtLZHoNv0pHUza03h6BJyrGEKsujCfHoS3mNS2/vPuy3LGgkM6xO3YEo2pD6X3V
 NVXmrv5JyvyMpXLL5VMAdIStphg6ouuJXrSsmtZgn5GCKkzqeUv57wNmRv7B7P43QydcAmmer
 j4T56X37aSCKDKUOFK9TRxOU7e6EFAr17zhNL9IrxyoL7iUfoRetuYSo6v8Mseq25wsY1NGxs
 CDrUhou
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
2.9.0.278.g1caae67


