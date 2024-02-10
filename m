Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B147F4B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707607376; cv=none; b=bBpnhkji+7HBuoZGdy0fZfdHB2ASCL+iSheO1TST75GZ68dQvZzsTgTMiDiBIK2CU/c9wsvdFiSFvVhwWYairNYP7qBQ2B+csf+m0LpqLC0wnfRBHl9SYkHb+yufXcHl+dkgOYjsSRcAvasqFwfsza6h4cXiELwc34kdJOrYqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707607376; c=relaxed/simple;
	bh=Q4WaXpf3T0f/uZuMZ39k8UHUI/OGZo0bq6kuGxp2HX0=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOBxZr4mvjvwH6zxsirlwzhtNY2AibxOVRfkDg7mgmII4r8XZPcPL18Iu4lg9X/M6y6fDJ4DOHpyy0ZAoJLdMi8skZbUEci/Wko32fZLtT/4FjxnYAphxZlafF6+YperGRGoXzLNq7i9IWAi7LwkGcvo0ZQVz5sjC7B6O5DKpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41ANMqDs3323889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 23:22:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>
In-Reply-To: <000401da5c4c$fd4ad260$f7e07720$@nexbridge.com>
Subject: RE: [BUG] git 2.44.0-rc0 t0080.1 Breaks on NonStop x86 and ia64
Date: Sat, 10 Feb 2024 18:22:46 -0500
Organization: Nexbridge Inc.
Message-ID: <002301da5c78$11959ea0$34c0dbe0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEKhykLt/LB5hLsEaYKWm4eL/p/IrKj3vFw
Content-Language: en-ca

On Saturday, February 10, 2024 1:14 PM, I wrote:
>I encountered a new problem on git 2.44.0-rc0 for test t0080.1. Run very
verbose
>(--verbose -x):
>
>++ cat
>++ /home/randall/git/t/unit-tests/bin/t-basic
>++ test_cmp expect actual
>++ test 2 -ne 2
>++ eval 'diff -u' '"$@"'
>+++ diff -u expect actual
>--- expect      2024-02-10 18:04:28 +0000
>+++ actual      2024-02-10 18:04:28 +0000
>@@ -1,43 +1,43 @@
> ok 1 - passing test
> ok 2 - passing test and assertion return 1 -# check "1 == 2" failed at
t/unit-tests/t-
>basic.c:76
>+# check "1 == 2" failed at /home/randall/git/t/unit-tests/t-basic.c:76
> #    left: 1
> #   right: 2
> not ok 3 - failing test
> ok 4 - failing test and assertion return 0  not ok 5 - passing TEST_TODO()
# TODO
>ok 6 - passing TEST_TODO() returns 1 -# todo check 'check(x)' succeeded at
t/unit-
>tests/t-basic.c:25
>+# todo check 'check(x)' succeeded at
>/home/randall/git/t/unit-tests/t-basic.c:25
> not ok 7 - failing TEST_TODO()
> ok 8 - failing TEST_TODO() returns 0
>-# check "0" failed at t/unit-tests/t-basic.c:30
>+# check "0" failed at /home/randall/git/t/unit-tests/t-basic.c:30
> # skipping test - missing prerequisite
>-# skipping check '1' at t/unit-tests/t-basic.c:32
>+# skipping check '1' at /home/randall/git/t/unit-tests/t-basic.c:32
> ok 9 - test_skip() # SKIP
> ok 10 - skipped test returns 1
> # skipping test - missing prerequisite
> ok 11 - test_skip() inside TEST_TODO() # SKIP  ok 12 - test_skip() inside
>TEST_TODO() returns 1 -# check "0" failed at t/unit-tests/t-basic.c:48
>+# check "0" failed at /home/randall/git/t/unit-tests/t-basic.c:48
> not ok 13 - TEST_TODO() after failing check  ok 14 - TEST_TODO() after
failing check
>returns 0 -# check "0" failed at t/unit-tests/t-basic.c:56
>+# check "0" failed at /home/randall/git/t/unit-tests/t-basic.c:56
> not ok 15 - failing check after TEST_TODO()  ok 16 - failing check after
TEST_TODO()
>returns 0 -# check "!strcmp("\thello\\", "there\"\n")" failed at
>t/unit-tests/t-basic.c:61
>+# check "!strcmp("\thello\\", "there\"\n")" failed at
>/home/randall/git/t/unit-tests/t-basic.c:61
> #    left: "\011hello\\"
> #   right: "there\"\012"
>-# check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-basic.c:62
>+# check "!strcmp("NULL", NULL)" failed at
>/home/randall/git/t/unit-tests/t-basic.c:62
> #    left: "NULL"
> #   right: NULL
>-# check "'a' == '\n'" failed at t/unit-tests/t-basic.c:63
>+# check "'a' == '\n'" failed at
>+/home/randall/git/t/unit-tests/t-basic.c:63
> #    left: 'a'
> #   right: '\012'
>-# check "'\\' == '\''" failed at t/unit-tests/t-basic.c:64
>+# check "'\\' == '\''" failed at
>/home/randall/git/t/unit-tests/t-basic.c:64
> #    left: '\\'
> #   right: '\''
> not ok 17 - messages from failing string and char comparison -# BUG: test
has no
>checks at t/unit-tests/t-basic.c:91
>+# BUG: test has no checks at
>+/home/randall/git/t/unit-tests/t-basic.c:91
> not ok 18 - test with no checks
> ok 19 - test with no checks returns 0
> 1..19
>error: last command exited with $?=1
>
>The diff appears to have failed because of an assumption of how paths are
resolved
>during compilation. The assumption is that files remain partially
qualified, which is
>not the case in all C compilers. This is c99. My experience with gcc is
that it qualifies
>names differently than other compilers. It might be useful to pipe to sed
to strip
>${HOME}/ when building the actual file, something like:
>
>sed -i "1,\$s/${HOME}\//g" actual    # Not that that will actually work
>because sed will process /. A different delimiter would work.
>
>Randall

Putting the sed command in, as follows:

diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 6657c114a3..eaf25f2ddc 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -52,7 +52,7 @@ test_expect_success 'TAP output from unit tests' '
        1..19
        EOF

-       ! "$GIT_BUILD_DIR"/t/unit-tests/bin/t-basic >actual &&
+       ! "$GIT_BUILD_DIR"/t/unit-tests/bin/t-basic | sed "s?/.*/t/?t/?"
>actual &&
        test_cmp expect actual
 '

still results in a problem. The ! in the above line is being interpreted
incorrectly:

diff expect actual
27c27
< # check "!strcmp("\thello\\", "there"\n")" failed at
t/unit-tests/t-basic.c:61
---
> # check "!strcmp("\thello\\", "there\"\n")" failed at
t/unit-tests/t-basic.c:61
29c29
< #   right: "there"\012"
---
> #   right: "there\"\012"

I am not convinced the test is working properly. The ! appears to be causing
/bin/ksh to be invoked instead of bash. If I remove !, the test works
correctly. Did we not have issues with using ! in the past?

--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



