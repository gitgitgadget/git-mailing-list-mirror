Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ADDC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6331D2075B
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkBsd2xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHBPU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHBPUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 11:20:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E0C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 08:20:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so31898298wrj.13
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pY8MAimXC+Ydvva3KsJj/smjr9DDkvPQjhoULrp2DRE=;
        b=AkBsd2xFZxHnOSS2X+WFFk92zhn9zVav02mvn4OKu7rGnVpyz2pocusiJuYUrzAmti
         oVaNgEhwFCpXWChFiEvVC8RWk++KdKYTMi8t5VxawG2jwAuXpaZi+eppiwVO9hmN6sFp
         dR7IokFFvuAoD5ntVD/Gf8ogc+ofXSJG+3CH/lZI3xksQRdNdxG8xYYePtzHzwoBagfN
         PeoOZNMTT3JMe1drgdI4yKX+I1doQgv4OuKfYJh6fMqWmbVria3Y96yBIdFwIEuEGi85
         Ir9cG6epRHy3GDWzQsOatIYAEEdD9k6LU8f4cpgKyBfQMqqKlaFlWqXds6TdwH+5KD78
         PPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pY8MAimXC+Ydvva3KsJj/smjr9DDkvPQjhoULrp2DRE=;
        b=Z6PMv54jkFt1E5EonbjHKjnhccIbO2k2PC86GCyUifbsL5YwXLoVJ6YcrqmOoNbDv6
         a9niH3715jGYYD1fa/HlnmC0MCZ+rAXLW+q7wkkqRvSY7aakiXf2JVFRa0iFJjVsb3Li
         O9E/7MKF8F7mdDkTnJXLn2TnKeD+itJ7egFKGxAN1zrdvipqBTrvt51L3ohkcTNqqqmr
         TIPo7R8KTLUfTOpy+MoRKGqsCf9jbXvDb3J2f2G2nvKPbEokiLt7N+IY3Ymor7yP2vMb
         jk5Rth8L6Wy3CbC3BE6PsHBTtkw7wn7cBkV8RjYbFw9RInXspCsv71oem6XNWOQMX+F0
         SsQQ==
X-Gm-Message-State: AOAM533WENh3gyA2PqkPya2EGh4gFhWT+x9DA8E+hIOQv0hi69g2G/V7
        h0omwnx4UQPm08wMQDtKoWlPLgYI
X-Google-Smtp-Source: ABdhPJxXrOy4T7qjOY/IaKBRsK1TmQPo5VDM3GOthu6mcAJEOPcP25KV5OV2x/JEMxO55GE5d/c4OA==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr11248081wru.272.1596381651405;
        Sun, 02 Aug 2020 08:20:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm21717016wru.27.2020.08.02.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 08:20:51 -0700 (PDT)
Message-Id: <9374d80f0c37a6b6a7f5f76601ee757f89712d0c.1596381647.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.691.git.1596381647.gitgitgadget@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 15:20:47 +0000
Subject: [PATCH 3/3] git.txt: add list of guides
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

Not all guides are mentioned in the 'git(1)' documentation,
which makes the missing ones somewhat hard to find.

Add a list of the guides to git(1).

Tweak `Documentation/cmd-list.perl` so that it also generates
a file `cmds-guide.txt` which gets included in git.txt.

Also, do not hard-code the manual section '1'. Instead, use a regex so
that the manual section is discovered from the first line of each
`git*.txt` file.

This addition was hinted at in 1b81d8cb19 (help: use command-list.txt for
the source of guides, 2018-05-20).

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/cmd-list.perl | 10 ++++++++--
 Documentation/git.txt       |  7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 5aa73cfe45..99f01a0910 100755
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
@@ -60,7 +65,8 @@ sub format_one {
 		synchingrepositories
 		foreignscminterface
 		purehelpers
-		synchelpers)) {
+		synchelpers
+		guide)) {
 	my $out = "cmds-$cat.txt";
 	open O, '>', "$out+" or die "Cannot open output file $out+";
 	for (@{$cmds{$cat}}) {
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
