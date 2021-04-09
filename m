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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE14BC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEC5610C7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhDIPD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhDIPDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D734CC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:03:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f12so5995785wro.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32O/eZ7pT16CGU8ijnnvfTWp1xNqn8SLzuwQczA7YMg=;
        b=ZLu2zT0a3zqn88utA5Wsnt5VbR8kn4K/V4RbqWWcYiJuYczYeZ9pw6OiSduFdweRQT
         VXVFb046TSQ2hk2eyKoxFBLulLYCDQaaExb9dHbeb1q0FY2lW2JNl7Oic/9caOtHGhSI
         2N/Fpb9WRefMFRDhSsh8qdhWg0SHfMnYP6mJOTZKsdOUoK+RZ8ZABlFRr9x2PvQIxnlr
         z984rKjp7VfVur1Hn5CG9qTu9IXV2k8spTiqcMNI4OWMS3h3pHR+b+NTYxr1phyFyGVe
         cgaNGTJac+nHM9wONNGrKvwlmSF50XC1xd5zT6fTHWTvykXBArfEIV8UY1O+c5UiQ5We
         M0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32O/eZ7pT16CGU8ijnnvfTWp1xNqn8SLzuwQczA7YMg=;
        b=mg2jqKqEML6ky5pfsz9ezlhGFfi9ST9Irv0peblGX+IfjRMTNmyJNlOFHy8Z3KH8bq
         JTszd/0vO36pnN3ZdYnzedBPjcGQXIH0gbq4uM7rwrhqBKfLsg/gieX1vhc60g19LKCD
         2Z6MXao+yQdZI4MCiuNaTl64A2nqJ+nwiQTuzM4IgYGPHFm+pQkI0PvypFWvOWFt7SDW
         cHq+zevjaWUG6I/FeBPjGEKy7XdF2BMwGgV+00q1T3Mfa7aDmra5t1PqC6IMxlC7z16U
         EPsU6j1aWdypmwKdORUDpFxJQGa3fLAasdCT67zqkvaa/sMrpgoLi/Nyc3ZjANxDpkn3
         xX1w==
X-Gm-Message-State: AOAM531wxOBp2HfRPWc563aS/LecTRJyelZW21j7ZuaozTa2yyA+l+T9
        oSgbgj5y4qfg8ailGm9zc/X0lqv6c9ljww==
X-Google-Smtp-Source: ABdhPJxtlfuMZ8S+eFVObqhglBVnrfhMZ8RMbNanzhsxUcrS9E8yl6kuXhGP1cW1FbIBX1mjkMIOZg==
X-Received: by 2002:a05:6000:1209:: with SMTP id e9mr18002438wrx.36.1617980579208;
        Fri, 09 Apr 2021 08:02:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:02:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] doc lint: fix bugs in, simplify and improve lint script
Date:   Fri,  9 Apr 2021 17:02:47 +0200
Message-Id: <patch-4.7-5acb116fea-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lint-gitlink.perl script added in ab81411ced (ci: validate
"linkgit:" in documentation, 2016-05-04) was more complex than it
needed to be. It:

 - Was using File::Find to recursively find *.txt files in
   Documentation/, let's instead use the Makefile as a source of truth
   for *.txt files, and pass it down to the script.

 - We now don't lint linkgit:* in RelNotes/* or technical/*, which we
   shouldn't have been doing in the first place anyway.

 - When the doc-diff script was added in beb188e22a (add a script to
   diff rendered documentation, 2018-08-06) we started sometimes having
   a "git worktree" under Documentation/.

   This tree contains a full checkout of git.git, as a result the
   "lint" script would recurse into that, and lint any *.txt file
   found in that entire repository.

   In practice the only in-tree "linkgit" outside of the
   Documentation/ tree is contrib/contacts/git-contacts.txt and
   contrib/subtree/git-subtree.txt, so this wouldn't emit any errors

Now we instead simply trust the Makefile to give us *.txt files.
Since the Makefile also knows what sections each page should be in we
don't have to open the files ourselves and try to parse that out. As a
bonus this will also catch bugs with the section line in the files
themselves being incorrect.

The structure of the new script is mostly based on
t/check-non-portable-shell.pl. As an added bonus it will also use
pos() to print where the problems it finds are, e.g. given an issue
like:

    diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
    [...]
     and line numbers.  git-cherry therefore detects when commits have been
    -"copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
    -linkgit:git-rebase[1].
    +"copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3] or
    +linkgit:git-rebase[4].

