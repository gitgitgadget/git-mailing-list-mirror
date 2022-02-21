Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AFDC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiBUTjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiBUTja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00339220C0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so35896818ejc.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAUpehjSe0Pv9RdimtFDeEwfli4XGlL7DRRsUzF5nMk=;
        b=gmqR2rKL2jAO8j3wXIlyD3WhQlqmKaYSWbGiCSvNtfItVMshZ/HZoknERZx6HFI99H
         RjBbeUxbOx9uj7uWKaC5jUXLcvX50ACHphEZpnlJFxcshN7VpHCeG0Y1uAD6Lo73WNNC
         ZbqaX3+MKJmfoVYIh9eBE3c57tyChZQdHxz8klEJ22jXXSjuwIPX6is2PVPjHb/0ntM1
         CjNatVGwOHVqBgWOH4pK/c0olGJgpY1ivx/VfVKdKlBOzEe2MD13ipfEXDcjDfqAPvGz
         22e8aa2a1hwPLoFuL5M7pyxyAupSPAIqy9UZi8S2Sj691hjxQJG9dXc4RkHy4gPz+do+
         Y3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAUpehjSe0Pv9RdimtFDeEwfli4XGlL7DRRsUzF5nMk=;
        b=2RNT4rRRrFGAp4XKVVw7uXDA27GXCBMhSNnqeOx7SrGoyEIwn8Xmiyo4mBy0nnwWRt
         HQuj/7k0CTZzNIVNbQ2Gx/xx4Cavziq/qLS4f9O5ifHfoQKTNh5TGK/r8lgqcq63j5Ap
         msnzdeafrhfpRWm6hiWKl7seOv6+Gfe+x53h8BdrhnEZjTkIwQGzWhHN5l2C8ytrz6LH
         jF1ykHorKjS0L71xm+UrXbSoVABZIlHJzitoOqwfbCCkDDyoYaaR/D81mLTeUGbRKytp
         xxGt2ee2FJps3AQ8UjycKjJMCIA81rSRdkzw5uXfXCrFeSviVq/+Fydysb76b+UYMCBU
         S2Rg==
X-Gm-Message-State: AOAM530FfH7K/AWbzpgTTTULCrQZdBfrEh5oI8GhbLGucUWtzNqYRCzA
        pnW3TLXfrfFSRa1xOa9dIB+5m9onoc949A==
X-Google-Smtp-Source: ABdhPJz9+46Xr26hgTS7QR3yqOQgC5SeUWL1Jiod9qdIHRLarmW77oYwI2l+OHi9uUPpvtyVnXUnPw==
X-Received: by 2002:a17:906:6716:b0:6cc:7d95:90af with SMTP id a22-20020a170906671600b006cc7d9590afmr16718270ejp.442.1645472340000;
        Mon, 21 Feb 2022 11:39:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:38:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] help tests: test "git" and "git help [-a|-g] spacing
Date:   Mon, 21 Feb 2022 20:38:46 +0100
Message-Id: <patch-v2-3.9-3e39116f197-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's logic in "help.c"'s "print_cmd_by_category()" to emit "help"
output with particular spacing, which doesn't make much sense when
emitting only one section with "help -g".

Let's add tests for the current spacing in preparation for a
subsequent whitespace formatting fix, and make sure that that fix
doesn't cause regressions for the "git" and "git help" output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0012-help.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index cbd725ccac8..9ac3f5d3c4b 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -138,6 +138,51 @@ test_expect_success 'git help --config-sections-for-completion' '
 	test_cmp human.munged sections
 '
 
+test_section_spacing () {
+	cat >expect &&
+	"$@" >out &&
+	grep -E "(^[^ ]|^$)" out >actual
+}
+
+test_section_spacing_trailer () {
+	test_section_spacing "$@" &&
+	test_expect_code 1 git >out &&
+	sed -n '/list available subcommands/,$p' <out >>expect
+}
+
+
+for cmd in git "git help"
+do
+	test_expect_success "'$cmd' section spacing" '
+		test_section_spacing_trailer git help <<-\EOF &&
+		usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
+
+		These are common Git commands used in various situations:
+
+		start a working area (see also: git help tutorial)
+
+		work on the current change (see also: git help everyday)
+
+		examine the history and state (see also: git help revisions)
+
+		grow, mark and tweak your common history
+
+		collaborate (see also: git help workflows)
+
+		EOF
+		test_cmp expect actual
+	'
+done
+
+test_expect_success "'git help -g' section spacing" '
+	test_section_spacing_trailer git help -g <<-\EOF &&
+
+	The Git concept guides are:
+
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'generate builtin list' '
 	mkdir -p sub &&
 	git --list-cmds=builtins >builtins
-- 
2.35.1.1132.ga1fe46f8690

