From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 9 May 2016 08:18:52 +0200 (CEST)
Message-ID: <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 08:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azeXJ-0003jt-6E
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 08:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbcEIGTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 02:19:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:56101 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbcEIGTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 02:19:08 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MY3Ho-1b46VF0LCq-00Uttp; Mon, 09 May 2016 08:18:49
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462774709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:IErU7orFww9+BTpyNYDTnvRIjOA+peBkThJXXkkhU5ESfxCGya4
 608mcApbYuzhvgxM5O86/quKtG6I2CJuSPlhQ/G+z4Gqz6Ssfb83+CR9DLLFDX1qrsl38vb
 Wvbz8OrVJfrVNLlGGJIuzqgRtvfoFmhz5zFj2JVBr2SB6ZFCg/ILyIdjOCkxJ72zPx8Nhl9
 DrHE+Rnd2pUvs4rnQX11A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:koDLmHKZT1Q=:TkPFgP25BRbXxayo34ezQM
 7MX6m4IwO0reVx8KAilB2MgQzQfaFwnDebWvPuiaSeOnuTEJHt2IxUA6s2LW+G3NzaYFKbKs8
 4DP+TuyXs8EMZacChjGP2VAHi5Ts6HloKWypYHnF8mTLFdT0qswcvSryQ/+mVU9D8IasGYvto
 YCEeqwkdkyjVwamZPdjVCCaZrOCETyV0Y7l9zmTdZDFkcgvRv4JA8zlkuVWQhobEP60Yu+h8e
 Oo/Sy1atyFQM/iam3SUz8gwZpHvtyvsKNTZo+dkVjLuit7RXJKg6SxRpoMLXYXUy4+PqrKiTi
 seQOzrXh2iAXUEBR1uRz1x/2cCAqGnSo6pW/kZipCBI1QNK+mmYrBM/9hwHEJHfFL5dYJ16b8
 aG2C68WqCjmKbg7h5jxNuXZiHbM0cNz2u6Z84FiGhdQcPbdyr3/YPX397AnbJWwsGTpgaVV9u
 zcf+MfDkjMLoxoDoF7Wge7MroyMLeUC+u9QHoZ6vvM+Q8gQ0u901OGaX/CPTMI2eIzY6bHsbl
 lFcr+dW7b5/3BqSgyGoomBYz7dAcB5PwH1BQxLknIuLNssBmdHy4Ail7YmFW2czTXv0NVUyUD
 mvCdoY8SbqCrkY0bIOdSzLt48fRmBmBDfdTK2DA0HBVyMukvk3oRmovNN/3zPRfyHxMnekqZU
 GNf12cu8sGUmpQ4hdOw43S81ApxChszBmxM3r82fC6tQ/KuUHJng+/eOvS+lShmxGdmrF92G5
 tCMhx0gFhHn+fkStLT4mYcUAd3sRrnAYKauZHoDAUh82CK9WYt8HXv4F5ylh/W+Z4wTXr3e1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293986>

Lars Schneider noticed that the configuration introduced to test the extra
HTTP headers cannot be used with Apache 2.2 (which is still actively
maintained, as pointed out by Junio Hamano).

To let the tests pass with Apache 2.2 again, let's substitute the
offending <RequireAll> and `expr` by using old school RewriteCond
statements.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-httpd/apache.conf | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index b8ed96f..29b34bb 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -103,10 +103,6 @@ Alias /auth/dumb/ www/auth/dumb/
 	Header set Set-Cookie name=value
 </LocationMatch>
 <LocationMatch /smart_headers/>
-	<RequireAll>
-		Require expr %{HTTP:x-magic-one} == 'abra'
-		Require expr %{HTTP:x-magic-two} == 'cadabra'
-	</RequireAll>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
@@ -136,6 +132,14 @@ RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
 RewriteRule ^/loop-redir/x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-(.*) /$1 [R=302]
 RewriteRule ^/loop-redir/(.*)$ /loop-redir/x-$1 [R=302]
 
+# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
+# And as RewriteCond unfortunately lacks "not equal" matching, we use this
+# ugly trick to fail *unless* the two headers are present.
+RewriteCond %{HTTP:x-magic-one} =abra
+RewriteCond %{HTTP:x-magic-two} =cadabra
+RewriteRule ^/smart_headers/.* - [L]
+RewriteRule ^/smart_headers/.* - [F]
+
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
-- 
2.8.2.463.g99156ee
