From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/8] gitk: fix "show origin of this line" with separate work tree
Date: Mon,  4 Apr 2011 22:14:13 -0400
Message-ID: <1301969659-19703-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpa-0002JM-2A
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab1DECRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:17:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36444 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab1DECQu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:50 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3719730qwk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VKCnSDvkTZLEmvX7NKEUliWvZZGrsdL3QML2AH2C0+c=;
        b=UQJQj8tshSleVLKQ8sYkxVCbl6IIFjvCAIe36pQ2Swp04CdQwrdyoLdcPjy2bFVUDg
         WW9YoPwsN1pNc2LjzSh0vfK8CIGKSL7bQw6u1LJ/1BoijeYkoO/OM1n9UxAp/4YYmxwg
         aXQAad838B4kv6JtLriLSU1m+2qFlBFMPcLSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bL04n8a8Kl5a6dR0N4cmi5rwcqFE8wEtLd3KtjrOo2TjTHdA0yJUG5qcietudrDp/7
         MAMkM8lHw0qOUpybDkFwoT576/s+BtzQuoabL9o/DImzSIulSyEw5D4XBiaJ/0nrOzom
         bLvZwojnBrlu1UUt0oSFMw8VZ8SR28Wy1etW8=
Received: by 10.224.214.72 with SMTP id gz8mr6594931qab.81.1301969810106;
        Mon, 04 Apr 2011 19:16:50 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170860>

Running "show origin of this line" currently fails when the the work
tree is not the parent of the git directory. Fix it by feeding
git-blame paths relative to $GIT_WORK_TREE instead of "$GIT_DIR/..".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 gitk-git/gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index ce96294..a0f0f37 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3590,7 +3590,7 @@ proc external_blame {parent_idx {line {}}} {
 proc show_line_source {} {
     global cmitmode currentid parents curview blamestuff blameinst
     global diff_menu_line diff_menu_filebase flist_menu_file
-    global nullid nullid2 gitdir
+    global nullid nullid2 gitdir cdup
 
     set from_index {}
     if {$cmitmode eq "tree"} {
@@ -3643,7 +3643,7 @@ proc show_line_source {} {
     } else {
 	lappend blameargs $id
     }
-    lappend blameargs -- [file join [file dirname $gitdir] $flist_menu_file]
+    lappend blameargs -- [file join $cdup $flist_menu_file]
     if {[catch {
 	set f [open $blameargs r]
     } err]} {
-- 
1.7.4.79.gcbe20
