From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 01/14] test-lib: add test_dir_is_empty()
Date: Sun, 15 Jun 2014 18:57:12 +0200
Message-ID: <539DD068.6020301@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 18:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDkB-000878-R3
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 18:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbaFOQ5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 12:57:17 -0400
Received: from mout.web.de ([212.227.17.12]:63634 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbaFOQ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 12:57:16 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MBkHT-1X4EkY2vt1-00AnY9; Sun, 15 Jun 2014 18:57:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:DZSDjCU94nPBxRhioQPQ3Kvfrtrz/gV0YYXd+1KzqwG8mjJz3MX
 +xo40ThAPpeQUZkf0prSuZlh8HeEuCcvPHXQ3GwLK5rcK9nYXOQShay6+lboXpCwLPJ6OSj
 ICJ7QRhIXZBKqbbkYYxgJ8nO7s2NO3clZPabN8+j4LqBfvJsjc1L3tfY2BZDI4PIGtk8hAW
 sXFj68yk+m2QQzGb6XaCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251683>

For the upcoming submodule test framework we often need to assert that an
empty directory exists in the work tree. Add the test_dir_is_empty()
function which asserts that the given argument is an empty directory.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/test-lib-functions.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 158e10a..546f0a6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -489,6 +489,17 @@ test_path_is_dir () {
 	fi
 }

+# Check if the directory exists and is empty as expected, barf otherwise.
+test_dir_is_empty () {
+	test_path_is_dir "$1" &&
+	if test "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
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
2.0.0.275.gc479268
