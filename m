From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] clone-pack: new option --keep to keep the pack unexploded.
Date: Wed, 12 Oct 2005 18:23:17 -0700
Message-ID: <7vmzleb46y.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051012173426.56fd5c1c.vsu@altlinux.ru>
	<20051012135405.CDE55E005E3@center4.mivlgu.local>
	<7vslv6b86l.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 03:24:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EProY-0005NW-2z
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 03:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVJMBXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 21:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJMBXT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 21:23:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36246 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964855AbVJMBXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 21:23:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013012308.LKRS19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 21:23:08 -0400
To: git@vger.kernel.org
In-Reply-To: <7vslv6b86l.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 12 Oct 2005 16:57:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10058>

With new option --keep, or a configuration item clone.keeppack (we
need a better name, or start allowing dash,"clone.keep-pack"), the packed
data downloaded while cloning is saved as a pack in .git/objects/pack/
locally, with index generated for it with git-index-pack.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Here is how to use it.

    $ mkdir test
    $ cd test
    $ git-init-db
    defaulting to local storage area
    $ git-clone-pack --keep ../other/repo/sito/ry/.git
    Packing 9044 objects
    $ git-checkout

   After cloning, you would notice there is no individual
   objects; instead you will find a single packfile in
   .git/objects/pack/ directory.

 Documentation/git-clone-pack.txt |    7 ++++++-
 clone-pack.c                     |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

applies-to: fa5213875bff7fdb8c7d05f35a047eedf3cb3af2
b64a46c81d8347e59285584e830e1ad99ad387e0
diff --git a/Documentation/git-clone-pack.txt b/Documentation/git-clone-pack.txt
index 87c0e46..b58165a 100644
--- a/Documentation/git-clone-pack.txt
+++ b/Documentation/git-clone-pack.txt
@@ -8,7 +8,7 @@ git-clone-pack - Clones a repository by 
 
 SYNOPSIS
 --------
-'git-clone-pack' [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<head>...]
+'git-clone-pack' [-q] [--keep] [--exec=<git-upload-pack>] [<host>:]<directory> [<head>...]
 
 DESCRIPTION
 -----------
@@ -23,6 +23,11 @@ OPTIONS
 	Pass '-q' flag to 'git-unpack-objects'; this makes the
 	cloning process less verbose.
 
+--keep::
+	Do not invoke 'git-unpack-objects' on received data, but
+	create a single packfile out of it instead, and store it
+	in the object database.
+
 --exec=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if it is not found on your $PATH.
diff --git a/clone-pack.c b/clone-pack.c
index 9567900..2f09df0 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -5,7 +5,8 @@
 
 static int quiet;
 static int keep_pack;
-static const char clone_pack_usage[] = "git-clone-pack [-q] [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
+static const char clone_pack_usage[] =
+"git-clone-pack [-q] [--keep] [--exec=<git-upload-pack>] [<host>:]<directory> [<heads>]*";
 static const char *exec = "git-upload-pack";
 
 static void clone_handshake(int fd[2], struct ref *ref)
---
0.99.8.GIT
