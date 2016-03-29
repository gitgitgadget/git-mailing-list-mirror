From: Harish K <harish2704@gmail.com>
Subject: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Date: Tue, 29 Mar 2016 11:38:10 +0000
Message-ID: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 13:38:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akryU-0005kd-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 13:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888AbcC2LiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 07:38:13 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:52878
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895AbcC2LiN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 07:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459251490;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=6skXYhYuzERpMC9XFiV5NRPQBCBRHQ/G8gB67/jnxFI=;
	b=YH18IPfmWRLcuMmHGuI9ZZQAN5aw0ETziCmmVbUSJQQ0tWkTfhK0wfvihf+3vZZG
	rVapVmVn6gBx8F5HyOVMUpr2RCfDUsKEGNizTzD7jTqF7VLx+ej98SlTIvi00q5I6d1
	AEwCBPpBKGjMcFqsH7CqVo0ApYCR6BBmtEch31YA=
X-SES-Outgoing: 2016.03.29-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290118>

---
 git-gui/lib/tools.tcl | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl
index 6ec9411..749bc67 100644
--- a/git-gui/lib/tools.tcl
+++ b/git-gui/lib/tools.tcl
@@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
 }
 
 proc tools_populate_one {fullname} {
-	global tools_menubar tools_menutbl tools_id
+	global tools_menubar tools_menutbl tools_id repo_config
 
 	if {![info exists tools_id]} {
 		set tools_id 0
@@ -61,9 +61,19 @@ proc tools_populate_one {fullname} {
 		}
 	}
 
-	tools_create_item $parent command \
+	if {[info exists repo_config(guitool.$fullname.accelerator)] && [info exists repo_config(guitool.$fullname.accelerator-label)]} {
+		set accele_key $repo_config(guitool.$fullname.accelerator)
+		set accel_label $repo_config(guitool.$fullname.accelerator-label)
+		tools_create_item $parent command \
 		-label [lindex $names end] \
-		-command [list tools_exec $fullname]
+		-command [list tools_exec $fullname] \
+		-accelerator $accel_label
+		bind . $accele_key [list tools_exec $fullname]
+	} else {
+		tools_create_item $parent command \
+			-label [lindex $names end] \
+			-command [list tools_exec $fullname]
+	}
 }
 
 proc tools_exec {fullname} {

--
https://github.com/git/git/pull/220
