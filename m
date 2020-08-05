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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB564C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA6F2075D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8sgVgCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHEBTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgHEBTO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:19:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D97DC061756
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:19:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so39059721wrh.10
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g09DkUyyJitxKLSoaRxuNVFbdB7QVX7Nn2DMOu3eqko=;
        b=L8sgVgCFXNrAW27B4enJpLkk1aKLM4RdyWIxfrjXLZpJtMPsSA4vDXdL4jaXSO/M32
         2KZAztUIgj7+5xO/DEVoYm/BakmjXeTUJKPPzphoa5MowFfs+DnTGYn2Hfdczt3IIv99
         cuLBftxtsCEvKKgrXf9a3dPFdKvXZckIkxRv67CaWVK+mkUc5O1hLPfEcHURNjDr5FeB
         cIyzsilL+DMjPb/tfJh6JUWgmZ5OHkemcBhde6qAgo6gHdQ3MTwjFiQ5UNWsrbo7PBmn
         eXmlu39GQcG46bEIffJln5OerUJDfrAwWNpvJTxYsuv499vff7qagvdQh9pzJ3/duQbi
         zQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g09DkUyyJitxKLSoaRxuNVFbdB7QVX7Nn2DMOu3eqko=;
        b=H/bBDdCsT9LFlpoCeap2oSrY9At3v+tgKO8k92/L4T9957MKc/BETSxdj4juwtRVYq
         GA+tBUu/90evAozU0xQWQvAdTgSzBq+iFgKwVfwVQrD+mz4fVGm7HnlPuSm3GC9HHgfQ
         ygDaK/HPM4J24gdl+Srxz8nghxiVZIJlkGuZ/t8N02Q5bZPVeZnpvLDaWDvl2CCC8kfX
         64CIFhs6WrDKqDHb4vEiBaCpjuSZVh3kmKHwweIIIQLj77xWzRer3MAEJ9bggwV8iybf
         enHrQfCK7RJ998k7/Bu/pbG8EnCRaqdxc1TaKt7SvMQk8D/3duOEgi/Rt7nKDEEoDbUH
         OouA==
X-Gm-Message-State: AOAM532X9dbTqmdCBmZkAGpNpda//a/PKDjUj2F0f7lfIY8RunWBiGcv
        hlgTEvqfGiGleCZ+npuJdAQuwX6G
X-Google-Smtp-Source: ABdhPJxLXQG0P2ktSOt5NY1pOu5z7Z/80CqYFKTGXj7SF+hk2qqJX4MMO6n0lyrpaW8iy+repr+27g==
X-Received: by 2002:adf:f247:: with SMTP id b7mr542041wrp.128.1596590352761;
        Tue, 04 Aug 2020 18:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 130sm594429wme.26.2020.08.04.18.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:19:12 -0700 (PDT)
Message-Id: <840371fb4b7ec5ae5c5876be25f27008359dab9e.1596590347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.v3.git.1596590347.gitgitgadget@gmail.com>
References: <pull.691.v2.git.1596500459.gitgitgadget@gmail.com>
        <pull.691.v3.git.1596590347.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 01:19:07 +0000
Subject: [PATCH v3 4/4] git.txt: add list of guides
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

Also, do not hard-code the manual section '1'. Instead, use a regex so
that the manual section is discovered from the first line of each
`git*.txt` file.

This addition was hinted at in 1b81d8cb19 (help: use command-list.txt
for the source of guides, 2018-05-20).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/Makefile      | 1 +
 Documentation/cmd-list.perl | 7 ++++++-
 Documentation/git.txt       | 7 +++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index eb9c7e2b0e..80d1908a44 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -295,6 +295,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-plumbingmanipulators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
+	cmds-guide.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index ee96de53db..af5da45d28 100755
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
