Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD0C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE1520722
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqs2TcGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgHDAVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgHDAVD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:21:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B2C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:21:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so25787852wrm.6
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fv47CySepGAX8L40Rn+k15lhTK+mX6d87K6J5asf3xw=;
        b=Sqs2TcGa+ToCe3lSFHWSOzLgtttCA0KYecP77MCSKknExlKAg1ACucHTVSME2XV7JJ
         0BFuilq3IoqBp+TdvU/wUTcu2Rif2M41Me6WbkMhFFm29pjOakSLmowyJn4oaZsaNtqi
         uZwGW+b5Rb8tnDDkTvs9e2iQDg9FX71kxdYudS0cVcT+KKeLM4Ib/WEQ7LJF4jDh6h3d
         9BYjpP17elSN8Wp3AN/m+YWXq1vmJB4xmTDbsV28PL/0GXFwolVwCtu7HkCpU4CwBnqE
         v83pW9rm/5l1UiLN4xR/rjrttJkOiIUzg5v4a3fkNe/h6kmhT0P0wbVnICzgI2Z8VYVN
         Ha6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fv47CySepGAX8L40Rn+k15lhTK+mX6d87K6J5asf3xw=;
        b=YrbDSZ97VlG1yARDtx86J62G6FkeNUvZMkl38JRkAGrQgUt31pEqtODKJeIj3FYXNI
         Dh20Ku1VRsnxqJMZtx4Y0YyLm3DehxTfD5xo6oY2g1jQFxyXUSOl1vB6ZVIeSEqdW3ee
         4x054yO0dVK8ZiABEUeLfC8aOig9xxGF/zd6/gGH9s2LD59cLBAasTRumwHvxfcRvEN4
         O0zz6k3MK78H0yfl9nexx2W+oncTCTL7J11+rdKjHxP2lawLcNn4q/ZQiKkVppJ368/h
         raUlqJvAWIRwjNz0QgfIcAQUxNwIT6l93Nvq0Q5RWhD+C9zVF1SeyGzdlnrPbZQvA3IZ
         xu6Q==
X-Gm-Message-State: AOAM532YCrRPElmJcoW8QPSagXU4FDKlRgi3JpFluCaQvh7sMGiohmIM
        0K4HyTjYzK2Gzh9nvEXU2QD2bNRL
X-Google-Smtp-Source: ABdhPJwfXMRB3QIEMp2FdELvfmWA5cqdd08MQ701rpIoHXfHQS61Uw7D0sVffyyVR4308QJQR/zWDw==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr17788141wrs.27.1596500461218;
        Mon, 03 Aug 2020 17:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm30828499wrg.38.2020.08.03.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 17:21:00 -0700 (PDT)
Message-Id: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.git.1596381647.gitgitgadget@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Aug 2020 00:20:56 +0000
Subject: [PATCH v2 0/3] List all guides in git(1)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * Incorporated Junio's suggestion to reduce duplication.

v1: This series adds a list of the guides to git(1).

The first commit adds the misssing guides 'gitcredentials' and
'gitremote-helpers' to command-list.txt. The only missing guide after this
change is 'gitweb.conf', but I think this one is obscure anough, and already
linked to in 'gitweb.txt', that it does not matter much.

The second commit drops the usage of 'common' and 'useful' for guides. This
was suggested as one of two ways forward by Duy in [1] but was not commented
on. I'm CC'ing the people that were CC'ed on that message.

The third commit tweaks 'Documentation/cmd-list.perl' so that it also
generates a list of the guides, which gets included in 'git.txt'. I chose to
put this list just after the end of the list of commands.

[1] 
https://lore.kernel.org/git/CACsJy8ADj-bTMYDHxRNLOMppOEdPbVwL49u3XCfNBCmoLLZo+A@mail.gmail.com/

Philippe Blain (3):
  command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'
  help: drop usage of 'common' and 'useful' for guides
  git.txt: add list of guides

 Documentation/Makefile           |  4 +++-
 Documentation/cmd-list.perl      | 27 ++++++++++++++-------------
 Documentation/git-help.txt       |  6 +++---
 Documentation/git.txt            |  7 +++++++
 Documentation/gitcredentials.txt |  2 +-
 builtin/help.c                   |  2 +-
 command-list.txt                 |  2 ++
 help.c                           |  4 ++--
 help.h                           |  2 +-
 9 files changed, 34 insertions(+), 22 deletions(-)


