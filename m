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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE1C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FBA64EF5
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhBXTzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbhBXTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD31C061226
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o10so3829997wmc.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOHeC36R0bYcnqbQ4THhJ9b9TW0bqHNxo+M2RQEpjQY=;
        b=ovV5hHgvapSWPpWX8oFsOeH+5I34soz0lOKdRbPXSJiR6T9R+57bsXq5PEuaNa41t+
         648AZjmff2eqSJeGencqWB/wK7VkmhI1hgPktAs2AkGkIu1WpsYxtDvW7tsdXp6CEgUU
         cTt/YuC5S33Xc6G0UJcN45bANngSnsoYR7/KUHSifwgXGdP/CPgLqgqqdRLdJqT1SzVU
         H+/gNIrpk67eBg5Hv9MCeNhFcGzvS+Xr1ejKwseP+UtlBEQ7GHZYoUcOHZAAQ/YCt+Jk
         fdORAof1cbCaUz//uimaS9SMGVug6q2FHYPt7tRbEzmgsOv883mdxCRxvdhXIF1FEr/A
         IcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOHeC36R0bYcnqbQ4THhJ9b9TW0bqHNxo+M2RQEpjQY=;
        b=NZkkmXCJv/aUJChsIkUGJM3roWpsPBDVb50r2lWNXhr4eYgtZXG1+w6qJWBjDErCyC
         zbHARUNFTCEONLRCdEC/1sZhc3jI9dCDlPDD4pPtu6/r6y+r30k0A4XQmn5J8KNlgMWz
         11gAVOqrDrHNp6Hi5y802TawMStcs0Wlimtqk00teNAlzXyB/vr4541m6eM9Ad/08IzO
         7EhtIxXgj1xAXZp0VThcSRcw472QvMj4KJtAKF3oFA+2t2fW2CM0pN7mNt/4gtwhFZyu
         ooFMsAc8qXAWvVDa8RmXvc5qG0m1Gp9XOt/gOwMhIxhSr5AGNGvipk0lcWqwLNqBDOvy
         PBWA==
X-Gm-Message-State: AOAM533T3kvLCdIfg2ub8M1o+F9cufqrj+YF3p3euTGzUH+ERBvYzdhR
        z3cgaB9zUT06UQYRjuJdcfWmkXTc5pD+Fg==
X-Google-Smtp-Source: ABdhPJxRJBDJQoK/RHaU2QEG79DSdVcOfXU5otFdBlpOn7nyHg92C45DTYDSWxXsYqs3ugebYhNGUQ==
X-Received: by 2002:a05:600c:2298:: with SMTP id 24mr5329795wmf.136.1614196332152;
        Wed, 24 Feb 2021 11:52:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:11 -0800 (PST)
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
Subject: [PATCH v3 23/35] userdiff tests: move perl tests to perl.sh
Date:   Wed, 24 Feb 2021 20:51:17 +0100
Message-Id: <20210224195129.4004-24-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the perl tests to perl.sh, a follow-up change will piggy-back on
these tests for updating the userdiff documentation. This will require
the new test *.sh test framework.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/perl-skip-end-of-heredoc     |  9 ----
 t/t4018/perl-skip-forward-decl       | 11 ----
 t/t4018/perl-skip-sub-in-pod         | 19 -------
 t/t4018/perl-sub-definition          |  5 --
 t/t4018/perl-sub-definition-kr-brace |  5 --
 t/t4018/perl.sh                      | 78 ++++++++++++++++++++++++++++
 6 files changed, 78 insertions(+), 49 deletions(-)
 delete mode 100644 t/t4018/perl-skip-end-of-heredoc
 delete mode 100644 t/t4018/perl-skip-forward-decl
 delete mode 100644 t/t4018/perl-skip-sub-in-pod
 delete mode 100644 t/t4018/perl-sub-definition
 delete mode 100644 t/t4018/perl-sub-definition-kr-brace
 create mode 100755 t/t4018/perl.sh

