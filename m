Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6331F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeGKGux (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40869 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeGKGux (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:53 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so12689307iob.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzTAdZxPqMoDk2BBmh87gjorArldYvPq06/QtiPpGmM=;
        b=Zl+10znyaN5laGeKf4/8CJ6TnYLqz1RnDYjXvDH6aVgQEWytRnYTDaqNPb2T/dTegg
         uOmaYbRwvlftE4gWCF/WzprjeYVPwvIN0DM4cqRWtHnWBxRyKigIAgZ/swE8IEiT4JTX
         5ZbHjDvujl5oDFRxCEJiQt0U4gOsl1r8RUNdH76PFeesO5Kyqg44+kAMStgy4RCyo6TU
         3ApJIs5tewmoz+yjI0I6LgDrkBEh0oolVj5RvtnbNElwH4OCHNnKSxM5RPIRM08UT4Xt
         JW3zbPkDkOWo1nQ0NDLT1/XZxrYhBzi5lpBQAoFc0/QuXC6K9FFddDd3bx/14SXkVy+r
         yIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=GzTAdZxPqMoDk2BBmh87gjorArldYvPq06/QtiPpGmM=;
        b=tKG0hIE9aTeHQryAOm5lAKI+cjJk4GuGMZVwrC/bpkjDNvgkBSEUPX+QJhyw90mce7
         p+boaJ82a00S2k+mnSf8XmxtIFfEFii07JFLiwO+vzJo47pFgWK4Jm3RHYsyd54pmpIT
         yIBXWmqj3MV5AWK4iHitGEL+voa5n3WBKMF19bgg3Ew42FE0TKcjJs3+aikG/QPe9PQD
         XReW2lbImJ1wfvlOQhBxWCX8FpKegTM8QQAKV9o3vA5IBDGhqeGlGb2MrjRnj2inh+al
         EkyCZk5rVRimCCIbRMYTuZx76fdkXo956TYRP/K4810A5PnvWBd7uuCfLLha02+Q4j+Y
         kNSQ==
X-Gm-Message-State: APt69E0s6l3Ijv4XQs/y3p6bpsocn36EMr86UcjGDxKu4XzOC+lIEhkF
        5RScatpoaaG0vWxK5XtWO/e+wQ==
X-Google-Smtp-Source: AAOMgpcJqyhOkZREHJ3E8O1ZMirgJBIQ6uugHAEpvjS3/BhlSYDmPIuE0TMO3xPml1Z/yeJQXxaOcw==
X-Received: by 2002:a6b:df4a:: with SMTP id d10-v6mr23984077iop.152.1531291687281;
        Tue, 10 Jul 2018 23:48:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/10] t/chainlint: add chainlint "nested subshell" test cases
Date:   Wed, 11 Jul 2018 02:46:38 -0400
Message-Id: <20180711064642.6933-7-sunshine@sunshineco.com>
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
 t/chainlint/block.expect                      | 12 +++++++
 t/chainlint/block.test                        | 15 +++++++++
 ...ti-line-nested-command-substitution.expect |  9 ++++++
 ...ulti-line-nested-command-substitution.test |  9 ++++++
 t/chainlint/nested-cuddled-subshell.expect    | 19 ++++++++++++
 t/chainlint/nested-cuddled-subshell.test      | 31 +++++++++++++++++++
 t/chainlint/nested-here-doc.expect            |  5 +++
 t/chainlint/nested-here-doc.test              | 23 ++++++++++++++
 t/chainlint/nested-subshell-comment.expect    | 11 +++++++
 t/chainlint/nested-subshell-comment.test      | 13 ++++++++
 t/chainlint/nested-subshell.expect            | 12 +++++++
 t/chainlint/nested-subshell.test              | 14 +++++++++
 12 files changed, 173 insertions(+)
 create mode 100644 t/chainlint/block.expect
 create mode 100644 t/chainlint/block.test
 create mode 100644 t/chainlint/multi-line-nested-command-substitution.expect
 create mode 100644 t/chainlint/multi-line-nested-command-substitution.test
 create mode 100644 t/chainlint/nested-cuddled-subshell.expect
 create mode 100644 t/chainlint/nested-cuddled-subshell.test
 create mode 100644 t/chainlint/nested-here-doc.expect
 create mode 100644 t/chainlint/nested-here-doc.test
 create mode 100644 t/chainlint/nested-subshell-comment.expect
 create mode 100644 t/chainlint/nested-subshell-comment.test
 create mode 100644 t/chainlint/nested-subshell.expect
 create mode 100644 t/chainlint/nested-subshell.test

diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
new file mode 100644
index 0000000000..fed7e89ae8
--- /dev/null
+++ b/t/chainlint/block.expect
@@ -0,0 +1,12 @@
+(
+	foo &&
+	{
+		echo a
+		echo b
+	} &&
+	bar &&
+	{
+		echo c
+?!AMP?!	}
+	baz
+>)
diff --git a/t/chainlint/block.test b/t/chainlint/block.test
new file mode 100644
index 0000000000..d859151af1
--- /dev/null
+++ b/t/chainlint/block.test
@@ -0,0 +1,15 @@
+(
+# LINT: missing "&&" in block not currently detected (for consistency with
+# LINT: --chain-lint at top level and to provide escape hatch if needed)
+	foo &&
+	{
+		echo a
+		echo b
+	} &&
+	bar &&
+# LINT: missing "&&" at closing "}"
+	{
+		echo c
+	}
+	baz
+)
diff --git a/t/chainlint/multi-line-nested-command-substitution.expect b/t/chainlint/multi-line-nested-command-substitution.expect
new file mode 100644
index 0000000000..19c023b1c8
--- /dev/null
+++ b/t/chainlint/multi-line-nested-command-substitution.expect
@@ -0,0 +1,9 @@
+(
+	foo &&
+	x=$(
+		echo bar |
+		cat
+>>	) &&
+	echo ok
+>) |
+sort
diff --git a/t/chainlint/multi-line-nested-command-substitution.test b/t/chainlint/multi-line-nested-command-substitution.test
new file mode 100644
index 0000000000..ca0620ab6b
--- /dev/null
+++ b/t/chainlint/multi-line-nested-command-substitution.test
@@ -0,0 +1,9 @@
+(
+	foo &&
+	x=$(
+		echo bar |
+		cat
+	) &&
+	echo ok
+) |
+sort
diff --git a/t/chainlint/nested-cuddled-subshell.expect b/t/chainlint/nested-cuddled-subshell.expect
new file mode 100644
index 0000000000..c2a59ffc33
--- /dev/null
+++ b/t/chainlint/nested-cuddled-subshell.expect
@@ -0,0 +1,19 @@
+(
+	(cd foo &&
+		bar
+>>	) &&
+	(cd foo &&
+		bar
+?!AMP?!>>	)
+	(
+		cd foo &&
+>>		bar) &&
+	(
+		cd foo &&
+?!AMP?!>>		bar)
+	(cd foo &&
+>>		bar) &&
+	(cd foo &&
+?!AMP?!>>		bar)
+	foobar
+>)
diff --git a/t/chainlint/nested-cuddled-subshell.test b/t/chainlint/nested-cuddled-subshell.test
new file mode 100644
index 0000000000..8fd656c7b5
--- /dev/null
+++ b/t/chainlint/nested-cuddled-subshell.test
@@ -0,0 +1,31 @@
+(
+# LINT: opening "(" cuddled with first nested subshell statement
+	(cd foo &&
+		bar
+	) &&
+
+# LINT: same but "&&" missing
+	(cd foo &&
+		bar
+	)
+
+# LINT: closing ")" cuddled with final nested subshell statement
+	(
+		cd foo &&
+		bar) &&
+
+# LINT: same but "&&" missing
+	(
+		cd foo &&
+		bar)
+
+# LINT: "(" and ")" cuddled with first and final subshell statements
+	(cd foo &&
+		bar) &&
+
+# LINT: same but "&&" missing
+	(cd foo &&
+		bar)
+
+	foobar
+)
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
new file mode 100644
index 0000000000..559301e005
--- /dev/null
+++ b/t/chainlint/nested-here-doc.expect
@@ -0,0 +1,5 @@
+(
+	cat &&
+?!AMP?!	cat
+	foobar
+>)
diff --git a/t/chainlint/nested-here-doc.test b/t/chainlint/nested-here-doc.test
new file mode 100644
index 0000000000..027e0bb3ff
--- /dev/null
+++ b/t/chainlint/nested-here-doc.test
@@ -0,0 +1,23 @@
+(
+# LINT: inner "EOF" not misintrepreted as closing INPUT_END here-doc
+	cat <<-\INPUT_END &&
+	fish are mice
+	but geese go slow
+	data <<EOF
+		perl is lerp
+		and nothing else
+	EOF
+	toink
+	INPUT_END
+
+# LINT: same but missing "&&"
+	cat <<-\EOT
+	text goes here
+	data <<EOF
+		data goes here
+	EOF
+	more test here
+	EOT
+
+	foobar
+)
diff --git a/t/chainlint/nested-subshell-comment.expect b/t/chainlint/nested-subshell-comment.expect
new file mode 100644
index 0000000000..15b68d4373
--- /dev/null
+++ b/t/chainlint/nested-subshell-comment.expect
@@ -0,0 +1,11 @@
+(
+	foo &&
+	(
+		bar &&
+		# bottles wobble while fiddles gobble
+		# minor numbers of cows (or do they?)
+		baz &&
+		snaff
+?!AMP?!>>	)
+	fuzzy
+>)
diff --git a/t/chainlint/nested-subshell-comment.test b/t/chainlint/nested-subshell-comment.test
new file mode 100644
index 0000000000..0ff136ab3c
--- /dev/null
+++ b/t/chainlint/nested-subshell-comment.test
@@ -0,0 +1,13 @@
+(
+	foo &&
+	(
+		bar &&
+# LINT: ")" in comment in nested subshell not misinterpreted as closing ")"
+		# bottles wobble while fiddles gobble
+		# minor numbers of cows (or do they?)
+		baz &&
+		snaff
+# LINT: missing "&&" on ')'
+	)
+	fuzzy
+)
diff --git a/t/chainlint/nested-subshell.expect b/t/chainlint/nested-subshell.expect
new file mode 100644
index 0000000000..c8165ad19e
--- /dev/null
+++ b/t/chainlint/nested-subshell.expect
@@ -0,0 +1,12 @@
+(
+	cd foo &&
+	(
+		echo a &&
+		echo b
+>>	) >file &&
+	cd foo &&
+	(
+		echo a
+		echo b
+>>	) >file
+>)
diff --git a/t/chainlint/nested-subshell.test b/t/chainlint/nested-subshell.test
new file mode 100644
index 0000000000..998b05a47d
--- /dev/null
+++ b/t/chainlint/nested-subshell.test
@@ -0,0 +1,14 @@
+(
+	cd foo &&
+	(
+		echo a &&
+		echo b
+	) >file &&
+
+	cd foo &&
+	(
+# LINT: nested multi-line subshell not presently checked for missing "&&"
+		echo a
+		echo b
+	) >file
+)
-- 
2.18.0.203.gfac676dfb9

