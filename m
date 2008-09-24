From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Wed, 24 Sep 2008 21:56:58 +0200
Message-ID: <20080924195658.GB6816@neumann>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de>
	<20080924155745.GA3908@coredump.intra.peff.net>
	<20080924170154.GA6816@neumann>
	<20080924175315.GA10337@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vim@tpope.info, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 21:58:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiaVZ-0005S3-39
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 21:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYIXT5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 15:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbYIXT5O
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 15:57:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56731 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYIXT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 15:57:13 -0400
Received: from [127.0.1.1] (p5B13362F.dip0.t-ipconnect.de [91.19.54.47])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1KiaTq1nrT-0008Am; Wed, 24 Sep 2008 21:57:00 +0200
Content-Disposition: inline
In-Reply-To: <20080924175315.GA10337@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/8/3BZW3KctM9nTJnRaahuSJu9dcVnudTCJeA
 JBt4TB0LJ44ufKYkrhCEDggBetW4u8W7DyC9lnCiR5oqZ6E2d3
 ZGzpwQhp9wv6OrTKuo4Xg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96686>

Hi,

On Wed, Sep 24, 2008 at 01:53:15PM -0400, Jeff King wrote:
> +Syntax highlighting for git commit messages is included with the vim
> +distribution as of vim 7.2, and should work automatically.
> +
> +If you have an older version of vim, you can get the latest syntax file
> +from the vim project:
> +
> +  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitcommit.vim

vim 7.2 provides support not only for commit messages but also for
other git-related filetypes.  I think it would be good to mention
them, too, therefore I extended your patch with them.


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

Furthermore, vim 7.2 also provides syntax highlighting for
other git filetypes (gitconfig, rebase, send-email).

This patch gets rid of our local version and just points
interested parties to the upstream version.

The code for auto-detecting filetypes is taken from vim 7.2's
runtime/filetype.vim.

---
 contrib/vim/README               |   38 ++++++++++++++++++++++++++++++--------
 contrib/vim/syntax/gitcommit.vim |   18 ------------------
 2 files changed, 30 insertions(+), 26 deletions(-)
 delete mode 100644 contrib/vim/syntax/gitcommit.vim

diff --git a/contrib/vim/README b/contrib/vim/README
index 9e7881f..a811675 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -1,8 +1,30 @@
-To syntax highlight git's commit messages, you need to:
-  1. Copy syntax/gitcommit.vim to vim's syntax directory:
-     $ mkdir -p $HOME/.vim/syntax
-     $ cp syntax/gitcommit.vim $HOME/.vim/syntax
-  2. Auto-detect the editing of git commit files:
-     $ cat >>$HOME/.vimrc <<'EOF'
-     autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
-     EOF
+Syntax highlighting for git commit messages, config files, etc. is
+included with the vim distribution as of vim 7.2, and should work
+automatically.
+
+If you have an older version of vim, you can get the latest syntax
+files from the vim project:
+
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/git.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitcommit.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitconfig.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitrebase.vim
+  http://vim.svn.sourceforge.net/viewvc/vim/trunk/runtime/syntax/gitsendemail.vim
+
+To install:
+
+  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
+  2. Auto-detect the editing of various git-related filetypes:
+	$ cat >>$HOME/.vimrc <<'EOF'
+	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
+	autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
+	autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
+	autocmd BufNewFile,BufRead .msg.[0-9]*
+		\ if getline(1) =~ '^From.*# This line is ignored.$' |
+		\   setf gitsendemail |
+		\ endif
+	autocmd BufNewFile,BufRead *.git/**
+		\ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
+		\   setf git |
+		\ endif
+	EOF
diff --git a/contrib/vim/syntax/gitcommit.vim b/contrib/vim/syntax/gitcommit.vim
deleted file mode 100644
index 332121b..0000000
--- a/contrib/vim/syntax/gitcommit.vim
+++ /dev/null
@@ -1,18 +0,0 @@
-syn region gitLine start=/^#/ end=/$/
-syn region gitCommit start=/^# Changes to be committed:$/ end=/^#$/ contains=gitHead,gitCommitFile
-syn region gitHead contained start=/^#   (.*)/ end=/^#$/
-syn region gitChanged start=/^# Changed but not updated:/ end=/^#$/ contains=gitHead,gitChangedFile
-syn region gitUntracked start=/^# Untracked files:/ end=/^#$/ contains=gitHead,gitUntrackedFile
-
-syn match gitCommitFile contained /^#\t.*/hs=s+2
-syn match gitChangedFile contained /^#\t.*/hs=s+2
-syn match gitUntrackedFile contained /^#\t.*/hs=s+2
-
-hi def link gitLine Comment
-hi def link gitCommit Comment
-hi def link gitChanged Comment
-hi def link gitHead Comment
-hi def link gitUntracked Comment
-hi def link gitCommitFile Type
-hi def link gitChangedFile Constant
-hi def link gitUntrackedFile Constant
