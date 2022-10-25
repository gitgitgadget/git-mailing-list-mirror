Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED3C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiJYWmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiJYWma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 18:42:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA96DEF08
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j12so12278525plj.5
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtQD7V1zA8+yuE43y5UYga6ixhGgMgvHQcVruwVRHiM=;
        b=ouOA7eNaIlTZ5IZ/CPFcYA6pF/jlo+8Wn1JiQvnt3/+WBtbVstEwQDYLRcz3du6ntR
         tdoVSEBlC9suZ8ocySlBHjNmJoxgStYyH7bf7WbMzRjgUhDUwl+FJAXo3fNAQ6tguUbj
         1qbfVpZ206pTQDE7kT7aYwtdb+W8ZKX6FUSK1rLoaIL9NDT0MIO39DkTgLGvtoNI39jK
         49aJOb9Vx/dWdFMYgkUdYaPNygtXkHkuhM0Y4NlvMOHOqxIusMIt1cBhUytCtcmUp7ei
         Jc+y9pubYAiQv6d+LjK6XJAeeG1NrvWJHKcPcqP0+pH8KCo3tSDaXBj3Mb/hhB0xTNhL
         bIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gtQD7V1zA8+yuE43y5UYga6ixhGgMgvHQcVruwVRHiM=;
        b=n5uZzA0hEaUh9zTB9vvuCi8QkqEbruOnCqpJJwEHxZ9wiprj872tN6dKYGkH9bZfBR
         KW8iumVITBrZHeY6KvkTXHkfq6xMfaZdphsdWMmN0cKaOulddNFVLsyorWa2FehqRUSe
         CFfchOo2wN3GSaOrszIGpU3R0dzGWzQNEtDAtqJg/eLIrfk9qowiAQrfRT+DvRRNY26m
         FOAM/PZsbpG5oO2qjKVdvJtvA0xikxV6b9ggGP8wkyIcBTx8Qp+WsUErl5XpNg+buYVd
         l1FE+N4Tny53GhoYM4C/HdENHdiVVXlPrjQzLPvVuyY09l1oyOzp0CMRz/PxVzusuj9p
         b2og==
X-Gm-Message-State: ACrzQf3PTqc257zd7f7TvBonZ56QoK7oj6Jx2eMHBrqRdu+PIP5xLl1Z
        bIYrby26mEI6lfUmHQSnG64dBNeRkh0=
X-Google-Smtp-Source: AMsMyM6omlc9z/TtLB47LR6Jt6YB62Fekgc2E36HwnN+jr8Cw4FVRw1IeTs8HKJoQhaj/yp8e3CwXg==
X-Received: by 2002:a17:903:32cf:b0:185:c53f:7459 with SMTP id i15-20020a17090332cf00b00185c53f7459mr39193472plr.82.1666737749286;
        Tue, 25 Oct 2022 15:42:29 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w184-20020a6282c1000000b0056bb21cd7basm1854579pfd.51.2022.10.25.15.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:42:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Subject: [PATCH v3 4/4] Documentation: add lint-fsck-msgids
Date:   Tue, 25 Oct 2022 15:42:24 -0700
Message-Id: <20221025224224.2352979-5-gitster@pobox.com>
X-Mailer: git-send-email 2.38.1-359-g84c4c6d5a5
In-Reply-To: <20221025224224.2352979-1-gitster@pobox.com>
References: <pull.1369.v2.git.git.1666667864.gitgitgadget@gmail.com>
 <20221025224224.2352979-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During the initial development of the fsck-msgids.txt feature, it
has become apparent that it is very much error prone to make sure
the description in the documentation file are sorted and correctly
match what is in the fsck.h header file.

Add a quick-and-dirty Perl script and doc-lint target to sanity
check that the fsck-msgids.txt is consistent with the error type
list in the fsck.h header file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/Makefile              | 11 +++++
 Documentation/lint-fsck-msgids.perl | 70 +++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100755 Documentation/lint-fsck-msgids.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d47acb2e25..5e1a7f655c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -476,8 +476,19 @@ $(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.txt
 .PHONY: lint-docs-man-section-order
 lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
 
+.PHONY: lint-docs-fsck-msgids
+LINT_DOCS_FSCK_MSGIDS = .build/lint-docs/fsck-msgids.ok
+$(LINT_DOCS_FSCK_MSGIDS): lint-fsck-msgids.perl
+$(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.txt
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(PERL_PATH) lint-fsck-msgids.perl \
+		../fsck.h fsck-msgids.txt $@
+
+lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
+
 ## Lint: list of targets above
 .PHONY: lint-docs
+lint-docs: lint-docs-fsck-msgids
 lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
diff --git a/Documentation/lint-fsck-msgids.perl b/Documentation/lint-fsck-msgids.perl
new file mode 100755
index 0000000000..1233ffe815
--- /dev/null
+++ b/Documentation/lint-fsck-msgids.perl
@@ -0,0 +1,70 @@
+#!/usr/bin/perl
+
+my ($fsck_h, $fsck_msgids_txt, $okfile) = @ARGV;
+
+my (%in_fsck_h, $fh, $bad);
+
+open($fh, "<", "$fsck_h") or die;
+while (<$fh>) {
+	if (/^\s+FUNC\(([0-9A-Z_]+), ([A-Z]+)\)/) {
+		my ($name, $severity) = ($1, $2);
+		my ($first) = 1;
+		$name = join('',
+			     map {
+				     y/A-Z/a-z/;
+				     if (!$first) {
+					     s/^(.)/uc($1)/e;
+				     } else {
+					     $first = 0;
+				     }
+				     $_;
+			     }
+			     split(/_/, $name));
+		$in_fsck_h{$name} = $severity;
+	}
+}
+close($fh);
+
+open($fh, "<", "$fsck_msgids_txt") or die;
+my ($previous, $current);
+while (<$fh>) {
+	if (!defined $current) {
+		if (/^\`([a-zA-Z0-9]*)\`::/) {
+			$current = $1;
+			if ((defined $previous) &&
+			    ($current le $previous)) {
+				print STDERR "$previous >= $current in doc\n";
+				$bad = 1;
+			}
+		}
+	} elsif (/^\s+\(([A-Z]+)\) /) {
+		my ($level) = $1;
+		if (!exists $in_fsck_h{$current}) {
+			print STDERR "$current does not exist in fsck.h\n";
+			$bad = 1;
+		} elsif ($in_fsck_h{$current} eq "") {
+			print STDERR "$current defined twice\n";
+			$bad = 1;
+		} elsif ($in_fsck_h{$current} ne $level) {
+			print STDERR "$current severity $level != $in_fsck_h{$current}\n";
+			$bad = 1;
+		}
+		$previous = $current;
+		$in_fsck_h{$current} = ""; # mark as seen.
+		undef $current;
+	}
+}
+close($fh);
+
+for my $key (keys %in_fsck_h) {
+	if ($in_fsck_h{$key} ne "") {
+		print STDERR "$key not explained in doc.\n";
+		$bad = 1;
+	}
+}
+
+die if ($bad);
+
+open($fh, ">", "$okfile");
+print $fh "good\n";
+close($fh);
-- 
2.38.1-359-g84c4c6d5a5

