Received: from impout003.msg.chrl.nc.charter.net (impout003aa.msg.chrl.nc.charter.net [47.43.20.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222E17625D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981873; cv=none; b=lh8GGDharj0ENyBsXm5aXG1meuF31ECA2lQvIP9EfegH0O1d1HBS0SUVkGjjipJXCq/Q4CHr1sZO3KBcd+JO09a272ZgfiNjl2jYeXqR11gkgPQorhCaPkDQCxyBBuf5jF7nfyJZBXSg7bGb6LBz16E0WeQWYh/dHKRNRBhmtoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981873; c=relaxed/simple;
	bh=8pku5jmEztSx85iiShzmfWqLZnynkuhvxG6YMBjpBmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko8Tu3Q3zWxkYT1BbYdK80uosrfm9tT1ad5+2sUh87Got9wWhSA2cJRs9RwTsRNVMymNCmteUmF6Wyr6OZY0fnHfPKGF5qqcPxruGwTM4zOh82qMJMbdzBkqayq9yVSgUllzRkpEVuTW18zKZpkQ6AYXfZw1N0WlLAR3GNmr/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=iIskMt6C; arc=none smtp.client-ip=47.43.20.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="iIskMt6C"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id XG7MsyipKvFCWXG7YsRqix; Fri, 26 Jul 2024 08:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721981773;
	bh=8pku5jmEztSx85iiShzmfWqLZnynkuhvxG6YMBjpBmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iIskMt6CBiM3RKwzyob1wAvHXhUkgTLqZFHVDInSApkGhBbprqEsHU9aT+npRIy7w
	 j4y7qf3xYw6Dj9IcYV73L3nwUdnklgLBUKcdVWhF3mwWtNoCNmQlS+63v/l3CoZkHD
	 2ZSdcPNC2CcXdUrrrVowtQW8iGvJngPeon3HwGzDsPXK8Ln6wVbsCy0yowSWT0Eb6N
	 K+m6D2fQDH3m597S3KO/dXNTRUY0OYLbL/wtIWBO/IziExP+O8gCYU1XUsTXsCRD3N
	 xZfAZncDgkv26rdiPCFUNnGkhLXk+MFc/iU+uaMSSVY1FoCP485s6wwgyp9nky7EpY
	 IR50OIRGauQqw==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=O+w/vg9W c=1 sm=1 tr=0 ts=66a35b4d
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=hOpmn2quAAAA:8 a=A1X0JdhQAAAA:8 a=f02pLfhIjOB6mNUTFNsA:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=AjGcO6oz07-iQ99wixmX:22 a=Df3jFdWbhGDLdZNm0fyq:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] improve one-shot variable detection with shell function
Date: Fri, 26 Jul 2024 04:15:17 -0400
Message-ID: <20240726081522.28015-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722065915.80760-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIRDs6Davw2aWHZtwOmj7fCu2dRTcTfecn094yLQcuIHWLubkDiIfVughfkcgbqQhkjMCvT6vwtT02OzPDBBnin0vqgBPhYDKbWyGgGRoxg/ti/Cx0+w
 bfkCBcItcolPIrBEzmjVB55kS0GYWkIj2HEdfBguVxCWQbCXZJxA3gDOmVfkWK7MGk5XX6+SwVV9UL0GfRo0/z8f9xmb1gxiuig6FvGTaRgInCed72SgcLUE
 BKFjYWBSVnvmKl4u2PjxydS/jbGlOfFYJDwG6aooKBhyp76uuKEWBD8HWvbhlU9qGMjWpAe7e9EZM5L37ohBprtRDnhxDlNbgtqWZV+Hv7OOz5qB/oKfMjX7
 ms0BJPG2

From: Eric Sunshine <sunshine@sunshineco.com>

This is a reroll of [1] which improves check-non-portable-shell's
detection of one-shot environment variable assignment with shell
functions. Changes since v1:

* commit messages now state the behavior is undefined according to POSIX
  rather than focusing only on the original reason given (that the
  assignments could outlive the shell function invocation)

* t3430 simplified by dropping the subshell altogether in favor of
  `test_commit --author`

* new commit to improve the error message when one-shot assignment with
  shell function is detected

[1]: https://lore.kernel.org/git/20240722065915.80760-1-ericsunshine@charter.net/

Eric Sunshine (5):
  t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
  t4034: fix use of one-shot variable assignment with shell function
  check-non-portable-shell: loosen one-shot assignment error message
  check-non-portable-shell: suggest alternative for `VAR=val shell-func`
  check-non-portable-shell: improve `VAR=val shell-func` detection

 t/check-non-portable-shell.pl | 4 ++--
 t/t3430-rebase-merges.sh      | 3 +--
 t/t4034-diff-words.sh         | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  5bb6811f68 ! 1:  0d3c0593c9 t3430: modernize one-shot "VAR=val shell-func" invocation
    @@ Metadata
     Author: Eric Sunshine <sunshine@sunshineco.com>
     
      ## Commit message ##
    -    t3430: modernize one-shot "VAR=val shell-func" invocation
    +    t3430: drop unnecessary one-shot "VAR=val shell-func" invocation
     
    -    Unlike "VAR=val cmd" one-shot environment variable assignments which
    -    exist only for the invocation of 'cmd', those assigned by "VAR=val
    -    shell-func" exist within the running shell and continue to do so until
    -    the process exits (or are explicitly unset). check-non-portable-shell.pl
    -    warns when it detects such usage since, more often than not, the author
    -    who writes such an invocation is unaware of the undesirable behavior.
    +    The behavior of a one-shot environment variable assignment of the form
    +    "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
    +    function. Indeed the behavior differs between shell implementations and
    +    even different versions of the same shell. One such ill-defined behavior
    +    is that, with some shells, the assignment will outlive the invocation of
    +    the function, thus may potentially impact subsequent commands in the
    +    test, as well as subsequent tests. A common way to work around the
    +    problem is to wrap a subshell around the one-shot assignment, thus
    +    ensuring that the assignment is short-lived.
     
    -    A common way to work around the problem is to wrap a subshell around the
    -    variable assignments and function call, thus ensuring that the
    -    assignments are short-lived. However, these days, a more ergonomic
    -    approach is to employ test_env() which is tailor-made for this specific
    -    use-case.
    +    In this test, the subshell is employed precisely for this purpose; other
    +    side-effects of the subshell, such as losing the effect of `test_tick`
    +    which is invoked by `test_commit`, are immaterial.
    +
    +    These days, we can take advantage of `test_commit --author` to more
    +    clearly convey that the test is interested only in overriding the author
    +    of the commit.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
    @@ t/t3430-rebase-merges.sh: test_expect_success 'refuse to merge ancestors of HEAD
      	git checkout --orphan unrelated &&
     -	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
     -	 test_commit second-root) &&
    -+	test_env GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
    -+		test_commit second-root &&
    ++	test_commit --author "Parsnip <root@example.com>" second-root &&
      	test_commit third-root &&
      	cat >script-from-scratch <<-\EOF &&
      	pick third-root
