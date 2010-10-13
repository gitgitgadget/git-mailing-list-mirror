From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix test of highlighting support in t9500
Date: Wed, 13 Oct 2010 13:57:41 +0200
Message-ID: <20101013115657.11392.76179.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christopher Wilson <cwilson@cdwilson.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 13:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5zyX-0006nO-N2
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 13:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab0JML6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 07:58:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54556 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0JML6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 07:58:21 -0400
Received: by bwz15 with SMTP id 15so3106302bwz.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=iGfRgiC2qoLtj87ybES9rhRx51Q5l34UayLxjU96yIo=;
        b=NfHU1T5io00rfyCe29TNRA9uvCAbYCsaJpOZgLlYiHPf1VWuePTHxPb7rFzmIJESUd
         whh91ECy8RWzUTPE2pq/zQTj/GhezoV5YjxWHd0QD9Ahy8U0Z1jB3q6hA0OPM++2FB1y
         0M1rHRT0NiCktlXd2EKz/O7o0COdrNqESHInY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=b9+VK9xAmeFLiO75VxqBIsvIGaFVUUigpRUodVmrn4GUDjYonfZZOnr5pCSRgLNZuu
         nHQ+n6B+QGLRA+DPzjHdi3Gr8IRHCPI2pDJIo6YKHruiu8QpXBoxjmBDZnVAxEPC568T
         Dh7OJPhLJTr87Soqy/yWZsYY7NR38y6QExtKc=
Received: by 10.204.50.211 with SMTP id a19mr285559bkg.130.1286971095470;
        Wed, 13 Oct 2010 04:58:15 -0700 (PDT)
Received: from localhost.localdomain (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id 4sm5728253bki.1.2010.10.13.04.58.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 04:58:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9DBvfkY011429;
	Wed, 13 Oct 2010 13:57:52 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158931>

The commit 7ce896b (Enable highlight executable path as a
configuration option, 2010-09-21) forgot to update t9500 test.

While at it, describe highlight test better.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Noticed while running t9500 with `--debug` option.

 t/t9500-gitweb-standalone-no-errors.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 4f2b9b0..21cd286 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -650,25 +650,26 @@ test_debug 'cat gitweb.log'
 # ----------------------------------------------------------------------
 # syntax highlighting
 
-cat >>gitweb_config.perl <<\EOF
-$feature{'highlight'}{'override'} = 1;
-EOF
 
 highlight --version >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	say "Skipping syntax highlighting test, because 'highlight' was not found"
 else
 	test_set_prereq HIGHLIGHT
+	cat >>gitweb_config.perl <<-\EOF
+	our $highlight_bin = "highlight";
+	$feature{'highlight'}{'override'} = 1;
+	EOF
 fi
 
 test_expect_success HIGHLIGHT \
-	'syntax highlighting (no highlight)' \
+	'syntax highlighting (no highlight, unknown syntax)' \
 	'git config gitweb.highlight yes &&
 	 gitweb_run "p=.git;a=blob;f=file"'
 test_debug 'cat gitweb.log'
 
 test_expect_success HIGHLIGHT \
-	'syntax highlighting (highlighted)' \
+	'syntax highlighting (highlighted, shell script)' \
 	'git config gitweb.highlight yes &&
 	 echo "#!/usr/bin/sh" > test.sh &&
 	 git add test.sh &&
