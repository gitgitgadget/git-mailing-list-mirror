From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [BULLS**T PATCH] Allow Git to work at Insane Bank Corp
Date: Wed, 14 Nov 2007 20:52:27 -0500
Message-ID: <20071115015227.GA2116@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 02:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTuS-0007SJ-3b
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbXKOBwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbXKOBwc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:52:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47373 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbXKOBwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 20:52:31 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsTty-0001rt-6Q
	for git@vger.kernel.org; Wed, 14 Nov 2007 20:52:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 73FF920FBAE; Wed, 14 Nov 2007 20:52:27 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65043>

Oh what a day I've had.  Today Insane Bank Corp (my day-job employer)
upgraded their Windows desktop encryption software.  *Every*
directory on every computer is now blessed with a "Desktop.ini" file.
Git of course loves this concept:

 $ git for-each-ref >/dev/null && echo yes
 error: refs/Desktop.ini points nowhere!
 error: refs/heads/Desktop.ini points nowhere!
 yes

Fortunately for-each-ref allows corrupt refs to exist in the ref
namespace.  So until Git is properly patched we are at least able
to ignore these error messages.

For corporate security reasons it is obviously absolutely vital that
these Desktop.ini files exist in every directory of every system.
Even if application software scans all files in a particular
directory and assumes those files belong to it.  If these files did
not exist it would not be possible for Insane Bank Corp to protect
its customer's data, which of course must be toted around on $1000
laptops in the posession of any employee who asks for one.

Because Insane Bank Corp is one of the largest banks in the world
all 3rd party software vendors must comply and correct their
applications to not fail when they encounter Desktop.ini in an
application's internal data directory.  Or they will lose their
contract with Insane Bank Corp.

This patch must be applied to Git, since Git is a 3rd party software
product and its global assets are much smaller than those of Insane
Bank Corp.  If not applied Git won't be permitted for use.  Git could
lose all of its software licenses and support contracts.  Git shall
do as Insane Bank Corp requests.

Never-Shall-Be-Signed-Off-By: me

---

 </rant off>

 Seriously, this patch shouldn't ever be made to Git.  I'll likely
 have to carry it in my own local build process until the end
 of time.

 Our corporate security goons are unable to fathom why having
 "Desktop.ini" shoved into every directory of every filesystem may
 cause problems for some applications.  Especially those who may
 attempt to read every file in a given directory.

 Just thought folks would like to see what sort of bulls**t patches
 internal developers need to create for systems because they are
 unable to rely upon the operating system they are forced to rely
 upon for "security reasons".  Yes, really, Insane Bank Corp feels
 that Microsoft Windows Xtreme Professional is more trustworthy
 than RedHat Linux.  Especially when toted in someone's backpack.
 Just so long as Desktop.ini is in every directory we're safe.

 Grrrrrrrrrrrrr.

 </rant really is now off>

 git-compat-util.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index ca0a597..ca875c7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -172,6 +172,19 @@ extern uintmax_t gitstrtoumax(const char *, char **, int);
 extern const char *githstrerror(int herror);
 #endif
 
+#ifdef WORK_FOR_INSANE_BANK_CORP
+static inline struct dirent *gitreaddir(DIR *dirp)
+{
+	struct dirent *r;
+	while ((r = readdir(dirp))) {
+		if (!strcasecmp(r->d_name, "Desktop.ini"))
+			continue;
+	}
+	return r;
+}
+#define readdir gitreaddir
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 static inline char* xstrdup(const char *str)
-- 
1.5.3.5.1728.g34b3e
