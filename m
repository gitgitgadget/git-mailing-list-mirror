From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/26] upload-pack: move shallow deepen code out of receive_needs()
Date: Wed, 13 Apr 2016 19:54:47 +0700
Message-ID: <1460552110-5554-4-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKY-0003zU-KF
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966178AbcDMMz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36638 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965750AbcDMMzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id q129so4047750pfb.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLGAtxDEp8xKAlmhVYnGQ4Q/aPsXAg+S/ZVX0liBhYw=;
        b=Lc2vtioJ50EspsYtHiAdiMl3OpAyrIScAaJsg1jSj6udXUcK1CHwJh+HHBYeJGtz5C
         TYbfo02phF+eGbwLACmL2n09Er8Cp63g1kZqsCChZoLkU/F8BnZDGlm3pEPO0AWmbvQe
         W+sUUdEcRrnlh9v4Y91y7bgjR7KvDDScvheEThX4kKw9N/9JKCIvEd15BRCNmyDiIMr5
         o9GJhnumytthNtxNAwMBEzByPl9CiV7SSLlIEkotPFQCpYSptWBV84EstLJDPIqlGi00
         iU4dbJvb8YOn4jDOBGDTpMThnyORwkrzmJaKQWVwgxvuDWwl5sibLogaIrlDtZV94LkW
         xhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLGAtxDEp8xKAlmhVYnGQ4Q/aPsXAg+S/ZVX0liBhYw=;
        b=ilAfr8fpGT7PnexevjgQjcXDC0UTt6Pr71LugDeSu2yqh5sBWEhlv/Oy8pOj4L+r2Z
         0rLeBLdFuof1cF6wtSB6YKAemJGt2OKsNNh+sL+hSL2BwP8DMLSWukn6tnuONkxcCx4n
         NdT6oGXFA9mXQRy1XdtLXvnmovrTMkheLIyqC4drrFTXzVKDGhIun4dBgBxrbrVYE71c
         f5tF27m9Ewc+czElJHnvx/ThyvrAV/h06vmRnK0LqmUpB2ZV+zJrtDs1ErUP34YODDrs
         QKC0/sPVlQUhRl/lMaqQm5JnQ2jsMQfhiVD2odVL0JAc/MqzoKxBJrpJIvEeUdJkK4PD
         h8eA==
X-Gm-Message-State: AOPr4FXJDwCjy/rs38FzwGCUompUHJAZQqu3qKxHeCsyVxP4ZNvQoVAIvsczp1mH3yZ5nA==
X-Received: by 10.98.71.203 with SMTP id p72mr12650885pfi.165.1460552124844;
        Wed, 13 Apr 2016 05:55:24 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id s66sm51075827pfi.3.2016.04.13.05.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:30 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291397>

This is a prep step for further refactoring. Besides reindentation and
s/shallows\./shallows->/g, no other changes are expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 99 +++++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b3f6653..97ed620 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -538,6 +538,55 @@ error:
 	}
 }
=20
+static void deepen(int depth, const struct object_array *shallows)
+{
+	struct commit_list *result =3D NULL, *backup =3D NULL;
+	int i;
+	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
+		for (i =3D 0; i < shallows->nr; i++) {
+			struct object *object =3D shallows->objects[i].item;
+			object->flags |=3D NOT_SHALLOW;
+		}
+	else
+		backup =3D result =3D
+			get_shallow_commits(&want_obj, depth,
+					    SHALLOW, NOT_SHALLOW);
+	while (result) {
+		struct object *object =3D &result->item->object;
+		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
+			packet_write(1, "shallow %s",
+				     oid_to_hex(&object->oid));
+			register_shallow(object->oid.hash);
+			shallow_nr++;
+		}
+		result =3D result->next;
+	}
+	free_commit_list(backup);
+	for (i =3D 0; i < shallows->nr; i++) {
+		struct object *object =3D shallows->objects[i].item;
+		if (object->flags & NOT_SHALLOW) {
+			struct commit_list *parents;
+			packet_write(1, "unshallow %s",
+				     oid_to_hex(&object->oid));
+			object->flags &=3D ~CLIENT_SHALLOW;
+			/* make sure the real parents are parsed */
+			unregister_shallow(object->oid.hash);
+			object->parsed =3D 0;
+			parse_commit_or_die((struct commit *)object);
+			parents =3D ((struct commit *)object)->parents;
+			while (parents) {
+				add_object_array(&parents->item->object,
+						 NULL, &want_obj);
+				parents =3D parents->next;
+			}
+			add_object_array(object, NULL, &extra_edge_obj);
+		}
+		/* make sure commit traversal conforms to client */
+		register_shallow(object->oid.hash);
+	}
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
@@ -630,53 +679,9 @@ static void receive_needs(void)
=20
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
-	if (depth > 0) {
-		struct commit_list *result =3D NULL, *backup =3D NULL;
-		int i;
-		if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
-			for (i =3D 0; i < shallows.nr; i++) {
-				struct object *object =3D shallows.objects[i].item;
-				object->flags |=3D NOT_SHALLOW;
-			}
-		else
-			backup =3D result =3D
-				get_shallow_commits(&want_obj, depth,
-						    SHALLOW, NOT_SHALLOW);
-		while (result) {
-			struct object *object =3D &result->item->object;
-			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-				packet_write(1, "shallow %s",
-						oid_to_hex(&object->oid));
-				register_shallow(object->oid.hash);
-				shallow_nr++;
-			}
-			result =3D result->next;
-		}
-		free_commit_list(backup);
-		for (i =3D 0; i < shallows.nr; i++) {
-			struct object *object =3D shallows.objects[i].item;
-			if (object->flags & NOT_SHALLOW) {
-				struct commit_list *parents;
-				packet_write(1, "unshallow %s",
-					oid_to_hex(&object->oid));
-				object->flags &=3D ~CLIENT_SHALLOW;
-				/* make sure the real parents are parsed */
-				unregister_shallow(object->oid.hash);
-				object->parsed =3D 0;
-				parse_commit_or_die((struct commit *)object);
-				parents =3D ((struct commit *)object)->parents;
-				while (parents) {
-					add_object_array(&parents->item->object,
-							NULL, &want_obj);
-					parents =3D parents->next;
-				}
-				add_object_array(object, NULL, &extra_edge_obj);
-			}
-			/* make sure commit traversal conforms to client */
-			register_shallow(object->oid.hash);
-		}
-		packet_flush(1);
-	} else
+	if (depth > 0)
+		deepen(depth, &shallows);
+	else
 		if (shallows.nr > 0) {
 			int i;
 			for (i =3D 0; i < shallows.nr; i++)
--=20
2.8.0.rc0.210.gd302cd2
