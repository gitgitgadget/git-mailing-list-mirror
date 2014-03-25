From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH 1/4] test-lib: add test_dir_is_empty()
Date: Tue, 25 Mar 2014 18:04:23 +0100
Message-ID: <5331B717.5010600@web.de>
References: <5331B6F6.60501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:04:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUmA-0000Jz-0b
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbaCYRE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:04:27 -0400
Received: from mout.web.de ([212.227.15.3]:61476 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbaCYRE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:04:27 -0400
Received: from [192.168.178.41] ([84.132.146.250]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZDP6-1WnT2C3Jfg-00KzYv; Tue, 25 Mar 2014 18:04:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5331B6F6.60501@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:5dcPtXQN1sV9pZpaba0tdRkyuBl+HajVqQnFO7NwmphuHjPlDzo
 fTSjMc4W4cDJOTvPZ0G3oUMq97EDrHIgox7sU0xQBV59sBhVUUWwWzcQ9necRr1XfQlqYES
 XV1a5VLNt6loZUAQxcK4qnCZKxOLu7Y6oGh/zLAgHbINOw6qWIvKV8zMwCEHdSXvGCDI3fU
 S0UG3Z41bf+LT+H8xpMWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245045>

For the upcoming submodule test framework we often need to assert that an
empty directory exists in the work tree. Add the test_dir_is_empty()
function which asserts that the given argument is an empty directory.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I believe this one is pretty straightforward (unless I missed that this
functionality already exists someplace I forgot to look ;-).

 t/test-lib-functions.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 158e10a..93d10cd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -489,6 +489,17 @@ test_path_is_dir () {
 	fi
 }

+# Check if the directory exists and is empty as expected, barf otherwise.
+test_dir_is_empty () {
+	test_path_is_dir "$1" &&
+	if test $(ls -a1 "$1" | wc -l) != 2
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
1.9.1.327.g3d8d896
