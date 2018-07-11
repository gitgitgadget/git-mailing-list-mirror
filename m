Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4E11F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeGKGu5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:57 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37237 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeGKGuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:54 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so22640784ioh.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbaGeBclDBkkR5UrEA3AAsEbgYPonDrYN5knEFGP1ww=;
        b=bzxo7yAzz7/p4bRzxzjtfmDDZe2MzEiu5ta0ok/aYeHUbrsA7xE6HWIVirZYk+u/0B
         rma5Bmfn9HKyr2etBmV8k9xLwbRWHuXhpO1TUIpF5o4SZzmiIUp5mDyhMEGZLII600HD
         0WyAm4O8DvV1jMO2XpjQg6ChLchQOh68eIPrKSlmn1cNA0YNWsZcZ8T7w8I43yYhOsIB
         6X9MRnVtU7ItR+ZGTCNYkBKIINxqY47gdDoAsDPZfqqSaSNJnKD/6igmR38XysHm77GW
         xmh5LDwpV4gDu5b56Fx9tvLEnLoP5qVxpRMKxMsAFClx1cTvvS4rWZ/LM7vbMkHwzHmH
         QEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=cbaGeBclDBkkR5UrEA3AAsEbgYPonDrYN5knEFGP1ww=;
        b=IntRqbcCEURFvov5euLLZrUaFX02Ms8+aVV+J2EEbFGbWwu3EkTewMc5x0o+UP7hJg
         nps+n45Equecm2suXpUc9IkXlEdKYLWhPgf62cu1HDAIePq2YcsJoxuY6H3K2wJG9D8u
         NtqZ7c9ONYwjAn8lEdoNzEH+Bv0gcq3/Q8cuY28Dm4hromHeg7Su8sudh6sNWj51mCND
         DsOEwLIvyMElaqANSeWcsGhgPApuQT1bdMbDyd9YHV6WBGNaUd92Mhra+5UpOp+TO7tl
         av6+0NfyBgJO8mPkZe6w0MAeA/9/mdRmGt3JVHP83gnUm8sy+K6tF8yOmghbXttSml13
         x0Ig==
X-Gm-Message-State: AOUpUlEdSNSgNqKv719st56mYTjEFNSLhP0TpccLdBi7ub2CGvVs2CYU
        1iq2ak+v9sncifI5Rbs+/2E5Tw==
X-Google-Smtp-Source: AAOMgpfZE4RSmaDUdbPcH2MR+JcrO2YN9ly7q3+m+NA6JmzyIknV75fWAmiaJYc7M14Qw/V5agx7bw==
X-Received: by 2002:a5e:8b47:: with SMTP id z7-v6mr3160770iom.144.1531291688205;
        Tue, 10 Jul 2018 23:48:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/10] t/chainlint: add chainlint "loop" and "conditional" test cases
Date:   Wed, 11 Jul 2018 02:46:39 -0400
Message-Id: <20180711064642.6933-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180711064642.6933-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --chain-lint option uses heuristics and knowledge of shell syntax to
detect broken &&-chains in subshells by pure textual inspection. The
heuristics handle a range of stylistic variations in existing tests
(evolved over the years), however, they are still best-guesses. As such,
it is possible for future changes to accidentally break assumptions upon
which the heuristics are based. Protect against this possibility by
adding tests which check the linter itself for correctness.

