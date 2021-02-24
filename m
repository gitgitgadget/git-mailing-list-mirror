Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1153C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6BB64EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhBXTzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhBXTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D43C0611C1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n4so1468567wmq.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNOrn2D42zwmMKMbMtfUy7eKTPbwLRpRQ311kcCd28E=;
        b=DVK9fWmBVOa3xCmxCLHqiSpkugqYn5gTTzi6cNapyHDz0jpalA0qCy5mlTbrNkKeB2
         IZ1E03NQAv+DnJ3XLzLefsXPxHmX0ReRGs+ZqJTPj4ROCC3ra6FJNrV7DGgwWyBVUsQZ
         c30IvzaVQz3Pm4J65ilTfbi8fqFu5mZGlAfbAiwsWVBsIbI0NkUIT6eZIB0+DJ5HlSrp
         KB6urV4i2StL5Wy0cGsldnJAW0/elSVh4LMue8Vxl60WMpG/jUPQ2oAQfOQBooUtiL/O
         SYxA3fAWi4KJ4HP1VVcQSsxl52nLHdfvdzpOR/3r6kCUTdWm3jtuJCSI4jRTR4gFWcus
         LKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNOrn2D42zwmMKMbMtfUy7eKTPbwLRpRQ311kcCd28E=;
        b=jkGJQFQNq1xt6qgn/yp9YJmGm2xpTbYc51YMrADH66BQDSCNqpRf7qpgWhHFi1XaQl
         MLxd3QedZ8xSwYPgM7l24HyPlF0gobtu53lbo/SPjswnzw3NsW/5a36VqtwI7GOCnGVq
         oRYz3kw1M7gei54YAmond91Ec9ej30WYVfjpHJZv94VVtd3QAJwVvwObw5RKPQugO12Z
         5bPjIVIV7vBeRlOSrKtFLqxwrhLem6ALUHewhRHxyPrzRQG9/JHLwhvzytIJPR87SFzK
         5KBjp2ULFWf2HAiM7u/kaSjU9+dtDKb2NIjWLAl/bm0oXpJxRIWDYmjliHEEXtGHAdGp
         DdsA==
X-Gm-Message-State: AOAM53324VY59+RdFaI1WApFmxiQxjrGjwS/MgCgboh1kzF4OvPraLfU
        Q0QsxEGeZI1qCa2g958CLY95W0OnuRLH6w==
X-Google-Smtp-Source: ABdhPJx0imn1+bw6y13hVwO8xN6fIDvP4jeo0pelSVbEjl6HhGDxq+1XJxl7BMJ/ddPdgRjCbZSbcg==
X-Received: by 2002:a05:600c:210f:: with SMTP id u15mr5037951wml.119.1614196333954;
        Wed, 24 Feb 2021 11:52:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 25/35] gitattributes doc: document multi-line userdiff patterns
Date:   Wed, 24 Feb 2021 20:51:19 +0100
Message-Id: <20210224195129.4004-26-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the multi-line userdiff patterns and how their matching and
the negation syntax works.

These patterns have been supported since f258475a6e (Per-path
attribute based hunk header selection., 2007-07-06), and have had
their current semantics ever since 3d8dccd74a (diff: fix "multiple
regexp" semantics to find hunk header comment, 2008-09-20).

But we had no documentation for them, let's fix that, and also add
tests showing how some of the things being discussed here work.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitattributes.txt | 38 ++++++++++++++++--
 t/t4018/custom.sh               | 70 +++++++++++++++++++++++++++++++++
 t/t4018/perl.sh                 | 16 ++++++++
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 62c1147ba97..8082ff1ee73 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -794,12 +794,42 @@ backslashes; the pattern above picks a line that begins with a
 backslash, and zero or more occurrences of `sub` followed by
 `section` followed by open brace, to the end of line.
 
-There are built-in patterns shipped as part of git itself. A more
-advanced version of the `tex` pattern discussed above is one of them.
+Multiple patterns can be supplied by listing them one per line
+separated by `\n`. They will be matched one line at a time, e.g.:
+
+------------------------
+[diff "perl"]
+	xfuncname = "!^=head\n^[^ ]+.*"
+------------------------
+
+Patterns in a list of multiple patterns that begin with "!" are
+negated. A matching negated pattern will cause the matched line to be
+skipped. Use it to skip a later pattern that would otherwise match. It
+is an error if one or more negated patterns aren't followed by a
+non-negated pattern.
+
+To match a literal "!" at the start of a line, use some other regex
+construct that will match a literal "!" without "!" being the first
+character on that line, such as "[!]".
+
+If the last pattern in a list of multiple patterns ends with "\n" it
+will be interpreted as an empty pattern, and will match the first
+empty line. It's almost always a logic error to provide a list of
+multiple patterns ending with "\n", but it's permitted in case you
+genuinely want to match an empty line.
+
+If the pattern contains a `$1` capture it will be used instead of the
+entire matching line (`$0`) to display the hunk header. This can be
+used e.g. to strip whitespace from the beginning of the line, or to
+only display the function name as part of a longer function
+definition.
+
+There are built-in patterns shipped as part of git itself, see the
+full listing below.
 
 For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
-configuration file as discussed above, but if present, it will
-override a built-in pattern.
+configuration file. If present, it will override a built-in pattern,
+as shown in the `diff.perl.xfuncname` example above.
 
 Nevertheless, you need to enable built-in patterns via .gitattributes`
 for the pattern to take effect.
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 72d38dad686..127524afda3 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -111,3 +111,73 @@ ChangeMe
 
 baz
 EOF_TEST
+
+test_expect_success 'custom: setup negation syntax, ! is magic' '
+	git config diff.custom.xfuncname "!negation
+line"
+'
+
+test_diff_funcname 'custom: negation syntax, ! is magic' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+line
+EOF_HUNK
+line
+!negation
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: setup negation syntax, use [!] to override ! magic' '
+	git config diff.custom.xfuncname "[!]negation
+line"
+'
+
+test_diff_funcname 'custom: negation syntax, use [!] to override ! magic' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+!negation
+EOF_HUNK
+line
+!negation
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: setup captures in multiple patterns' '
+	git config diff.custom.xfuncname "!^=head
+^format ([^ ]+)
+^sub ([^;]+)"
+'
+
+test_diff_funcname 'custom: captures in multiple patterns' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+foo
+EOF_HUNK
+sub foo;
+
+=head1
+
+ChangeMe
+
+EOF_TEST
+
+test_expect_success 'custom: multiple patterns ending with \n' '
+	git config diff.custom.xfuncname "!^=head
+^sub ([^;]+)
+"
+'
+
+test_diff_funcname 'custom: multiple patterns ending with \n' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+
+EOF_HUNK
+sub foo;
+
+=head1
+
+ChangeMe
+
+EOF_TEST
diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
index b53b759353b..ba11241750b 100755
--- a/t/t4018/perl.sh
+++ b/t/t4018/perl.sh
@@ -76,3 +76,19 @@ sub asub
 	print "ChangeMe\n";
 }
 EOF_TEST
+
+
+test_expect_success 'custom: setup config overrides built-in patterns' '
+	git config diff.perl.xfuncname "!^=head
+^[^ ]+.*"
+'
+
+test_diff_funcname 'custom: config overrides built-in patterns' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub foo;
+EOF_HUNK
+sub foo;
+=head1
+
+ChangeMe
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

