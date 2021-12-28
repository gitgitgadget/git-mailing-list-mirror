Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82F6C433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhL1PgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbhL1PgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53249C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j18so39103344wrd.2
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NDjEZZSOLnBWWaHBj3GfCICXj9kqQTdbqBCBzFNel0A=;
        b=jVfojpy6Mn9QcXIr+z2taKVPkRd+rCnXiUCvO1pgLWf32GMeDf1TEIWbttpK0ZjwIU
         bRv0sSsrS4+kf67eytZ7ijJzgjbGjQ96Sgm8i5E1X+8n2tkWJjR8becp1dKzay+k199Q
         VSFjNp1Br8XttVLlnKPqKXMRRpBw+walHVGfXZv8rUHdyFmaQxx0McenOGIYOdqJVGtP
         gwGgOC3V343/+GH3g83hZXczgvZoVHV4Dwc12kdSHx5hluqC/2ejsIVMEEoH1hXywI6X
         VNEqO2JZWFRl+LgatFPXOHvZnisVdV6n1du2etiZq9EcfmTbfv2rb/I5SwFhhiJSRYKI
         V9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NDjEZZSOLnBWWaHBj3GfCICXj9kqQTdbqBCBzFNel0A=;
        b=E0zgTAOaY9FKFQxK/FbrqcxOTdJXsCHEvQHoF5JzpdVG4FmABdHfLvA4RRTQ7kwG0S
         tOo8BIQmI6YZ1B09lDroc6uSqby6gUgFa9l3OG6MP+9GR4y4prX5p2T+xEA1MQEhT06W
         TcvficRD/BmxoqYcWdBPFydi0MzAsSWH5viV3a6lBjiwfdQZied/Kmbqz/d2SSv+f+cu
         4FyqIq9LRyIIYxRHoSE1j/kAp6BfGaYuGe8FUNCnNcaoWle/n3apTxN/hKwUs7KTqcqe
         2B0SU5ulQ8kwJVAXtBBvn6pfLX0sIXojlPAze0c+a9Nuxinvuc9V7HFhJSi3u4sWmlgX
         jKPQ==
X-Gm-Message-State: AOAM5339MtNYauurub7dUd8PfEZo61/iir8W+kZVLqH3cv35PZTZAWCC
        qRFH5U28K2dCIVor2cqgCwRFMg2XlKSBCgbb
X-Google-Smtp-Source: ABdhPJwrQgukKVnRpr/VeSDvohjn+HpHIvOMVTpttF/GUM6exO01soFFmqc4nF4B0wXh9ytBs9fkGg==
X-Received: by 2002:adf:d1ef:: with SMTP id g15mr17016046wrd.47.1640705781662;
        Tue, 28 Dec 2021 07:36:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:21 -0800 (PST)
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
Subject: [PATCH 3/7] help tests: test "git" and "git help [-a|-g] spacing
Date:   Tue, 28 Dec 2021 16:35:08 +0100
Message-Id: <patch-3.7-3956937cf3b-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
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
index 91b68c74a15..6ac293c19ed 100755
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
 	git --list-cmds=builtins >builtins
 '
-- 
2.34.1.1257.g2af47340c7b

