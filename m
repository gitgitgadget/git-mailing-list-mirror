Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58F2EAE4
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548357; cv=none; b=e1fRxvDgZtGBh/76xNfDRS+jD98IGbAXAvimDX0TNlmHq/xPaZCay095yO0hlb615XmsI57pSKMMQ5XlnXhn6UByda8z/jclfbfLKwF71kGVUQLP7fp7DnQvtLskSKt5CmmIyVjW2oBuXV7nfmcitHtglixynwmRT7xmwNzwDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548357; c=relaxed/simple;
	bh=vWntoGC81zqA279BZFTcFohTUAL2fp4bls0CA1K7A2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZimZrnY8nhwlYP8zhRyiyEJlOPTIcBMixyvqzn9wcRZadajCWm4vtYfEDPcHZvAB6WgEN8ehVpVZzAVJ6baheUMW2b98swXDACo/0P48NkZx7NYHy8qvBr8bCrj0cxJO+jh6FHFyMbsYkOYXpWfoCaDPpae2JCKc8VEgLpVc0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YuKvofBq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YuKvofBq"
Received: (qmail 26613 invoked by uid 109); 14 Nov 2024 01:39:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vWntoGC81zqA279BZFTcFohTUAL2fp4bls0CA1K7A2o=; b=YuKvofBqlXvzzQ/hYTxntDpVnh8aPUpAhdZu9Nl2v4rTpheltVvndaSbrzBOm3dpbo8sBWAvNcPpZxp3VyGMHYKghUaxcB8G9/1rRkSo7P5qegoQWJ8yhHonOvo4lV2hchGDMg66r6uh+HquQOXQ709gIFQM7p1sQ6EpCXmvXhmfAsxyxxW6450zgZN/HjJ4yQcyMlZzMJWLJlvoQqZ4s/H3VeOGHtmNTwtWQw5eIoI7nbdiO2FhjNRcypsnsfLHlOXrybJ2AtZj8+ENYl+28RQv/KE1ZYn+M7yVh1w4kONNGHnRERxsLmrbaJmtmuTddAkv9Hw2MOohmOgEUqHecA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Nov 2024 01:39:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20267 invoked by uid 111); 14 Nov 2024 01:39:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2024 20:39:15 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Nov 2024 20:39:12 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/1] test-lib: move malloc-debug setup after $PATH setup
Message-ID: <20241114013912.GA1155455@coredump.intra.peff.net>
References: <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
 <CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
 <87msi85vc9.fsf@igel.home>
 <CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
 <Zy-IYwjb_RO5NW-s@teonanacatl.net>
 <20241109190012.GA588841@coredump.intra.peff.net>
 <xmqq7c9aihvx.fsf@gitster.g>
 <20241111070134.GA675125@coredump.intra.peff.net>
 <87zfm3iggu.fsf@iotcl.com>
 <20241114012729.GA1148710@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114012729.GA1148710@coredump.intra.peff.net>

Originally, the conditional definition of the setup/teardown functions
for malloc checking could be run at any time, because they depended only
on command-line options and the system getconf function.

But since 02d900361c (test-lib: check malloc debug LD_PRELOAD before
using, 2024-11-11), we probe the system by running "git version". Since
this code runs before we've set $PATH to point to the version of Git we
intend to test, we actually run the system version of git.

This mostly works, since what we really care about is whether the
LD_PRELOAD works, and it should work the same with any program. But
there are some corner cases:

  1. You might not have a system git at all, in which case the preload
     will appear to fail, even though it could work with the actual
     built version of git.

  2. Your system git could be linked in a different way. For example, if
     it was built statically, then it will ignore LD_PRELOAD entirely,
     and we might assume that the preload works, even though it might
     not when used with a dynamic build.

We could give a more complete path to the version of Git we intend to
test, but features like GIT_TEST_INSTALLED make that not entirely
trivial. So instead, let's just bump the setup until after we've set up
the $PATH. There's no need for us to do it early, as long as it is done
before the first test runs.

