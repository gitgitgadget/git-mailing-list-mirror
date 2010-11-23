From: Zane Bitter <zane.bitter@alliedtelesis.co.nz>
Subject: [StGIT PATCH] contrib/vim: Add vim syntax highlighting for StGit
	commit messages
Date: Wed, 24 Nov 2010 04:46:51 +1300
Message-ID: <20101123154538.12513.39180.stgit@zaneb-dl.ws.alliedtelesyn.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 23 16:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKvBi-0001L7-1U
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 16:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab0KWPxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 10:53:40 -0500
Received: from gate.alliedtelesyn.co.nz ([202.49.72.33]:59865 "HELO
	gate.alliedtelesyn.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753415Ab0KWPxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 10:53:39 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2010 10:53:38 EST
Received: (qmail 3236 invoked from network); 23 Nov 2010 15:46:56 -0000
Received: from mmarshal2-dx.alliedtelesyn.co.nz (HELO mailmarshall.alliedtelesyn.co.nz) (10.32.18.41)
  by gate-int.alliedtelesyn.co.nz with SMTP; 23 Nov 2010 15:46:56 -0000
Received: from alliedtelesyn.co.nz (Not Verified[10.32.16.32]) by mailmarshall.alliedtelesyn.co.nz with MailMarshal (v6,2,0,2977)
	id <B4cebe36c0001>; Wed, 24 Nov 2010 04:53:16 +1300
Received: from MAIL/SpoolDir by alliedtelesyn.co.nz (Mercury 1.48);
    24 Nov 10 04:46:56 +1200
Received: from SpoolDir by MAIL (Mercury 1.48); 24 Nov 10 04:46:55 +1200
Received: from zaneb-dl.ws.alliedtelesyn.co.nz (10.33.15.12) by alliedtelesyn.co.nz (Mercury 1.48) with ESMTP;
    24 Nov 10 04:46:51 +1200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161975>


---

 contrib/vim/README               |   11 ++++++++++
 contrib/vim/ftdetect/stg.vim     |   44 ++++++++++++++++++++++++++++++++++++++
 contrib/vim/syntax/stgedit.vim   |   40 +++++++++++++++++++++++++++++++++++
 contrib/vim/syntax/stgmail.vim   |   33 +++++++++++++++++++++++++++++
 contrib/vim/syntax/stgnew.vim    |   33 +++++++++++++++++++++++++++++
 contrib/vim/syntax/stgsquash.vim |   40 +++++++++++++++++++++++++++++++++++
 6 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 contrib/vim/README
 create mode 100644 contrib/vim/ftdetect/stg.vim
 create mode 100644 contrib/vim/syntax/stgedit.vim
 create mode 100644 contrib/vim/syntax/stgmail.vim
 create mode 100644 contrib/vim/syntax/stgnew.vim
 create mode 100644 contrib/vim/syntax/stgsquash.vim

diff --git a/contrib/vim/README b/contrib/vim/README
new file mode 100644
index 0000000..4899b6e
--- /dev/null
+++ b/contrib/vim/README
@@ -0,0 +1,11 @@
+To syntax highlight StGit commit messages in vim:
+
+ * For the current user only:
+    > mkdir -p ~/.vim/ftdetect ~/.vim/syntax
+    > cp syntax/*.vim ~/.vim/syntax/
+    > cp ftdetect/*.vim ~/.vim/ftdetect/
+
+ * For all users:
+    # cp syntax/*.vim /usr/share/vim/site/syntax/
+    # cp ftdetect/*.vim /usr/share/vim/site/ftdetect/
+
diff --git a/contrib/vim/ftdetect/stg.vim b/contrib/vim/ftdetect/stg.vim
new file mode 100644
index 0000000..abd4d9f
--- /dev/null
+++ b/contrib/vim/ftdetect/stg.vim
@@ -0,0 +1,44 @@
+" Vim filetype detection plugin
+" Language:     StGit commit messages
+" Author:       Zane Bitter <zane.bitter@alliedtelesis.co.nz>
+
+
+if has("autocmd")
+
+  " Detect 'stg new' files
+  autocmd BufNewFile,BufRead .stgit-new.txt       setf     stgnew
+  autocmd BufNewFile,BufRead .stgitmsg.txt        setf     stgnew
+  " Ignore the modeline so we get type 'stgnew' instead of 'diff'
+  autocmd BufNewFile,BufRead .stgitmsg.txt        setlocal nomodeline
+
+  " Detect 'stg edit' files
+  autocmd BufNewFile,BufRead .stgit-edit.txt      setf     stgedit
+  " Use set filetype instead of setfiletype to override detection as patch
+  autocmd BufNewFile,BufRead .stgit-edit.patch    setlocal filetype=stgedit
+  autocmd BufNewFile,BufRead .stgit-edit.diff     setlocal filetype=stgedit
+  autocmd BufNewFile,BufRead .stgit-failed.patch  setlocal filetype=stgedit
+
+  " Detect 'stg squash' files
+  autocmd BufNewFile,BufRead .stgit-squash.txt    setf     stgsquash
+
+  " Detect 'stg mail' files
+  autocmd BufNewFile,BufRead .stgitmail.txt       setf     stgmail
+
+
+  " A modeline in a diff belongs to the diffed file, so ignore it
+  autocmd BufNewFile,BufRead .stgit-edit.patch    setlocal nomodeline
+  autocmd BufNewFile,BufRead .stgit-edit.diff     setlocal nomodeline
+  autocmd BufNewFile,BufRead .stgit-failed.patch  setlocal nomodeline
+  autocmd BufNewFile,BufRead .stgitmail.txt       setlocal nomodeline
+
+
+  " Set parameters on 'stg new' files to be consistent with the modeline
+  autocmd FileType           stgnew               setlocal textwidth=75
+  autocmd FileType           stgnew               setlocal nobackup
+
+  " For other stg files set textwidth the same as 'stg new'
+  autocmd FileType           stgedit              setlocal textwidth=75
+  autocmd FileType           stgmail              setlocal textwidth=75
+  autocmd FileType           stgsquash            setlocal textwidth=75
+
+endif " has("autocmd")
diff --git a/contrib/vim/syntax/stgedit.vim b/contrib/vim/syntax/stgedit.vim
new file mode 100644
index 0000000..ef46a8d
--- /dev/null
+++ b/contrib/vim/syntax/stgedit.vim
@@ -0,0 +1,40 @@
+" Vim syntax file
+" Language:     StGit 'stg edit' commit message file
+" Author:       Zane Bitter <zane.bitter@alliedtelesis.co.nz>
+
+if exists("b:current_syntax")
+  finish
+endif
+
+
+runtime! syntax/mail.vim
+unlet b:current_syntax
+
+syn include @stgDiff syntax/diff.vim
+
+
+syn case match
+syn sync minlines=50
+
+
+if has("spell")
+  syn spell toplevel
+endif
+
+
+syn match    stgeditFrom        "\%^From:.*" contains=mailHeader nextgroup=stgeditFirstLine skipempty
+syn match    stgeditFirstLine   "^.\+" contained nextgroup=stgeditDiffs,stgeditComment,stgeditBlank skipnl
+syn match    stgeditSummary     "^.\{0,50\}" contained containedin=stgeditFirstLine nextgroup=stgeditOverflow contains=@Spell
+syn match    stgeditOverflow    ".*" contained contains=@Spell
+syn match    stgeditBlank       "^.\+" contained contains=@Spell
+syn match    stgeditComment     "^#.*"
+syn region   stgeditDiffs       start="^---" end="%$" contains=@stgDiff fold
+syn region   stgeditDiff        start="^\%(diff --git \)\@=" end="^\%(diff --git \|$\)\@=" contained containedin=stgeditDiffs contains=@stgDiff fold
+
+hi def link  stgeditSummary     Keyword
+hi def link  stgeditComment     Comment
+hi def link  stgeditBlank       Error
+
+
+let b:current_syntax = "stgedit"
+
diff --git a/contrib/vim/syntax/stgmail.vim b/contrib/vim/syntax/stgmail.vim
new file mode 100644
index 0000000..bd5a77d
--- /dev/null
+++ b/contrib/vim/syntax/stgmail.vim
@@ -0,0 +1,33 @@
+" Vim syntax file
+" Language:     StGit 'stg mail' file
+" Author:       Zane Bitter <zane.bitter@alliedtelesis.co.nz>
+
+if exists("b:current_syntax")
+  finish
+endif
+
+
+runtime! syntax/mail.vim
+unlet b:current_syntax
+
+syn include @stgDiff syntax/diff.vim
+
+
+syn case match
+syn sync minlines=50
+
+
+if has("spell")
+  syn spell toplevel
+endif
+
+
+syn match    stgmailComment     "^#.*"
+syn region   stgmailDiffs       start="^---" end="%$" contains=@stgDiff fold
+syn region   stgmailDiff        start="^\%(diff --git \)\@=" end="^\%(diff --git \|$\)\@=" contained containedin=stgmailDiffs contains=@stgDiff fold
+
+hi def link  stgmailComment     Comment
+
+
+let b:current_syntax = "stgmail"
+
diff --git a/contrib/vim/syntax/stgnew.vim b/contrib/vim/syntax/stgnew.vim
new file mode 100644
index 0000000..a794cf5
--- /dev/null
+++ b/contrib/vim/syntax/stgnew.vim
@@ -0,0 +1,33 @@
+" Vim syntax file
+" Language:     StGit 'stg new' commit message file
+" Author:       Zane Bitter <zane.bitter@alliedtelesis.co.nz>
+
+if exists("b:current_syntax")
+  finish
+endif
+
+
+syn case match
+syn sync minlines=50
+
+
+if has("spell")
+  syn spell toplevel
+endif
+
+
+syn match    stgnewFirstLine    "\%^.*" nextgroup=stgnewSTG,stgnewComment,stgnewBlank skipnl
+syn match    stgnewSummary      "^.\{0,50\}" contained containedin=stgnewFirstLine nextgroup=stgnewOverflow contains=@Spell
+syn match    stgnewOverflow     ".*" contained contains=@Spell
+syn match    stgnewBlank        "^.\+" contained contains=@Spell
+syn match    stgnewSTG          "^STG:.*"
+syn match    stgnewComment      "^#.*"
+
+hi def link  stgnewSummary      Keyword
+hi def link  stgnewComment      Comment
+hi def link  stgnewSTG          Comment
+hi def link  stgnewBlank        Error
+
+
+let b:current_syntax = "stgnew"
+
diff --git a/contrib/vim/syntax/stgsquash.vim b/contrib/vim/syntax/stgsquash.vim
new file mode 100644
index 0000000..9524963
--- /dev/null
+++ b/contrib/vim/syntax/stgsquash.vim
@@ -0,0 +1,40 @@
+" Vim syntax file
+" Language:     StGit 'stg squash' commit message file
+" Author:       Zane Bitter <zane.bitter@alliedtelesis.co.nz>
+
+if exists("b:current_syntax")
+  finish
+endif
+
+
+syn case match
+syn sync minlines=50
+
+
+if has("spell")
+  syn spell toplevel
+endif
+
+
+syn match    stgsqFirstLine     "\%^.*" nextgroup=stgsqComment,stgsqContext,stgsqBlank skipnl
+syn match    stgsqSummary       "^.\{0,50\}" contained containedin=stgsqFirstLine nextgroup=stgsqOverflow contains=@Spell
+syn match    stgsqOverflow      ".*" contained contains=@Spell
+syn match    stgsqBlank         "^.\+" contained contains=@Spell
+syn match    stgsqSeparator     "-\+$" contained
+syn region   stgsqPatch         start="^\(.\{66\}-\{4\}$\)\@=" end="\(^.\{66\}-\{4\}$\)\@=" contained containedin=stgsqContext contains=@Spell fold
+syn match    stgsqNextPatch     "^.\{66\}-\{4\}$" contained containedin=stgsqPatch contains=stgsqPatchName
+syn match    stgsqPatchName     "^.\{-\}\(-*$\)\@=" contained containedin=stgsqNextPatch nextgroup=stgsqSeparator
+syn region   stgsqContext       start="^---" end="%$" contains=@Spell fold
+syn match    stgsqComment       "^#.*"
+
+hi def link  stgsqSummary       Keyword
+hi def link  stgsqComment       Comment
+hi def link  stgsqBlank         Error
+hi def link  stgsqContext       Comment
+hi def link  stgsqPatch         Constant
+hi def link  stgsqPatchName     Identifier
+hi def link  stgsqSeparator     Comment
+
+
+let b:current_syntax = "stgsquash"
+
