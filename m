From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] t4018: introduce test cases for the internal hunk
 header patterns
Date: Tue, 20 Dec 2011 20:52:33 +0100
Message-ID: <4EF0E781.4060506@kdbg.org>
References: <7vmxaokv6k.fsf@alter.siamese.dyndns.org> <1324348939-27115-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	jrnieder@gmail.com, trast@student.ethz.ch
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 20:52:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5jx-0001OU-3v
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 20:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab1LTTwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 14:52:41 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:52367 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751715Ab1LTTwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 14:52:39 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9E379A7EB4;
	Tue, 20 Dec 2011 20:53:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0B42519F5FE;
	Tue, 20 Dec 2011 20:52:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <1324348939-27115-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187522>

Am 20.12.2011 03:42, schrieb Brandon Casey:
> +int WRONG_global_variable;

Personally, I'm not a fan of this one. IMHO, global variable
definitions need not be ignored. (But I can live with it.)

But here are some more tests that I care about and that you can squash in.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018/broken_class_constructor.cpp               |    3 +-
 t/t4018/broken_return_type_in_global_namespace.cpp |   16 ++++++++++++++
 t/t4018/class_definition.cpp                       |   19 +++++++++++++++++
 t/t4018/derived_class_definition.cpp               |   20 ++++++++++++++++++
 t/t4018/ignore_access_specifier.cpp                |   22 ++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletions(-)
 create mode 100644 t/t4018/broken_return_type_in_global_namespace.cpp
 create mode 100644 t/t4018/class_definition.cpp
 create mode 100644 t/t4018/derived_class_definition.cpp
 create mode 100644 t/t4018/ignore_access_specifier.cpp

diff --git a/t/t4018/broken_class_constructor.cpp b/t/t4018/broken_class_constructor.cpp
index 774c7f9..28c1bc8 100644
--- a/t/t4018/broken_class_constructor.cpp
+++ b/t/t4018/broken_class_constructor.cpp
@@ -3,7 +3,8 @@ int WRONG_function_hunk_header_preceding_the_right_one (void)
 	return 0;
 }
 
-RIGHT_function_hunk_header::RIGHT_function_hunk_header (void)
+RIGHT_function_hunk_header::RIGHT_function_hunk_header (int x) :
+	WRONG_member_initializer(x)
 {
 	const char *msg = "ChangeMe";
 	printf("Hello, world, %s\n", msg);
diff --git a/t/t4018/broken_return_type_in_global_namespace.cpp b/t/t4018/broken_return_type_in_global_namespace.cpp
new file mode 100644
index 0000000..da9931b
--- /dev/null
+++ b/t/t4018/broken_return_type_in_global_namespace.cpp
@@ -0,0 +1,16 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+::TypeInGlobalNamespace RIGHT_function_hunk_header()
+{
+	const char *msg = "ChangeMe";
+	printf("Hello, world, %s\n", msg);
+	return 0;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/class_definition.cpp b/t/t4018/class_definition.cpp
new file mode 100644
index 0000000..fc3df34
--- /dev/null
+++ b/t/t4018/class_definition.cpp
@@ -0,0 +1,19 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+class RIGHT_class_name
+{
+	void WRONG_function_name_following_the_right_one()
+	{
+		const char *msg = "ChangeMe";
+		printf("Hello, world, %s\n", msg);
+		return 0;
+	}
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/derived_class_definition.cpp b/t/t4018/derived_class_definition.cpp
new file mode 100644
index 0000000..b8501a5
--- /dev/null
+++ b/t/t4018/derived_class_definition.cpp
@@ -0,0 +1,20 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+class RIGHT_class_name :
+	public WRONG_class_name_following_the_right_one
+{
+	void WRONG_function_name_following_the_right_one()
+	{
+		const char *msg = "ChangeMe";
+		printf("Hello, world, %s\n", msg);
+		return 0;
+	}
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/ignore_access_specifier.cpp b/t/t4018/ignore_access_specifier.cpp
new file mode 100644
index 0000000..d865040
--- /dev/null
+++ b/t/t4018/ignore_access_specifier.cpp
@@ -0,0 +1,22 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+class RIGHT_class_name
+{
+public:
+protected:
+private:
+	void WRONG_function_name_following_the_right_one()
+	{
+		const char *msg = "ChangeMe";
+		printf("Hello, world, %s\n", msg);
+		return 0;
+	}
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
-- 
1.7.8.216.g2e426