Reported-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Tested by removing "git" from my $PATH and checking whether it was used.
I didn't do a full test with the static version, but I confirmed that:

  gcc -static foo.c
  LD_PRELOAD=bogus.so ./a.out

does not complain.

 t/test-lib.sh | 100 +++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4fe757fe9a..6c60e8adae 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -577,56 +577,6 @@ case $GIT_TEST_FSYNC in
 	;;
 esac
 
-# Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
-# the test with valgrind and have not compiled with conflict SANITIZE
-# options.
-if test -n "$valgrind" ||
-   test -n "$SANITIZE_ADDRESS" ||
-   test -n "$SANITIZE_LEAK" ||
-   test -n "$TEST_NO_MALLOC_CHECK"
-then
-	setup_malloc_check () {
-		: nothing
-	}
-	teardown_malloc_check () {
-		: nothing
-	}
-else
-	_USE_GLIBC_TUNABLES=
-	_USE_GLIBC_PRELOAD=libc_malloc_debug.so.0
-	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
-	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
-	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null &&
-	   stderr=$(LD_PRELOAD=$_USE_GLIBC_PRELOAD git version 2>&1 >/dev/null) &&
-	   test -z "$stderr"
-	then
-		_USE_GLIBC_TUNABLES=YesPlease
-	fi
-	setup_malloc_check () {
-		local g
-		local t
-		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
-		export MALLOC_CHECK_ MALLOC_PERTURB_
-		if test -n "$_USE_GLIBC_TUNABLES"
-		then
-			g=
-			LD_PRELOAD=$_USE_GLIBC_PRELOAD
-			for t in \
-				glibc.malloc.check=1 \
-				glibc.malloc.perturb=165
-			do
-				g="${g#:}:$t"
-			done
-			GLIBC_TUNABLES=$g
-			export LD_PRELOAD GLIBC_TUNABLES
-		fi
-	}
-	teardown_malloc_check () {
-		unset MALLOC_CHECK_ MALLOC_PERTURB_
-		unset LD_PRELOAD GLIBC_TUNABLES
-	}
-fi
-
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
@@ -1486,6 +1436,56 @@ GIT_ATTR_NOSYSTEM=1
 GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
 
+# Add libc MALLOC and MALLOC_PERTURB test only if we are not executing
+# the test with valgrind and have not compiled with conflict SANITIZE
+# options.
+if test -n "$valgrind" ||
+   test -n "$SANITIZE_ADDRESS" ||
+   test -n "$SANITIZE_LEAK" ||
+   test -n "$TEST_NO_MALLOC_CHECK"
+then
+	setup_malloc_check () {
+		: nothing
+	}
+	teardown_malloc_check () {
+		: nothing
+	}
+else
+	_USE_GLIBC_TUNABLES=
+	_USE_GLIBC_PRELOAD=libc_malloc_debug.so.0
+	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
+	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
+	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null &&
+	   stderr=$(LD_PRELOAD=$_USE_GLIBC_PRELOAD git version 2>&1 >/dev/null) &&
+	   test -z "$stderr"
+	then
+		_USE_GLIBC_TUNABLES=YesPlease
+	fi
+	setup_malloc_check () {
+		local g
+		local t
+		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
+		export MALLOC_CHECK_ MALLOC_PERTURB_
+		if test -n "$_USE_GLIBC_TUNABLES"
+		then
+			g=
+			LD_PRELOAD=$_USE_GLIBC_PRELOAD
+			for t in \
+				glibc.malloc.check=1 \
+				glibc.malloc.perturb=165
+			do
+				g="${g#:}:$t"
+			done
+			GLIBC_TUNABLES=$g
+			export LD_PRELOAD GLIBC_TUNABLES
+		fi
+	}
+	teardown_malloc_check () {
+		unset MALLOC_CHECK_ MALLOC_PERTURB_
+		unset LD_PRELOAD GLIBC_TUNABLES
+	}
+fi
+
 if test -z "$GIT_TEST_CMP"
 then
 	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
-- 
2.47.0.527.gfb211c7f3b