In addition to protecting against regressions, these tests help document
(for humans) expected behavior, which is important since the linter's
implementation language ('sed') does not necessarily lend itself to easy
comprehension.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/case.expect         | 19 +++++++++++++++++++
 t/chainlint/case.test           | 23 +++++++++++++++++++++++
 t/chainlint/exit-loop.expect    | 24 ++++++++++++++++++++++++
 t/chainlint/exit-loop.test      | 27 +++++++++++++++++++++++++++
 t/chainlint/for-loop.expect     | 11 +++++++++++
 t/chainlint/for-loop.test       | 19 +++++++++++++++++++
 t/chainlint/if-then-else.expect | 19 +++++++++++++++++++
 t/chainlint/if-then-else.test   | 28 ++++++++++++++++++++++++++++
 t/chainlint/while-loop.expect   | 11 +++++++++++
 t/chainlint/while-loop.test     | 19 +++++++++++++++++++
 10 files changed, 200 insertions(+)
 create mode 100644 t/chainlint/case.expect
 create mode 100644 t/chainlint/case.test
 create mode 100644 t/chainlint/exit-loop.expect
 create mode 100644 t/chainlint/exit-loop.test
 create mode 100644 t/chainlint/for-loop.expect
 create mode 100644 t/chainlint/for-loop.test
 create mode 100644 t/chainlint/if-then-else.expect
 create mode 100644 t/chainlint/if-then-else.test
 create mode 100644 t/chainlint/while-loop.expect
 create mode 100644 t/chainlint/while-loop.test

