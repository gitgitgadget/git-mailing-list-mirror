From: Johan Herland <johan@herland.net>
Subject: [PATCH] Update docs on behaviour of 'core.sharedRepository' and 'git init --shared'
Date: Tue, 14 Apr 2009 15:15:42 +0200
Message-ID: <200904141515.42580.johan@herland.net>
References: <7vmyaq2nva.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 15:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtiW1-00060V-9r
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 15:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbZDNNPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 09:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbZDNNPy
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 09:15:54 -0400
Received: from sam.opera.com ([213.236.208.81]:49627 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993AbZDNNPx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 09:15:53 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n3EDFg5w020748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Apr 2009 13:15:48 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vmyaq2nva.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116537>

This documentation update is needed to reflect the recent changes where
"core.sharedRepository = 0mode" was changed to set, not loosen, the
repository permissions.

Signed-off-by: Johan Herland <johan@herland.net>
---

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
