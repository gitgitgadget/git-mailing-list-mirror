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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611BDC433E3
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3894E61A4A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 10:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCZKhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhCZKhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 06:37:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A31C0613B2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:37:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2730469wmj.1
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFVioaokP6SLdOo/06l5OeQ6DbPEuhoryMat81VXq7Y=;
        b=QwIMlqDki9tuqvKajwSbpS30F3ly0lveOjVh55VjDqAftfonvV2OBd5nbn9OiZihMq
         JoH24qLeiWeliTAV7NkY7Vr/tfNFaFgPRgwOK681Nt3PATciTiaJHCHqOAQIHoRjBsb8
         wfQ+LM6UyYs9C2wxPV0P94G3E1ES7xfChMwivcgYzaO0aX0dBv00jRTPx1y/18hTkArh
         bFo35tTMYmCeKkCPItOoxMOiDB63uQ1XdQQ8zUUMpnd3RuWKTM5S2BZrei3865EMClk6
         IPABEoev79kJ951Qc4Cv8xcUGedxihKMMHSS9PmNNjs/c2tJI8aTvpRDHfWYQozj+pqe
         YmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFVioaokP6SLdOo/06l5OeQ6DbPEuhoryMat81VXq7Y=;
        b=CLDxZSU2tbi5Q2dvG1c0A5KEn0KNP9poX0cSdBwYN65Wq3vfetbEbz3OXqBWjcuyC2
         TxYPuK8NOb6xH/RfnR7Y43iyJ9kkAi5EPjKg1dIzmkkLr0f8OzjCSG6yX7OiywiEpyHU
         xZD2y8LY3Vnawz3uGxkQjsSGrYEcZqVRnuAmy5xCHq0nt6UkKQFqjc29c7XAkd7/1Cir
         JbvuCx+vjQcaLZCpxWI0xfKC1Rl5XK1ulHXtyh/F5muXosfUDJWnGwUKIqe6O6RydqAX
         yZE3I6LG9yACWZgBenrrahiLOMmelXMasWv1MquW14+TAgb2t9ZKgNMdEuwuBcblreIw
         T72A==
X-Gm-Message-State: AOAM5321pEsj0Vd4eBbQQCYwOSU6BPvB5uAn3yUXSQ6Dm2KgHTGTpmtl
        FV2fbfKYR/XJGL1ZR1Us4xvy/mrEfY8QIw==
X-Google-Smtp-Source: ABdhPJxKKJBoyjpT5BRbnMhXrh5A1g8U9IoclNBriV0n6LS3AzyZ+bW+lPjIPLU+FNYlyU3BVenaLA==
X-Received: by 2002:a05:600c:1553:: with SMTP id f19mr12378607wmg.33.1616755019050;
        Fri, 26 Mar 2021 03:36:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o2sm1752563wmr.10.2021.03.26.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 03:36:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
Date:   Fri, 26 Mar 2021 11:36:50 +0100
Message-Id: <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.419.gfc6e4cae13
In-Reply-To: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lint for and fix the three manual pages that were missing the standard
"Part of the linkgit:git[1] suite" end section.

We only do this for the man[157] section documents (we don't have
anything outside those sections), not files to be included,
howto *.txt files etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile           |  2 ++
 Documentation/git-credential.txt |  4 ++++
 Documentation/git-p4.txt         |  4 ++++
 Documentation/gitnamespaces.txt  |  4 ++++
 Documentation/lint-man-txt.perl  | 24 ++++++++++++++++++++++++
 5 files changed, 38 insertions(+)
 create mode 100755 Documentation/lint-man-txt.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6bfd8c75772..2b6cd0f7be2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -490,6 +490,8 @@ lint-docs::
 		--section=5 $(MAN5_TXT) \
 		--section=7 $(MAN7_TXT)	\
 		--to-lint $(ALL_TXT)
+	$(QUIET_LINT)$(PERL_PATH) lint-man-txt.perl \
+		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 31c81c4c026..206e3c5f407 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -159,3 +159,7 @@ empty string.
 +
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b424c..38e5257b2a4 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -762,3 +762,7 @@ IMPLEMENTATION DETAILS
   message indicating the p4 depot location and change number.  This
   line is used by later 'git p4 sync' operations to know which p4
   changes are new.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
index b614969ad2c..1c8d2ecc358 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -62,3 +62,7 @@ git clone ext::'git --namespace=foo %s /tmp/prefixed.git'
 ----------
 
 include::transfer-data-leaks.txt[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/lint-man-txt.perl b/Documentation/lint-man-txt.perl
new file mode 100755
index 00000000000..d69312e5db5
--- /dev/null
+++ b/Documentation/lint-man-txt.perl
@@ -0,0 +1,24 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+my $exit_code = 0;
+sub report {
+	my ($target, $msg) = @_;
+	print "error: $target: $msg\n";
+	$exit_code = 1;
+}
+
+local $/;
+while (my $slurp = <>) {
+	report($ARGV, "has no 'Part of the linkgit:git[1] suite' end blurb")
+		unless $slurp =~ m[
+		^GIT\n
+		 ---\n
+		\QPart of the linkgit:git[1] suite\E \n
+		\z
+	]mx;
+}
+
+exit $exit_code;
-- 
2.31.0.419.gfc6e4cae13

