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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7318C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4EA61029
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhIMAPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbhIMAOy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:14:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35101C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso5650357wms.3
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqEkudrd+2fs7hjYqcHrulSDZf2P/fz7a2Wkk8fwQ8A=;
        b=qXHGEaJYQdGGDe6M88emI2NPP0ZVFvmMVEX8ySSgC2ZE9tBugjSJZHz7nqeQs/mvHK
         FxDdYgahND76pxO03FkewP39BtetsEoStMfvw3eY0iTexeaKVdJKIKyKUoKu9rFzce74
         hWp0G+lrPkHur9if4nXTdF3SMhJ3dnvcq6L+ubUNLeBxfJC4OlYrzpyTauNHwMDwQgar
         ei4F/YRmnLXRyw7D7EXcgpgVL4XUBWc4uZuWJycnfUtonWdJv3fED/6yg+PUM2rQ1TOu
         meqo9qu+TJrASvnT/Tm3fTfWLpCOKwAXyCGuCAbJzUGsVBQ0trktsYV4i+L9UUPkUW3f
         K5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqEkudrd+2fs7hjYqcHrulSDZf2P/fz7a2Wkk8fwQ8A=;
        b=HDevTdEZQw33pdGNF3+2hdKnzPT68Mbq336jqPbJn7hW1OsBUqRmSgRrTUI8UcbOrh
         ILh4YP4TSqcwR025yS2L2wdpsDYkNH2YyiBHLWMqPft7bsgmwmLVOcEwCtlNuoaGNgZ2
         gv17VK9/CDxwWRy6/rcbvtFQMeuOytczXxVmj1E45Lb3ghZlMumArX/ijrO5bTcUs/0A
         Pevp3qZuY3ycslgvkmlX/VKnnxTQ9FLeQrWvX5IR28l3bROxxdGnC6dbQJtLK+aa8h/y
         P9UE665jNv6VQ1w2GbWdEmwBvsxZEVH2F13x6mw63DugdA6bjnAMKfXeyoF0VCG1Iuaz
         bZxw==
X-Gm-Message-State: AOAM531a1iJZAmjQdERe2Fp/ZlQNwMrIK/VCoLTvj1bR0OZ2DyTxL9OG
        Eq9AP8+lixmbk7iUVK8H8Sf8DsfA+7bCFg==
X-Google-Smtp-Source: ABdhPJwWmX7D2W5v2R9ZcVqLzUuKeC4y+Ug4XaRq4/SCl1u3dy8OQHRim/55D5liv25Sep5CVr+F6w==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr8612871wmh.18.1631492017636;
        Sun, 12 Sep 2021 17:13:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j14sm5827974wrp.21.2021.09.12.17.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:13:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/4] git rev-parse --parseopt tests: add more usagestr tests
Date:   Mon, 13 Sep 2021 02:13:21 +0200
Message-Id: <patch-v4-3.4-05a0c7cac37-20210912T235347Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1001.g3ab2ac1eaae
In-Reply-To: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
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
2.33.0.1001.g3ab2ac1eaae

