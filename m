Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B0C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD44920809
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv9tMqvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbgKJXmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbgKJXm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA350C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:28 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so358805wrl.7
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7fuDlDpWYpiI76IwISm/Zm85PJpd+Kjy9VbDOwFHfjw=;
        b=pv9tMqvvYBTheMtTXfr9bbw2rbmKoKDWn9B/sju8BQBnciHaWUuqRpNxegnhyF4HaE
         B2q/n6PG6Yl7Z2360bAgsRAnC3L+iDwZAfolMAUHHutRdvJotofIU8Pon3rY6LwsGf1C
         CiUuTUmTeqifgV+pwHPgXb8t4OIpQe3bVRjCSTlp2gvLazR1AbyoJEbg4DsRciXBZW6E
         GABP8gLvFHy9V6Z/kBswM6C4nbCcdUPiwnVsXcFG/yAISK1LN/X3/IwqQEBgIezJspKA
         Xx8j/o29NXLFL6F5lXdSeckJbIiFDfO6TaeX6U6mL0m91qjbcbufaFgNYmQBZr2UI8dG
         fD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7fuDlDpWYpiI76IwISm/Zm85PJpd+Kjy9VbDOwFHfjw=;
        b=A8n4NwwQW+qvSr95fa4GBlHgKLeZ4BojjRQzAD5NfktbkBHVCcgh9UwXfcqnAXKtO3
         kPDTYNFrZQipwSxO5uU7lg0IFiX/Bk1X7zXo414Y5pMS50hk8Pdr3miuV/OLyLud+Ri6
         yhsGsCEWScZriC1eVWhkaTwll6i0VJ/5Ql/BLKTuWm+vycR5q3BG7Yyr0/nvfvxwxFqx
         gs2r+iaNl/Dp4kKZkJKc62h4d8wYQR8eCD7Im1PwUnFdPsQDXuXm31V+TT4LZRaXLzAi
         DjC9j1yqKHarQJArhAaUerdXZBGvzh8QTxie9T1Ov5cyKYZP9KmPxPD2PyJEsvNcnhTb
         ZOLg==
X-Gm-Message-State: AOAM530mI1cQKEDIN83K8qINrd68birQxcE7OUoBPySJe149rAWhQTNJ
        2iyXgU4OTSypL5UKYp0mjIK40G0PiZo=
X-Google-Smtp-Source: ABdhPJwohdFOSZ2k3outAamzHzvpvTiRh0uYZd8n4ViznX0k8du1rS18tBCqeHJ0RXe6vqlM3W5gcA==
X-Received: by 2002:a5d:51c5:: with SMTP id n5mr5452774wrv.83.1605051747437;
        Tue, 10 Nov 2020 15:42:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g131sm380370wma.35.2020.11.10.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:27 -0800 (PST)
Message-Id: <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:19 +0000
Subject: [PATCH 9/9] add -i: verify in the tests that colors can be overridden
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that the Perl version produces the same output as the built-in
version (mostly fixing bugs in the latter), let's add a regression test
to verify that it stays this way.

Note that we only `grep` for the colored error message instead of
verifying that the entire `stderr` consists of just this one line: when
running the test script via `dash`, using the `-x` option to trace the
commands, the sub-shell in `force_color` causes those commands to be
traced into `err.raw` because we set, but do not export
`BASH_XTRACEFD`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..28549a41a2 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -589,6 +589,59 @@ test_expect_success 'diffs can be colorized' '
 	grep "$(printf "\\033")" output
 '
 
+test_expect_success 'colors can be overridden' '
+	test_config color.interactive.header red &&
+	test_config color.interactive.help green &&
+	test_config color.interactive.prompt yellow &&
+	test_config color.interactive.error blue &&
+	test_config color.diff.frag magenta &&
+	test_config color.diff.context cyan &&
+	test_config color.diff.old bold &&
+	test_config color.diff.new "bold red" &&
+
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old more-context >color-test &&
+	git add color-test &&
+	test_write_lines context new more-context >color-test &&
+
+	echo trigger an error message >input &&
+	force_color git add -i 2>err.raw <input &&
+	test_decode_color <err.raw >err &&
+	grep "<BLUE>Huh (trigger)?<RESET>" err &&
+
+	test_write_lines patch color-test "" y quit >input &&
+	force_color git add -i >actual.raw <input &&
+	test_decode_color <actual.raw >actual.decoded &&
+	sed "/index [0-9a-f]*\\.\\.[0-9a-f]* 100644/d" <actual.decoded >actual &&
+	cat >expect <<-\EOF &&
+	<RED>           staged     unstaged path<RESET>
+	  1:        +3/-0        +1/-1 color-test
+
+	<RED>*** Commands ***<RESET>
+	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
+	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
+	<YELLOW>What now<RESET>> <RED>           staged     unstaged path<RESET>
+	  1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
+	<YELLOW>Patch update<RESET>>> <RED>           staged     unstaged path<RESET>
+	* 1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
+	<YELLOW>Patch update<RESET>>> <BOLD>diff --git a/color-test b/color-test<RESET>
+	<BOLD>--- a/color-test<RESET>
+	<BOLD>+++ b/color-test<RESET>
+	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<CYAN> context<RESET>
+	<BOLD>-old<RESET>
+	<BOLD;RED>+<RESET><BOLD;RED>new<RESET>
+	<CYAN> more-context<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,e,?]? <RESET>
+	<RED>*** Commands ***<RESET>
+	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
+	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
+	<YELLOW>What now<RESET>> Bye.
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	git reset --hard &&
 
-- 
gitgitgadget