diff --git a/t/chainlint/case.expect b/t/chainlint/case.expect
new file mode 100644
index 0000000000..41f121fbbf
--- /dev/null
+++ b/t/chainlint/case.expect
@@ -0,0 +1,19 @@
+(
+	case "$x" in
+	x) foo ;;
+	*) bar ;;
+	esac &&
+	foobar
+>) &&
+(
+	case "$x" in
+	x) foo ;;
+	*) bar ;;
+?!AMP?!	esac
+	foobar
+>) &&
+(
+	case "$x" in 1) true;; esac &&
+?!AMP?!	case "$y" in 2) false;; esac
+	foobar
+>)
diff --git a/t/chainlint/case.test b/t/chainlint/case.test
new file mode 100644
index 0000000000..5ef6ff7db5
--- /dev/null
+++ b/t/chainlint/case.test
@@ -0,0 +1,23 @@
+(
+# LINT: "...)" arms in 'case' not misinterpreted as subshell-closing ")"
+	case "$x" in
+	x) foo ;;
+	*) bar ;;
+	esac &&
+	foobar
+) &&
+(
+# LINT: missing "&&" on 'esac'
+	case "$x" in
+	x) foo ;;
+	*) bar ;;
+	esac
+	foobar
+) &&
+(
+# LINT: "...)" arm in one-liner 'case' not misinterpreted as closing ")"
+	case "$x" in 1) true;; esac &&
+# LINT: same but missing "&&"
+	case "$y" in 2) false;; esac
+	foobar
+)
diff --git a/t/chainlint/exit-loop.expect b/t/chainlint/exit-loop.expect
new file mode 100644
index 0000000000..84d8bdebc0
--- /dev/null
+++ b/t/chainlint/exit-loop.expect
@@ -0,0 +1,24 @@
+(
+	for i in a b c
+	do
+		foo || exit 1
+		bar &&
+		baz
+	done
+>) &&
+(
+	while true
+	do
+		foo || exit 1
+		bar &&
+		baz
+	done
+>) &&
+(
+	i=0 &&
+	while test $i -lt 10
+	do
+		echo $i || exit
+		i=$(($i + 1))
+	done
+>)
diff --git a/t/chainlint/exit-loop.test b/t/chainlint/exit-loop.test
new file mode 100644
index 0000000000..2f038207e1
--- /dev/null
+++ b/t/chainlint/exit-loop.test
@@ -0,0 +1,27 @@
+(
+	for i in a b c
+	do
+# LINT: "|| exit {n}" valid for-loop escape in subshell; no "&&" needed
+		foo || exit 1
+		bar &&
+		baz
+	done
+) &&
+(
+	while true
+	do
+# LINT: "|| exit {n}" valid while-loop escape in subshell; no "&&" needed
+		foo || exit 1
+		bar &&
+		baz
+	done
+) &&
+(
+	i=0 &&
+	while test $i -lt 10
+	do
+# LINT: "|| exit" (sans exit code) valid escape in subshell; no "&&" needed
+		echo $i || exit
+		i=$(($i + 1))
+	done
+)
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
new file mode 100644
index 0000000000..c33cf56ee7
--- /dev/null
+++ b/t/chainlint/for-loop.expect
@@ -0,0 +1,11 @@
+(
+	for i in a b c
+	do
+?!AMP?!		echo $i
+		cat
+?!AMP?!	done
+	for i in a b c; do
+		echo $i &&
+		cat $i
+	done
+>)
diff --git a/t/chainlint/for-loop.test b/t/chainlint/for-loop.test
new file mode 100644
index 0000000000..7db76262bc
--- /dev/null
+++ b/t/chainlint/for-loop.test
@@ -0,0 +1,19 @@
+(
+# LINT: 'for', 'do', 'done' do not need "&&"
+	for i in a b c
+	do
+# LINT: missing "&&" on 'echo'
+		echo $i
+# LINT: last statement of while does not need "&&"
+		cat <<-\EOF
+		bar
+		EOF
+# LINT: missing "&&" on 'done'
+	done
+
+# LINT: 'do' on same line as 'for'
+	for i in a b c; do
+		echo $i &&
+		cat $i
+	done
+)
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
new file mode 100644
index 0000000000..5953c7bfbc
--- /dev/null
+++ b/t/chainlint/if-then-else.expect
@@ -0,0 +1,19 @@
+(
+	if test -n ""
+	then
+?!AMP?!		echo very
+		echo empty
+	elif test -z ""
+		echo foo
+	else
+		echo foo &&
+		cat
+?!AMP?!	fi
+	echo poodle
+>) &&
+(
+	if test -n ""; then
+		echo very &&
+?!AMP?!		echo empty
+	if
+>)
diff --git a/t/chainlint/if-then-else.test b/t/chainlint/if-then-else.test
new file mode 100644
index 0000000000..9bd8e9a4c6
--- /dev/null
+++ b/t/chainlint/if-then-else.test
@@ -0,0 +1,28 @@
+(
+# LINT: 'if', 'then', 'elif', 'else', 'fi' do not need "&&"
+	if test -n ""
+	then
+# LINT: missing "&&" on 'echo'
+		echo very
+# LINT: last statement before 'elif' does not need "&&"
+		echo empty
+	elif test -z ""
+# LINT: last statement before 'else' does not need "&&"
+		echo foo
+	else
+		echo foo &&
+# LINT: last statement before 'fi' does not need "&&"
+		cat <<-\EOF
+		bar
+		EOF
+# LINT: missing "&&" on 'fi'
+	fi
+	echo poodle
+) &&
+(
+# LINT: 'then' on same line as 'if'
+	if test -n ""; then
+		echo very &&
+		echo empty
+	if
+)
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
new file mode 100644
index 0000000000..13cff2c0a5
--- /dev/null
+++ b/t/chainlint/while-loop.expect
@@ -0,0 +1,11 @@
+(
+	while true
+	do
+?!AMP?!		echo foo
+		cat
+?!AMP?!	done
+	while true; do
+		echo foo &&
+		cat bar
+	done
+>)
diff --git a/t/chainlint/while-loop.test b/t/chainlint/while-loop.test
new file mode 100644
index 0000000000..f1df085bf0
--- /dev/null
+++ b/t/chainlint/while-loop.test
@@ -0,0 +1,19 @@
+(
+# LINT: 'while, 'do', 'done' do not need "&&"
+	while true
+	do
+# LINT: missing "&&" on 'echo'
+		echo foo
+# LINT: last statement of while does not need "&&"
+		cat <<-\EOF
+		bar
+		EOF
+# LINT: missing "&&" on 'done'
+	done
+
+# LINT: 'do' on same line as 'while'
+	while true; do
+		echo foo &&
+		cat bar
+	done
+)
-- 
2.18.0.203.gfac676dfb9

