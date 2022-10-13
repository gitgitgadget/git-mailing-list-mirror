Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DCFC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiJMPmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJMPlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:41:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D686FA5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bv10so3454579wrb.4
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogw9KzZuvP4emeildCPJG4XbQAo9e2oxhj9e6vUhVCQ=;
        b=HmmeKpMbDhqfn6lyOC+Xo+r/NYsWe7Y0Lnb340jywyqeF3YXop/pQHe+XykkS7PnKh
         gejzNC39nbSK7EcTSOcFfOSlkI4GqllYVUJsxy1pM1D+N4Fu9+X3s5EWcG3nxh5EdYTD
         mQ4cUuMQzwCyt2zbu36ssdvlsBQe5m80JscYnY6q7CoS4dBD0epYVSgND3Xz4zQccXTv
         xMPlNLXqo4KDOGAM9KS2CEUy35fqrdAgytzjyjsyK0ynjfzJtFzLn8teHIlORLMxQ2YD
         5aEO90a6vki6lCy3btL/CviqQrZlrVOFYWa1sIjumf1eRPqls61jNgk7/TsQ76qsQQve
         A9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogw9KzZuvP4emeildCPJG4XbQAo9e2oxhj9e6vUhVCQ=;
        b=NbJZlUFW6307rFMK1LDfuKiveE24/LdXrIa60NgaG2B6yIPASObrXhvyIfpCGeU8O3
         2jkVqC3x3xY4hWbUdJCz3fzPxeQRwPFN7fr80D0OoAdng8bPcLbAyMCLur9Qil1yUwz8
         Uobg5i9XREX5h+R3B+zNYcDcZxXGi6FfRcAC8tc9BnsGSYCzBIJCn/C7RUKo51SltChh
         hBHrbSnnP+DPNw9NvDMeWFZlY1ghTvU9JBWe/XvpIfh7yPb00iwRw/Pa+q38tALNjwEj
         wJBEthiNwoqu3104uebpjd1djjrijNcV4wT3why1ii03ke3T7xQQhAdZZdG8wb8JhDUS
         ARrA==
X-Gm-Message-State: ACrzQf3ER00xBHdHjoJK6LdD5tscWs+aNs/3nsZf+sxqwKZYixTamIzD
        U9JCI8WTL0hL/AF0MOdLBuHB28OrjKAz8A==
X-Google-Smtp-Source: AMsMyM56PnDpszvM4B5Mf0joYXqhs2P1hgsTSAJ+cTC65T1sDY2wVqf9lxLPfDyf4x5CZSCPGJLIhQ==
X-Received: by 2002:a5d:5585:0:b0:22d:f0cd:e3b9 with SMTP id i5-20020a5d5585000000b0022df0cde3b9mr377792wrv.347.1665675611522;
        Thu, 13 Oct 2022 08:40:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:40:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 34/34] tests: assert consistent whitespace in -h output
Date:   Thu, 13 Oct 2022 17:39:28 +0200
Message-Id: <patch-v5-34.34-4de83d3d89a-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the *.txt and *.c output assertions which asserts that
for "-h" lines that aren't the "usage: " or " or: " lines they start
with the same amount of whitespace. This ensures that we won't have
buggy output like:

   [...]
   or: git tag [-n[<num>]]
               [...]
       [--create-reflog] [...]

Which should instead be like this, i.e. the options lines should be
aligned:

   [...]
   or: git tag [-n[<num>]]
               [...]
               [--create-reflog] [...]

It would be better to be able to use "test_cmp" here, i.e. to
construct the output we expect, and compare it against the actual
output.

For most built-in commands this would be rather straightforward. In
"t0450-txt-doc-vs-help.sh" we already compute the whitespace that a
"git-$builtin" needs, and strip away "usage: " or " or: " from the
start of lines. The problem is:

 * For commands that implement subcommands, such as "git bundle", we
   don't know whether e.g. "git bundle create" is the subcommand
   "create", or the argument "create" to "bundle" for the purposes of
   alignment.

   We *do* have that information from the *.txt version, since the
   part within the ''-quotes should be the command & subcommand, but
   that isn't consistent (e.g. see "git bundle" and "git
   commit-graph", only the latter is correct), and parsing that out
   would be non-trivial.

 * If we were to make this stricter we have various
   non-parse_options() users (e.g. "git diff-tree") that don't have the
   nicely aligned output which we've had since
   4631cfc20bd (parse-options: properly align continued usage output,
   2021-09-21).

So rather than make perfect the enemy of the good let's assert that
for those lines that are indented they should all use the same
indentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 8fd20b6dba6..cd3969e852b 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -96,6 +96,21 @@ do
 		check_dashed_labels "$(help_to_synopsis "$builtin")"
 	'
 
+	test_expect_success "$builtin -h output has consistent spacing" '
+		h2s="$(help_to_synopsis "$builtin")" &&
+		sed -n \
+			-e "/^ / {
+				s/[^ ].*//;
+				p;
+			}" \
+			<"$h2s" >help &&
+		sort -u help >help.ws &&
+		if test -s help.ws
+		then
+			test_line_count = 1 help.ws
+		fi
+	'
+
 	txt="$(builtin_to_txt "$builtin")" &&
 	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-- 
2.38.0.1085.gb7e61c3016c

