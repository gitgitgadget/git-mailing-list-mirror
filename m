Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3884120899
	for <e@80x24.org>; Thu, 10 Aug 2017 09:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdHJJmS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 05:42:18 -0400
Received: from mout.web.de ([212.227.17.11]:50685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdHJJmR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 05:42:17 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MIvXZ-1ddoAn3OiP-002aNd; Thu, 10
 Aug 2017 11:42:12 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fsck: free buffers on error in fsck_obj()
Message-ID: <c7f5b84b-b7b7-c9ed-601d-686b37ffe61c@web.de>
Date:   Thu, 10 Aug 2017 11:42:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:TVLXWIvXO516y7AuAYzoQU5xWTfCPR8AnHR8gKCyWtIQIG1aEhx
 CfxYaBOM6hsRprzg3jSbHJjbRBFFw0PPJpZKq7g+ORkLDBBz+9Rx54zo9yCQAQNn9TQ0aPY
 TyK4H6q8Tr2zjrDzOkzk4Zi87+prWxgSN4f9P7r/sDsexi/KbRW5yJz0Xankkn3G1X9wBi6
 cK8ChOBeMY9RolzSS2ktA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EzVssLZLWL0=:u4Pp1B3doKsC+ib4OVe7HM
 DvflHQ/ATNxg8gZj7c/rcnxdFm76DwBx2DkZon50gai/zw7xsBgJjuq+dJS8G3o/8ONAZYMci
 3gCsri+c4yGeYCBO08/w2uvhf7yuaiQlcbg9UXP+ceYq9O8kzZ8w9qdxyHSninL/pQGQWCXhv
 8tpUs37KU7DGHvbGCsbh6f4exnO8ruPc0iskrZgeXpWhRLjxW1LyXQstAACnQW5unAFW/Vf6U
 HCf/HW3B3kKGaYq/cH2+pLVyp9itcnSmIgXcV0JXQ2w7u6TjmzsFPhjyeICa9X4MruoY4DXK/
 h/nbnT8S6kluQ588gdA1goQu+PaFMjM+1C76exj16sZI8ohdNJ90NeUMhIKVxPWqIpNiyUyX7
 HQGKRWqecKaudtL1FQMgHfrKmFgaW6tqc/kD/qqgqGUQQHrefDtvayLCgpBRALe/XITEtTW6b
 +EtJUCS3puSBxR4BsD4WJdgJZkPdYoGZ51Ys0kx7e0izfqfoLAj6hxlUXm5E6xYna1KOWb+OJ
 RHd/LrPEU4KWbO7ht/Qp2iMOXDJL8Qpq76JXaCFFOinZNCJOgTllhGRj0Rx2k9wzwC+GtYs5s
 m7TXO0eYKraCDf/AbOGptPkGEHZfZh+6XsXLUDo4qc0E8kB16Baz8qrxTZk0iqjPH9BoMXpKu
 ABFwIXhT1WKI/VLpFmw7T3wW6OoALCELWe1wythlenFNace1IUpSEG55ln00yib9idlaC/wAm
 ECAOLke7+HWZQkWjCKU9plBEOtcanK5TWRnh54uSqolEG6N/wiPeTlr7mHdUciHUa91bAkBtd
 QORPJ4WKjsh3WN3y1K8UeaR0PhVRlRnpk+KpmbeFjujMPlxQDM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the code for releasing tree buffers and commit buffers in
fsck_obj() to the end of the function and make sure it's executed no
matter of an error is encountered or not.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/fsck.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf6..698a8776a4 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -335,6 +335,8 @@ static void check_connectivity(void)
 
 static int fsck_obj(struct object *obj)
 {
+	int err;
+
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |= SEEN;
@@ -345,20 +347,13 @@ static int fsck_obj(struct object *obj)
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, "broken links");
-	if (fsck_object(obj, NULL, 0, &fsck_obj_options))
-		return -1;
-
-	if (obj->type == OBJ_TREE) {
-		struct tree *item = (struct tree *) obj;
-
-		free_tree_buffer(item);
-	}
+	err = fsck_object(obj, NULL, 0, &fsck_obj_options);
+	if (err)
+		goto out;
 
 	if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 
-		free_commit_buffer(commit);
-
 		if (!commit->parents && show_root)
 			printf("root %s\n", describe_object(&commit->object));
 	}
@@ -374,7 +369,12 @@ static int fsck_obj(struct object *obj)
 		}
 	}
 
-	return 0;
+out:
+	if (obj->type == OBJ_TREE)
+		free_tree_buffer((struct tree *)obj);
+	if (obj->type == OBJ_COMMIT)
+		free_commit_buffer((struct commit *)obj);
+	return err;
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-- 
2.14.0
