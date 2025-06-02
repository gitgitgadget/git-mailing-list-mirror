Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BBC2C325A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748849348; cv=none; b=eomuQGDsqNgIzRmkM6CwM0KssFqxprl5wqW8XQWpi2iFN76qdr9+cRJ58Cl9joLR9CF6BGeAdiolzkaR09zDkOaUcfoUnVWyg9jFPNEO0B70s47u9VAfw3xLKZ2s/QySkTV6Oep18dEgl/wirKqr5hsIUfQ290VLJ1iu0NnxA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748849348; c=relaxed/simple;
	bh=Cj7hVboydZVOHK9vCEhTFBfucWWQi5Vac0fvHYqK+O0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aM1eNAqik0oZ3HxshONf6Ag8OKVwItTdfw/Yk1UUffKO/t5axMjwEJZCa/jIlpMO+GSOioG9Ia9gCYUEe23Cxxxe9TfNd3emxlwgQAAXsDkLJqEsQa+d7eT1ULw5NV+ZPUpQKy3sL1iti2u9IF4JnjgVVwsZP7V3/FGc3uscbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=jIeSq1c+; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="jIeSq1c+"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4b9lp92d0Hz8PbP
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 03:29:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=Cj7hVboydZVOHK9vCEhTFBfucWWQi5Vac0fvHYqK+O0=; b=jIeS
	q1c+9Qu+D1QdWkslpq5WaFwhZTw1TdJUxDXAyeDtnOvZmdH4qdNooxA5/ccT9apK
	qvHL6oxHLpJd76ST8OMxMNd+m2DvJoDYX4J+vHXhRDdAM2Gd1XJg0iPIaQzl9vSl
	VkXLHa4OBNt/E2AIF2+GrE4ePOSerbw/dtxPrtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	b1nFSnYF3w4XJxuOUPq2dYJ6Mrb9BV4V43N575jNPoJv1Z5agmfOyJbZUDtfuJB+
	lscSYsY0aQkFf30ay0Afsv6pyG6bj3f0UmbWgexDbnLLL4eFCkUHygTiRrGTEj6d
	EDtlsvP7U1fEQX+1Mu08xYYK1Th0AYSMw+Fx6/psXcQ=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:b29c:6e05:bafd:127d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4b9lp90YGqz8PbN
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 03:29:05 -0400 (EDT)
Date: Mon, 2 Jun 2025 03:29:02 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD
Message-ID: <aD1SvlRypkhczxRS@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Handle OpenBSD and NetBSD as FreeBSD / DragonFly are. OpenBSD would
need _XOPEN_SOURCE to be set to 700. Its simpler to just not set
_XOPEN_SOURCE.

    CC strbuf.o
strbuf.c:645:6: warning: call to undeclared function 'getdelim'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
        r = getdelim(&sb->buf, &sb->alloc, term, fp);
            ^
1 warning generated.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 compat/posix.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index f4c71f9427..61fb08b64c 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -60,18 +60,17 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
-      !defined(__CYGWIN__)
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__NetBSD__) && \
+      !defined(__OpenBSD__) && !defined(__DragonFly__) && !defined(__MirBSD__) && \
+      !defined(__USLC__) && !defined(_M_UNIX) && !defined(__sgi) && \
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__CYGWIN__)
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500 */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
 #define _DEFAULT_SOURCE 1
-#define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
-- 
2.49.0

