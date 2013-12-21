From: Jeff King <peff@peff.net>
Subject: [PATCH v4 19/23] count-objects: recognize .bitmap in garbage-checking
Date: Sat, 21 Dec 2013 09:00:34 -0500
Message-ID: <20131221140034.GS21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6m-0005qi-Ke
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab3LUOAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Dec 2013 09:00:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:48500 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753895Ab3LUOAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:36 -0500
Received: (qmail 7551 invoked by uid 102); 21 Dec 2013 14:00:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:34 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239612>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Count-objects will report any "garbage" files in the packs
directory, including files whose extensions it does not
know (case 1), and files whose matching ".pack" file is
missing (case 2).  Without having learned about ".bitmap"
files, the current code reports all such files as garbage
(case 1), even if their pack exists. Instead, they should be
treated as case 2.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1_file.c b/sha1_file.c
index 4714bd8..1294962 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1194,6 +1194,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
=20
 		if (has_extension(de->d_name, ".idx") ||
 		    has_extension(de->d_name, ".pack") ||
+		    has_extension(de->d_name, ".bitmap") ||
 		    has_extension(de->d_name, ".keep"))
 			string_list_append(&garbage, path);
 		else
--=20
1.8.5.1.399.g900e7cd
