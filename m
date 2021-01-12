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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D0AC4332E
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386AC23123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406967AbhALVhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436889AbhALUTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:55 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3FC0617BC
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w5so3822725wrm.11
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GbiPcxVPtVHZEDZbn05l7tKilW9oowR0P27rayiY/s=;
        b=hr4o0L4gv/mnclfvo410tYKKr8RfWlI+rdBcthIJD5eeYBu+QOojS42b5fKcjsyzoa
         cVItsAaIPlpQVo0qVYY1TJ0O5p5irWij7zhpYhTNdotm1Lc7CCRjl7Y5B3D00hQoCgh4
         XsnISXVfgq5VPdyTYBZ7dkpvNeiIb582BWx15u2nII0aY5cimqGTb+yi1OOwRfLUPCq6
         GGm/0tp+PuwF8Rv84Ii8qlR9qmBhQ7jWaknpoe70mUo5jm4t9VooQC2/O5Y2//j0APx6
         lsj6Drr2Z2SImGRkTRO9dbyjt3yI2R79lhX2JQaLnYpZVoeL5BgMooqRK1AlVBTg5uaa
         xmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GbiPcxVPtVHZEDZbn05l7tKilW9oowR0P27rayiY/s=;
        b=K0Y6XIhUBco4W9bcZmHNrQmX36IXiNus3XjI+QKKsCN0xgXrQNYmS9TbLED6pMnIko
         6SECZFxWBr4HTQ4HRALfgqiK/vYwjz6HKiDypgMszQUizNYRoG8Xd7lbci1OXTh1/wgO
         gQV2631cfC41QX/HnGYTdjZtIXRLRSXlnVQpuzVOBx55Ug1//HhAJ5HSBNiefLDIMrGm
         DEUveimdnymM2qoSgV7z0onEV5P72ZurI7iSYiReZ6x0PAUkocDL03nTn+ZJs3YYVZGw
         rRM9HhFmZpzw5YRcXjEV5N1qTluzg64wfzRdDwMWkW0Fl8/h7cV+yhs8V04/hiiksnxa
         szuw==
X-Gm-Message-State: AOAM533QTxtCbVhFRq0nr3U8hkIOVeIh9YXt/iuDh8Y0DThvRp3ilek9
        CvS1NGKviub13I2WdJx4Uk8gx8UEoCY3Iw==
X-Google-Smtp-Source: ABdhPJywfGVUiaizldQEj9TXdmeDiKp/6pE+NQ0oC/9qfeMCTekk6pAwQMuiiyT2hPUhvOu0ZCHmNw==
X-Received: by 2002:adf:8285:: with SMTP id 5mr500454wrc.289.1610482730236;
        Tue, 12 Jan 2021 12:18:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 19/22] mailmap tests: add tests for whitespace syntax
Date:   Tue, 12 Jan 2021 21:18:03 +0100
Message-Id: <20210112201806.13284-20-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for mailmap's handling of whitespace, i.e. how it trims
space within "<>" and around author names.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 10e672e006..4f61655c04 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -786,4 +786,56 @@ test_expect_success 'comment syntax: setup' '
 	test_cmp expect actual
 '
 
+test_expect_success 'whitespace syntax: setup' '
+	test_create_repo space &&
+	test_commit -C space --author "A <a@example.com>" A &&
+	test_commit -C space --author "B <b@example.com>" B &&
+	test_commit -C space --author " C <c@example.com>" C &&
+	test_commit -C space --author " D  <d@example.com>" D &&
+	test_commit -C space --author "E E <e@example.com>" E &&
+	test_commit -C space --author "F  F <f@example.com>" F &&
+	test_commit -C space --author "G   G <g@example.com>" G &&
+	test_commit -C space --author "H   H <h@example.com>" H &&
+
+	test_config -C space mailmap.file ../space.map &&
+	cat >>space.map <<-\EOF &&
+	Ah <ah@example.com> < a@example.com >
+	Bee <bee@example.com  > <  b@example.com  >
+	Cee <cee@example.com> C <c@example.com>
+	dee <dee@example.com>  D  <d@example.com>
+	eee <eee@example.com> E E <e@example.com>
+	eff <eff@example.com> F  F <f@example.com>
+	gee <gee@example.com> G   G <g@example.com>
+	aitch <aitch@example.com> H  H <h@example.com>
+	EOF
+
+	cat >expect <<-\EOF &&
+	Author A <a@example.com> maps to A <a@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author B <b@example.com> maps to B <b@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author C <c@example.com> maps to Cee <cee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author D <d@example.com> maps to dee <dee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author E E <e@example.com> maps to eee <eee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author F  F <f@example.com> maps to eff <eff@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author G   G <g@example.com> maps to gee <gee@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+
+	Author H   H <h@example.com> maps to H   H <h@example.com>
+	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
+	EOF
+	git -C space log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

