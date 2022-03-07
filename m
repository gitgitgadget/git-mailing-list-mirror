Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5AAC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiCGMuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiCGMum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1A4ECD1
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so9215011wms.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUYnsoCHGRB1PLHUlT5nLbIjeMRzxPL/1Xm1MIZrzWQ=;
        b=I5IT7L2pJk2s/yvZqebfpoEXYUEbrf7VsWUz2KFzD+902Ec3ga2XKcyjo5MJKsUfaR
         r6D2P+RNNgVg+2X1hRzG/LiBhkRv5b/0M52eXhLghiXmMsd6mjm0rbfVWNGnmhKW/cVn
         OTt+5zlh0dfjDifiGWMGW79QOZdgJRQPRU2jX7mxuGAGxg/rJApfxZx8DwFJx0ZaftIC
         HIcRv//SybExjTzW2FY9YHvO4ivV+i0dCYavYot2aGhyJ1H35jOc4ex0aDSc/I7CmaXz
         tsKgQey3hSZgpWcrYMV08jv53NaC6VUMPb78tyIuQarWxj1siNQbTr0xMmTdguF2UtOz
         JhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUYnsoCHGRB1PLHUlT5nLbIjeMRzxPL/1Xm1MIZrzWQ=;
        b=M7UdTnKbzaCREVJbO0SjVZGWsgfBY/fKv8qRPogjiIgOxufBajhYq0kP9vRYf7QhuG
         pl6WcFTddWfen7GO5/mAjhXpKcVOY8WlOY2adsL8d5NJkGAsPmbVJHEoFzUoc6t4qEzR
         S3jGkg8ZnhKngD1BB9Xb+wVgU8BgOG+ooebkZqgqv33x+05bRHVDIaQb2lt8aEhXwQxF
         V4p9iqHwmF18BH12qcWUZvj5IelSo3jTYv7h7PXuSirAZGM7MsrvDa2uzJ7QIlUj6ieT
         E1SMiLioKGXxMJIjqOuFGRPfiNjVlnTASUJYuBdU+yWh0Fv0hxzmVvVRYzWWKT+dZCUZ
         L4GA==
X-Gm-Message-State: AOAM530NlUSnTTHA8H9p7b1cWeKEe0mIYCpzEXAfqoKrgt3HYgYvscLa
        RwPExJie0adAmzjoONPoxWev8dJEraYL3g==
X-Google-Smtp-Source: ABdhPJw7DH1Z/IVda80O/7hwVr568S1DBbxNYtaeLcUQOkJWxQ5byF0Dn5p7Byqp4kqHrN/Ob+IgvQ==
X-Received: by 2002:a7b:c4c7:0:b0:381:874e:30a9 with SMTP id g7-20020a7bc4c7000000b00381874e30a9mr8779388wmk.53.1646657374764;
        Mon, 07 Mar 2022 04:49:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/15] diff tests: don't ignore "git rev-list" exit code
Date:   Mon,  7 Mar 2022 13:49:01 +0100
Message-Id: <patch-v2-10.15-946397033d4-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile pattern introduced in 2b459b483cb (diff: make sure
work tree side is shown as 0{40} when different, 2008-03-02) to check
the exit code of "git rev-list", while we're at it let's get rid of
the needless sub-shell for invoking it in favor of the "-C" option.

Because of this I'd marked these tests as passing under SANITIZE=leak
in 16d4bd4f14e (leak tests: mark some diff tests as passing with
SANITIZE=leak, 2021-10-31), let's remove the
"TEST_PASSES_SANITIZE_LEAK=true" annotation as they no longer do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4027-diff-submodule.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 6cef0da982f..295da987cce 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='difference in submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
@@ -28,10 +27,8 @@ test_expect_success setup '
 		git commit -m "submodule #2"
 	) &&
 
-	set x $(
-		cd sub &&
-		git rev-list HEAD
-	) &&
+	git -C sub rev-list HEAD >revs &&
+	set x $(cat revs) &&
 	echo ":160000 160000 $3 $ZERO_OID M	sub" >expect &&
 	subtip=$3 subprev=$2
 '
-- 
2.35.1.1242.gfeba0eae32b

