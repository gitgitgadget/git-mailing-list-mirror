From: applehq <theappleman@gmail.com>
Subject: [PATCH] t9129: Prevent test failure if no UTF-8 locale
Date: Sat, 6 Dec 2008 01:31:52 +0000
Message-ID: <20081206013152.GA6129@cumin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:31:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8m0x-0000MB-P7
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYLFBaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbYLFBaH
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:30:07 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:62712 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYLFBaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:30:05 -0500
Received: by wf-out-1314.google.com with SMTP id 27so254231wfd.4
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 17:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=gi4v2ihY07NprZXdD1laRtUF7jX5AiMYlNzjqVYakKY=;
        b=oyQQOpFl1rzrL0SMuDNxRMe1QM9CqGwf/LnIJIs4h9p4rKwYYhz5cxXU8ecDLrZwSo
         1QBR+PQQNbksEVbGX0TV0s84Cs1Aa8nuheEVgisiUrPLHge/NRizidjf46ewtfaeb6bp
         eRQbYiGeH1dpsr8BN2IXfA5ubIuWUxsJ1nOM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=JwHIGl/SLrYUf427fLBqluQvTLibdrhqfb7yjDzDSCoDSi+ZUaOuAKsJVTYc4/1olT
         NacJWsKFjTqw8MRgPMfHEHAzZ+O2n/Sy6z5nZ8i0TO6BbCcwoaSmLpzFUQd+TTbxjRko
         lJiILucPpqNpFt4yI4EmW6nkgmJoZ73b5mYe8=
Received: by 10.142.221.11 with SMTP id t11mr265933wfg.238.1228527005050;
        Fri, 05 Dec 2008 17:30:05 -0800 (PST)
Received: from @ (82-35-17-232.cable.ubr03.hari.blueyonder.co.uk [82.35.17.232])
        by mx.google.com with ESMTPS id 20sm11111672wfi.27.2008.12.05.17.30.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 17:30:04 -0800 (PST)
Mail-Followup-To: applehq <theappleman@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-11-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102431>

Commit 16fc08e2d86dad152194829d21bc55b2ef0c8fb1 introduced a
test that failed if the en_US.UTF-8 locale was not installed.

Make the test find a UTF-8 locale, and expect failure.

Signed-off-by: applehq <theappleman@gmail.com>
---
 t/t9129-git-svn-i18n-commitencoding.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 938b7fe..87ecdd0 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -15,8 +15,9 @@ compare_git_head_with () {
 }
 
 compare_svn_head_with () {
-	LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
-		sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&
+	LC_ALL=`locale -a | grep -i utf | head -1` \
+		svn log --limit 1 `git svn info --url` | \
+			sed -e 1,3d -e "/^-\{1,\}\$/d" >current &&
 	test_cmp current "$1"
 }
 
@@ -60,7 +61,7 @@ do
 	'
 done
 
-test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
+test_expect_failure 'ISO-8859-1 should match UTF-8 in svn' '
 (
 	cd ISO-8859-1 &&
 	compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
@@ -69,7 +70,7 @@ test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
 
 for H in EUCJP ISO-2022-JP
 do
-	test_expect_success '$H should match UTF-8 in svn' '
+	test_expect_failure '$H should match UTF-8 in svn' '
 	(
 		cd $H &&
 		compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
-- 
1.6.1.rc1.53.g455b
