Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9074C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8467B61001
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhDTMvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTMvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3A1C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so58083493ejj.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAPLdClDk6qYbdPFgzEksOaJrzjxcsS690zGpKlYM3s=;
        b=GrKECfUxznSD74qVnnHHiPugbQ8m5YVTL1O1iPaE0X7DH86HWF3Uk1q5cBqJAJfMMp
         fmM3BoR6/3Wo16u9JtHIZn5ALDaUofF4HWk9S5ddR3MY5WIHQ2Wjf7clRAgsy2BpDCj8
         ljfCmkq+WJKZ1jLiDXEaosQ4ih7xOTigcFe9UlDZBFdvs1fJHSaQN6xgvtjJnoNHEXGl
         RdAv39TiuxrMYVimq+iooy30S1sjuKOVhD5MJWW2qPmzqdVMJZ+XyXlTZVHMiCr3TNds
         kQDdieP6XZ172c1YlRfPgyhUZM5a5unc9ydRV33g/vh0pcPCBgTRsARNu+ma3ypbphcw
         /8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAPLdClDk6qYbdPFgzEksOaJrzjxcsS690zGpKlYM3s=;
        b=I/GhSaBZPLFKkoOffpcWGuk2KUcdTnt8275vMRQEBjpJMXVQkW4lBxsUNgjMWyccv3
         jcCFgzDYaaprm2cy9rQ5Qs31fO8GtHc17oHTO0yG7JUIgpGWpFPYCAqLQuKZ4bMHdlTL
         Lt0SZxdrnDpgA4/wcwGcmOMs6pUqErdJzahsbLcZAf7MxhEVrUde9y2RsUqb58IvMfr4
         G79jMcijw5O5+7nU2G5VxHNiSDL02/15cQRsS6cEddUXmPxQqOAQYW4TXkIemBZ4No7N
         SFT3yELzERe1q3YbeaL1AiWqn9v/1qPZpGrwUW7VpyGSgNkCofwUq0gxvUXRknyPg5Nc
         7Bqg==
X-Gm-Message-State: AOAM531a7dKjJl60qL/rXypw93rrtAmPPjwqVvmdz9EUc8hQm+NalXcc
        1pwPD5IBDil3ScC2reN5/PUiag90oQMBoQ==
X-Google-Smtp-Source: ABdhPJwzpQ7gvE7gjjfi41c6b0GRQmVMCR4+m3c0oAhuZh7KytFot3hfCTCg+IEaXIYlYOwGNWmnhw==
X-Received: by 2002:a17:906:b09:: with SMTP id u9mr21528390ejg.244.1618923046408;
        Tue, 20 Apr 2021 05:50:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] cat-file tests: test for bogus type name handling
Date:   Tue, 20 Apr 2021 14:50:34 +0200
Message-Id: <patch-01.10-5818eca45d-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test of how "cat-file" behaves when given a bogus type in its
"git cat-file <TYPE> <OBJECT>" mode. There were existing tests (just
below this one) for "-t bogus" or "--allow-unknown-type" modes, but
none for the switch-less mode.

This test is similar to the one that exists for "git hash-object"
already, see b7994af0f92 (type_from_string_gently: make sure length
matches, 2015-04-17).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74..908797dcae 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -315,6 +315,22 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+test_expect_success 'cat-file complains about bogus type name' '
+	test_must_fail git cat-file co HEAD >out 2>err &&
+	test_must_be_empty out &&
+	cat >expected <<-\EOF &&
+	fatal: invalid object type "co"
+	EOF
+	test_cmp expected err &&
+
+	test_must_fail git cat-file bogus HEAD >out 2>err &&
+	test_must_be_empty out &&
+	cat >expected <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_cmp expected err
+'
+
 bogus_type="bogus"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.31.1.723.ga5d7868e4a

