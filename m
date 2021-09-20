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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7BBC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CFC61050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhIUC7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349415AbhIUC0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D26C1E326D
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w17so24466989wrv.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O25dEyDSANR/yR1AZkz1pvQ6Kd3IIbCIMKFFNOZOo/c=;
        b=MRK7wtp7JThnhJptjVNs7biDSukWxJ5nUsD8XiJDz+ad13d/0JGFhkkTXRp7FAvLpT
         aEy2MjMjd5b+ic6XQWOQaHL6s4QhuhOriNINAGe7HZNz3fRLgzbbOuPLLqJc5JkYmWII
         cXbqPW7HPN1Chow7rq3TlflvTJtkBOkdkLlXhrhTQy/VR4cLGwXexkg+FnBCvYmi7+ux
         7zYBdgf+CK25JOhyecFvcC+yjnJ684rvMzIZwx3OqOb0dgMAJTo+RiKwNwiM8oSIWk1Y
         yT7+a62TY9TRa9SKPhGjhPEltCdIHzrkgHqkFonYrohb7PRCvUOzsZfP0xiFWDRhxD97
         qVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O25dEyDSANR/yR1AZkz1pvQ6Kd3IIbCIMKFFNOZOo/c=;
        b=GWf4C0EBozQgqXPxSutt5eYkYjFovofU67BK/jHnFhg1XPPuTsNMcHlDu0mUJQEgyM
         xNN3WVHIgWC/3lfElC8GLiwG4lhYNaFihPbG1lRN/RbR0l2o4ZjvMbDuaxZAtFZH1YUt
         wKxiQ3ujcziQ6o124qiV5WCyIRLprjENYTaF08GZgN8gHaNPXAIq/kWbG4hQZzIAgBQV
         4TBq5v+t23gJyNK5pw11tl0JWELyjB7xWmaU4GZawaFjc/LU8ZvPVFc+Af16wDcc89PF
         V5CHlAh6mMBH1pSWbK/OlkTYtqI6fuSmNjtmH8pNe692+4QKQdmQZjtzH+GHl+Hr2cWv
         pEFA==
X-Gm-Message-State: AOAM5309GGvkEmujtGkbbIKMWKNuZQoPaGRHJiMaxFlOihvna34KE2Io
        sHRxiiuPglrap/rMYL7DA96ViBosZahBBw==
X-Google-Smtp-Source: ABdhPJzA6QSXi5bQxQhkgmO3fjt7R6ex0aILmlqbZb0I6XAWZvQlT6Bi5ln6BZWIM4MoeBnyBnDoLA==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr30839671wrt.69.1632164669424;
        Mon, 20 Sep 2021 12:04:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 04/17] fsck tests: test for garbage appended to a loose object
Date:   Mon, 20 Sep 2021 21:04:08 +0200
Message-Id: <patch-v7-04.17-854991c1543-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There wasn't any output tests for this scenario, let's ensure that we
don't regress on it in the changes that come after this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 175ed304637..bd696d21dba 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -93,6 +93,26 @@ test_expect_success 'object with hash and type mismatch' '
 	)
 '
 
+test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
+	git init --bare corrupt-loose-output &&
+	(
+		cd corrupt-loose-output &&
+		oid=$(git hash-object -w --stdin --literally </dev/null) &&
+		oidf=objects/$(test_oid_to_path "$oid") &&
+		chmod 755 $oidf &&
+		echo extra garbage >>$oidf &&
+
+		cat >expect.error <<-EOF &&
+		error: garbage at end of loose object '\''$oid'\''
+		error: unable to unpack contents of ./$oidf
+		error: $oid: object corrupt or missing: ./$oidf
+		EOF
+		test_must_fail git fsck 2>actual &&
+		grep ^error: actual >error &&
+		test_cmp expect.error error
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-- 
2.33.0.1098.g29a6526ae47

