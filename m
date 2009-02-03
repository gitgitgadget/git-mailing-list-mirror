From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/3] Try load UI xml files from the current working directory
Date: Tue,  3 Feb 2009 14:08:51 +0100
Message-ID: <1233666531-21589-3-git-send-email-szeder@ira.uka.de>
References: <20090203130818.GA20359@neumann>
	<1233666531-21589-1-git-send-email-szeder@ira.uka.de>
	<1233666531-21589-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Tue Feb 03 14:10:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUL3E-00033F-FL
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 14:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbZBCNJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 08:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZBCNI6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 08:08:58 -0500
Received: from francis.fzi.de ([141.21.7.5]:23842 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753325AbZBCNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 08:08:56 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Feb 2009 14:08:50 +0100
X-Mailer: git-send-email 1.6.1.2.362.g0f78
In-Reply-To: <1233666531-21589-2-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 03 Feb 2009 13:08:50.0851 (UTC) FILETIME=[8EABB730:01C98600]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108186>

Currently, gitg looks for the UI xml files only at the paths where
they should have been installed.  This makes hard to just give gitg a
try without actually installing it, as it simply errors out.

This patch makes running gitg from the root directory of the working
tree possible by checking whether those UI files can be found under
the 'gitg' directory relative to the current working directory if they
can't be found on their proper place.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  This should be further enhanced (e.g. by looking for those files
  relative to the path of the gitg binary), because you can only browse
  gitg's history that way;  running gitg in an other git repository
  without installing it still doesn't work.

 gitg/gitg-utils.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gitg/gitg-utils.c b/gitg/gitg-utils.c
index cfce323..95bccd2 100644
--- a/gitg/gitg-utils.c
+++ b/gitg/gitg-utils.c
@@ -429,7 +429,12 @@ gitg_builder_add_from_file(GtkBuilder *builder, co=
nst gchar *filename)
 	if (!gtk_builder_add_from_file(builder, full_filename, &error))
 	{
 		g_critical("Could not open UI file: %s (%s)", full_filename, error->=
message);
-		g_error_free(error);
-		exit(1);
+
+		g_snprintf(full_filename, PATH_MAX, "%s%c%s", "gitg", G_DIR_SEPARATO=
R, filename);
+		if (!gtk_builder_add_from_file(builder, full_filename, &error))
+		{
+			g_error_free(error);
+			exit(1);
+		}
 	}
 }
--=20
1.6.1.2.362.g0f78
