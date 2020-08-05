Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F80C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6262075D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHTc2Epw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHEBTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgHEBTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:19:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA760C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:19:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a14so39095158wra.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NohGUJkTNz8tQXtFpefX4F1oprCF9XsxPxI3ZjPbScI=;
        b=aHTc2Epw9WkbpEoYDPnjxhya/2MmJrgEnnY2xBhoxcJCeEf4UbF8E+HLWT+XkoHPos
         MFVCPtwkWAd9zmyjPqToXR17eD0P+w9bG4PeVpA00WXM+9miclbAn7zJRyMJmvWBsUGE
         fZC3QAb/kZCLxtaD7cpgEgL5NJ3qRCf5XcnYGuDW7CgzkJZH2UpE58AoL3HwpG/a9X0d
         8TSApG3OKw+EJUftkLomOzHPLRTDk73fRLcmOIG9D36sgxSWbp+UrDSSLo5u9md4Tvdl
         DEdWLTt3Top5l4PntpX0P0FmMKnkkXJy9RtV8X3qeDYv0v5H5FyUaQmk//g0SW3/+Rnb
         GX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NohGUJkTNz8tQXtFpefX4F1oprCF9XsxPxI3ZjPbScI=;
        b=XSXBXHN9EpFB+j3gM++3ifaVGly3NZPLPMDKosz7HChfEDpqXkRWZqUChz01H3z/l9
         60Fp9TNtpf3yRmht1EGnMv9+dha50EBPqFbkdHCh5zVoJcnu7Bar6rtvi41RVXMvPVNY
         aVwJFTZ8KTAN8zu91lYN1henucAw5yYDLuoJtK8kE2vYdfYpf9e48BBhLYWRWYc9EwWC
         eSbruD3BVXFwhWu1kPROKHOz8pg3XYDbuGfp41OOh7/5TYP1CK6Ywa9SL0LoLfL0QRLE
         6rn9P3MjsrI2iBfA+4nA2w0XaAgodaSgWwvThNp4rfp7bpC4lPUrJvY8fDK+18T1EBud
         Y0oQ==
X-Gm-Message-State: AOAM5311bBPlyTsiJUOeoMOPQgnUvK3e+mrkl+Mvftrqq2N3k5BLKb3U
        h0P+X978BdtKAdmwvdwSMFssZeVi
X-Google-Smtp-Source: ABdhPJzDf8e1Z6IBQ9VzKnBZFhnHnOxQjzfQPuaUfJJnxj2Wr5udhjkZbilIy8vSFkwAu0/6jtRtHg==
X-Received: by 2002:adf:e382:: with SMTP id e2mr506333wrm.306.1596590352045;
        Tue, 04 Aug 2020 18:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189sm575489wmf.47.2020.08.04.18.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:19:11 -0700 (PDT)
Message-Id: <552444a84241d280640c4700f17477a9c297fb73.1596590347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.v3.git.1596590347.gitgitgadget@gmail.com>
References: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
        <pull.691.v3.git.1596590347.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 01:19:06 +0000
Subject: [PATCH v3 3/4] Documentation: don't hardcode command categories twice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Instead of hard-coding the list of command categories in both
`Documentation/Makefile` and `Documentation/cmd-list.perl`, make the
Makefile the authoritative source and tweak `cmd-list.perl` so that it
receives the list of command categories as argument.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/Makefile      |  2 +-
 Documentation/cmd-list.perl | 20 ++++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 39f6fc8de7..eb9c7e2b0e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -302,7 +302,7 @@ $(cmds_txt): cmd-list.made
 
 cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(QUIET_GEN)$(RM) $@ && \
-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
+	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
 	date >$@
 
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5aa73cfe45..ee96de53db 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -38,12 +38,15 @@ sub format_one {
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
@@ -51,17 +54,10 @@ sub format_one {
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
-- 
gitgitgadget

