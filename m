From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH]: cg-clean confused by symlinks to directories
Date: Fri, 23 Sep 2005 18:12:50 -0400
Message-ID: <1127513570.4708.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 24 00:14:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIvmw-0005LJ-J5
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 00:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVIWWNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 18:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVIWWM7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 18:12:59 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:10727 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751321AbVIWWM7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 18:12:59 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EIvmr-0008QF-Nk
	for git@vger.kernel.org; Fri, 23 Sep 2005 18:12:58 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EIvmk-0001lt-Ek; Fri, 23 Sep 2005 18:12:50 -0400
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9208>

cg-clean confused by symlinks to directories

It turns out that "git-ls-files --others" shows symlinks to directories.
That shouldn't trigger internal error in cg-clean.  Such symlinks should
be treated like files and removed even without the "-d" option.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg-clean b/cg-clean
--- a/cg-clean
+++ b/cg-clean
@@ -111,7 +111,7 @@ clean_files()
 	cg-status "$xopt" -w | sed -n 's/^? //p' |
 	for file in $(cat); do
 		path="${_git_relpath}$file"
-		if [ -d "$path" ]; then
+		if [ -d "$path" -a ! -L "$path" ]; then
 			# Sanity check, shouldn't happen
 			echo "FATAL: cg-status reports directories (internal error)" >&2
 			exit 1


-- 
Regards,
Pavel Roskin
