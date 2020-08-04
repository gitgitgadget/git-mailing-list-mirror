Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB1C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2320722
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLnU6hGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgHDAVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHDAVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:21:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E29FC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:21:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y3so35750468wrl.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HS3xHrLK4gIL9VyQx5QUemN3ASzGtxWxUKZQ1AvbCEo=;
        b=tLnU6hGG2p3XPhtK7jms6zhExzvvs4NDvaFDoOHKKQEy+OecogkBq1sjguCH4z2I01
         l9VwyMnf7fcKt78Khonsri4D7f23MjqmVRAYzd1IuDyEhL+Zac7zyLy0xo3T5ph9ppjj
         pFt9ifaqtFemFy8htMy1JhW2qXwx91Daort4kpq5GUNn4OLz5uDyfF8okWdx6fvfX0Xc
         xi6u/AHpf2vXUEwTDX8+RHXKWuKqpe4VJxpBHCJkdtmQhAw41SmYp/ZwoMz3WiA3z531
         cYB+RehOmfqQvehSQSN9Pw8m0ZX1golsYYRBMCZt3GKb8+Kv6olchB/NKQSAIcXGV9cN
         s5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HS3xHrLK4gIL9VyQx5QUemN3ASzGtxWxUKZQ1AvbCEo=;
        b=C4EModMpxt2DkfUQfKH71QSBBuMBJKcWyvu5o/121kNrjA0vXvWxiWw1Lb0hgXwSY6
         wokR5L7z3uVYyF75y1rgO2itk1HmIE9T8iia3YdPPOHEMYUd3TS89wcsIrBXuIsW4Nxd
         rSKmlwV/PDO0q8AoU1YWcDbYGYJMYS4AHfiERWFjH1nfVjFMCHifOIzKg53/ojltOYhk
         CvcaLx02YK79mD+h1UVkam0C8DJ6nqwJp5YDGD+u2r/v7VU7m2AGg9Rq9k4zbzo8xevN
         3lSXR0CqVRLpVuzggz3WoFgt3jE2KEz0keQrIhMA90Zxw1PY5KDnMICq1UBoTWW1HS9e
         ugFA==
X-Gm-Message-State: AOAM532VQdQayw80imx7UlK1PDPVZDkl3fb4lmwWvE8MaRrkKQsOBZWP
        unvdufa14A2hD7EHEe9o3gNJgU+M
X-Google-Smtp-Source: ABdhPJzSwQoUejvj8Nl3A9DPE5LimQyiQcj/mkp4HYALYyNd6fgS4b031LNqa+2YPMZ0sQi0j0jT5g==
X-Received: by 2002:adf:c981:: with SMTP id f1mr16841255wrh.14.1596500463668;
        Mon, 03 Aug 2020 17:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s205sm2194312wme.7.2020.08.03.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:21:03 -0700 (PDT)
Message-Id: <4394bb357b5e7025618665c4f7b387d4d37f3a84.1596500460.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
        <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Aug 2020 00:20:59 +0000
Subject: [PATCH v2 3/3] git.txt: add list of guides
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Not all man5/man7 guides are mentioned in the 'git(1)' documentation,
which makes the missing ones somewhat hard to find.

Add a list of the guides to git(1) by leveraging the existing
`Documentation/cmd-list.perl` script to generate a file `cmds-guide.txt`
which gets included in git.txt.

Instead of hard-coding the list of command categories in both
`Documentation/Makefile` and `Documentation/cmd-list.perl`, make the
Makefile the authoritative source and tweak `cmd-list.perl` so that it
receives the list of command categories as argument.

Also, do not hard-code the manual section '1'. Instead, use a regex so
that the manual section is discovered from the first line of each
`git*.txt` file.

This addition was hinted at in 1b81d8cb19 (help: use command-list.txt for
the source of guides, 2018-05-20).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/Makefile      |  3 ++-
 Documentation/cmd-list.perl | 27 ++++++++++++++-------------
 Documentation/git.txt       |  7 +++++++
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 39f6fc8de7..80d1908a44 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -295,6 +295,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-plumbingmanipulators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
+	cmds-guide.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
@@ -302,7 +303,7 @@ $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(QUIET_GEN)$(RM) $@ && \
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
+	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
 	date >$@
 
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5aa73cfe45..af5da45d28 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -6,9 +6,14 @@ sub format_one {
 	my ($out, $nameattr) = @_;
 	my ($name, $attr) = @$nameattr;
 	my ($state, $description);
+	my $mansection;
 	$state = 0;
 	open I, '<', "$name.txt" or die "No such file $name.txt";
 	while (<I>) {
+		if (/^git[a-z0-9-]*\(([0-9])\)$/) {
+			$mansection = $1;
+			next;
+		}
 		if (/^NAME$/) {
 			$state = 1;
 			next;
@@ -27,7 +32,7 @@ sub format_one {
 		die "No description found in $name.txt";
 	}
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
-		print $out "linkgit:$name\[1\]::\n\t";
+		print $out "linkgit:$name\[$mansection\]::\n\t";
 		if ($attr =~ / deprecated /) {
 			print $out "(deprecated) ";
 		}
@@ -38,12 +43,15 @@ sub format_one {
 	}
 }
 
-while (<>) {
+my ($input, @categories) = @ARGV;
+
+open IN, "<$input";
+while (<IN>) {
 	last if /^### command list/;
 }
 
 my %cmds = ();
-for (sort <>) {
+for (sort <IN>) {
 	next if /^#/;
 
 	chomp;
@@ -51,17 +59,10 @@ sub format_one {
 	$attr = '' unless defined $attr;
 	push @{$cmds{$cat}}, [$name, " $attr "];
 }
+close IN;
 
-for my $cat (qw(ancillaryinterrogators
-		ancillarymanipulators
-		mainporcelain
-		plumbinginterrogators
-		plumbingmanipulators
-		synchingrepositories
-		foreignscminterface
-		purehelpers
-		synchelpers)) {
-	my $out = "cmds-$cat.txt";
+for my $out (@categories) {
+	my ($cat) = $out =~ /^cmds-(.*)\.txt$/;
 	open O, '>', "$out+" or die "Cannot open output file $out+";
 	for (@{$cmds{$cat}}) {
 		format_one(\*O, $_);
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3e50065198..81349a84e7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -304,6 +304,13 @@ users typically do not use them directly.
 
 include::cmds-purehelpers.txt[]
 
+Guides
+------
+
+The following documentation pages are guides about Git concepts.
+
+include::cmds-guide.txt[]
+
 
 Configuration Mechanism
 -----------------------
-- 
gitgitgadget
