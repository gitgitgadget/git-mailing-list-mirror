X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] clarify some error messages wrt unknown object types
Date: Wed, 20 Dec 2006 13:34:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612201328160.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 18:34:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34953>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx6Gf-0004Jz-ML for gcvg-git@gmane.org; Wed, 20 Dec
 2006 19:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030265AbWLTSeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 13:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWLTSeJ
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 13:34:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44928 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030265AbWLTSeI (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 13:34:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAL00JVV4WTXI80@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Wed,
 20 Dec 2006 13:34:05 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

If ever new object types are added for future extensions then better 
have current git version report them as "unknown" instead of 
"corrupted".

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/index-pack.c b/index-pack.c
index 6d6c92b..35be3e9 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -268,7 +268,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 	case OBJ_TAG:
 		break;
 	default:
-		bad_object(obj->offset, "bad object type %d", obj->type);
+		bad_object(obj->offset, "unknown object type %d", obj->type);
 	}
 	obj->hdr_size = consumed_bytes - obj->offset;
 
diff --git a/sha1_file.c b/sha1_file.c
index 63f416b..1c4df5b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1013,7 +1013,7 @@ void packed_object_info_detail(struct packed_git *p,
 	for (;;) {
 		switch (kind) {
 		default:
-			die("corrupted pack file %s containing object of kind %d",
+			die("pack %s contains unknown object type %d",
 			    p->pack_name, kind);
 		case OBJ_COMMIT:
 		case OBJ_TREE:
@@ -1063,7 +1063,7 @@ static int packed_object_info(struct packed_git *p, unsigned long offset,
 		strcpy(type, type_names[kind]);
 		break;
 	default:
-		die("corrupted pack file %s containing object of kind %d",
+		die("pack %s contains unknown object type %d",
 		    p->pack_name, kind);
 	}
