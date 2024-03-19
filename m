Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002E37708
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873498; cv=none; b=gkPl9GfaTO/8MhiV1VtqDn1G1RlFQvIiL2nk3Mjx1Y7YVlBNDdL6F4qrfAF4ca3tQd8CFJ7Fyh6a6iIJ82KsjeOokGSbrNCzLOOBFAhBh9EebDah6+HnIqYRJrNNu91LiwtXrofbX13k/Qtm7W6Oj299eqQg0np2yew6pR3rvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873498; c=relaxed/simple;
	bh=OUu2lEG9Nv0bZheTKLRjiQrJVzd7iZ0ZpXB4kKh+9K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDt03871BiHZJxJjCZHXuXjJ/uIo1GFJ9DI9SxqCqXqpzdLdva+W30KcsNITtm2STtQje8GtymkmKb1WGX+mq1wkERBBcJk4ZEZP/YmpOCzBS20RZ5uF5t+bOInsbFldOHf3hzVkNH8RIb9A7EyHbCkOKlAfPv1j1GsMmrRUpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=XhixUwIF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="XhixUwIF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710873491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlO5iMWkcZmEJ+mJ0bqkas/diFd8Tjwia/QV10eRov8=;
	b=XhixUwIFy3BgrSsJuf1TqxbNBROghIrJGyBJBUnN3QbumfNv419Uv65ES/mBBa0KPyfjpK
	KGTejHrOp/yANtqNI9VcvNKIhP9mkMWGFDypfQBer9g6rpTViOD9cFWMVlCVZ2bGbXfvMe
	3pHcVZAzPicUs+H8rheS9xS+XIueVoWszdRGTdZkg1OK23PszG31IVypgq287chDNifdBK
	vwgYd6VLoiUL9QXmX/Meqi057V1u4PDcdn4w8nOR84LQ7H/IyezlSsYdU6B6u/BWqw/gdI
	8uFL2MDfgAu7gcNLUx4DAXP0uClEsshf9dXQPHjgQDIYpc428+FsWvCgrZixyA==
From: Ignacio Encinas <ignacio@iencinas.com>
To: git@vger.kernel.org
Cc: Ignacio Encinas <ignacio@iencinas.com>
Subject: [PATCH v3 1/2] t: add a test helper for getting hostname
Date: Tue, 19 Mar 2024 19:37:21 +0100
Message-ID: <20240319183722.211300-2-ignacio@iencinas.com>
In-Reply-To: <20240319183722.211300-1-ignacio@iencinas.com>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Avoid relying on whether the system running the test has "hostname"
installed or not, and expose the output of xgethostname through
test-tool.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
 Makefile                     |  1 +
 t/helper/test-tool.c         |  1 +
 t/helper/test-tool.h         |  1 +
 t/helper/test-xgethostname.c | 12 ++++++++++++
 t/t6500-gc.sh                |  3 +--
 5 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-xgethostname.c

diff --git a/Makefile b/Makefile
index 4e255c81f223..561d7a1fa268 100644
--- a/Makefile
+++ b/Makefile
@@ -863,6 +863,7 @@ TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
+TEST_BUILTINS_OBJS += test-xgethostname.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
 
 # Do not add more tests here unless they have extra dependencies. Add
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 482a1e58a4b6..9318900a2981 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -86,6 +86,7 @@ static struct test_cmd cmds[] = {
 	{ "truncate", cmd__truncate },
 	{ "userdiff", cmd__userdiff },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
+	{ "xgethostname", cmd__xgethostname },
 	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b1be7cfcf593..075d34bd3c0a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -79,6 +79,7 @@ int cmd__trace2(int argc, const char **argv);
 int cmd__truncate(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
+int cmd__xgethostname(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 #ifdef GIT_WINDOWS_NATIVE
diff --git a/t/helper/test-xgethostname.c b/t/helper/test-xgethostname.c
new file mode 100644
index 000000000000..285746aef54a
--- /dev/null
+++ b/t/helper/test-xgethostname.c
@@ -0,0 +1,12 @@
+#include "test-tool.h"
+
+int cmd__xgethostname(int argc, const char **argv)
+{
+	char hostname[HOST_NAME_MAX + 1];
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		die("unable to get the host name");
+
+	puts(hostname);
+	return 0;
+}
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 18fe1c25e6a0..613c766e2bb4 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -395,7 +395,6 @@ test_expect_success 'background auto gc respects lock for all operations' '
 
 	# now fake a concurrent gc that holds the lock; we can use our
 	# shell pid so that it looks valid.
-	hostname=$(hostname || echo unknown) &&
 	shell_pid=$$ &&
 	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
 	then
@@ -404,7 +403,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
 		# the Windows PID in this case.
 		shell_pid=$(cat /proc/$shell_pid/winpid)
 	fi &&
-	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
+	printf "%d %s" "$shell_pid" "$(test-tool xgethostname)" >.git/gc.pid &&
 
 	# our gc should exit zero without doing anything
 	run_and_wait_for_auto_gc &&
-- 
2.44.0

