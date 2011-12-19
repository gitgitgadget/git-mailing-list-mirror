From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t4018: add a few more test cases for cpp hunk header matching
Date: Mon, 19 Dec 2011 15:53:13 -0600
Message-ID: <6fUozvAFiZtWtB8fYx2kUeUq8VtDgI4bzcA55hMiHJgT_Ag96PM120NEGB5HdtvbJQHJWjAksX6bgea_pMM2jpV6mCwiLKQ9EacSnIUmJ8llgHHqU2I0v9oMj8mYKTJxdIZXJFnBtYA@cipher.nrlssc.navy.mil>
References: <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com, trast@student.ethz.ch,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Mon Dec 19 22:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RclAd-0002MG-SU
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1LSVyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 16:54:52 -0500
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:48751 "EHLO
	mail4.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab1LSVyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 16:54:50 -0500
Received: by mail4.nrlssc.navy.mil id pBJLsRbL001601; Mon, 19 Dec 2011 15:54:27 -0600
In-Reply-To: <31E9klcRboMV0wSJY5WO-N7nIBOUOa_wr6MVfWY9AInImxJIqC0flahvpDrVGMIuZ9e7Ouha1HDuesbwTGaNQA4dgN-FShNJKkfMG_cHLUJAT2rE539shnQxzM0dQyZIb5661As6Tvs@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Dec 2011 21:54:26.0399 (UTC) FILETIME=[C6A636F0:01CCBE98]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187479>

From: Brandon Casey <drafnel@gmail.com>

Add one case for matching a function returning a pointer.

Plus add examples of things we explicitly do not match:

   labels
   function declarations
   global variable declarations

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


This can be squashed into the original patch with the other test cases.
This just introduces a few more cases pointed out by Thomas Rast in the
email Johannes referenced.

   http://thread.gmane.org/gmane.comp.version-control.git/186355/focus=186439

Also, note that all of the tests pass except for ignore_global.cpp with
Johannes's pattern:

   "!^[ \\t]*[a-zA-Z_][a-zA-Z_0-9]*[^()]*:[[:space:]]*$\n^[a-zA-Z_][a-zA-Z_0-9]*.*"

-Brandon


 t/t4018/ignore_declaration.cpp |   35 +++++++++++++++++++++++++++++++++++
 t/t4018/ignore_global.cpp      |   36 ++++++++++++++++++++++++++++++++++++
 t/t4018/ignore_label.cpp       |   35 +++++++++++++++++++++++++++++++++++
 t/t4018/pointer_return.cpp     |   34 ++++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 t/t4018/ignore_declaration.cpp
 create mode 100644 t/t4018/ignore_global.cpp
 create mode 100644 t/t4018/ignore_label.cpp
 create mode 100644 t/t4018/pointer_return.cpp

diff --git a/t/t4018/ignore_declaration.cpp b/t/t4018/ignore_declaration.cpp
new file mode 100644
index 0000000..615aea0
--- /dev/null
+++ b/t/t4018/ignore_declaration.cpp
@@ -0,0 +1,35 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+	void WRONG_function_declaration_within_body (void);
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/ignore_global.cpp b/t/t4018/ignore_global.cpp
new file mode 100644
index 0000000..df6b8aa
--- /dev/null
+++ b/t/t4018/ignore_global.cpp
@@ -0,0 +1,36 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_global_variable;
+
+/*
+ * Filler
+ * Filler
+ * Filler
+ * Filler
+ * Filler
+ * Filler
+ */
+
+int answer = 0;
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/ignore_label.cpp b/t/t4018/ignore_label.cpp
new file mode 100644
index 0000000..2e3ce10
--- /dev/null
+++ b/t/t4018/ignore_label.cpp
@@ -0,0 +1,35 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+int RIGHT_function_hunk_header (void)
+{
+WRONG_should_not_match_label:
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
diff --git a/t/t4018/pointer_return.cpp b/t/t4018/pointer_return.cpp
new file mode 100644
index 0000000..fd85545
--- /dev/null
+++ b/t/t4018/pointer_return.cpp
@@ -0,0 +1,34 @@
+int WRONG_function_hunk_header_preceding_the_right_one (void)
+{
+	return 0;
+}
+
+static int *RIGHT_function_hunk_header (void)
+{
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	int answer = 0;
+
+	/*
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 * Filler
+	 */
+
+	return answer;
+}
+
+int WRONG_function_hunk_header_following_the_right_one (void)
+{
+	return 0;
+}
-- 
1.7.7.4
