From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] list-objects: perform NULL check before the variable is dereferenced
Date: Mon,  9 Apr 2012 17:45:11 +0700
Message-ID: <1333968311-29889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 12:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHC7F-0000gW-M9
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 12:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab2DIKp5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 06:45:57 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:46930 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2DIKp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 06:45:56 -0400
Received: by dake40 with SMTP id e40so5130254dak.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=4frsMS7vdokbeUPR9ODQ+9TPxn3wKYXIoPlGqkWeyyU=;
        b=Dob+QP1oGwuIDqQw7MtOJvVOVQ3U49jxlsF4Rx//p/BfFfaCjYgBCjaOJYcnM4cEje
         FUUrGl5e8a08rijlpzQs9TCdoCCRDDeTYh1jjIkcwctGeRW+eWxODuAL+oEqgpqR5D+i
         OVdEXoN7kJq5yYsRf2CvQ//ZDvtbaI80Z1KpHiZHTTBuNL1IvNUgoGx0nNEmXlrhddKq
         dDxOwZry5wq/dMt9YziCsWKkciJFGvsN3pTIVaoOiv65EKqjTPoOqZZCOHugrOi0ng2l
         E4R9WvX4VM1JsEAScUidyqxqulmtHIO+iSiaiXaqLCoU6OuUfqb+nl8HGqphF+cA0/fw
         rW4Q==
Received: by 10.68.225.39 with SMTP id rh7mr18406366pbc.104.1333968355907;
        Mon, 09 Apr 2012 03:45:55 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id or6sm11561129pbc.43.2012.04.09.03.45.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Apr 2012 03:45:55 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 09 Apr 2012 17:45:12 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195013>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..34044d9 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -15,12 +15,13 @@ static void process_blob(struct rev_info *revs,
 			 const char *name,
 			 void *cb_data)
 {
-	struct object *obj =3D &blob->object;
+	struct object *obj;
=20
 	if (!revs->blob_objects)
 		return;
-	if (!obj)
+	if (!blob)
 		die("bad blob object");
+	obj =3D &blob->object;
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	obj->flags |=3D SEEN;
@@ -67,7 +68,7 @@ static void process_tree(struct rev_info *revs,
 			 const char *name,
 			 void *cb_data)
 {
-	struct object *obj =3D &tree->object;
+	struct object *obj;
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
@@ -77,8 +78,9 @@ static void process_tree(struct rev_info *revs,
=20
 	if (!revs->tree_objects)
 		return;
-	if (!obj)
+	if (!tree)
 		die("bad tree object");
+	obj =3D &tree->object;
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
 	if (parse_tree(tree) < 0)
--=20
1.7.3.1.256.g2539c.dirty
