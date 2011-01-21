From: Tilman Vogel <tilman.vogel@web.de>
Subject: [PATCH] git-gui: add config value gui.diffopts for passing additional diff options
Date: Fri, 21 Jan 2011 11:59:45 +0100
Message-ID: <1295607585-15971-1-git-send-email-tilman.vogel@web.de>
Cc: Tilman Vogel <tilman.vogel@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 21 12:00:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgEit-0002Z6-TV
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 12:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab1AULAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 06:00:00 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56771 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab1AUK77 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 05:59:59 -0500
Received: by fxm20 with SMTP id 20so1625435fxm.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 02:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=iK5HJAm/O84j2pbC9YkYyjs7ihbcltHmEZCHJHGmdxI=;
        b=OuHi8vPALGf7mO6zSrtz0bLmV1Bg6psNjv75Wu2K0dRK8GCGKhR2m4G7gXpBmt319g
         Wfs8IxC+3rwMLfryZG3gle3UHTzjmCoMwR8fLaRtkdDlqqeueITeHxFdyGghPZJAjt8S
         guUOVuZMPQ6UiFD1eAfwuL+dzu3o3gnizKKoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=EdCpMe0uzcZmH/ob3Bb3gV9R1T+DqJq0a3WixBtPYH/cBNUurXxpWRt8uNDmxU8Lv7
         skhFE/VBMLz4u44rAp9zAIdy1lTwUqumXeSE3WyX/X4GqUV/e7alaTd9/+EpWfLIZkSO
         p4mL/Ui9fbzEsltLP4bxP/QwqmDeBFjdH8RKw=
Received: by 10.223.86.71 with SMTP id r7mr499272fal.137.1295607597984;
        Fri, 21 Jan 2011 02:59:57 -0800 (PST)
Received: from localhost.localdomain (e178197124.adsl.alicedsl.de [85.178.197.124])
        by mx.google.com with ESMTPS id l3sm71503fan.0.2011.01.21.02.59.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 02:59:57 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165366>

Signed-off-by: Tilman Vogel <tilman.vogel@web.de>
---
 Documentation/config.txt |    4 ++++
 git-gui/git-gui.sh       |    1 +
 git-gui/lib/diff.tcl     |    1 +
 git-gui/lib/option.tcl   |    1 +
 4 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..0ed7bcf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1100,6 +1100,10 @@ gui.diffcontext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
 
+gui.diffopts::
+	Specifies additional parameters to pass to diff from 
+	linkgit:git-gui[1]. The default is "".
+
 gui.encoding::
 	Specifies the default encoding to use for displaying of
 	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3acf0d..2a3aed5 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -823,6 +823,7 @@ set default_config(gui.fastcopyblame) false
 set default_config(gui.copyblamethreshold) 40
 set default_config(gui.blamehistoryctx) 7
 set default_config(gui.diffcontext) 5
+set default_config(gui.diffopts) {}
 set default_config(gui.commitmsgwidth) 75
 set default_config(gui.newbranchtemplate) {}
 set default_config(gui.spellingdictionary) {}
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index dcf0711..de3827a 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -295,6 +295,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 
 	lappend cmd -p
 	lappend cmd --color
+	set cmd [concat $cmd $repo_config(gui.diffopts)]
 	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
 	}
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index 3807c8d..1e5d28c 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -153,6 +153,7 @@ proc do_options {} {
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{t gui.diffopts {mc "Additional Diff Parameters"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
-- 
1.7.3.4
