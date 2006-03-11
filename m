From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] imap-send: cleanup execl() call to use NULL sentinel instead of 0
Date: Sat, 11 Mar 2006 09:55:50 +0100
Message-ID: <20060311085550.GA32089@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 09:56:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHztc-00046Q-QN
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 09:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWCKIz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 03:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWCKIz4
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 03:55:56 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:39111 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S932435AbWCKIzz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 03:55:55 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FHzt8-0008Ms-Ix; Sat, 11 Mar 2006 09:55:50 +0100
To: Mike McCormack <mike@codeweavers.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17498>

Some versions of gcc check that calls to the exec() family have the proper
sentinel for variadic calls. This should be (char *) NULL according to the
man page. Although for all other purposes the 0 is equivalent, gcc
nevertheless does emit a warning for 0 and not for NULL. This also makes the
usage consistent throughout git.

The whitespace in function calls throughout imap-send.c has its own style,
so I left it that way.

---

 imap-send.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

db1a0875cbc28970208e7a2fbb93d680d8ffe572
diff --git a/imap-send.c b/imap-send.c
index fddaac0..203284d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -945,7 +945,7 @@ imap_open_store( imap_server_conf_t *srv
 				_exit( 127 );
 			close( a[0] );
 			close( a[1] );
-			execl( "/bin/sh", "sh", "-c", srvc->tunnel, 0 );
+			execl( "/bin/sh", "sh", "-c", srvc->tunnel, NULL );
 			_exit( 127 );
 		}
 
-- 
1.2.4.ge29f
Marco Roeland
