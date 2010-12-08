From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] get_sha1_oneline: allow to input commit_list
Date: Wed,  8 Dec 2010 21:58:38 +0700
Message-ID: <1291820319-12455-2-git-send-email-pclouds@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 16:00:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQLUy-0003lY-5Y
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 16:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab0LHO7x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 09:59:53 -0500
Received: from mail-px0-f179.google.com ([209.85.212.179]:64316 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab0LHO7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 09:59:52 -0500
Received: by pxi20 with SMTP id 20so376334pxi.10
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=VwrgssMAjI0fRsmocN0zIFnrlSpilxd/rDotes2c0sY=;
        b=wh20F437AZIw32ilE5PxDeraohZIMkdhTKGeyxUfs2aO9KCqUdxXo9xUyNNeRjopzd
         WojSLZXA73slwVXSldDdUXpX2CUFaSTUAZo2Cp1JYBP8d+8y1hAKGbw8Na6BF3wQWvtt
         nvy7zzcvv5AhtCONMt42LbPhj9mNvoTbe7rJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SDWeJ2KmX9eJbgiVCqjHGOmMeMnm2cY1VZN3iZmsO9Qdx89gEsakQ7wVG90CbyAT15
         SOTqWloe7R8y1jF0I4a5EN0e2Ukk5FeFb7kFafa/vAnODLA4/FNuoyV12MFvNCRuuxmu
         4wXDrboKqW+cg2tP2Ep5cAoR7q5tkTa7Z1GK4=
Received: by 10.142.89.20 with SMTP id m20mr2639430wfb.13.1291820391849;
        Wed, 08 Dec 2010 06:59:51 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.178])
        by mx.google.com with ESMTPS id w42sm945365wfh.3.2010.12.08.06.59.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 06:59:50 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 08 Dec 2010 21:58:55 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163196>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2c3a5fb..f4ccdc5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -686,13 +686,14 @@ static int handle_one_ref(const char *path,
 	if (object->type !=3D OBJ_COMMIT)
 		return 0;
 	insert_by_date((struct commit *)object, list);
-	object->flags |=3D ONELINE_SEEN;
 	return 0;
 }
=20
-static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
+static int get_sha1_oneline(const char *prefix,
+			    unsigned char *sha1,
+			    struct commit_list *list_)
 {
-	struct commit_list *list =3D NULL, *backup =3D NULL, *l;
+	struct commit_list *list =3D list_, *backup =3D NULL, *l;
 	int retval =3D -1;
 	char *temp_commit_buffer =3D NULL;
 	regex_t regex;
@@ -706,9 +707,12 @@ static int get_sha1_oneline(const char *prefix, un=
signed char *sha1)
 	if (regcomp(&regex, prefix, REG_EXTENDED))
 		die("Invalid search pattern: %s", prefix);
=20
-	for_each_ref(handle_one_ref, &list);
-	for (l =3D list; l; l =3D l->next)
+	if (!list)
+		for_each_ref(handle_one_ref, &list);
+	for (l =3D list; l; l =3D l->next) {
 		commit_list_insert(l->item, &backup);
+		l->item->object.flags |=3D ONELINE_SEEN;
+	}
 	while (list) {
 		char *p;
 		struct commit *commit;
@@ -737,7 +741,8 @@ static int get_sha1_oneline(const char *prefix, uns=
igned char *sha1)
 	}
 	regfree(&regex);
 	free(temp_commit_buffer);
-	free_commit_list(list);
+	if (!list_)
+		free_commit_list(list);
 	for (l =3D backup; l; l =3D l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
 	return retval;
@@ -1090,7 +1095,7 @@ int get_sha1_with_context_1(const char *name, uns=
igned char *sha1,
 		int pos;
 		if (namelen > 2 && name[1] =3D=3D '/')
 			/* don't need mode for commit */
-			return get_sha1_oneline(name + 2, sha1);
+			return get_sha1_oneline(name + 2, sha1, NULL);
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
 		    name[1] < '0' || '3' < name[1])
--=20
1.7.3.2.316.gda8b3
