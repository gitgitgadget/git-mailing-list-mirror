Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59844C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiKHOL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiKHOLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E64977237
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so38876254ejc.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7K0qhPHx3/gZUnMruJcMoWxQMImQmkQt3y8L9y8m2g=;
        b=cBF81sLxNZXb1UN85MhNH/Sz0VIGd+f2ehFpKKD/Vk0Gv2R5nYd4Eo7Cnc0roqyG9m
         ViQmfnYgWZqd5cWomqUpCzvIuhOGlJ3RRTyCLMnsbF5eH9BVOthAyEst7adzJoknaZfs
         LcIMPH1TGqqsDwGgGqRWRywKtstGeqwjfKQ9k9FeHgXsNoqyuWnuZtemtvoFBknIc6Gp
         qAVrVyyjvW0zYJ0/j83m6DWiRr1gq1ItzlnrVq0Lf4esnx6lzXQF1aMRZG7NIWDB1sp7
         6cihO8kJJf2unYdYz8kpd4rQC33wi2YmbpKRgSxA1Lc+CVWdMU/13f8u5Jp7Kmm1LwuM
         iFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7K0qhPHx3/gZUnMruJcMoWxQMImQmkQt3y8L9y8m2g=;
        b=nrZz54abWWlvhXFusLw0t2hGPQDSMGn6yBDRy6T2MQgSIy0jf83NYpBfsBPrswRGWn
         15VaV9GVru7Dxep8fley2znQTNxrylhP9Ot1NkMYJ+izfOaZ2283y8M6xe7vrR6SOoD1
         gW1pBZ9kxfZNa+a5FM6FvcPPHxGeyKUrE3TlFbSse26iD5KbzsjMsM+a0307BQmNq1+V
         j32zQFJlDznFXLw+Qw6A90H1bqA2huw5vLnvXWq2ct5ipEO0UkBgkdJLRtPUIxdhqyZ3
         zcb1l82OGKQRw9jpNONWP3jY3WyDh+aaS8YjY2rUXB1qYfCRZuSqMZPtARh1smKoQ6C0
         JEzg==
X-Gm-Message-State: ANoB5pmSLKCcADONjxrh6RRqavm9dMhy9O+t48QufyN7NcfODeYjZlad
        IkcNBCdsyjofgIfeCG5javFohd9noSOjfQ==
X-Google-Smtp-Source: AA0mqf7Rmom5QeJJfcCwdDsPZfXX1WHrzQxAPQ1XpOL9K6sUp4C1OLZhaMez+wUpY5YfU4YLus4svw==
X-Received: by 2002:a17:907:9555:b0:7ae:5471:379c with SMTP id ex21-20020a170907955500b007ae5471379cmr15871676ejc.123.1667916652608;
        Tue, 08 Nov 2022 06:10:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] submodule tests: test for a "foreach" blind-spot
Date:   Tue,  8 Nov 2022 15:10:35 +0100
Message-Id: <patch-v2-4.9-c14cc0e14b8-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We tested for "--" followed by command names, but not for "--"
followed by an argument that looks like an option, let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7407-submodule-foreach.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 59bd1501667..8d7b234beb8 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -154,6 +154,11 @@ test_expect_success 'use "submodule foreach" to checkout 2nd level submodule' '
 	)
 '
 
+test_expect_success 'usage: foreach -- --not-an-option' '
+	test_expect_code 1 git submodule foreach -- --not-an-option &&
+	test_expect_code 1 git -C clone2 submodule foreach -- --not-an-option
+'
+
 test_expect_success 'use "foreach --recursive" to checkout all submodules' '
 	(
 		cd clone2 &&
-- 
2.38.0.1464.gea6794aacbc

