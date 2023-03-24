Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664FCC7619A
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 20:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjCXUyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjCXUyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 16:54:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFB97296
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ew6so12630463edb.7
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679691282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+A+b3B3UPCEjSrHXwNe8NmkbubLWcX51P1W/Kdr7Rg=;
        b=Iprd9yglTy6uzLWNlmpVUQ6HemEyPtlfgqSE57WJQgCDPE0cWKsYHTaIjn3jprlPTj
         /+ZpZ/G4CY8u0F5Pr+00bWoqxXuzbaqhdUCLjeSSzV80xEjIboeKq6g6S0Lr1LaFdC1r
         jSmFRToan6JG2od0iBot4c4j5BsqLRxoFn8qsXb4lrc2NHyJquoTZ1JgYO6lpXvF9jLT
         6F8fqh9pdVVyS3VO8wxU/VJW3v/HMGczZMRoCF8Dvc4XcXeYL7njcUAq2x6+btPCKmG8
         CzdQkt9Iio/aVQ4Ix3BAh9jNCRxW/rhOZIo9rfJjuKOZtf9+XxAgcAYE7LO1UTqJiE8e
         6M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679691282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+A+b3B3UPCEjSrHXwNe8NmkbubLWcX51P1W/Kdr7Rg=;
        b=Uh9LP9aIiVo/NwChbFot5A6krvwdhCaNXKqvtfxKnoTArgoGGe3nnntoGhVVw1YLpY
         GLcDH8Xk750IeCSvMe984DMaeeOoeChZv1hJTeOFxd2QwZGJ3qYbIvuxorRL1Ch8LD86
         iDQNoRlsm2nVlkevg7/chb1ApUK8ODtLfcOysKYG6mC7jpr7HIzRPU64sQnFMmM3endQ
         bDdF/cbFzg8eIpHuWJeAAq8AjSrddAX+GMdhfGs7XCcDMYj9SeBQ8L1yz0FFJ9Mdi0NJ
         at2fh6WQlhJM7aJEdm+thoWKQ8of64bfisZ9OAAXn0rKASknc1/U3pmZQN77d7Fab9Xf
         LAkA==
X-Gm-Message-State: AAQBX9d9OpjqETRLoxWDJebUHXJiWxUM3/dgC2yv2eDL7PMrzQmT22aZ
        gnt10dh2uO/iYhzzoHciO7e1iN0m9DwBWXFG
X-Google-Smtp-Source: AKy350YE7HMs+BLTk6niwJ48PEYLNzsTP0zLu4UMdbaI4uC5+PXUpYhUJxmLZsu1bc35iLzr7LIMGw==
X-Received: by 2002:a05:6402:742:b0:4ad:738b:6706 with SMTP id p2-20020a056402074200b004ad738b6706mr4493047edy.2.1679691281648;
        Fri, 24 Mar 2023 13:54:41 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id e22-20020a50a696000000b005021c7f08absm2007099edc.29.2023.03.24.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:54:40 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/7] t1400: assert output of update-ref
Date:   Fri, 24 Mar 2023 21:54:32 +0100
Message-Id: <20230324205434.93754-6-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324205434.93754-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230324205434.93754-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t1400-update-ref.sh test 'transaction can create and delete' creates
files "expect" and "actual", but doesn't compare them.  Similarly, test
'transaction cannot restart ongoing transaction' redirects output of
"git update-ref" to file "actual", but doesn't check its contents with
any assertions.

Assert output of "git update-ref" in tests to improve test coverage in
t1400-update-ref.sh.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1400-update-ref.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index cf58cf025c..4d66cd7f4a 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1568,6 +1568,7 @@ test_expect_success 'transaction can create and delete' '
 	EOF
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start commit start commit >expect &&
+	test_cmp expect actual &&
 	test_must_fail git show-ref --verify refs/heads/create-and-delete
 '
 
@@ -1595,6 +1596,8 @@ test_expect_success 'transaction cannot restart ongoing transaction' '
 	commit
 	EOF
 	test_must_fail git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start >expect &&
+	test_cmp expect actual &&
 	test_must_fail git show-ref --verify refs/heads/restart
 '
 
-- 
2.40.0

