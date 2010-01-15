From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] t7800-difftool.sh: Simplify the --extcmd test
Date: Thu, 14 Jan 2010 23:16:00 -0800
Message-ID: <1263539762-8269-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 15 08:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVgTv-0002ja-Fr
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab0AOHQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 02:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264Ab0AOHQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 02:16:09 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:44225 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab0AOHQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 02:16:08 -0500
Received: by yxe26 with SMTP id 26so224339yxe.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 23:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=uGN9H+PT0VM3K0LpmbinGQY1dKC5xI6lpVCtBnWYlD4=;
        b=lskUYsrLZRO8kQeXCBdClo2YeKT8fnYxiJUyWVYLXny6O5UFq/KUsp9kZciQeTOOsw
         bx1EbtDInCnqIHW7qHu0Kl818gPmWTG/AGgy1Ajjeog3oRfV8+rQSlr157DQjVa9SDnR
         d2lcLTepvHxaas9U8oSvpeauNYXnHW0bXGmnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=T/mQ4pIIroKTinAeiHPg6OMXZxBhwy/Y90zqYuRG2cvknMKAEmYI4Ye//e/jatHkBa
         wWITmsfDRVPZctn1VzbjORDFubDFPvFuoUwlVqflh6vlCy+n5iT908nMyUq7Xhyl7e51
         alKmK0a0KNP5pzQt6rgH1ia5PQQEQF5/J4vpY=
Received: by 10.150.47.11 with SMTP id u11mr162260ybu.140.1263539767964;
        Thu, 14 Jan 2010 23:16:07 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm610384ywc.6.2010.01.14.23.16.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 23:16:07 -0800 (PST)
X-Mailer: git-send-email 1.6.6.196.g1f735
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137054>

Instead of running 'grep', 'echo', and 'wc' we simply compare
git-difftool's output against a known good value.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 8ee186a..1d9e07b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -15,6 +15,9 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
+LF='
+'
+
 remove_config_vars()
 {
 	# Unset all config variables used by git-difftool
@@ -219,19 +222,13 @@ test_expect_success 'difftool.<tool>.path' '
 	restore_test_defaults
 '
 
-test_expect_success 'difftool --extcmd=...' '
+test_expect_success 'difftool --extcmd=cat' '
 	diff=$(git difftool --no-prompt --extcmd=cat branch) &&
+	test "$diff" = branch"$LF"master
 
-	lines=$(echo "$diff" | wc -l) &&
-	test "$lines" -eq 2 &&
 
-	lines=$(echo "$diff" | grep master | wc -l) &&
-	test "$lines" -eq 1 &&
 
-	lines=$(echo "$diff" | grep branch | wc -l) &&
-	test "$lines" -eq 1 &&
 
-	restore_test_defaults
 '
 
 test_done
-- 
1.6.6.6.g627fb.dirty
