From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 6/8] bash completion: Add completion for 'git archive'
Date: Mon,  4 Aug 2008 23:50:36 -0600
Message-ID: <1217915438-6838-7-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-5-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:52:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFT8-0007dV-Sw
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbYHEFvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755054AbYHEFvA
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:51:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:55154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbYHEFus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753944wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=RAiGxSQQn3rERkF2yZxem7qk7gJ8Tw71nIGLkab5YZs=;
        b=Nu1nG/6+Z//EklDC4Z8a3uArOjTKlDZ8i+gkGKKBuolMTILzbgx+hDHSebmrF9ZnOs
         FsKn8eT5oWHfK0iD0Giy2KKcPPUGDnq5JXqiFvp4j/LNdqwOYEXR3Vg/lmTK7X2pI/+D
         Zf3E0CHN0inl2dQ6qz4XWYLNNyE+uYtQ4u8W8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=R0T3Wad/lgQEvEMOxMk8RIScJf+5knKjBe7v0szESyvwjhMBT3LYiS/QpiN5j4Vu3Y
         6sU+xF0i3JMHVlNimIP8U2fUFMRKnZTiDPyu1sJAq2LRoUWx58uOO+DrVPVPln6DiGOV
         aT6RfQ30mBMMog3cvUDzPTnHskArU5BytcFA8=
Received: by 10.142.89.9 with SMTP id m9mr5293827wfb.71.1217915447934;
        Mon, 04 Aug 2008 22:50:47 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91424>

Added completions for all long options specified in the docs
	--format= --list --verbose
	--prefix= --remote= --exec=
The --format= long option can be completed with available formats
and the --remote= can be completed with defined remote repositories.

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a292cbd..61ea6d9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -561,6 +561,29 @@ _git_add ()
 	COMPREPLY=()
 }
 
+_git_archive ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--format=*)
+		__gitcomp "$(git archive --list)" "" "${cur##--format=}"
+		return
+		;;
+	--remote=*)
+		__gitcomp "$(__git_remotes)" "" "${cur##--remote=}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--format= --list --verbose
+			--prefix= --remote= --exec=
+			"
+		return
+		;;
+	esac
+	__git_complete_file
+}
+
 _git_bisect ()
 {
 	__git_has_doubledash && return
@@ -1548,6 +1571,7 @@ _git ()
 	am)          _git_am ;;
 	add)         _git_add ;;
 	apply)       _git_apply ;;
+	archive)     _git_archive ;;
 	bisect)      _git_bisect ;;
 	bundle)      _git_bundle ;;
 	branch)      _git_branch ;;
-- 
1.6.0.rc1.48.g2b6032
