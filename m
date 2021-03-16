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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60686C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8864F76
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbhCPA4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhCPA4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F8C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id r16so6365090pfh.10
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZVh/LIyKwf29/4alI+sUOnJx/pJ7PZzfHQMfW5ghbM=;
        b=T1ANssurX0NZj/QlplHbu9nfyGtIpQWlSPnqbzGvFK6m14ssFtb5clxD+F/fWzgb6J
         A0yCICgO6mglnYUMTpZO/b3DF+ADHnZLqW/trVJaHWDWTg/3/n8HnyojZaWoTEnutwEY
         2qoYEmTVe++LhYnZxaW1o8HbLdcT9IW/r9gb4yFlHFOPcE5bBLgxR8pmdXhNS8nrjeyh
         x3t0XgSF8rKPyYisgix06eYekVUGoqad4XStfm4LWWqcJJJVaDqvJgUgoG7mvfS5OATj
         BqcGtS+hShPQb8X9ATnmLyHCJ9MThGib+un/I17mrPewqVXGedOfebyD2yvI0+ykFgSh
         Zhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZVh/LIyKwf29/4alI+sUOnJx/pJ7PZzfHQMfW5ghbM=;
        b=FuKk9CfLwOa8g4ijxQ0pn7I36HMsUuqL4P9htghmMdv01FVF0dUuqsvR3cb4dsAjeh
         UIUMg4wpr5/tMJmR6xF+oi8W37wiOvaoic6nK5vPSYsU1AkDgL0N07XAU5WUDWdsgshO
         ldXi872Qf+MUUXVLXwJmlTngoC++L8HkjkxHQUGCGRl8mrwFVg3YnrVbdtKC6PIDGLwk
         1oy5/cYR8DAyFs5NXk2qKjuNAyTgh1VJwdORkP2YJAi9WBbOhqLFADQe1QcrgbwXkQm4
         PHfN1kiPHMIvMUDSjJ++M3YLnSjfF9lpRnLPPomB6MSM82JuJYKiVovuCUn3AGXYUgeU
         mtqw==
X-Gm-Message-State: AOAM531Pi21W2PVt4HR87XcP7IgTB8Y4wlynzMPcAUhuK7285YUhGq+P
        Dw4n9n2WPuz0nxp6qbQpqorKf2KiHvQ=
X-Google-Smtp-Source: ABdhPJx1aFabrSlREvqKUXPR1yerCUF+qgJt86dHnj4lneo1qhWKJl9BpPDJS2vWcwdGjH8sydxGjQ==
X-Received: by 2002:a62:8804:0:b029:20a:2125:2737 with SMTP id l4-20020a6288040000b029020a21252737mr3323563pfd.60.1615856194197;
        Mon, 15 Mar 2021 17:56:34 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] Makefile: add 'check-sort' target
Date:   Mon, 15 Mar 2021 17:56:24 -0700
Message-Id: <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous few commits, we sorted many lists into ASCII-order. In
order to ensure that they remain that way, add the 'check-sort' target.

The check-sort.perl program ensures that consecutive lines that match
the same regex are sorted in ASCII-order. The 'check-sort' target runs
the check-sort.perl program on some files which are known to contain
sorted lists.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    Full disclaimer: this is the first time I've written anything in Perl.
    Please let me know if I'm doing anything unconventional :)

 Makefile        | 25 +++++++++++++++++++++++++
 check-sort.perl | 31 +++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100755 check-sort.perl

diff --git a/Makefile b/Makefile
index 5832aa33da..b23dff384d 100644
--- a/Makefile
+++ b/Makefile
@@ -3240,6 +3240,31 @@ check-docs::
 check-builtins::
 	./check-builtins.sh
 
+.PHONY: check-sort
+check-sort::
+	./check-sort.perl \
+		'ALL_COMMANDS \+=' \
+		'ALL_COMMANDS_TO_INSTALL \+=' \
+		'BINDIR_PROGRAMS_NEED_X \+=' \
+		'BINDIR_PROGRAMS_NO_X \+=' \
+		'BUILTIN_OBJS \+=' \
+		'BUILT_INS \+=' \
+		'FUZZ_OBJS \+=' \
+		'GENERATED_H \+=' \
+		'LIB_OBJS \+=' \
+		'SCRIPT_LIB \+=' \
+		'SCRIPT_PERL \+=' \
+		'SCRIPT_PYTHON \+=' \
+		'SCRIPT_SH \+=' \
+		'TEST_BUILTINS_OBJS \+=' \
+		'TEST_PROGRAMS_NEED_X \+=' \
+		'THIRD_PARTY_SOURCES \+=' \
+		'XDIFF_OBJS \+=' \
+		<Makefile
+	./check-sort.perl 'int cmd_[^(]*\(' <builtin.h
+	./check-sort.perl 'int cmd__[^(]*\(' <t/helper/test-tool.h
+	./check-sort.perl '\t\{ "[^"]*",' <git.c
+
 ### Test suite coverage testing
 #
 .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
diff --git a/check-sort.perl b/check-sort.perl
new file mode 100755
index 0000000000..cd723db14d
--- /dev/null
+++ b/check-sort.perl
@@ -0,0 +1,31 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+my @regexes = map { qr/^$_/ } @ARGV;
+my $last_regex = 0;
+my $last_line = '';
+
+while (<STDIN>) {
+	my $matched = 0;
+	chomp;
+
+	for my $regex (@regexes) {
+		next unless $_ =~ $regex;
+
+		if ($last_regex == $regex) {
+			die "duplicate lines: '$_'\n" unless $last_line ne $_;
+			die "unsorted lines: '$last_line' before '$_'\n" unless $last_line lt $_;
+		}
+
+		$matched = 1;
+		$last_regex = $regex;
+		$last_line = $_;
+	}
+
+	unless ($matched) {
+		$last_regex = 0;
+		$last_line = '';
+	}
+}
-- 
2.31.0.rc2.261.g7f71774620

