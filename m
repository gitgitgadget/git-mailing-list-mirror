From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 01/14] test-lib: add test_dir_is_empty()
Date: Thu, 19 Jun 2014 22:12:23 +0200
Message-ID: <53A34427.6010704@web.de>
References: <539DD029.4030506@web.de> <539DD068.6020301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxihS-00065B-7k
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319AbaFSUMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:12:42 -0400
Received: from mout.web.de ([212.227.15.3]:50504 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757289AbaFSUMl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:12:41 -0400
Received: from [192.168.178.41] ([79.193.64.138]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LqoAk-1WSWsG2DUg-00eQ3X; Thu, 19 Jun 2014 22:12:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD068.6020301@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:PVNbIdIBkrT6pyXn0SWs6YPG5KnGowJ3LqrdEeYtIzvJXZQTpkD
 6IDb+60GKxMITbnHUMyiXoqw66l/FoTktIS/T9NTiExtmgwps/DzvVUsCbCyHS/L4lh2i/2
 rIAUgrQGZatMznMGWzd4coR5MZB/OIvxf0el3a3am4PHeuWVRRp9v2GLGIm1TTFSJ44Re0T
 RssbyDsELuP03ebvW3UdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252175>

For the upcoming submodule test framework we often need to assert that an
empty directory exists in the work tree. Add the test_dir_is_empty()
function which asserts that the given argument is an empty directory.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes to v1:

*) Added "-n" to test expression (you have this as "SQUASH???" commit in pu)


 t/test-lib-functions.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c617c82..acd9a55 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -489,6 +489,17 @@ test_path_is_dir () {
 	fi
 }

+# Check if the directory exists and is empty as expected, barf otherwise.
+test_dir_is_empty () {
+	test_path_is_dir "$1" &&
+	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	then
+		echo "Directory '$1' is not empty, it contains:"
+		ls -la "$1"
+		return 1
+	fi
+}
+
 test_path_is_missing () {
 	if [ -e "$1" ]
 	then
-- 
2.0.0.406.gf4dce28
