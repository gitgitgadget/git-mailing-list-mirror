X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 4/4] git.el: Include MERGE_MSG in the log-edit buffer even when not committing a merge.
Date: Fri, 03 Nov 2006 17:42:43 +0100
Message-ID: <87zmb81ny4.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 16:45:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30866>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg28G-00045q-TB for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753365AbWKCQmr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 11:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbWKCQmr
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:42:47 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:51383 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1753365AbWKCQmq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:42:46 -0500
Received: from adsl-84-227-158-29.adslplus.ch ([84.227.158.29]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1Gg27x-0004XX-AX for
 git@vger.kernel.org; Fri, 03 Nov 2006 10:42:45 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 37EE3109EB7; Fri,
  3 Nov 2006 17:42:43 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This lets us take advantage of the fact that git-cherry-pick now saves
the message in MERGE_MSG too.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 6f3b46d..972c402 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -589,6 +589,7 @@ and returns the process output as a stri
                           (let ((commit (git-commit-tree buffer tree head)))
                             (git-update-ref "HEAD" commit head)
                             (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
+                            (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
                             (with-current-buffer buffer (erase-buffer))
                             (git-set-files-state files 'uptodate)
                             (when (file-directory-p ".git/rr-cache")
@@ -888,7 +889,7 @@ and returns the process output as a stri
           'face 'git-header-face)
          (propertize git-log-msg-separator 'face 'git-separator-face)
          "\n")
-        (cond ((and merge-heads (file-readable-p ".git/MERGE_MSG"))
+        (cond ((file-readable-p ".git/MERGE_MSG")
                (insert-file-contents ".git/MERGE_MSG"))
               (sign-off
                (insert (format "\n\nSigned-off-by: %s <%s>\n"
-- 
1.4.3.3.gf3240

-- 
Alexandre Julliard
