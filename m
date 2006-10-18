From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] be more robust wrt the git-dir.
Date: Wed, 18 Oct 2006 02:47:26 +0200
Message-ID: <1161132446703-git-send-email-madcoder@debian.org>
References: <11611319762395-git-send-email-madcoder@debian.org> <11611324463754-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 02:50:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzal-0001yQ-4B
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWJRAr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWJRAr2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:47:28 -0400
Received: from pan.madism.org ([88.191.16.128]:23016 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1751200AbWJRAr1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 20:47:27 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id 14D38B005C;
	Wed, 18 Oct 2006 02:47:24 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id DEE16B005D;
	Wed, 18 Oct 2006 02:47:23 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 8E5F062112; Wed, 18 Oct 2006 02:47:26 +0200 (CEST)
To: Jeff King <peff@peff.net>
X-Mailer: git-send-email 1.4.2.3
In-Reply-To: <11611324463754-git-send-email-madcoder@debian.org>
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29162>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 contrib/vim/ftplugin/gitcommit.vim |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/vim/ftplugin/gitcommit.vim b/contrib/vim/ftplugin/gitcommit.vim
index a9cb946..e958fb1 100644
--- a/contrib/vim/ftplugin/gitcommit.vim
+++ b/contrib/vim/ftplugin/gitcommit.vim
@@ -52,9 +52,17 @@ function! Git_diff_windows(vertsplit, au
         rightbelow new
     endif
     silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
-    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . "\n1Gdd"
-    exe 'normal :r!LANG=C cd ..; git diff HEAD -- ' . list_of_files . " \| git apply --stat\no\<esc>1GddO\<esc>"
+    let gitDir = system('git rev-parse --git-dir 2>/dev/null')
+    let gitDir = substitute(gitDir, '.git\n', '', '')
+    let wd = getcwd()
+    if gitDir != ''
+        exe 'cd '.gitDir
+    endif
+    exe 'normal :r!LANG=C git diff HEAD -- ' . list_of_files . "\n1Gdd"
+    exe 'normal :r!LANG=C git diff HEAD -- ' . list_of_files . " \| git apply --stat\no\<esc>1GddO\<esc>"
+    exe 'cd '.wd
     setlocal nomodifiable
+    noremap <buffer> q :bw<cr>
     if a:auto
         redraw!
         wincmd p
-- 
1.4.2.3
