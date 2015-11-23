From: charles@hashpling.org
Subject: [PATCH] http: treat config options sslCAPath and sslCAInfo as paths
Date: Mon, 23 Nov 2015 12:02:40 +0000
Message-ID: <1448280160-113572-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 13:18:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0q50-0004xw-6a
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 13:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbbKWMSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 07:18:42 -0500
Received: from host02.zombieandprude.com ([80.82.119.138]:59649 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbbKWMSl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 07:18:41 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2015 07:18:41 EST
Received: from dab-glb1-h-5-7.dab.02.net ([82.132.218.159]:48317 helo=localhost.localdomain)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1a0pqC-0002k5-Mo
	for git@vger.kernel.org; Mon, 23 Nov 2015 12:03:29 +0000
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281581>

From: Charles Bailey <cbailey32@bloomberg.net>

This enables ~ and ~user expansion for these config options.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---

In the only place that we (optionally) test https specifically, we also
turn off SSL verification so I couldn't see a sensible way to add an
automated test.

The change is fairly simple and I've tested manually and the effects are
as I expected - I can point to a certificate bundle or directory in my
home directory using a ~/ prefix in my .gitconfig.

 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 42f29ce..5e37252 100644
--- a/http.c
+++ b/http.c
@@ -214,10 +214,10 @@ static int http_options(const char *var, const char *value, void *cb)
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var))
-		return git_config_string(&ssl_capath, var, value);
+		return git_config_pathname(&ssl_capath, var, value);
 #endif
 	if (!strcmp("http.sslcainfo", var))
-		return git_config_string(&ssl_cainfo, var, value);
+		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
 		ssl_cert_password_required = git_config_bool(var, value);
 		return 0;
-- 
2.6.0
