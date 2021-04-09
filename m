Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F35CC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E55610D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhDIPD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhDIPDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA26C061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:03:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f6so5945052wrv.12
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b8JSJO97gx8NVF2BXfnhBpz3n2jvS+gtDGt2uz5ZHYA=;
        b=eUJAUQNPzlu9xpbqYxOoKBWL1C3p4hWuYYcvBcqbdZrXmNyuPF0z344O6YVtJMiK8u
         HSPpKQYwxrinQSMQT+qrMlfIkDlrhHzM7zspmIgGjOZLLUvrd1oRIKiXaNFjgjS+nLN0
         ZrlRjBox/sbi6r2KD5Gry3iYbGBgOZzM5u+hhwiTcfwtisDhd38hJBgItupQNKl5r42q
         3lcHe+84Aqs+avL3UlsGwO1rnip8BOulzMsrR7OUr/d0MGHmTWc1puiUpeGfZMzEEm2Y
         su7WRxFjN0YV2jwvNIAAe3a+oRthSfaDXvxAehoMDQ0YKOcPpbFN5MLRy+9LcXZFxnxn
         161A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8JSJO97gx8NVF2BXfnhBpz3n2jvS+gtDGt2uz5ZHYA=;
        b=fOYrx6uEinXkqspFv1g17ABMURiD5G8DldG3HKWpTiL+29QFdICoslscKBFG+4mFkH
         vucNWspbyEKAWR7NiFJsD04Hz4plOJeEkmdeZZR72G6PbpMmihyZta3ZCrPsqWkPgkK3
         ZHItnhKigvtCI5b+rZdIeRIDCgqG9EZtrLUPVrJPiX0BVs7og3LEa8a2h+CNwd7Wv6jk
         z9vySUBrFS39UYWRnP1vsqxUa8jyr43/3IVeF6Hr0UyTGaCw8p8/LK9wyZ/Oo22tA3bK
         rnkw92zl+A3Dhs8mawIfH8fN2nP5aY6V9nn9b/9Hxz3QJ01eeGY4fv3hYCf7R3o1fQhd
         JAgQ==
X-Gm-Message-State: AOAM530uxvNJ0UYHwdjgpkrkQqPatLwpas6eajcVJbKlSXptGgiuDxSS
        97q1WHZvsgSYrObz+RSyS912xBBNjhnjWg==
X-Google-Smtp-Source: ABdhPJxQLYTaKpm36950WKmXlyJL/dKWkxnDjsh/TbKHd6X41PbWrPP6A8eAKHNx/TiSZNzcUEHaiA==
X-Received: by 2002:adf:f692:: with SMTP id v18mr8504305wrp.206.1617980581544;
        Fri, 09 Apr 2021 08:03:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:03:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] doc lint: lint relative section order
Date:   Fri,  9 Apr 2021 17:02:49 +0200
Message-Id: <patch-6.7-8c294afe2a-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a linting script to check the relative order of the sections in
the documentation. We should have NAME, then SYNOPSIS, DESCRIPTION,
OPTIONS etc. in that order.

That holds true throughout our documentation, except for a few
exceptions which are hardcoded in the linting script.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                    |   3 +-
 Documentation/lint-man-section-order.perl | 125 ++++++++++++++++++++++
 2 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100755 Documentation/lint-man-section-order.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 34b4f5716a..5e0828869b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -483,7 +483,8 @@ lint-docs::
 		--section=1 $(MAN1_TXT) \
 		--section=5 $(MAN5_TXT) \
 		--section=7 $(MAN7_TXT); \
-	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT)
+	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT); \
+	$(PERL_PATH) lint-man-section-order.perl $(MAN_TXT);
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
new file mode 100755
index 0000000000..5767e7e456
--- /dev/null
+++ b/Documentation/lint-man-section-order.perl
@@ -0,0 +1,125 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+my %SECTIONS;
+{
+	my $order = 0;
+	%SECTIONS = (
+		'NAME' => {
+			required => 1,
+			order => $order++,
+		},
+		'SYNOPSIS' => {
+			required => 1,
+			order => $order++,
+		},
+		'DESCRIPTION' => {
+			required => 1,
+			order => $order++,
+			bad => {
+				'git-mktag.txt' => 'OPTIONS',
+				'git-cvsserver.txt' => 'OPTIONS',
+			},
+		},
+		'OPTIONS' => {
+			order => $order++,
+			required => 0,
+			bad => {
+				'git-grep.txt' => 'CONFIGURATION',
+				'git-rebase.txt' => 'CONFIGURATION',
+			},
+		},
+		'CONFIGURATION' => {
+			order => $order++,
+			bad => {
+				'git-svn.txt' => 'BUGS',
+			},
+		},
+		'BUGS' => {
+			order => $order++,
+		},
+		'SEE ALSO' => {
+			order => $order++,
+		},
+		'GIT' => {
+			required => 1,
+			order => $order++,
+		},
+	);
+}
+my $SECTION_RX = do {
+	my ($names) = join "|", keys %SECTIONS;
+	qr/^($names)$/s;
+};
+
+my $exit_code = 0;
+sub report {
+	my ($msg) = @_;
+	print "$ARGV:$.: $msg\n";
+	$exit_code = 1;
+}
+
+my $last_was_section;
+my @actual_order;
+while (my $line = <>) {
+	chomp $line;
+	if ($line =~ $SECTION_RX) {
+		push @actual_order => $line;
+		$last_was_section = 1;
+		# Have no "last" section yet, processing NAME
+		next if @actual_order == 1;
+
+		my @expected_order = sort {
+			$SECTIONS{$a}->{order} <=> $SECTIONS{$b}->{order}
+		} @actual_order;
+
+		my $expected_last = $expected_order[-2];
+		my $actual_last = $actual_order[-2];
+		my $except_last = $SECTIONS{$line}->{bad}->{$ARGV} || '';
+		if (($SECTIONS{$line}->{bad}->{$ARGV} || '') eq $actual_last) {
+			# Either we're whitelisted, or ...
+			next
+		} elsif (exists $SECTIONS{$actual_last}->{bad}->{$ARGV}) {
+			# ... we're complaing about the next section
+			# which is out of order because this one is,
+			# don't complain about that one.
+			next;
+		} elsif ($actual_last ne $expected_last) {
+			report("section '$line' incorrectly ordered, comes after '$actual_last'");
+		}
+		next;
+	}
+	if ($last_was_section) {
+		my $last_section = $actual_order[-1];
+		if (length $last_section ne length $line) {
+			report("dashes under '$last_section' should match its length!");
+		}
+		if ($line !~ /^-+$/) {
+			report("dashes under '$last_section' should be '-' dashes!");
+		}
+		$last_was_section = 0;
+	}
+
+	if (eof) {
+		# We have both a hash and an array to consider, for
+		# convenience
+		my %actual_sections;
+		@actual_sections{@actual_order} = ();
+
+		for my $section (sort keys %SECTIONS) {
+			next if !$SECTIONS{$section}->{required} or exists $actual_sections{$section};
+			report("has no required '$section' section!");
+		}
+
+		# Reset per-file state
+		{
+			@actual_order = ();
+			# this resets our $. for each file
+			close ARGV;
+		}
+	}
+}
+
+exit $exit_code;
-- 
2.31.1.622.g1b8cc22e65

