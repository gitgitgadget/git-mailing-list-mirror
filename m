From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/25] upload-pack: move shallow deepen code out of receive_needs()
Date: Thu,  4 Feb 2016 16:03:40 +0700
Message-ID: <1454576641-29615-5-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:04:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFqI-0005cb-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbcBDJEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:41 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35543 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965381AbcBDJEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:35 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so38466142pfd.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WHVM/Bu4FldmZC+8Iyz0KEXKiH1scP6iKDtyDSSNCQA=;
        b=cgm3Oz3ozZwpdgTeotrjRaqjAfFPKhlw3FYpS4mbM+GX/TUFmSNnmjRPv5KJ9IMOdO
         AvCJm/hJumlAcaw5G9+tcjfzV9oaLoa0je7irW5nOJKPQgl+V4fquNjf5ZFl+rMkq9Qw
         0SHxJQ+l7KyR/T7hkTPId4K8fzxw7SxH1p7I0TWP9/xkFd5wkdXrxau67IC5LjAiAUuf
         4KRnGckA4D1P8YOUoSsoIqlStuZw7uPczKp+g7uVEG5vtX7xj3gqmj+C9zGa0VjNgkTQ
         virn2BeOGNAgLDDn7lRIEWTMF0vr23gf5PEIzwQZaxTM12FEIKITzLIrxiL4JXud8VaQ
         yrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=WHVM/Bu4FldmZC+8Iyz0KEXKiH1scP6iKDtyDSSNCQA=;
        b=Jf1Tx3Ga/URSZ1/RxxM7JIv7qwETdfLIFnNACvDjus+Yclac0UuElgBUPrC2aSoWJH
         zaNbLXtPFa4bo3w2ggEYT+o9Kn9EzZ2AoYpB3XwQUZUU0tLnFZBnK42Mnq7CJ90PqpwT
         0IcXS7cAhNLcLJLaQUx86lO0KnNK3wAKU+zCmrNcWqT973gumYTXl/ihaNZJto50xsRS
         YCU71YcidlDhm1TQ1k6snhWv2k4Pq3/Cd6gnAPOXxNl+xORnDsSkkU8cE3pqXiQIbJfx
         ZTG8UdEdOrt5dZ7C+98Mzoq0ltqibo2e9LbMxSjNEHo+r7ktidJKLcuRSM+OXYVwe0M3
         ofqA==
X-Gm-Message-State: AG10YOQetarnHiZPhXHgdN3jvTLHgJlLHqr1fHYcXDi8gJvXw+YOYEiBzFu9I2jRx99qrA==
X-Received: by 10.98.34.212 with SMTP id p81mr9245343pfj.23.1454576674948;
        Thu, 04 Feb 2016 01:04:34 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id dg1sm15380315pad.18.2016.02.04.01.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:47 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285418>

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
2.7.0.377.g4cd97dd
