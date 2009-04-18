From: Johan Herland <johan@herland.net>
Subject: [PATCH] Update docs on behaviour of 'core.sharedRepository' and 'git
 init --shared'
Date: Sat, 18 Apr 2009 12:28:06 +0200
Message-ID: <200904181228.06812.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 12:29:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv7nt-00051k-Vj
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 12:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZDRK2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 06:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZDRK2M
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 06:28:12 -0400
Received: from mx.getmail.no ([84.208.15.66]:42662 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751875AbZDRK2L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 06:28:11 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIA00KDYL2WRGB0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 18 Apr 2009 12:28:08 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KIA003T8L2VLT70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 18 Apr 2009 12:28:08 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.4.18.101635
User-Agent: KMail/1.11.2 (Linux/2.6.29-ARCH; KDE/4.2.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116822>

This documentation update is needed to reflect the recent changes where
"core.sharedRepository = 0mode" was changed to set, not loosen, the
repository permissions.

Signed-off-by: Johan Herland <johan@herland.net>
---

Ping...

On Thursday 09 April 2009, Junio C Hamano wrote:
> Junio C Hamano (13):
>   "core.sharedrepository = 0mode" should set, not loosen

It just hit me that after fixing the main problem, we never clarified
the docs (that were fairly confusing to begin with). I hope this version
is both correct and understandable.


Have fun! :)

...Johan


 Documentation/config.txt   |    6 ++++--
 Documentation/git-init.txt |   16 +++++++++++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f3ebd2f..59217d2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -295,8 +295,10 @@ core.sharedRepository::
 	group-shareable. When 'umask' (or 'false'), git will use permissions
 	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
 	files in the repository will have this mode value. '0xxx' will override
-	user's umask value, and thus, users with a safe umask (0077) can use
-	this option. Examples: '0660' is equivalent to 'group'. '0640' is a
+	user's umask value (whereas the other options will only override
+	requested parts of the user's umask value). Examples: '0660' will make
+	the repo read/write-able for the owner and group, but inaccessible to
+	others (equivalent to 'group' unless umask is e.g. '0022'). '0640' is a
 	repository that is group-readable but not group-writable.
 	See linkgit:git-init[1]. False by default.
 
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..7151d12 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -54,15 +54,21 @@ is given:
 
  - 'group' (or 'true'): Make the repository group-writable, (and g+sx, since
    the git group may be not the primary group of all users).
+   This is used to loosen the permissions of an otherwise safe umask(2) value.
+   Note that the umask still applies to the other permission bits (e.g. if
+   umask is '0022', using 'group' will not remove read privileges from other
+   (non-group) users). See '0xxx' for how to exactly specify the repository
+   permissions.
 
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
- - '0xxx': '0xxx' is an octal number and each file will have mode '0xxx'
-   Any option except 'umask' can be set using this option. '0xxx' will
-   override users umask(2) value, and thus, users with a safe umask (0077)
-   can use this option. '0640' will create a repository which is group-readable
-   but not writable. '0660' is equivalent to 'group'.
+ - '0xxx': '0xxx' is an octal number and each file will have mode '0xxx'.
+   '0xxx' will override users' umask(2) value (and not only loosen permissions
+   as 'group' and 'all' does). '0640' will create a repository which is
+   group-readable, but not group-writable or accessible to others. '0660' will
+   create a repo that is readable and writable to the current user and group,
+   but inaccessible to others.
 
 By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
-- 
1.6.1.2.461.g5bad6

-- 
Johan Herland, <johan@herland.net>
www.herland.net
