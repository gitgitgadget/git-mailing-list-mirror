Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512DC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJJQ5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJJQ5u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:57:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0195A2D5
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:57:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv10so14362909wrb.4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YadAueWz+VItvd8irIOHxvzpwMHq/yNk+a4uavoavIs=;
        b=Whssk1mmWbh0I5MAL8OnSi518a/+xKxln1FGU4N2x62UbXmdRH2iOBZq6Ph7qgmOGp
         g+Rq0lBsr+yn547I4+XVIkYZ/NBtjz5v/fwKjK5OW5kPT3e3s2BpSJtkhReV3qGEQCfp
         HrLh8LZguMfwEVmJK0LX78f4MjDVz6d8rK9K7o7YnJ/9WQoo5t8qqAuBi+Ed9LF9pwJK
         BFLiS/YWehYlfBCd7MvJYUNEt9QtouYzbcmFQyXSrpHE3R7o8ApRBQk9VzPu6MqffJD2
         MZBjTck8lGCXig7oMp6ogUmoBXSDkAT4G132ghdHk3YIBoqzsZb5F4UCTV82a8iYucxy
         umjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YadAueWz+VItvd8irIOHxvzpwMHq/yNk+a4uavoavIs=;
        b=f9q/uUhaSH6wVpNGtMzamhxNJ8DgiPoDhd5fnNPZdzEI7mHzp5T9w5lGLLusReCEf8
         /cNZQriDdUbL/pRCc/9Ulng2tgvrBG32DTtf8vFW9Y4I2UAr+Q43PXkDTi99keaFwDWy
         4ndEcc2PDLqgtwHvtZwRQV/QRcBpSdnZ2Dp/CKGUg4Te8m9C5xg1Maq/LFT4Xb5poM7W
         KBnZjMKYV/pDyw41GJPd8XaSsnUiZIU62901aVS0dkPd0s3MRv0R0AqbPQk2IjCLsQyr
         ijbTdiFoPp7J84Cj8rHuNtlZaLskC4DJw2L0/WZeIQif3bDrmtRP/mUfDthb09zY73rQ
         6gtg==
X-Gm-Message-State: ACrzQf3MdBq9HWyVfCRpEjVMROKMiChxjrVa//ThZoNZbgTc0PLqlsro
        07ouV4GOhuvQvKJ85Aab49mpK+mGBAs=
X-Google-Smtp-Source: AMsMyM6RPG2kQePD57IYBliFTMsKMZGGfJStpNbMJtyirLNtNy2UnxYaVVGLjDq9i9Nxo2MNe1TtxA==
X-Received: by 2002:a5d:428c:0:b0:22e:5d4e:c71e with SMTP id k12-20020a5d428c000000b0022e5d4ec71emr11863026wrq.19.1665421066223;
        Mon, 10 Oct 2022 09:57:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a13-20020adff7cd000000b0022a403954c3sm9314496wrq.42.2022.10.10.09.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:57:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, orygaw <orygaw@protonmail.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] log: require --grep for --invert-grep and --all-match, fix segfault
Date:   Mon, 10 Oct 2022 18:57:42 +0200
Message-Id: <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither the "--invert-grep" option added in [1] nor the earlier
"--all-match" option added in [2] were intended to be used
stand-alone.

But due to how the built-in and the revision API interacted those
options without the corresponding --grep would be ignored.

Then in f41fb662f57 (revisions API: have release_revisions() release
"grep_filter", 2022-04-13) this turned into a segfault, as we'd
attempt to free() the non-existing --grep patterns.

Arguably it makes more sense to add this check to
compile_grep_patterns(), since it's possible to use the C API in the
same way and trigger this segfault. But in practice the revision.c API
is the only user of "no_body_match", and by placing the check here we
can more sensibly emit a message that assumes that the user used
"--invert-grep" without "--grep".

1. 22dfa8a23de (log: teach --invert-grep option, 2015-01-12)
2. 0ab7befa31d (grep --all-match, 2006-09-27)

Reported-by: orygaw <orygaw@protonmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c      | 6 ++++++
 t/t4202-log.sh  | 4 ++++
 t/t7810-grep.sh | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/revision.c b/revision.c
index 36e31942cee..a55ead48448 100644
--- a/revision.c
+++ b/revision.c
@@ -2986,6 +2986,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
+	if (!revs->grep_filter.pattern_expression) {
+		if (revs->grep_filter.no_body_match)
+			die(_("the option '%s' requires '%s'"), "--invert-grep", "--grep");
+		if (revs->grep_filter.all_match)
+			die(_("the option '%s' requires '%s'"), "--all-match", "--grep");
+	}
 
 	if (revs->line_level_traverse &&
 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cc15cb4ff62..298678fb7c8 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -249,6 +249,10 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --invert-grep usage' '
+	test_expect_code 128 git log --invert-grep
+'
+
 cat > expect << EOF
 second
 initial
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8eded6ab274..6dd750349e1 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -914,6 +914,10 @@ test_expect_success 'log with multiple --grep uses union' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --all-match usage' '
+	test_expect_code 128 git log --all-match
+'
+
 test_expect_success 'log --all-match with multiple --grep uses intersection' '
 	git log --all-match --grep=i --grep=r --format=%s >actual &&
 	{
-- 
2.38.0.971.ge79ff6d20e7

