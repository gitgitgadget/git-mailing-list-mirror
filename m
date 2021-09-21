Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46663C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE006109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhIUNbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbhIUNbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:31:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E236C061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so39218801wrq.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0yckHJIArVuiJ/szbOwUMYq9UWAkgGP3PdHtjmt8D8=;
        b=hQBGyiTzP1f8ErCZ03/dD28abvvw8nuH+X+irlpFcuFk6+Y/ppeSpOEuNaSUhOww+3
         e8bO/UTJDwFPuJbCIKA8lg+Rqlxv0WHgcqNCQz2T5Mpfj51J9FunGhn7vJueh5a05dkC
         H61vwPBRGjF0CZ+8xV0Vr3RnT3nwbCwvfe5qvs5nrNJ+g4vFe/5VuEXlFYeCERg/wpr7
         xleMrjfa824Iq/btATweuS+Zqvbg3nx7jaMLB3vuK1cMQFGT5PdZsjcNVfxUbjFhRvLS
         hawX6VJcFdCYjM6JiYOl49mpBaaKUNjD9ckzjwclY2XlQ6wIW10R0xKvs9RmMxN3s6Qo
         Qr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0yckHJIArVuiJ/szbOwUMYq9UWAkgGP3PdHtjmt8D8=;
        b=1wqey+jgIc2ru0C/QUdNkucNqNAhKprhqkPSQOwPjeNpb4K4AQpMXZsxKG03IPQIYv
         dKmFQu9s/gM7TONNndq3uhhIbL166Ux9Xy1h5q0X/EHkIQXw/KjHqWxkLCVfMJMcZlvt
         bgS8eOqwTc5H+dWCvuwWZGtSTbFBfb9RZxmn6KiFEQ0KO8Wjcjz/8wfuieCDprKe2skC
         SLqiPe+3AT/JCBye9Td1YLOuDND5rmep1u5jx2lmK2ceXGUJpNsAW8ClLYBz6bXMP3Nl
         X/rbe6+rpAFwZRt939Fsh2CECjR4OwEP50pVU+khr/lqncTaKyFttYGdV8y4LXXzO8jN
         Ahvw==
X-Gm-Message-State: AOAM5325DFs750Vjg1A1EyLB3D+xORAAwfdUO4I7KVCqRlQvZLNrGnW1
        JZHT8BZPUqkvWTUjNScPIlCGxYS9KV5dLw==
X-Google-Smtp-Source: ABdhPJxV2NY3cwokLmcS089ypiJbV1ivBA46hkatFAT1OLYyvFwg3AfKQEabMAHlTmXBKBdpcNBecg==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr35711827wrk.125.1632231019598;
        Tue, 21 Sep 2021 06:30:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 135sm2926891wma.32.2021.09.21.06.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:30:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/4] git rev-parse --parseopt tests: add more usagestr tests
Date:   Tue, 21 Sep 2021 15:30:10 +0200
Message-Id: <patch-v5-3.4-8262999b456-20210921T132350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
References: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com> <cover-v5-0.4-00000000000-20210921T132350Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for the "usagestr" passed to parse-options.c
usage_with_options_internal() through cmd_parseopt().

These test for edge cases in the existing behavior related to the
"--parseopt" interface doing its own line-splitting with
strbuf_getline(), and the native C interface expecting and potentially
needing to handle newlines within the strings in the array it
accepts. The results are probably something that wasn't anticipated,
but let's make sure we stay backwards compatible with it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1502-rev-parse-parseopt.sh | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index b29563fc997..284fe18e726 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -282,4 +282,58 @@ test_expect_success 'test --parseopt --stuck-long and short option with unset op
 	test_cmp expect output
 '
 
+test_expect_success 'test --parseopt help output: "wrapped" options normal "or:" lines' '
+	sed -e "s/^|//" >spec <<-\EOF &&
+	|cmd [--some-option]
+	|    [--another-option]
+	|cmd [--yet-another-option]
+	|--
+	|h,help    show the help
+	EOF
+
+	sed -e "s/^|//" >expect <<-\END_EXPECT &&
+	|cat <<\EOF
+	|usage: cmd [--some-option]
+	|   or:     [--another-option]
+	|   or: cmd [--yet-another-option]
+	|
+	|    -h, --help            show the help
+	|
+	|EOF
+	END_EXPECT
+
+	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'test --parseopt help output: multi-line blurb after empty line' '
+	sed -e "s/^|//" >spec <<-\EOF &&
+	|cmd [--some-option]
+	|    [--another-option]
+	|
+	|multi
+	|line
+	|blurb
+	|--
+	|h,help    show the help
+	EOF
+
+	sed -e "s/^|//" >expect <<-\END_EXPECT &&
+	|cat <<\EOF
+	|usage: cmd [--some-option]
+	|   or:     [--another-option]
+	|
+	|    multi
+	|    line
+	|    blurb
+	|
+	|    -h, --help            show the help
+	|
+	|EOF
+	END_EXPECT
+
+	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.0.1098.gf02a64c1a2d

