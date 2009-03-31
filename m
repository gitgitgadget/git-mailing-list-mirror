From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] Mailmap: Allow empty email addresses to be mapped
Date: Tue, 31 Mar 2009 17:30:39 +0200
Message-ID: <20090331153039.GA1520@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lofym-0003D4-GJ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763218AbZCaPau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 11:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763255AbZCaPas
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:30:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:48468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763246AbZCaPaq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 11:30:46 -0400
Received: (qmail invoked by alias); 31 Mar 2009 15:30:42 -0000
Received: from i59F54235.versanet.de (EHLO atjola.local) [89.245.66.53]
  by mail.gmx.net (mp043) with SMTP; 31 Mar 2009 17:30:42 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+8DK8Z6Rq8JMbWIRIkUqyhWg5NiNfzEDMIeYhBsB
	pqPXVvBW6uscHG
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115267>

While it makes no sense to map some email address to an empty one, doin=
g
things the other way around can be useful. For example when using
filter-branch with an env-filter that employs a mailmap to fix up an
import that created such broken commits with empty email addresses.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 mailmap.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index f12bb45..654c629 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -90,7 +90,8 @@ static void add_mapping(struct string_list *map,
 		 old_name, old_email, new_name, new_email);
 }
=20
-static char *parse_name_and_email(char *buffer, char **name, char **em=
ail)
+static char *parse_name_and_email(char *buffer, char **name,
+		char **email, int allow_empty_email)
 {
 	char *left, *right, *nstart, *nend;
 	*name =3D *email =3D 0;
@@ -99,7 +100,7 @@ static char *parse_name_and_email(char *buffer, char=
 **name, char **email)
 		return NULL;
 	if ((right =3D strchr(left+1, '>')) =3D=3D NULL)
 		return NULL;
-	if (left+1 =3D=3D right)
+	if (!allow_empty_email && (left+1 =3D=3D right))
 		return NULL;
=20
 	/* remove whitespace from beginning and end of name */
@@ -150,8 +151,8 @@ static int read_single_mailmap(struct string_list *=
map, const char *filename, ch
 			}
 			continue;
 		}
-		if ((name2 =3D parse_name_and_email(buffer, &name1, &email1)) !=3D N=
ULL)
-			parse_name_and_email(name2, &name2, &email2);
+		if ((name2 =3D parse_name_and_email(buffer, &name1, &email1, 0)) !=3D=
 NULL)
+			parse_name_and_email(name2, &name2, &email2, 1);
=20
 		if (email1)
 			add_mapping(map, name1, email1, name2, email2);
--=20
1.6.2.1.425.ga9a94
