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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D8C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBC8610CF
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhDIPDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhDIPDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F5C061763
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:03:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so5956252wrr.2
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JxsY8xyVTDrJ9BTKg+4VLRKGQJEGA1QjV9rPf4WPI1U=;
        b=PuzFXNTyaDJukCH2F1G1EcHTLjoEVqq3nkdQ4OdB9AXZZ9O9nDI1Uo5thE+qwShlwg
         LRUKFjIeZFNdVCw4wgX8V0S4aMyXO9Y0wOC5rDaW7ymzvavn2ZUkJEo8uxR/YHUO6vmx
         EQLmF9P3yT5xEXYcbTVqBpVx6pv0fakmxyin3u4AkBYElZxAOHRC6cLaDPFVFL7mUdyy
         5/M2ZJDeDg4VKlx46uMRb0uX83cx1ygtbHYZDEIXANUK1J8doYjiw9+PQmbKftOVTkyV
         6G1s5Ch4VJAwo4JlCTw0JYhVvACdPA7NYsGto+xVOK8YeiqO/y4P+GS2SHRf+dV6tI6z
         7bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JxsY8xyVTDrJ9BTKg+4VLRKGQJEGA1QjV9rPf4WPI1U=;
        b=f8JQ/va9Ts+dhO8AQgdFKbyORStkgklEEX5kGnYZoxq5ICqndq5mcCo5Irwn9SHznH
         gsPSm0qQdnfQ0JMYVOucuFiBtv/PHK49+hQ8/bGaceESGYDgEqMpD6MBz3en+gNZkGIO
         2IvLbEyKPjU11vytWO5dVheQZXmaPJmisnOGX7jyKh8pmCMekdt6etlhfqwV/kk6Azug
         rAkjHZi3ruuhm53RCXastaLSXFlKesOnSm16XGOUO7oSmrYeJDeEzdFkNQQTtRCnGwJH
         sgar7CIusi3XAShyrILg3RfXBR/nzg462z2NJHKYbjIRX3+QeQPwaMwNa4u45lSEi+hx
         qNyw==
X-Gm-Message-State: AOAM532UPt4cOknuSSwpTAtf6AiSYzfYpqr1wGeCcMG2LFi/OiNM0bOq
        qxfW27iVFV25tNMQKx4ZfStWHevTpmvUGw==
X-Google-Smtp-Source: ABdhPJzbHUGPzBUNK1dZSVTUWHLohKE/SaWppWjDSm6+BTfM19QcSC2Z2k7aZJo8ymvyX2OB2cFXbw==
X-Received: by 2002:a5d:5311:: with SMTP id e17mr3604199wrv.11.1617980580504;
        Fri, 09 Apr 2021 08:03:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:02:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] doc lint: lint and fix missing "GIT" end sections
Date:   Fri,  9 Apr 2021 17:02:48 +0200
Message-Id: <patch-5.7-e3af1a9405-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
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

We could also add this to the existing (and then renamed)
lint-gitlink.perl, but I'm not doing that here.

Obviously all of that fits in one script, but I think for something
like this that's a one-off script with global variables it's much
harder to follow when a large part of your script is some if/else or
keeping/resetting of state simply to work around the script doing two
things instead of one.

Especially because in this case this script wants to process the file
as one big string, but lint-gitlink.perl wants to look at it one line
at a time. We could also consolidate this whole thing and
t/check-non-portable-shell.pl, but that one likes to join lines as
part of its shell parsing.

So let's just add another script, whole scaffolding is basically:

    use strict;
    use warnings;
    sub report { ... }
    my $code = 0;
    while (<>) { ... }
    exit $code;

We'd spend more lines effort trying to consolidate them than just
copying that around.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                |  3 ++-
 Documentation/git-credential.txt      |  4 ++++
 Documentation/git-p4.txt              |  4 ++++
 Documentation/gitnamespaces.txt       |  4 ++++
 Documentation/lint-man-end-blurb.perl | 24 ++++++++++++++++++++++++
 5 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100755 Documentation/lint-man-end-blurb.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index de55c4ecf5..34b4f5716a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -482,7 +482,8 @@ lint-docs::
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
 		--section=1 $(MAN1_TXT) \
 		--section=5 $(MAN5_TXT) \
-		--section=7 $(MAN7_TXT)
+		--section=7 $(MAN7_TXT); \
+	$(PERL_PATH) lint-man-end-blurb.perl $(MAN_TXT)
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 31c81c4c02..206e3c5f40 100644
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
index f89e68b424..38e5257b2a 100644
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
index b614969ad2..1c8d2ecc35 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -62,3 +62,7 @@ git clone ext::'git --namespace=foo %s /tmp/prefixed.git'
 ----------
 
 include::transfer-data-leaks.txt[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/lint-man-end-blurb.perl b/Documentation/lint-man-end-blurb.perl
new file mode 100755
index 0000000000..d69312e5db
--- /dev/null
+++ b/Documentation/lint-man-end-blurb.perl
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
2.31.1.622.g1b8cc22e65

