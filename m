From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 3/8] gitk: fix "blame parent commit" with separate work tree
Date: Mon,  4 Apr 2011 22:14:14 -0400
Message-ID: <1301969659-19703-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpW-0002JM-AN
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab1DECQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:16:57 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42634 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1DECQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:52 -0400
Received: by qwk3 with SMTP id 3so3719792qwk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=AeUBpBuc/rn0WHKy9k9mInvbFL0Hl2jdXLsLb96nP6Q=;
        b=uuRFfBNrj6gJixD057HeilfdCH2XgXuBqqfl+MM7K7Oev2KrBAOqP2v8x6uMBLRCPh
         Nn+VgODq3IInWvw67t+lfl+q4FuFAHeswNctfyE3SwuudxyQWeKGl1AfBZkfybFU3oc5
         MzM7LeLcO6BMvOMFKRo/4ajYhRqN8ipy2Q2nI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G/YROCMbC8AOd1rXpnTQjO7S8fw65M1jyoruSPhLy8KrXiVomzJ3nxUMof7ORDz69v
         0rb4amO2sZhEiPuyOLa/KkepYng1lDE+FxnbCBiGV0it8HGV4XVe83MaNkjE3LCrkS+I
         OXxuYoABFtg8SHYaQY6Z9visKuEy/Prh5Mxr4=
Received: by 10.229.90.12 with SMTP id g12mr2221504qcm.104.1301969811667;
        Mon, 04 Apr 2011 19:16:51 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170857>

Running "blame parent commit" currently brings up an empty blame view
when the the work tree is not the parent of the git directory. Fix it
by feeding git-blame paths relative to $GIT_WORK_TREE instead of
"$GIT_DIR/..".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 gitk-git/gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0f0f37..b1696de 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3558,7 +3558,7 @@ proc make_relative {f} {
 }
 
 proc external_blame {parent_idx {line {}}} {
-    global flist_menu_file gitdir
+    global flist_menu_file cdup
     global nullid nullid2
     global parentlist selectedline currentid
 
@@ -3577,7 +3577,7 @@ proc external_blame {parent_idx {line {}}} {
     if {$line ne {} && $line > 1} {
 	lappend cmdline "--line=$line"
     }
-    set f [file join [file dirname $gitdir] $flist_menu_file]
+    set f [file join $cdup $flist_menu_file]
     # Unfortunately it seems git gui blame doesn't like
     # being given an absolute path...
     set f [make_relative $f]
-- 
1.7.4.79.gcbe20
