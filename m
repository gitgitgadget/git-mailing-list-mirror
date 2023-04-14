Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BCC77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 08:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDNIOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDNIOA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 04:14:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F65F271F
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:13:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b40so1941391lfv.4
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681460037; x=1684052037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtMPaTstwxS2FtFjw7Pt74StX9wReDixP8n6nXt2bes=;
        b=FGP6gEPGzq21mCHQP0XQSlXFP2JbTb0S2QJgxxPj2/9LLxPWM+V2JtfHOl+vICoDTr
         Q8Jxn+wczptbUdjA+Vjgir0AQWYBmY0ZLyeodMrE02Isa8iojecU3D0WV0h2TrHVUY+I
         i+YVlifQVVYkvr8Ct/KKCflQDgDabq67V2Qtv7fF7dV69u692+oD/VTS4L8OjWZ7yukq
         BWSLEI2BzuV1CMNKF9Tm7QypK4Rxdltv+s4IbHzai85dq4ZswP3lSK28EW1cP4p7qPUo
         hhzoGg8v/crsriO705dlqa13KcAQQ7Yta/wjuQR7F/COZMVGux10DdjBYVOSr8XTiSq2
         B4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460037; x=1684052037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtMPaTstwxS2FtFjw7Pt74StX9wReDixP8n6nXt2bes=;
        b=OHiGmR0pcxK6jN5YAmXoD/B93g5dHdUkdQpAuQbqnCag7bIXdNpdHbtTY9T+ktgTSW
         /3gS+FVJ5lvG8stjR7KfGTZb+9es9pbX+feD5tdO+b5HD2VK61BmBp+1AbLU5IFY9Vvf
         NrkR9+PIgBRWuR6oW2uyZyK0rESGt9NrCwmpLhcuCuvbT/87vT9F1Ai3eX5eNPvlVrlq
         9CJhHrtCkay0EqkEUls9yJ+QZR9XN9DecfqRGyPdOR0caogSFF9tUyb7soRYoMu0EE4o
         cKDYUdapnOn4eUjW3TDQzZ71vQlHUyhlOWJg9n/bfiSAuD5eIPQleyCg+du5gDkJXglG
         l6cQ==
X-Gm-Message-State: AAQBX9e9JClFzzF94fDjNTXnyVAexzVytEWQvPraCUIuS0VONWRZJ0Kb
        nwHxA01OTPr7i+n135w/1GpSUQpqO1nmRQPyOjM=
X-Google-Smtp-Source: AKy350Zv9ElfyUAnDtZplL8hLMkcS7PUebHUtohV5xsNDWtcivucuo7UgRHRPXJ4VffwwcYN2g6DUg==
X-Received: by 2002:a19:ae17:0:b0:4ec:5607:9055 with SMTP id f23-20020a19ae17000000b004ec56079055mr1576869lfc.31.1681460037445;
        Fri, 14 Apr 2023 01:13:57 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e3309000000b002a76f63a657sm657506ljc.105.2023.04.14.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 01:13:57 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 2/2] t1300: check stderr for "ignores pairs" tests
Date:   Fri, 14 Apr 2023 10:13:52 +0200
Message-Id: <20230414081352.810296-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414081352.810296-1-rybak.a.v@gmail.com>
References: <7a5de047-3535-3b87-f023-43c400d57131@gmail.com>
 <20230414081352.810296-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests "git config ignores pairs ..." in t1300-config.sh validate that
"git config" ignores with various kinds of supplied pairs of environment
variables GIT_CONFIG_KEY_* GIT_CONFIG_VALUE_* that should be ingored.
By "ignores" here we mean that "git config" doesn't complain about them
to standard error.  This is validated by redirecting the standard error
to a file called "error" and asserting that it is empty.  However, two
of these tests incorrectly redirect to standard output while calling the
file "error", and test 'git config ignores pairs exceeding count'
doesn't validate standard error at all.

Fix it by redirecting standard error to file "error" and asserting its
emptiness.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1300-config.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 696dca17c6..20a15ede5c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1462,24 +1462,25 @@ test_expect_success 'git config ignores pairs exceeding count' '
 	GIT_CONFIG_COUNT=1 \
 		GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
 		GIT_CONFIG_KEY_1="pair.two" GIT_CONFIG_VALUE_1="value" \
-		git config --get-regexp "pair.*" >actual &&
+		git config --get-regexp "pair.*" >actual 2>error &&
 	cat >expect <<-EOF &&
 	pair.one value
 	EOF
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test_must_be_empty error
 '
 
 test_expect_success 'git config ignores pairs with zero count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=0 GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one >error &&
+		git config pair.one 2>error &&
 	test_must_be_empty error
 '
 
 test_expect_success 'git config ignores pairs with empty count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT= GIT_CONFIG_KEY_0="pair.one" GIT_CONFIG_VALUE_0="value" \
-		git config pair.one >error &&
+		git config pair.one 2>error &&
 	test_must_be_empty error
 '
 
-- 
2.40.0

