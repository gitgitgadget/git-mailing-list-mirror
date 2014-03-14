From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] t5541: don't call start_httpd after sourcing lib-terminal.sh
Date: Fri, 14 Mar 2014 22:18:32 +0100
Message-ID: <53237228.10809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:18:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZV6-0005GZ-9i
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbaCNVSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:18:39 -0400
Received: from mout.web.de ([212.227.15.4]:65026 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755992AbaCNVSj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:18:39 -0400
Received: from [192.168.178.41] ([84.132.148.173]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MXYjm-1WcCd83Sju-00WVyt; Fri, 14 Mar 2014 22:18:36
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:LENkDPPa9pdxW+M5z3RdFtcGweHqUiJHw+XV0WqwcbfeFEmcXfp
 WEMECjcucHP01wibs+0kCeGiWgMj+6J0x4Wt5msSsjBGqtDKAz6Cjb4Z4dcEP+AqAQtUfqn
 r1wXSvXs1qy5uP6OppehsC0324WgNr5f+XvrEvGXKTbFxUaRSbg+aM8Gf2RiEA/yWWYUSwx
 F/nLU+F10/ZXBUW6Dn4Hg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244112>

Since 83d842dc8 "make test" using prove fails for some setups in t5541
with:

   "Parse errors: No plan found in TAP output"

Running t5541 on its own fails with:

   "error: Can't use skip_all after running some tests"

This happens because "start_httpd" (which determines if the test is to
be skipped) is called after sourcing lib-terminal.sh (which sets up the
terminal using test_expect_success).

Fix that by calling "start_httpd" before sourcing lib-terminal.sh.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Since recently t5541 fails for me on master and pu. I'm not sure what
detail in my setup causes this breakage (I have httpd installed and it
is running), but this patch fixes it for me.


 t/t5541-http-push-smart.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 73af16f..597fb96 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -13,8 +13,8 @@ fi

 ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-httpd.sh
-. "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
+. "$TEST_DIRECTORY"/lib-terminal.sh

 test_expect_success 'setup remote repository' '
 	cd "$ROOT_PATH" &&
-- 
1.9.0.168.g1119394
