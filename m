From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] bash completion: add git-difftool
Date: Thu,  2 Apr 2009 04:30:57 -0700
Message-ID: <1238671857-8811-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Apr 02 13:37:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpLA5-0006SV-QH
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 13:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbZDBLbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 07:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbZDBLbI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 07:31:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:5481 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbZDBLbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 07:31:05 -0400
Received: by wa-out-1112.google.com with SMTP id j5so393898wah.21
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VeICE46pnxz3XOENVPkV7jBpxES17DHraVRVVsct2/I=;
        b=CEpsZBnTK9wk2ymRgtEPXcP5A70gpjDGt9eIsfh81O3AHa4M1tnX6rrGLUYwAkC/gl
         vtkNmIC4MKaJaEPYnEiOaGT5E5GqwsQZHnpNht8mlgnCzbJcvhaARAZxHFvyXmJugMVJ
         HhV7dncvv0GJ89p+W20zj6T+RB0gOk3mN35Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KJF3/7wV/TFO1iD327/iPkAam40n+oWiMc+1ZKdNM/cgnGyS9abY4K1opQiuxnnGOU
         aiq+m8NKpZAPk+Orm746/cWsjlWM9AZ6Z/r7KVWkobkfmrzaoIJxh3aYiGvMoOPjiHAi
         Aobjour3hWlrEb77wikD6L88Cen6VIBmtEDhw=
Received: by 10.115.110.1 with SMTP id n1mr5855649wam.99.1238671863933;
        Thu, 02 Apr 2009 04:31:03 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm1055657wag.11.2009.04.02.04.31.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 04:31:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115458>

This adds completion for difftool's --tool flag.
The known diff tool names were also consolidated into
a single variable.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4fcd77a..33a8ec7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -909,6 +909,26 @@ _git_diff ()
 	__git_complete_file
 }
 
+__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
+			tkdiff vimdiff gvimdiff xxdiff
+"
+
+_git_difftool ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--tool=*)
+		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
+		return
+		;;
+	--*)
+		__gitcomp "--tool="
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
 	--tags --no-tags
@@ -1171,11 +1191,7 @@ _git_mergetool ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--tool=*)
-		__gitcomp "
-			kdiff3 tkdiff meld xxdiff emerge
-			vimdiff gvimdiff ecmerge diffuse
-			opendiff
-			" "" "${cur##--tool=}"
+		__gitcomp "$__git_mergetools_common" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
@@ -1900,6 +1916,7 @@ _git ()
 	config)      _git_config ;;
 	describe)    _git_describe ;;
 	diff)        _git_diff ;;
+	difftool)    _git_difftool;;
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
 	fsck)        _git_fsck ;;
-- 
1.6.2.1.469.gdffc1