diff --git a/t/t4018/perl-skip-end-of-heredoc b/t/t4018/perl-skip-end-of-heredoc
deleted file mode 100644
index 8f90cca7314..00000000000
--- a/t/t4018/perl-skip-end-of-heredoc
+++ /dev/null
@@ -1,9 +0,0 @@
-t4018 header: sub RIGHTwithheredocument {
-sub RIGHTwithheredocument {
-	print <<"EOF"
-decoy here-doc
-EOF
-	# some lines of context
-	# to pad it out
-	print "ChangeMe\n";
-}
diff --git a/t/t4018/perl-skip-forward-decl b/t/t4018/perl-skip-forward-decl
deleted file mode 100644
index ff1f6d14735..00000000000
--- a/t/t4018/perl-skip-forward-decl
+++ /dev/null
@@ -1,11 +0,0 @@
-t4018 header: package RIGHT;
-package RIGHT;
-
-use strict;
-use warnings;
-use parent qw(Exporter);
-our @EXPORT_OK = qw(round finalround);
-
-sub other; # forward declaration
-
-# ChangeMe
diff --git a/t/t4018/perl-skip-sub-in-pod b/t/t4018/perl-skip-sub-in-pod
deleted file mode 100644
index ff1c65b28fc..00000000000
--- a/t/t4018/perl-skip-sub-in-pod
+++ /dev/null
@@ -1,19 +0,0 @@
-t4018 header: =head1 SYNOPSIS_RIGHT
-=head1 NAME
-
-Beer - subroutine to output fragment of a drinking song
-
-=head1 SYNOPSIS_RIGHT
-
-	use Beer qw(round finalround);
-
-	sub song {
-		for (my $i = 99; $i > 0; $i--) {
-			round $i;
-		}
-		finalround;
-	}
-
-	ChangeMe;
-
-=cut
diff --git a/t/t4018/perl-sub-definition b/t/t4018/perl-sub-definition
deleted file mode 100644
index 22e16ad5363..00000000000
--- a/t/t4018/perl-sub-definition
+++ /dev/null
@@ -1,5 +0,0 @@
-t4018 header: sub RIGHT {
-sub RIGHT {
-	my ($n) = @_;
-	print "ChangeMe";
-}
diff --git a/t/t4018/perl-sub-definition-kr-brace b/t/t4018/perl-sub-definition-kr-brace
deleted file mode 100644
index 6c94e6a62dd..00000000000
--- a/t/t4018/perl-sub-definition-kr-brace
+++ /dev/null
@@ -1,5 +0,0 @@
-t4018 header: sub RIGHT
-sub RIGHT
-{
-	print "ChangeMe\n";
-}
diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
new file mode 100755
index 00000000000..ac8fff7417a
--- /dev/null
+++ b/t/t4018/perl.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'perl: skip end of heredoc' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub RIGHTwithheredocument {
+EOF_HUNK
+sub RIGHTwithheredocument {
+	print <<"EOF"
+decoy here-doc
+EOF
+	# some lines of context
+	# to pad it out
+	print "ChangeMe\n";
+}
+EOF_TEST
+
+test_diff_funcname 'perl: skip forward decl' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+package RIGHT;
+EOF_HUNK
+package RIGHT;
+
+use strict;
+use warnings;
+use parent qw(Exporter);
+our @EXPORT_OK = qw(round finalround);
+
+sub other; # forward declaration
+
+# ChangeMe
+EOF_TEST
+
+test_diff_funcname 'perl: skip sub in pod' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+=head1 SYNOPSIS_RIGHT
+EOF_HUNK
+=head1 NAME
+
+Beer - subroutine to output fragment of a drinking song
+
+=head1 SYNOPSIS_RIGHT
+
+	use Beer qw(round finalround);
+
+	sub song {
+		for (my $i = 99; $i > 0; $i--) {
+			round $i;
+		}
+		finalround;
+	}
+
+	ChangeMe;
+
+=cut
+EOF_TEST
+
+test_diff_funcname 'perl: sub definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub RIGHT {
+EOF_HUNK
+sub RIGHT {
+	my ($n) = @_;
+	print "ChangeMe";
+}
+EOF_TEST
+
+test_diff_funcname 'perl: sub definition kr brace' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub RIGHT
+EOF_HUNK
+sub RIGHT
+{
+	print "ChangeMe\n";
+}
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