base-commit: e8ab941b671da6890181aea5b5755d1d9eea24ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-691%2Fphil-blain%2Flist-guides-in-git.1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-691/phil-blain/list-guides-in-git.1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/691

Range-diff vs v1:

 1:  2bd473e0aa = 1:  2bd473e0aa command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'
 2:  f49cf08f4f = 2:  f49cf08f4f help: drop usage of 'common' and 'useful' for guides
 3:  9374d80f0c ! 3:  4394bb357b git.txt: add list of guides
     @@ Metadata
       ## Commit message ##
          git.txt: add list of guides
      
     -    Not all guides are mentioned in the 'git(1)' documentation,
     +    Not all man5/man7 guides are mentioned in the 'git(1)' documentation,
          which makes the missing ones somewhat hard to find.
      
     -    Add a list of the guides to git(1).
     +    Add a list of the guides to git(1) by leveraging the existing
     +    `Documentation/cmd-list.perl` script to generate a file `cmds-guide.txt`
     +    which gets included in git.txt.
      
     -    Tweak `Documentation/cmd-list.perl` so that it also generates
     -    a file `cmds-guide.txt` which gets included in git.txt.
     +    Instead of hard-coding the list of command categories in both
     +    `Documentation/Makefile` and `Documentation/cmd-list.perl`, make the
     +    Makefile the authoritative source and tweak `cmd-list.perl` so that it
     +    receives the list of command categories as argument.
      
          Also, do not hard-code the manual section '1'. Instead, use a regex so
          that the manual section is discovered from the first line of each
     @@ Commit message
          This addition was hinted at in 1b81d8cb19 (help: use command-list.txt for
          the source of guides, 2018-05-20).
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     + ## Documentation/Makefile ##
     +@@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
     + 	cmds-plumbingmanipulators.txt \
     + 	cmds-synchingrepositories.txt \
     + 	cmds-synchelpers.txt \
     ++	cmds-guide.txt \
     + 	cmds-purehelpers.txt \
     + 	cmds-foreignscminterface.txt
     + 
     +@@ Documentation/Makefile: $(cmds_txt): cmd-list.made
     + 
     + cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
     + 	$(QUIET_GEN)$(RM) $@ && \
     +-	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
     ++	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) $(QUIET_STDERR) && \
     + 	date >$@
     + 
     + mergetools_txt = mergetools-diff.txt mergetools-merge.txt
     +
       ## Documentation/cmd-list.perl ##
      @@ Documentation/cmd-list.perl: sub format_one {
       	my ($out, $nameattr) = @_;
     @@ Documentation/cmd-list.perl: sub format_one {
       			print $out "(deprecated) ";
       		}
      @@ Documentation/cmd-list.perl: sub format_one {
     - 		synchingrepositories
     - 		foreignscminterface
     - 		purehelpers
     + 	}
     + }
     + 
     +-while (<>) {
     ++my ($input, @categories) = @ARGV;
     ++
     ++open IN, "<$input";
     ++while (<IN>) {
     + 	last if /^### command list/;
     + }
     + 
     + my %cmds = ();
     +-for (sort <>) {
     ++for (sort <IN>) {
     + 	next if /^#/;
     + 
     + 	chomp;
     +@@ Documentation/cmd-list.perl: sub format_one {
     + 	$attr = '' unless defined $attr;
     + 	push @{$cmds{$cat}}, [$name, " $attr "];
     + }
     ++close IN;
     + 
     +-for my $cat (qw(ancillaryinterrogators
     +-		ancillarymanipulators
     +-		mainporcelain
     +-		plumbinginterrogators
     +-		plumbingmanipulators
     +-		synchingrepositories
     +-		foreignscminterface
     +-		purehelpers
      -		synchelpers)) {
     -+		synchelpers
     -+		guide)) {
     - 	my $out = "cmds-$cat.txt";
     +-	my $out = "cmds-$cat.txt";
     ++for my $out (@categories) {
     ++	my ($cat) = $out =~ /^cmds-(.*)\.txt$/;
       	open O, '>', "$out+" or die "Cannot open output file $out+";
       	for (@{$cmds{$cat}}) {
     + 		format_one(\*O, $_);
      
       ## Documentation/git.txt ##
      @@ Documentation/git.txt: users typically do not use them directly.

-- 
gitgitgadget
