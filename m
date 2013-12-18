From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/12] fetch.c: replace some use of starts_with() with skip_prefix()
Date: Wed, 18 Dec 2013 21:53:51 +0700
Message-ID: <1387378437-20646-7-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWN-0003fI-8G
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab3LROyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:41 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:52210 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab3LROyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:40 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so6037132pad.12
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fRTtkCHzbTMd1FZq+M2is+IxBsFN31gwmbUn04RiEdM=;
        b=f1JAlzqikcijgbYphHO+9t7MvUS/z4SKRfr56zlk2KZskCc5wwh9gojdxHw0Ra84eb
         2ELQiYbfsgmOBpqp1cxK24TUzqBmxeNeT/pcy6MTNJIimXdZYWpdWlA0E7LP9OxHhHb7
         J9fw3hGOHCH0lDiGP5PREe0iELXn5zt81Fszpp5XXjTBgJXbHwhylIgHrGpo3E9V7pxU
         X41UL7JtnNlJxVkmxVGts0wPUQCQcizVkwJyoE4qHBPY9tPYER3kbfFX4gM0Ynh2jV8+
         CSRz14Jz9wFuc5yg+VeCnwobB9iNQXArOC1+R+TqfDMyq6dEhucN9V2BhyPh392cUDXn
         Ba2A==
X-Received: by 10.66.216.129 with SMTP id oq1mr34050682pac.75.1387378480270;
        Wed, 18 Dec 2013 06:54:40 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id yd4sm562704pbc.13.2013.12.18.06.54.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:37 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239443>

Variable "what" is set in an if/else chain. If all fails (and "what"
is set to NULL) it'll be reset in the final "else" block.

in get_remote_group(), "key" is only used once. So changing it does
not harm.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1e7d617..38f4f7b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -589,18 +589,12 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
 				kind =3D "";
 				what =3D "";
 			}
-			else if (starts_with(rm->name, "refs/heads/")) {
+			else if ((what =3D skip_prefix(rm->name, "refs/heads/")) !=3D NULL)
 				kind =3D "branch";
-				what =3D rm->name + 11;
-			}
-			else if (starts_with(rm->name, "refs/tags/")) {
+			else if ((what =3D skip_prefix(rm->name, "refs/tags/")) !=3D NULL)
 				kind =3D "tag";
-				what =3D rm->name + 10;
-			}
-			else if (starts_with(rm->name, "refs/remotes/")) {
+			else if ((what =3D skip_prefix(rm->name, "refs/remotes/")) !=3D NUL=
L)
 				kind =3D "remote-tracking branch";
-				what =3D rm->name + 13;
-			}
 			else {
 				kind =3D "";
 				what =3D rm->name;
@@ -896,8 +890,8 @@ static int get_remote_group(const char *key, const =
char *value, void *priv)
 {
 	struct remote_group_data *g =3D priv;
=20
-	if (starts_with(key, "remotes.") &&
-			!strcmp(key + 8, g->name)) {
+	if ((key =3D skip_prefix(key, "remotes.")) !=3D NULL &&
+	    !strcmp(key, g->name)) {
 		/* split list by white space */
 		int space =3D strcspn(value, " \t\n");
 		while (*value) {
--=20
1.8.5.1.208.g019362e
