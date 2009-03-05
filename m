From: Petri Hodju <petri.hodju@yumesystems.com>
Subject: [PATCH] '%S' option for pretty printing to support --source
Date: Thu, 5 Mar 2009 09:18:28 +0200
Organization: Yume Systems
Message-ID: <200903050918.29051.petri.hodju@yumesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 05 08:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf7yp-0008P3-Vu
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 08:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZCEHZY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 02:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbZCEHZX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 02:25:23 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:49725 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZCEHZX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 02:25:23 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2009 02:25:22 EST
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 24776EF5C0;
	Thu,  5 Mar 2009 09:18:18 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0746EDCBBE; Thu, 05 Mar 2009 09:18:17 +0200
Received: from toybox.local (a88-112-217-75.elisa-laajakaista.fi [88.112.217.75])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 0747C403E;
	Thu,  5 Mar 2009 09:18:12 +0200 (EET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112259>

=46rom 79f817e25aada377ccb40ebf76c29af7f21e1ec4 Mon Sep 17 00:00:00 200=
1
=46rom: Petri Hodju <petrihodju@yahoo.com>
Date: Thu, 5 Mar 2009 09:00:39 +0200
Subject: [PATCH] '%S' option for pretty printing to support --source
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Print out the ref name by which each commit was reached. Works only whe=
n --source option is used

Examples:

git-log --graph --pretty=3Dformat:"%h(%S) =E2=80=94 %s (%cr)" --abbrev-=
commit --date=3Drelative --source

Show ref by which each commit is reachable in current branch

git-log --graph --pretty=3Dformat:"%h(%S) =E2=80=94 %s (%cr)" --abbrev-=
commit --date=3Drelative --source --all

Show ref by which each commit is reachable globally

Signed-off-by: Petri Hodju <petrihodju@yahoo.com>
---
 pretty.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6cd9149..cf05b37 100644
--- a/pretty.c
+++ b/pretty.c
@@ -544,6 +544,12 @@ static void format_decoration(struct strbuf *sb, c=
onst struct commit *commit)
 		strbuf_addch(sb, ')');
 }
=20
+static void format_source(struct strbuf *sb, const struct commit *comm=
it)
+{
+    if (commit->util)
+	strbuf_addstr(sb, (char *) commit->util);
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
                                void *context)
 {
@@ -650,6 +656,9 @@ static size_t format_commit_item(struct strbuf *sb,=
 const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'S':
+		format_source(sb, commit);
+		return 1;
 	}
=20
 	/* For the rest we have to parse the commit header. */
--=20
1.6.2.rc2.22.g1d035.dirty
