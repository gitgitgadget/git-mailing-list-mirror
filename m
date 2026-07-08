Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813E35950
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469769; cv=none; b=FdmGFTXIiXX5iJ2IEpdZa+Pe/JpJtWDuSBGq1Tr/s4OZs4L+pN2FUNSDosugs7CRkEwrmwsJSlZ+YFyYih30EoEgwCR+o+Bv/bTFj8V8eCLciGLiKZdjhjA1Pes7J2+4elZzTFiTqnUvZIX5BmgwytQF4bomyLUj3UxiaNrCwls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469769; c=relaxed/simple;
	bh=flITXln0UQGk0nviquMgiHmIKBMBHwy5Atuj2DeID4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMhJFvP861wlhb96NA+AKMIMtMSOmMEiKTppltn+hQ4Vv+ZMY7XFqUkmNQakFtOccvJK4eunh9elrKy2qHkchpzYNcCsZxJfMUlJmjoBM7VdCMKi/Nc3qgpIW+H6qcuOT1rIEVzSzDbuc8qexm5CmnMwY/WOeWPigDZN4HdTqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QjjXkDV0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QjjXkDV0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783469766;
	bh=flITXln0UQGk0nviquMgiHmIKBMBHwy5Atuj2DeID4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=QjjXkDV0F2lpGiN2JVkLxMCFTwFR75zu9u2IidZS/Ger7kEvEPcNEMtkcUdRnJS3a
	 9y/M9iI/cah9WQdPQXzdP6cHDDpdAONhREeCb6JpK1ml1tuwM/BrI2ftrqw4Orb7mb
	 y2HQA7A3D6MRy5JyI+s8RHNQK8SGz8cSgQlQISlWQMTzLrRnWD+YwdXZbhSJOrfZXE
	 qllW6dEidZVh8w9sMDk+NTky0NLVO2p6+DYBXtToVHf51t7bmZlNX4ZTNZSYfbSQtm
	 hJoPz85nfYmSoDTEzU/ndN6MzV2sUSiOEyRD6RlfVkg66ZJ8S6r0NgLbnHJJPYhiuy
	 hq17u0FGufQx/F+nBCtZe85Q+Th8ENpEnRLJfV1AGf1oMBLLHd3woVHfYPVe3NGrTW
	 pSW9+SdOOjIeHirQ8mUfIOwhf1JHigbxMH3M2gqPzUEVD2DU++yWBjvLIxOt/adZ7e
	 U4GmIRPJtZ9rTz5/O3Npt0v6SANuaQt93Uesv+vsCGmCdFKPF3d
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9470:51ef:86dd:bc22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 997F7201DD;
	Wed,  8 Jul 2026 00:16:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] rev-parse: have --parseopt callers exit 0 on --help
Date: Wed,  8 Jul 2026 00:15:56 +0000
Message-ID: <20260708001557.3581080-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260708001557.3581080-1-sandals@crustytoothpaste.net>
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260708001557.3581080-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The standard philosophy for Unix software when a help option (such as
--help) is specified is that the software should exit 0, printing the
help output to standard output, since the standard output is for
user-requested output and the program performed the requested task
successfully.  If the user specifies an incorrect option, then the help
output should be printed to standard error (since the user has made a
mistake) and it should exit unsuccessfully.

git rev-parse --parseopt properly directs the output in both of these
cases, but it currently exits 129 when it receives a --help or -h option
on the command line, which causes its invoking script to do the same.
This is not in line with the usual behavior and it causes scripts using
this command to exit unsuccessfully on --help as well.

Note that Git subcommands implemented using scripts, such as git
submodule, don't have this problem because Git itself intercepts the
--help option and runs man (or a similar tool), which then exits 0.
However, this still affects the myriad scripts that use this
functionality because Git is widespread and the --parseopt functionality
is a good way to get sensible option parsing across shells in a portable
way.

Because git rev-parse --parseopt is intended to be eval'd by the shell,
when help output is to be printed to standard output, Git actually
prints a cat command with a heredoc since the standard output is being
evaluated by the shell.  Thus, to do the right thing, simply add an
"exit 0" right after the end of the heredoc, which will cause the
invoking program to exit successfully.

The usual invocation recommended by the manual page is this:

    eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"

Thus, the fact that git rev-parse --parseopt still exits 129 in this
case is irrelevant, since the "echo exit $?" will print "exit 129", but
that will be after the "exit 0" printed by Git—and thus ignored, since
the shell will have already exited successfully.

