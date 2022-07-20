Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D771C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiGTVXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGTVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3FA5FAC2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h8so5144834wrw.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sds5qdUmtcEs2RU0lBvQ1fXJAg86A6GoOCREG/Rvv2A=;
        b=F4THC5oaWIhYqJrhU3aMCpowW2Y51i7AnM5tBZHhY+hSzQTGB2NDxP8I/8wAnAxOc4
         jx5GbWUgcaihWYc2UulqPG3/2Ztk6zM5U/UMCSyc3zUWl5mkYwOGe6aCWfQG/C+1IIjI
         wpzTDuCzsPU3rXRPTADyXIq9E5g/8sU8eDC6/kfoUdvel263rYIjwo412F9IxADpA0EX
         n8TW//dIOnpqOaRpnfNxQSl+qoHgKrkzkCoJ4AeFA7RzLFHTp3PxFH0mIfsig8qBJhG2
         5TEOlJ85vZsNWm+IuTnZ+9OVNWt2h5BO4vfItr49GveN43NMQRyzwz/c6BOF0TOEVITE
         w0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sds5qdUmtcEs2RU0lBvQ1fXJAg86A6GoOCREG/Rvv2A=;
        b=ie1kA012D/UDV0idMaehAUc42hG9mrFtAxCtaHsJAagPVFiti9VJqAzqhIvi1gaJks
         q1QYEu20haEVRo9QnYNMsIS3L7dvtpuR0/6SZKLuP8UUht2foD74uKmX63kdc4aIvB5B
         BOJeyUFj2MA25ohQnkQY5RcF0m0CZFD4tUH6uNlqfWwFURNOfKkMaZ2Sd9/dJj2bYx83
         PuWoMry8mHaTHW3Hal/jDeboh987o2GEiIaqbMwb+XrzoBVliP6smP8hUcUrmta2bnlO
         eT5ZEh2OsGYRbTIGMmSXq4+k85W4OrJVjgb6yGv4+QBfbaEE0XuxMzlxGXQ2Mew3EB2H
         aKhg==
X-Gm-Message-State: AJIora8JKSgfeomGYOGTXeoesmyWsYHd7DN2OqT0FyZKIn1pfFK8FcyT
        kMRAy594wzoEJFtlv+bcESSaA/KLTMz0gA==
X-Google-Smtp-Source: AGRyM1ud3nYOFQYq/V5zG9zED3rfyYhysm/16I9WmN90JiVw/ymDNnuWU/VWNjrcZDfKZWC3YaUY7w==
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr31040868wri.626.1658352144811;
        Wed, 20 Jul 2022 14:22:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/14] CI: use "GIT_TEST_SANITIZE_LEAK_LOG=true" in linux-leaks
Date:   Wed, 20 Jul 2022 23:21:52 +0200
Message-Id: <patch-v2-14.14-eaa35d1bc59-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in a preceding commit the leak checking done by
"GIT_TEST_PASSING_SANITIZE_LEAK=true" (added in [1]) is incomplete
without combining it with "GIT_TEST_SANITIZE_LEAK_LOG=true".

Let's run our CI with that, to ensure that we catch cases where our
tests are missing the abort() exit code resulting from a leak for
whatever reason. The reasons for that are discussed in detail in a
preceding commit.

1. 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
   CI, 2021-09-23)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index f095519f8db..1b0cc2b57db 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -276,6 +276,7 @@ linux-musl)
 linux-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
+	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
 esac
 
-- 
2.37.1.1064.gc96144cf387