2:  1f35449847 ! 2:  19ee8295ef t4034: fix use of one-shot variable assignment with shell function
    @@ Metadata
      ## Commit message ##
         t4034: fix use of one-shot variable assignment with shell function
     
    -    Unlike "VAR=val cmd" one-shot environment variable assignments which
    -    exist only for the invocation of 'cmd', those assigned by "VAR=val
    -    shell-func" exist within the running shell and continue to do so until
    -    the process exits (or are explicitly unset). In most cases, it is
    -    unlikely that this behavior was intended by the test author, and, even
    -    if those leaked assignments do not impact other tests today, they can
    -    negatively impact tests added later by authors unaware that the variable
    -    assignments are still hanging around. Address this shortcoming by
    -    ensuring that the assignments are short-lived.
    +    The behavior of a one-shot environment variable assignment of the form
    +    "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
    +    function. Indeed the behavior differs between shell implementations and
    +    even different versions of the same shell, thus should be avoided.
     
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
-:  ---------- > 3:  220ca26d4f check-non-portable-shell: loosen one-shot assignment error message
-:  ---------- > 4:  4910756aab check-non-portable-shell: suggest alternative for `VAR=val shell-func`
3:  89621f72a2 ! 5:  7a15553a5a check-non-portable-shell: improve `VAR=val shell-func` detection
    @@ Metadata
      ## Commit message ##
         check-non-portable-shell: improve `VAR=val shell-func` detection
     
    -    Unlike "VAR=val cmd" one-shot environment variable assignments which
    -    exist only for the invocation of 'cmd', those assigned by "VAR=val
    -    shell-func" exist within the running shell and continue to do so until
    -    the process exits. check-non-portable-shell.pl warns when it detects
    -    such usage since, more often than not, the author who writes such an
    -    invocation is unaware of the undesirable behavior.
    +    The behavior of a one-shot environment variable assignment of the form
    +    "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell
    +    function. Indeed the behavior differs between shell implementations and
    +    even different versions of the same shell, thus should be avoided.
     
    +    As such, check-non-portable-shell.pl warns when it detects such usage.
         However, a limitation of the check is that it only detects such
    -    invocations when variable assignment (i.e. `VAR=val`) is the first
    -    thing on the line. Thus, it can easily be fooled by an invocation such
    -    as:
    +    invocations when variable assignment (i.e. `VAR=val`) is the first thing
    +    on the line. Thus, it can easily be fooled by an invocation such as:
     
             echo X | VAR=val shell-func
     
    @@ t/check-non-portable-shell.pl: sub err {
      		err q(quote "$val" in 'local var=$val');
     -	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
     +	/\b([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and !/test_env.+=/ and exists($func{$4}) and
    - 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
    + 		err '"FOO=bar shell_func" is not portable (use test_env FOO=bar shell_func)';
      	$line = '';
      	# this resets our $. for each file
4:  7b2e1dd895 < -:  ---------- check-non-portable-shell: suggest alternative for `VAR=val shell-func`
-- 
2.45.2

