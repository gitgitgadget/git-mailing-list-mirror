From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] Export more test-related variables when running external
	tests
Date: Sat, 24 Apr 2010 15:50:09 +0200
Message-ID: <20100424134640.30511.37449.stgit@localhost.localdomain>
References: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 15:50:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fkp-0006Ol-TP
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 15:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab0DXNui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 09:50:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:31231 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab0DXNuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 09:50:37 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1370640fga.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=W9hPhNbue/ouuTaWYHwD8336NgCuJqkZDDkCJSphM0c=;
        b=aGwMmIPEaAXO1sqOJSzKFFwFCEtStMdHG9t8asca8y1rRllEZUy+jm59kDaRckPYwl
         3Zi3hLBCCYfo6xgnqGOeztaxH47ZpMvpVDT31xSU1nY9yaIApgrcm6z2Z634N4tfREJ5
         ShGTJHPikahzaghUOnzdSKY4mUt1+flrW/eTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=l00Q0lcWu/nOOLQSQoPbuJuMe0btPm/3lYLyR+dV075wte2cTTkAwVGNGwyUj8yddV
         rvCA7QHseQIQE65QoPkFeH8Agy70NGANu3knz2KWxWWUvPSHbVTN7gJpqr94oUi44OVY
         wkt4GnK5U0qyOMlCwa4GJ11o7AIUDgGTwt/wE=
Received: by 10.87.63.31 with SMTP id q31mr2597674fgk.18.1272117036097;
        Sat, 24 Apr 2010 06:50:36 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id 12sm1177287fgg.14.2010.04.24.06.50.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 06:50:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3ODo92Z030905;
	Sat, 24 Apr 2010 15:50:19 +0200
In-Reply-To: <20100424132255.30511.98829.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145676>

Add exporting TEST_DIRECTORY and TRASH_DIRECTORY to test_external, for
external tests to be able to find test script (and git sources), and
to find trash directory (usually with test repository in it).

Add also exporting GIT_TEST_LONG, so that external test can skip
time-intensive tests unless test is invoked with `--long' option.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Currently there is no test that requires those variables; git test
suite uses test_external* only in t9700-perl-git.sh.  It would be
needed for tests of caching for gitweb.

Nevertheless I think it is a good change to have...

 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

diff --git a/t/test-lib.sh b/t/test-lib.sh
old mode 100644
new mode 100755
index c582964..6187328
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -459,6 +459,9 @@ test_external () {
 		# Announce the script to reduce confusion about the
 		# test output that follows.
 		say_color "" " run $test_count: $descr ($*)"
+		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
+		# to be able to use them in script
+		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
