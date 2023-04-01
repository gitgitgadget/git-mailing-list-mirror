Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87594C77B74
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDAV3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDAV3G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450593FB
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j24so25749360wrd.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzyaut080C5Mk+YZcbpDJgzsXvOXxhqZg0mRjZEaONM=;
        b=T1dqTpWp2u276FsstFf4bTO2OolKIvWjiQVIKQQGdlTfFyAzyPf1zTJrgR2HVOzhiF
         k96r2eXb8Qibrcb+Yl9cqQFZQ92lkoPvZGH+d4nBV7EpS08D2SaM2RBe/6Hc2zsuz+8k
         OZKdZ6nsuQ7xTDsv1PY3EXMYxhg6r91koZy2CDdz8vlyl7jkXUm9UlVl0zxfQpNvDN28
         0n9LIj2GfMwjFbHSvsaYqJUDBOLM0e7GMMVKXSy4F77EoOA9OePeOo4NZFLQh/8R9osr
         vyVQ7NeE06Dv+cs10SlUzUhXr7WaHwLhmur1j9ieOwQ5zVw8tsUOHVLOZ5hbZGl72bKU
         gkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzyaut080C5Mk+YZcbpDJgzsXvOXxhqZg0mRjZEaONM=;
        b=zGKdvZIQL9YF+Hu15+C3w9WffjU0xfPPzfZf6B71qI7rX6eNeKb48aOoyc7gDLfJim
         AXHmEc9+5RwQh+0wsvx5F1AUAL0nuRdN1V0mi4EnsIf7ooBq+uJcnOtxZaUmUXb/cIZW
         xXX0WIKkU9jWB4XEdaDC3c8hPc3RPfixWtDe0ijfTr3scD++UqEawFPA6N1PxWhQHZkG
         hqhsz6TPBfjanLb8WM5IcKRV+HiSCpoeQjRilQ8aGO/52ydTDsfyZIMJ58BbLljV4Sc2
         aiXkwL7jqs6KvjrIjK1OUHqqx3frNZDocCaXiCixcI3X8T2ZW11KD+6Kvs+m6ylpLWJa
         Y1Hg==
X-Gm-Message-State: AAQBX9cZqR/uv89vbCVzdcIOD7HTpT33j+WQ94nMefADenWcIEGaEzM1
        yJrZIda8h82V9QbfPYFL4ZArS6GpCkjOpfsG
X-Google-Smtp-Source: AKy350ahJDBUP+9NKl/e+A+muTvLr7o40BPoJ2NL1zf/UwRNUhQvu5DAvqGxLR2rNfDmwfdRGJcJgg==
X-Received: by 2002:adf:f90f:0:b0:2e5:1c60:5afd with SMTP id b15-20020adff90f000000b002e51c605afdmr5372819wrr.1.1680384543747;
        Sat, 01 Apr 2023 14:29:03 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:03 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 4/6] t1450: don't create unused files
Date:   Sat,  1 Apr 2023 23:28:56 +0200
Message-Id: <20230401212858.266508-5-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'fsck error and recovery on invalid object type' in file
t1450-fsck.sh redirects output of a failing "git fsck" invocation to
files "out" and "err" to assert presence of error messages in the output
of the command.  Commit 31deb28f5e (fsck: don't hard die on invalid
object types, 2021-10-01) changed the way assertions in this test are
performed.  The test doesn't compare the whole standard error with
prepared file "err.expect" and it doesn't assert that standard output is
empty.

Don't create unused files "err.expect" and "out" in test 'fsck error and
recovery on invalid object type'.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t1450-fsck.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bca46378b2..8c442adb1a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -989,10 +989,7 @@ test_expect_success 'fsck error and recovery on invalid object type' '
 
 		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
 
-		cat >err.expect <<-\EOF &&
-		fatal: invalid object type
-		EOF
-		test_must_fail git fsck >out 2>err &&
+		test_must_fail git fsck 2>err &&
 		grep -e "^error" -e "^fatal" err >errors &&
 		test_line_count = 1 errors &&
 		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
-- 
2.40.0