We'll now emit:

    git-cherry.txt:20: error: git-cherry-pick[2]: wrong section (should be 1), shown with 'HERE' below:
    git-cherry.txt:20:      '"copied" by means of linkgit:git-cherry-pick[2]' <-- HERE
    git-cherry.txt:20: error: git-am[3]: wrong section (should be 1), shown with 'HERE' below:
    git-cherry.txt:20:      '"copied" by means of linkgit:git-cherry-pick[2], linkgit:git-am[3]' <-- HERE
    git-cherry.txt:21: error: git-rebase[4]: wrong section (should be 1), shown with 'HERE' below:
    git-cherry.txt:21:      'linkgit:git-rebase[4]' <-- HERE

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile          |   6 +-
 Documentation/lint-gitlink.perl | 106 +++++++++++++++-----------------
 2 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 164d5ff2f9..de55c4ecf5 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -478,7 +478,11 @@ print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
 lint-docs::
-	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl
+	$(QUIET_LINT)$(PERL_PATH) lint-gitlink.perl \
+		$(HOWTO_TXT) $(DOC_DEP_TXT) \
+		--section=1 $(MAN1_TXT) \
+		--section=5 $(MAN5_TXT) \
+		--section=7 $(MAN7_TXT)
 
 ifeq ($(wildcard po/Makefile),po/Makefile)
 doc-l10n install-l10n::
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index 35230875c2..b22a367844 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -2,72 +2,66 @@
 
 use strict;
 use warnings;
-use File::Find;
-use Getopt::Long;
 
-my $basedir = ".";
-GetOptions("basedir=s" => \$basedir)
-	or die("Cannot parse command line arguments\n");
+# Parse arguments, a simple state machine for input like:
+#
+# howto/*.txt config/*.txt --section=1 git.txt git-add.txt [...] --to-lint git-add.txt a-file.txt [...]
+my %TXT;
+my %SECTION;
+my $section;
+my $lint_these = 0;
+for my $arg (@ARGV) {
+	if (my ($sec) = $arg =~ /^--section=(\d+)$/s) {
+		$section = $sec;
+		next;
+	}
 
-my $found_errors = 0;
+	my ($name) = $arg =~ /^(.*?)\.txt$/s;
+	unless (defined $section) {
+		$TXT{$name} = $arg;
+		next;
+	}
 
-sub report {
-	my ($where, $what, $error) = @_;
-	print "$where: $error: $what\n";
-	$found_errors = 1;
+	$SECTION{$name} = $section;
 }
 
-sub grab_section {
-	my ($page) = @_;
-	open my $fh, "<", "$basedir/$page.txt";
-	my $firstline = <$fh>;
-	chomp $firstline;
-	close $fh;
-	my ($section) = ($firstline =~ /.*\((\d)\)$/);
-	return $section;
+my $exit_code = 0;
+sub report {
+	my ($pos, $line, $target, $msg) = @_;
+	substr($line, $pos) = "' <-- HERE";
+	$line =~ s/^\s+//;
+	print "$ARGV:$.: error: $target: $msg, shown with 'HERE' below:\n";
+	print "$ARGV:$.:\t'$line\n";
+	$exit_code = 1;
 }
 
-sub lint {
-	my ($file) = @_;
-	open my $fh, "<", $file
-		or return;
-	while (<$fh>) {
-		my $where = "$file:$.";
-		while (s/linkgit:((.*?)\[(\d)\])//) {
-			my ($target, $page, $section) = ($1, $2, $3);
+@ARGV = sort values %TXT;
+die "BUG: Nothing to process!" unless @ARGV;
+while (<>) {
+	my $line = $_;
+	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
+		my $pos = pos $line;
+		my ($target, $page, $section) = ($1, $2, $3);
 
-			# De-AsciiDoc
-			$page =~ s/{litdd}/--/g;
+		# De-AsciiDoc
+		$page =~ s/{litdd}/--/g;
 
-			if ($page !~ /^git/) {
-				report($where, $target, "nongit link");
-				next;
-			}
-			if (! -f "$basedir/$page.txt") {
-				report($where, $target, "no such source");
-				next;
-			}
-			my $real_section = grab_section($page);
-			if ($real_section != $section) {
-				report($where, $target,
-					"wrong section (should be $real_section)");
-				next;
-			}
+		if (!exists $TXT{$page}) {
+			report($pos, $line, $target, "link outside of our own docs");
+			next;
+		}
+		if (!exists $SECTION{$page}) {
+			report($pos, $line, $target, "link outside of our sectioned docs");
+			next;
+		}
+		my $real_section = $SECTION{$page};
+		if ($section != $SECTION{$page}) {
+			report($pos, $line, $target, "wrong section (should be $real_section)");
+			next;
 		}
 	}
-	close $fh;
-}
-
-sub lint_it {
-	lint($File::Find::name) if -f && /\.txt$/;
-}
-
-if (!@ARGV) {
-	find({ wanted => \&lint_it, no_chdir => 1 }, $basedir);
-} else {
-	for (@ARGV) {
-		lint($_);
-	}
+	# this resets our $. for each file
+	close ARGV if eof;
 }
 
-exit $found_errors;
+exit $exit_code;
-- 
2.31.1.622.g1b8cc22e65

