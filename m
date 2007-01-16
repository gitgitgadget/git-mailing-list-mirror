From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH RFC] new config option remote.<name>.pushexec
Date: Tue, 16 Jan 2007 16:02:59 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070116150259.GA2439@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Jan 16 16:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6pp0-0000AY-4N
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 16:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXAPPB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbXAPPBz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 10:01:55 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43852 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750984AbXAPPBz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 10:01:55 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H6pow-0005XP-1l
	for git@vger.kernel.org; Tue, 16 Jan 2007 16:01:54 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0GF1qDa016767
	for <git@vger.kernel.org>; Tue, 16 Jan 2007 16:01:52 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0GF1pS3016766
	for git@vger.kernel.org; Tue, 16 Jan 2007 16:01:51 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36942>

git push --exec=3D... is fine, but having it to specify every time is
annoying.

This sets the default remote program for pushing to remote <name>.

Signed-off-by: Uwe Kleine-K=F6nig <zeisberg@informatik.uni-freiburg.de>
---

This has (still) a few short comings:

 a) compiler warning because execute has the type const char*.

 b) cmdline should overwrite remote.<name>.pushexec w/o the warning.

 c) the symmetric part for fetch is missing.

The idea should be clear.  Would a more complete patch be welcome?

Best regards
Uwe

 Documentation/config.txt |    4 ++++
 builtin-push.c           |    7 +++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index faa17ba..667628a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -351,6 +351,10 @@ remote.<name>.push::
 	The default set of "refspec" for gitlink:git-push[1]. See
 	gitlink:git-push[1].
=20
+remote.<name>.pushexec::
+	The default program to execute on the remote side.  See
+	option \--exec of gitlink:git-push[1].
+
 repack.usedeltabaseoffset::
 	Allow gitlink:git-repack[1] to create packs that uses
 	delta-base offset.  Defaults to false.
diff --git a/builtin-push.c b/builtin-push.c
index 7a3d2bb..8ea5dea 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -157,6 +157,13 @@ static int get_remote_config(const char* key, cons=
t char* value)
 		else if (config_get_refspecs &&
 			 !strcmp(key + 7 + config_repo_len, ".push"))
 			add_refspec(xstrdup(value));
+		else if (!strcmp(key + 7 + config_repo_len, ".pushexec")) {
+			if (!execute) {
+				execute =3D xmalloc(strlen(value) + 8);
+				sprintf(execute, "--exec=3D%s", value);
+			} else
+				error("more than one pushexec given");
+		}
 	}
 	return 0;
 }
--=20
1.5.0.rc1.g581a


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5+choose+3