Update the tests for this case.  Note that we no longer need to delete
only the first and last lines in some tests, so add a command to delete
the end of the heredoc as well.  We could do something clever with sed
to delete all but the last two lines or switch to head and tail, but
those would be more complicated and less readable, so just stick with
the simple approach.

In t1517, add three shell scripts to the failure case because they no
longer return 129 as expected.  In a future commit, we'll change the
expected result to exit 0 and these will become successful again.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 parse-options.c               | 2 +-
 t/t1502-rev-parse-parseopt.sh | 9 +++++++--
 t/t1502/optionspec-neg.help   | 1 +
 t/t1502/optionspec.help       | 1 +
 t/t1517-outside-repo.sh       | 6 +++---
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index fd8ceed82b..cc3a8b0fe3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1479,7 +1479,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	fputc('\n', outfile);
 
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
-		fputs("EOF\n", outfile);
+		fputs("EOF\nexit 0\n", outfile);
 
 	return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
 }
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 3962f1d288..455608c429 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -12,7 +12,7 @@ check_invalid_long_option () {
 			cat <<-\EOF &&
 			error: unknown option `'${opt#--}\''
 			EOF
-			sed -e 1d -e \$d <"$TEST_DIRECTORY/t1502/$spec.help"
+			sed -e 1d -e /EOF/d -e \$d <"$TEST_DIRECTORY/t1502/$spec.help"
 		} >expect &&
 		test_expect_code 129 git rev-parse --parseopt -- $opt \
 			2>output <"$TEST_DIRECTORY/t1502/$spec" &&
@@ -87,6 +87,7 @@ test_expect_success 'test --parseopt help output no switches' '
 |    some-command does foo and bar!
 |
 |EOF
+|exit 0
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
 	test_cmp expect output
@@ -100,6 +101,7 @@ test_expect_success 'test --parseopt help output hidden switches' '
 |    some-command does foo and bar!
 |
 |EOF
+|exit 0
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
 	test_cmp expect output
@@ -115,6 +117,7 @@ test_expect_success 'test --parseopt help-all output hidden switches' '
 |    --[no-]hidden1        A hidden switch
 |
 |EOF
+|exit 0
 END_EXPECT
 	test_expect_code 129 git rev-parse --parseopt -- --help-all > output < optionspec_only_hidden_switches &&
 	test_cmp expect output
@@ -125,7 +128,7 @@ test_expect_success 'test --parseopt invalid switch help output' '
 		cat <<-\EOF &&
 		error: unknown option `does-not-exist'\''
 		EOF
-		sed -e 1d -e \$d <"$TEST_DIRECTORY/t1502/optionspec.help"
+		sed -e 1d -e /EOF/d -e \$d <"$TEST_DIRECTORY/t1502/optionspec.help"
 	} >expect &&
 	test_expect_code 129 git rev-parse --parseopt -- --does-not-exist 1>/dev/null 2>output < optionspec &&
 	test_cmp expect output
@@ -252,6 +255,7 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
 	|    -h, --help            show the help
 	|
 	|EOF
+	|exit 0
 	END_EXPECT
 
 	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
@@ -289,6 +293,7 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
 	|    -h, --help            show the help
 	|
 	|EOF
+	|exit 0
 	END_EXPECT
 
 	test_must_fail git rev-parse --parseopt -- -h <spec >actual &&
diff --git a/t/t1502/optionspec-neg.help b/t/t1502/optionspec-neg.help
index 7a29f8cb03..f85be7b8fd 100644
--- a/t/t1502/optionspec-neg.help
+++ b/t/t1502/optionspec-neg.help
@@ -10,3 +10,4 @@ usage: some-command [options] <args>...
     --no-negative         cannot be positivated
 
 EOF
+exit 0
diff --git a/t/t1502/optionspec.help b/t/t1502/optionspec.help
index cbdd54d41b..ded35ebc82 100755
--- a/t/t1502/optionspec.help
+++ b/t/t1502/optionspec.help
@@ -34,3 +34,4 @@ Extras
     --[no-]extra1         line above used to cause a segfault but no longer does
 
 EOF
+exit 0
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6421bdb3c3..03fa2f9cdf 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -132,10 +132,10 @@ do
 	difftool--helper | filter-branch | format-rev | fsck-objects | \
 	get-tar-commit-id | \
 	gui | gui--askpass | \
-	http-backend | http-fetch | http-push | init-db | \
+	http-backend | http-fetch | http-push | init-db | instaweb | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
-	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
-	remote-http | remote-https | replay | send-email | \
+	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | request-pull | send-email | \
 	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
 	upload-archive--writer | upload-pack | web--browse | whatchanged)
 		expect_outcome=expect_failure ;;
