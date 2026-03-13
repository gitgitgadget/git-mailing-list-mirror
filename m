Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982472236FD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360993; cv=none; b=T/iU0hyjkymEUBMhpyHO0Q1ivkrT1gCYiCnV+kU0+k3RDCnCGHduv0zRg9SC72QdUnCxChXrGN137aYCaEYEF2kwJEGz0cUA+WouAa00ll+t3l4qziGi9fP2iQVeROi5bYLSZ+SIqLp3/xXBc4JXsNkho1q+u1YgBNHVXkEc/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360993; c=relaxed/simple;
	bh=J67bBhJWWZtKNTxykFhcZZCaQCmp1y+zG/n8zSdn6RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7q+P4YG5TO1HdkajRt3M+VeVd0c+llBC+JZTA17VEmGRnpBHVruhYwMOk9eyUyDDXSh8VK0/1CuHomAfljlN38acFDqn16zubuE6vsj+RUTrETvYMYaJgtit4A6Mh9m78s2qcFQqLVoQkSjqt7vz6kYZO7BX0SVFkRx73MT/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=b0Juu0vv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="b0Juu0vv"
Received: (qmail 94368 invoked by uid 106); 13 Mar 2026 00:16:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=J67bBhJWWZtKNTxykFhcZZCaQCmp1y+zG/n8zSdn6RU=; b=b0Juu0vvV0C9MmcR2WCWBoXTzpZDjo+SD+PuyMb1+IVodvW7hwikzHXROVDeEFvw4wPdiOTzZypQweDjy/t6v4DQms7iryZyXAoCXGwRwU0gqm/fjWz6xLN6IEr5xm8LABxa9gOFcZH/tIQ5kMdVrKFEpaF1+NJHEhVrufpGbCc/CmyD2l0gv6oljv125EtdvCthVq72lfOHy/ZqH18F10tq4gYwy9L1JY5MW2bmIxL1yNBfNmZQilYHHru12bLByHO8dnqsfX4SrUeUVnGCGpb+wWauv2VHEKu3m1OQve67r0em15xBuWvquz3nia1+6KB+munsC12ocew6toRAmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Mar 2026 00:16:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 517400 invoked by uid 111); 13 Mar 2026 00:16:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 20:16:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 20:16:29 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] apply.c: fix -p argument parsing
Message-ID: <20260313001629.GA3193660@coredump.intra.peff.net>
References: <20260310005408.2022216-1-mroik@delayed.space>
 <20260310050621.3849719-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310050621.3849719-1-mroik@delayed.space>

On Tue, Mar 10, 2026 at 06:06:15AM +0100, Mirko Faina wrote:

> diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
> index 697e86c0ff..3fdcfecc52 100755
> --- a/t/t4120-apply-popt.sh
> +++ b/t/t4120-apply-popt.sh
> @@ -23,6 +23,27 @@ test_expect_success setup '
>  	rmdir süb
>  '
>  
> +test_expect_success 'git apply -p 1 patch' '
> +	test_when_finished "rm -rf t" &&
> +	git apply -p 1 $TEST_DIRECTORY/t4120/patch &&
> +	test_path_is_dir t
> +'

This test seems to fail on Windows. From CI:

    ++ git apply -p 1 /d/a/git/git/t/t4120/patch
    error: git diff header lacks filename information when removing 1 leading pathname component (line 14)
    error: last command exited with $?=128

but I can't figure out why (and don't have a local Windows machine to
test on easily).

> diff --git a/t/t4120/patch b/t/t4120/patch

Not related to the failure, but IMHO we should keep small data like this
in the script itself, rather than as auxiliary files. The t/ directory
is already quite crowded, and it is often easier to refer to it when
it's near the tests themselves.

You don't even need the full email, just the patch part. (You might even
be able to reuse one of the other patches we make in the script, but I
didn't check).

Something like this would work. Note that it also gets rid of bare
references to $TEST_DIRECTORY, which really ought to be quoted (unlike
$TRASH_DIRECTORY, it does not always have a space, but it depends on
where somebody places their clone of git.git).


 t/t4120-apply-popt.sh | 16 ++++++++++++----
 t/t4120/patch         | 15 ---------------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 3fdcfecc52..0531a19ee8 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -23,25 +23,33 @@ test_expect_success setup '
 	rmdir süb
 '
 
+test_expect_success 'setup deep subdir patch' '
+	cat >patch.deep <<-\EOF
+	diff --git a/t/test/test b/t/test/test
+	new file mode 100644
+	index 0000000000..e69de29bb2
+	EOF
+'
+
 test_expect_success 'git apply -p 1 patch' '
 	test_when_finished "rm -rf t" &&
-	git apply -p 1 $TEST_DIRECTORY/t4120/patch &&
+	git apply -p 1 patch.deep &&
 	test_path_is_dir t
 '
 
 test_expect_success 'apply fails due to non-num -p' '
 	test_when_finished "rm -rf t test" &&
-	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4120/patch
+	test_must_fail git apply -p malformed patch.deep
 '
 
 test_expect_success 'apply fails due to trailing non-digit in -p' '
 	test_when_finished "rm -rf t test" &&
-	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4120/patch
+	test_must_fail git apply -p 2q patch.deep
 '
 
 test_expect_success 'apply fails due to negative number in -p' '
 	test_when_finished "rm -rf t test" &&
-	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4120/patch
+	test_must_fail git apply -p -1 patch.deep
 '
 
 test_expect_success 'apply git diff with -p2' '
diff --git a/t/t4120/patch b/t/t4120/patch
deleted file mode 100644
index bfccc708dd..0000000000
--- a/t/t4120/patch
+++ /dev/null
@@ -1,15 +0,0 @@
-From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
-From: Mroik <mroik@delayed.space>
-Date: Mon, 9 Mar 2026 23:25:00 +0100
-Subject: [PATCH] Test
-
----
- t/test/test | 0
- 1 file changed, 0 insertions(+), 0 deletions(-)
- create mode 100644 t/test/test
-
-diff --git a/t/test/test b/t/test/test
-new file mode 100644
-index 0000000000..e69de29bb2
---
-2.53.0.851.ga537e3e6e9
