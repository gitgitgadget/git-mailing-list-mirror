From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] git-gui: don't warn for detached head when rebasing
Date: Sat, 22 Oct 2011 21:39:40 +0200
Message-ID: <a9a6eb9e70a8d4a75f2061a51bf401469d1b0b7f.1319312280.git.bert.wesarg@googlemail.com>
References: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:39:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHhQ9-0002ke-Ec
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1JVTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:39:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56803 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab1JVTjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:39:48 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so6300526bkb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=g+z45Ba5RW8PLAdC57OmR+ZZ2iFiynppn3YEG3WKrls=;
        b=FIoTJE2dl0tENs/Fu+JetoaHReGflIoi1obUxiI/czyMFOJ4GCgAzMB4HqBYgWuESs
         zb+22YmR+yJaE0mTkAP76IJAfgMpqkTv1FMmSchO84knNCctqtQFCnz0Sl/CqBQaYqmU
         YsuseVVMOLkSumpGT7wn1LHJtYOmJHyMnHIwA=
Received: by 10.204.10.67 with SMTP id o3mr13643501bko.3.1319312387402;
        Sat, 22 Oct 2011 12:39:47 -0700 (PDT)
Received: from localhost (p5B2AD0E6.dip.t-dialin.net. [91.42.208.230])
        by mx.google.com with ESMTPS id j9sm17810804bkd.2.2011.10.22.12.39.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:39:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.908.g383b5
In-Reply-To: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
In-Reply-To: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
References: <0f4995b5df707782c73ec83171fb2f512ae887ef.1319312280.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184121>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/commit.tcl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index e27e148..d679db4 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -263,7 +263,9 @@ proc commit_commitmsg {curHEAD msg_p} {
 	global is_detached repo_config
 	global pch_error
 
-	if {$is_detached && [is_config_true gui.warndetachedcommit]} {
+	if {$is_detached
+	    && ![file exists [gitdir [file join rebase-merge head-name]]]
+	    && 	[is_config_true gui.warndetachedcommit]} {
 		set msg [mc "You are about to commit on a detached head.\
 This is a potentially dangerous thing to do because if you switch\
 to another branch you will loose your changes and it can be difficult\
-- 
1.7.7.908.g383b5
