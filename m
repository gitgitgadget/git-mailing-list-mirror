From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 3/4] git-gui: only except numbers in the goto-line input
Date: Thu, 13 Oct 2011 15:48:14 +0200
Message-ID: <fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
 <a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
Cc: David Fries <David@Fries.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:48:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELeC-0002Hq-IS
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab1JMNsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:48:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33264 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab1JMNsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:48:24 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1464856bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=H70srH8AYRdmbrXf93W3dCxGLEGXa9afDTeAm+3OYCg=;
        b=fQ844GhUkCYbt7T2p9tC5kMq9xn7f4p7pV+bh+F4IsI6CV0vVwLiQ7dN4a0qHE0JOB
         VQkQu9RPUYN/W/6cm6AGBBjPahOPPH6SXBmcJ0Hd6nyIAeXZqd6nMYtLPHUcKFSGK35n
         v38bIq0FptxmybmAwXkYgdYpi1MtM4tyBNEPI=
Received: by 10.204.144.21 with SMTP id x21mr2925896bku.16.1318513703970;
        Thu, 13 Oct 2011 06:48:23 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id v16sm3738567bkd.6.2011.10.13.06.48.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 06:48:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
In-Reply-To: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183484>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/line.tcl |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/line.tcl b/lib/line.tcl
index 692485a..70785e1 100644
--- a/lib/line.tcl
+++ b/lib/line.tcl
@@ -15,7 +15,11 @@ constructor new {i_w i_text args} {
 
 	${NS}::frame  $w
 	${NS}::label  $w.l       -text [mc "Goto Line:"]
-	entry  $w.ent -textvariable ${__this}::linenum -background lightgreen
+	entry  $w.ent \
+		-textvariable ${__this}::linenum \
+		-background lightgreen \
+		-validate key \
+		-validatecommand [cb _validate %P]
 	${NS}::button $w.bn      -text [mc Go] -command [cb _incrgoto]
 
 	pack   $w.l   -side left
@@ -26,7 +30,7 @@ constructor new {i_w i_text args} {
 	grid remove $w
 
 	bind $w.ent <Return> [cb _incrgoto]
-	bind $w.ent <Escape> [list linebar::hide $this]
+	bind $w.ent <Escape> [cb hide]
 
 	bind $w <Destroy> [list delete_this $this]
 	return $this
@@ -55,6 +59,14 @@ method editor {} {
 	return $w.ent
 }
 
+method _validate {P} {
+	# only accept numbers as input
+	if {[regexp {\d*} $P]} {
+		return 1
+	}
+	return 0
+}
+
 method _incrgoto {} {
 	if {$linenum ne {}} {
 		$ctext see $linenum.0
-- 
1.7.6.789.gb4599
