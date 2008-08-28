From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] Allow 'git cmd -h' outside of repository
Date: Thu, 28 Aug 2008 23:28:37 +0200
Message-ID: <1219958917-22780-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:30:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYp4V-00040R-Tb
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbYH1V3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 17:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYH1V3N
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:29:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57996 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYH1V3M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:29:12 -0400
Received: from [127.0.1.1] (p5B1346C3.dip0.t-ipconnect.de [91.19.70.195])
	by mrelayeu.kundenserver.de (node=mrelayeu3) with ESMTP (Nemesis)
	id 0MKxQS-1KYp2j16xF-0000P0; Thu, 28 Aug 2008 23:28:38 +0200
X-Mailer: git-send-email 1.6.0.1.133.g10dd.dirty
X-Provags-ID: V01U2FsdGVkX19ttQzCIpJDr70rfOSSWN6VT6LSMu+TnAZWWMv
 h9Jy0fuY2vmSZnxgqNqKxjyTxTKyNGVvVA5znfOR6Xa/JP/iy7
 JedZWZn6WKbgdHS9zmlzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94181>

Printing usage strings of git commands should obviously not depend on
the command being run inside a git repository.  However, in case of a
command requiring a repository, the command line options are parsed onl=
y
after it is ensured that the command was started inside a repository,
resulting in a 'fatal: Not a git repository' if 'git cmd -h' wasn't
executed inside a repository.

To get around this issue, we will check early for the presence of '-h'
option, and skip ensuring that the command is run inside a repository.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 git.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 37b1d76..af53472 100644
--- a/git.c
+++ b/git.c
@@ -380,6 +380,10 @@ static void handle_internal_command(int argc, cons=
t char **argv)
 		struct cmd_struct *p =3D commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
+		/* Don't require repository if only usage string is requested */
+		if (argc > 1 && !strcmp(argv[1], "-h")) {
+			p->option =3D 0;
+		}
 		exit(run_command(p, argc, argv));
 	}
 }
--=20
1.6.0.1.133.g10dd.dirty
