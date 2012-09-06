From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 8/8] t0060: verify that real_path() removes extra slashes
Date: Fri,  7 Sep 2012 00:41:04 +0200
Message-ID: <1346971264-23744-9-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9klv-0007lO-06
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab2IFWls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:48 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:48487 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754261Ab2IFWlq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:46 -0400
X-AuditID: 1207440d-b7f236d000000943-67-504926a9972d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 39.D2.02371.9A629405; Thu,  6 Sep 2012 18:41:45 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJa025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:44 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLtSzTPA4MJ5A4uuK91MFg29V5gt
	nsy9y2xxe8V8Zov1ixpYLbqnvGV0YPP4+/4Dk8fOWXfZPR6+6mL3uHhJ2ePzJrkA1ihum6TE
	krLgzPQ8fbsE7oz5LxexF5zirtjw5DVrA+M9zi5GTg4JAROJ4x272SFsMYkL99azdTFycQgJ
	XGaUuDf5GpRzmkli+vvjLCBVbAK6Eot6mplAbBEBNYmJbYfA4swC5xkl/twEmyQs4CPRuuEJ
	M4jNIqAq8eJMI1icV8BFou3lAUaIbYoSP76vAarh4OAUcJWYtkAOJCwEVDLv/W22CYy8CxgZ
	VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEBBfvDsb/62QOMQpwMCrx8E44
	7xEgxJpYVlyZe4hRkoNJSZT3n5JngBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3om/gMp5UxIr
	q1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK80apAQwWLUtNTK9Iyc0oQ0kwc
	nCCCC2QDD9CGAJBC3uKCxNzizHSIolOMilLivEUgCQGQREZpHtwAWBp4xSgO9I8wbxBIFQ8w
	hcB1vwIazAQ0WOQZyOnFJYkIKakGxtZF7cWRupUJ/04czNi2g+/3is+NbL/KvG8fEjXu6JUz
	e3r/u32c63wBz1NMERuuSMoVNwt6mVe+nsrXc+UzE9/p9oDCEqntHhw5/0Qf/Ob1n97H0njs
	Y+mdvrfxIrN+PYn2kTbz4lgY7BF36fvCzdK/bP7uWfWmY8mmOvsHzuKue0u3bPwq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204935>

Adjusted for Windows by: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0060-path-utils.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 30361f9..e40f764 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -158,6 +158,24 @@ test_expect_success POSIX 'real path works on absolute paths' '
 	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
 '
 
+test_expect_success POSIX 'real path removes extra leading slashes' '
+	nopath="hopefully-absent-path" &&
+	test "/" = "$(test-path-utils real_path "///")" &&
+	test "/$nopath" = "$(test-path-utils real_path "///$nopath")" &&
+	# Find an existing top-level directory for the remaining tests:
+	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
+	test "$d" = "$(test-path-utils real_path "//$d")" &&
+	test "$d/$nopath" = "$(test-path-utils real_path "//$d/$nopath")"
+'
+
+test_expect_success 'real path removes other extra slashes' '
+	nopath="hopefully-absent-path" &&
+	# Find an existing top-level directory for the remaining tests:
+	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
+	test "$d" = "$(test-path-utils real_path "$d///")" &&
+	test "$d/$nopath" = "$(test-path-utils real_path "$d///$nopath")"
+'
+
 test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
-- 
1.7.11.3
