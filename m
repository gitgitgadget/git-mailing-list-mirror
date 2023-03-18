Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65765C61DA4
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCRPrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCRPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:47:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E101EBD6
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so31335346edd.5
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679154415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTQxLyNjl4laCwmeKfpVSFxQ6sWy7Mb7svkCHfDZrMM=;
        b=mBthbM5KlCyJakY1xIoc/9rgh4w4LkxdIcEobtYYqgytMUedaDxdhj/2r5wXcrXCdI
         J8kMOq3hIf2P7/dnCH3qFFpGPQhkaqLzXnIsa4NNrlzUyDZySbf7XcQut57WC+oxWzSO
         fAyd4CuFntds/8w+t7oZk8xyweQ9Yqk+wPxeIMCbfKQmTA75RTYT/BOztCud51hWtCYh
         lYSmrfr6JSiIpQ1UhZFp5EcOuDI6um75ZIXC+jkCKAozoKLIZ2FBoooVu9DSmJIzFsl+
         vPKnPaWj+ccVuxPHcdp4JHaoGiLqar+5585Xrh4kKEbzapELM1OIzIw2YEqW1XJQTNO0
         c22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679154415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTQxLyNjl4laCwmeKfpVSFxQ6sWy7Mb7svkCHfDZrMM=;
        b=N7MK5d9uwlBoRmKh+Fi51H4ZFm0mZ8W1VnOxzu1POp252HO5ar+V6jSDWxHticSP+7
         HfsisnBwW9QbeRB0d6fmUeI8KPvWQ8yfcjuWR4xX4Y8i6O4kc/bcIzDTmwY+qdu/5+8Y
         I4830IUnzEukJTisugYajRXVadHaKM0BS7dX6irZbG7IjEzgwZe0/URPa7hbnq4Mcowb
         JS0aXyNLUHigI5Rgd9Ou0menb/aJwVQJ9SD5Agn5Vv0z0VTyIZ2PQyIyWx9bVaPshfTm
         qpUOsAwXG1Lnb7v1iZUEesN0UsuJ8653WSSl7WtqpEfSCbzACfCwz7Uc4mGVJ6EdK0Z5
         EofQ==
X-Gm-Message-State: AO0yUKWDsuIil+Fx8uPAQhAw/8uCgL9vuggLaTb4sWupIxAVvpYp41g5
        vvh8/wWsycai89rU/1SfM2xkWSCwAT7vU7HSevs=
X-Google-Smtp-Source: AK7set/pX3aKqv8F2ULih5aTCzjcfBLGNyv0En1tD8LKDoaJma94WXgsd/Cbe18h9PrSHyqN0Qb8yA==
X-Received: by 2002:a17:906:5645:b0:932:e9c7:c32 with SMTP id v5-20020a170906564500b00932e9c70c32mr3362055ejr.59.1679154414592;
        Sat, 18 Mar 2023 08:46:54 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id ha18-20020a170906a89200b0092be4b381b7sm2271200ejb.81.2023.03.18.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:46:54 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/7] t1010: don't create unused files
Date:   Sat, 18 Mar 2023 16:46:42 +0100
Message-Id: <20230318154646.131344-4-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230312201520.370234-1-rybak.a.v@gmail.com>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Builtin "git mktree" writes the the object name of the tree object built
to the standard output.  Tests 'mktree refuses to read ls-tree -r output
(1)' and 'mktree refuses to read ls-tree -r output (2)' in
"t1010-mktree.sh" redirect output of "git mktree" to a file, but don't
use its contents in assertions.

Don't redirect output of "git mktree" to file "actual" in tests that
assert that an invocation of "git mktree" must fail.

Output of "git mktree" is empty when it refuses to build a tree object.
So, alternatively, the test could assert that the output is empty.
However, there isn't a good reason for the user to expect the command to
be silent in such cases, so we shouldn't enforce it.  The user shouldn't
use the output of a failing command anyway.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1010-mktree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 3c08194526..22875ba598 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -60,11 +60,11 @@ test_expect_success 'allow missing object with --missing' '
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
-	test_must_fail git mktree <all >actual
+	test_must_fail git mktree <all
 '
 
 test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
-	test_must_fail git mktree <all.withsub >actual
+	test_must_fail git mktree <all.withsub
 '
 
 test_done
-- 
2.40.0

