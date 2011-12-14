From: Johannes Sixt <j6t@kdbg.org>
Subject: How to run http server tests?
Date: Wed, 14 Dec 2011 22:20:07 +0100
Message-ID: <4EE91307.6080504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 22:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RawFN-0001xP-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 22:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947Ab1LNVUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 16:20:13 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:29554 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755364Ab1LNVUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 16:20:12 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FF771000B
	for <git@vger.kernel.org>; Wed, 14 Dec 2011 22:18:56 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8BA3819F3B8
	for <git@vger.kernel.org>; Wed, 14 Dec 2011 22:20:07 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187168>

I have a hard time running tests that use lib-httpd.sh.

I run the tests like this:

  LIB_HTTPD_MODULE_PATH=/usr/lib64/apache2 GIT_TEST_HTTPD=Yes \
      sh -x t5541-http-push.sh -v -i

and I have to apply this patch because I do not have mod_cgi on my
system (OpenSuse 11.4):

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0a4cdfa..e5cb3f9 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -13,4 +13,4 @@ ErrorLog error.log
 </IfModule>
-<IfModule !mod_cgi.c>
-       LoadModule cgi_module modules/mod_cgi.so
+<IfModule !mod_scgi.c>
+       LoadModule scgi_module modules/mod_scgi.so
 </IfModule>


I see t5541-http-push.sh #2 fail with:

++ cd '/home/jsixt/Src/git/git/t/trash directory.t5541-http-push'
++ git clone http://127.0.0.1:5541/smart/test_repo.git/ test_repo_clone
Cloning into 'test_repo_clone'...
fatal: http://127.0.0.1:5541/smart/test_repo.git/info/refs not found:
did you run git update-server-info on the server?

t5551-http-fetch.sh fails at #3 here:

++ GIT_CURL_VERBOSE=1
++ git clone --quiet http://127.0.0.1:5551/smart/repo.git clone
+ eval_ret=128

In this case, 'git clone' output is redirected to file 'err'; it has the
same error as above.

t5561-http-backend.sh fails at #3 like so:

+++ diff -u exp act
--- exp 2011-12-14 21:14:49.000000000 +0000
+++ act 2011-12-14 21:14:49.000000000 +0000
@@ -1 +1 @@
-HTTP/1.1 200 OK
+HTTP/1.1 404 Not Found

Can someone help?

Thanks,
-- Hannes
