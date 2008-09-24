From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Wed, 24 Sep 2008 13:53:15 -0400
Message-ID: <20080924175315.GA10337@coredump.intra.peff.net>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de> <20080924155745.GA3908@coredump.intra.peff.net> <20080924170154.GA6816@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: vim@tpope.info, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:54:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiYZH-0004Kz-W5
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbYIXRxS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 13:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbYIXRxS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:53:18 -0400
Received: from peff.net ([208.65.91.99]:1851 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbYIXRxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:53:17 -0400
Received: (qmail 22893 invoked by uid 111); 24 Sep 2008 17:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 24 Sep 2008 13:53:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Sep 2008 13:53:15 -0400
Content-Disposition: inline
In-Reply-To: <20080924170154.GA6816@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96670>

[Tim Pope cc'd as the author of the official version. Tim: just an FYI,
but if you have any comments, please feel free to share]

[Shawn cc'd as the interim maintainer. I, for one, welcome our
new Java-programming overlords].

On Wed, Sep 24, 2008 at 07:01:54PM +0200, SZEDER G=C3=A1bor wrote:

> > Is there any objection to simply removing it (and probably replacin=
g it
> > with a note to go look at the official highlighting file)?
> I'm for it, because I didn't know that there is an official git synta=
x
> highlight file out there.  Indeed, I haven't even know that vim 7.2 i=
s
> out.

Here is a patch, then. Shawn, we should probably give any vim users a
few days to object in case there is something they don't like about the
upstream version, but other than that, I think this should be applied t=
o
master.

-- >8 --
remove vim syntax highlighting in favor of upstream

As of version 7.2, vim ships with its own syntax
highlighting for git commit messages, which is:

  1. more comprehensive in splitting up the various
     components of the file

  2. in accordance with the usual vim behavior for syntax
     highlighting (e.g., respecting b:current_syntax)

  3. presumably better maintained (I have not been using
     what's in git's contrib/ directory for some time in
     favor of the upstream version)

This patch gets rid of our local version and just points
interested parties to the upstream version.
---
 contrib/vim/README               |   13 +++++++++++--
 contrib/vim/syntax/gitcommit.vim |   18 ------------------
 2 files changed, 11 insertions(+), 20 deletions(-)
 delete mode 100644 contrib/vim/syntax/gitcommit.vim

diff --git a/contrib/vim/README b/contrib/vim/README
index 9e7881f..12d61bb 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -1,8 +1,17 @@
-To syntax highlight git's commit messages, you need to:
-  1. Copy syntax/gitcommit.vim to vim's syntax directory:
+Syntax highlighting for git commit messages is included with the vim
+distribution as of vim 7.2, and should work automatically.
+
+If you have an older version of vim, you can get the latest syntax fil=
e
+from the vim project:
+
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitco=
mmit.vim
+
+To install:
+
+  1. Copy gitcommit.vim to vim's syntax directory:
      $ mkdir -p $HOME/.vim/syntax
      $ cp syntax/gitcommit.vim $HOME/.vim/syntax
   2. Auto-detect the editing of git commit files:
      $ cat >>$HOME/.vimrc <<'EOF'
      autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=3Dgitcommi=
t
      EOF
diff --git a/contrib/vim/syntax/gitcommit.vim b/contrib/vim/syntax/gitc=
ommit.vim
deleted file mode 100644
index 332121b..0000000
--- a/contrib/vim/syntax/gitcommit.vim
+++ /dev/null
@@ -1,18 +0,0 @@
-syn region gitLine start=3D/^#/ end=3D/$/
-syn region gitCommit start=3D/^# Changes to be committed:$/ end=3D/^#$=
/ contains=3DgitHead,gitCommitFile
-syn region gitHead contained start=3D/^#   (.*)/ end=3D/^#$/
-syn region gitChanged start=3D/^# Changed but not updated:/ end=3D/^#$=
/ contains=3DgitHead,gitChangedFile
-syn region gitUntracked start=3D/^# Untracked files:/ end=3D/^#$/ cont=
ains=3DgitHead,gitUntrackedFile
-
-syn match gitCommitFile contained /^#\t.*/hs=3Ds+2
-syn match gitChangedFile contained /^#\t.*/hs=3Ds+2
-syn match gitUntrackedFile contained /^#\t.*/hs=3Ds+2
-
-hi def link gitLine Comment
-hi def link gitCommit Comment
-hi def link gitChanged Comment
-hi def link gitHead Comment
-hi def link gitUntracked Comment
-hi def link gitCommitFile Type
-hi def link gitChangedFile Constant
-hi def link gitUntrackedFile Constant
--=20
1.6.0.2.473.g126a14
