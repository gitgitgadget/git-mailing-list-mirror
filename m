From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: Add completion for 'git grep'
Date: Sun,  3 Aug 2008 23:26:48 -0600
Message-ID: <1217827608-5143-1-git-send-email-lee.marlow@gmail.com>
References: <20080804040634.GC2963@spearce.org>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 07:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPsbq-0000bs-6H
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 07:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYHDF0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 01:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYHDF0w
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 01:26:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:35587 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYHDF0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 01:26:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1957073rvb.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 22:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rhz5NAnW9uURuOaS35mvmlpzxPsnIE5WN9RiHCMt9H8=;
        b=KT2kzrrdMrjG86lsD1Ym+fJMKpuDBTmsA5xpADcCd7yZDcNG99yu50TaRR6Iy1ZLwS
         5fQB0CQJt0JGB9Xk3i4Vf3nkhtDi7I1S786wNYfBM3UY89sUdchVkPmDLuZFjvnak/td
         ACuk7Dd/Sa8Eh+fHWZQCjL+T5l6D84Py8mgC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JNy2YbrzFhACyaXDYckuSi3/8yFtbt0fCkLjXrXMTmDquimG+c0H9AcUgCRbwMbAOh
         jc96MH7xEnXILDtulKne2mA+t06sSlenCxxLaGIEHA+I/zXOtPy6lJhqC/k9nlpRh4xY
         JAHLJDQBgSZ55keG0Fj+r7fIhemz7Hs8LMIX0=
Received: by 10.141.142.15 with SMTP id u15mr7348669rvn.51.1217827611012;
        Sun, 03 Aug 2008 22:26:51 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id k41sm6228341rvb.3.2008.08.03.22.26.50
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 22:26:50 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <20080804040634.GC2963@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91317>

Added completions for all long options specified in the docs
	--cached
	--text --ignore-case --word-regexp --invert-match
	--full-name
	--extended-regexp --basic-regexp --fixed-strings
	--files-with-matches --name-only
	--files-without-match
	--count
	--and --or --not --all-match

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---

On Sun, Aug 3, 2008 at 10:06 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Though I think you have an excellent point about completing paths
> by ls-tree for HEAD rather than the working directory itself,
> as then you can avoid produced files.  But in practice how often
> do you pass a single file or a couple of files to the grep utility
> and are having problems bypassing the build products?

I think you're right that it's not a good fit for grep, but maybe for
some other commands.  mv and commit come to mind.  I'll look into this
as I'm trying to add completions for the more common (i.e. ones that I
use) porcelain commands.

> After having thought about it your original patch makes the most
> sense, but without the has_doubledash test.

This updated patch removes the __git_has_doublehash line.  However, I
just noticed that d773c631 added __git_has_doublehash to prevent
completions of long options after --.  So, maybe it's not too
redundant and my first patch might be better.

-Lee

 contrib/completion/git-completion.bash |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 678a155..96181dc 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -791,6 +791,27 @@ _git_gc ()
 	COMPREPLY=()
 }
 
+_git_grep ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--cached
+			--text --ignore-case --word-regexp --invert-match
+			--full-name
+			--extended-regexp --basic-regexp --fixed-strings
+			--files-with-matches --name-only
+			--files-without-match
+			--count
+			--and --or --not --all-match
+			"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_help ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1482,6 +1503,7 @@ _git ()
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
 	gc)          _git_gc ;;
+	grep)        _git_grep ;;
 	help)        _git_help ;;
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
-- 
1.6.0.rc1.48.g2b6032
