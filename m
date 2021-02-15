Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09B0C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F3064E27
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBOA4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhBOAzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:55:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B71C061221
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m1so6503001wml.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/sLl8dRKf1qRn97nwzZWW+nGKGt+t6RpPQfPUjp7ts=;
        b=kmG7NlhGwX77L7LmonHedIeGtvnOThJrW7ZWJTo+KlHPGlF/fZeGkitLCqpzVXL3cB
         XIbo43h3/2UrMK+ptBks/WhXgc8bHyOQsCkxdkEMbrADJTa3JG2Q0hULmxRJ3eHWlQqg
         b634GCN/9b1Zn8eSFNmHZVyu+fNpdq6NFaQZQ+c77DDstS9tqn5wTVy2IqTyWUZd81Xa
         QGywOM/8wi7QdxEvbYmgLEILZ7/vLOqcRVMf/byr4wOA+qcdt2YtV1pGB9MgzJK9mRs3
         KMCbUlSag4SbNw9t2W/gS3GFS4w7f4QZzzOqQR1YmNCiGzO6nKWwJIQ+85neOg5inCvf
         9/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/sLl8dRKf1qRn97nwzZWW+nGKGt+t6RpPQfPUjp7ts=;
        b=DDVxvctCFPUnri/YPUiNTS+6HYoZ60slcbeIbv70sVkoTeZ8N/QUmYATc/toOWvotK
         1QpcdThtYcuC0nE3dPHDwCugdLLj/zTJwSA0wEpw5Wpnu5etJPH1qTkJ3aYQbduVvk5t
         4MMdsHR2qhr4B8dqhWiatynbIGZV0rsvyyEqf0Xr6fKYk4oguGcgwk2eAKouUThSJMCD
         Zo+X7Js6yx9kQvnFYRkzLTWRcw8FhlxMWveQmwzlPCzZbcNb4k9g3rzXgvYYM88rnq/3
         MA62cpZMp4adwKFr81ZErvff6zPktF/Ay8OcXEbjp5NCxextBlX85bz52hlFLVqYi6z2
         XqFg==
X-Gm-Message-State: AOAM5305LXkxthnv3eejNlPyVY2t/z23+csU/gAwshxXpfPeOLFdonMc
        vYpP+deltvjWUChnaXD1QiY8QgJ6tAeQ0w==
X-Google-Smtp-Source: ABdhPJzA5SFjAt6VCecbAZrMp01DRavvNXYQqlejg+xl0LCW/hb8ONIjAqVVIAroDxhEvOrJwQxInA==
X-Received: by 2002:a05:600c:2ca:: with SMTP id 10mr12300172wmn.151.1613350395183;
        Sun, 14 Feb 2021 16:53:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/20] userdiff tests: assert empty hunk header context on -U<large>
Date:   Mon, 15 Feb 2021 01:52:36 +0100
Message-Id: <20210215005236.11313-21-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert the existing behavior that under -U<large> we'll show no hunk
header context, where <large> takes us past the potential hunk header
we'd have extracted. I'm just picking a number over nine thousand as a
really large number we're unlikely to exceed in these tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 94026b8296..bd81974dab 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -103,6 +103,14 @@ test_diff_funcname () {
 		tail -n 1 actual.lines >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "$desc -U9001 (accumulated)" '
+		git diff -U9001 "$what".acc >diff &&
+		last_diff_context_line diff >actual.lines &&
+		tail -n 1 actual.lines >actual &&
+		echo >blank &&
+		test_cmp blank actual
+	'
 }
 
 for what in $diffpatterns
-- 
2.30.0.284.gd98b1dd5eaa7

