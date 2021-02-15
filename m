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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB86C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573FD64DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhBOPt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBOPpj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:39 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B89C061222
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v62so230098wmg.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7hTilje5QCz2pw5zJL0WMC7kXNP7KBVqQR3LDOfqjk=;
        b=kGtalEwVfXUYvY2/Q21HLVetYYk8Lek7y5H7lL58/C/C1gHWFOo+f8z6uaS/2FTYVe
         HYRbbmg2e1sCfysZlw66b0iaGFWEJGbygibT7DfbCaW9szvMBPkeTQTyL/6/sJJAETFN
         rSB2z82uvV4DpwS8yD77R9k0atTFH7bkpKlL3psSqjhBtrcFVrM2qA3oTw8uhLp9JuSD
         sMBJ83vBcE566yEZmfGqlgtl2ZNwpTgXbR4zwvuIZLilhWeDS4a3tyN4i9vDeqh4ejZ/
         grvANSVtnaPPCmgmFTPeLT/z/cNHmFfj7dzVBHfsea0LCJFaxKg0mPfVLS8Y8IRVsxeH
         56Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7hTilje5QCz2pw5zJL0WMC7kXNP7KBVqQR3LDOfqjk=;
        b=eP/mz9BSnyTyVLTkQDahaLIWGiwRMITFFjYqwHxqiYE724vTg0sO9wZg3+PZ8ZdMbs
         cjvTqwmq1DLjfG8A0m1kkXh3ofBxl6Ium7vZx3D/W72FMFD7iZXz0+GxHxCgsP5VCzyS
         MJeRdyUUp/AtMWkVtyYv3EEqXk5yVLScKnGd+1bPJb+dIWiet45KN2dZtRRlFifEYnGK
         iY4A3A2R3kKyOVYuw/e/GRVPFOlbA96mRR3X5YWniX9mDdqzhHPaLI4qm9XCKte8SNN7
         VOM1QK+vp/FGrmA3ZTyjHccovPDSykM9txr3srTtHHA9sFfDsTlhgwIT5yU3TaBKewFT
         DJMg==
X-Gm-Message-State: AOAM530crGRqaDZxC9by4zkea6Ix8GEQBIR1UaxYQMe8OgG/J+NxwARs
        qjWXEd0g3ROXCV6ERlVNy+jv7HkAxOOhsg==
X-Google-Smtp-Source: ABdhPJyi7wWifoTx5qSIpjoLZT8oyiBQ+q8PkGpEESr+vBbJ1etw2mL7tjkQimhep3cXy7FymGdErQ==
X-Received: by 2002:a1c:4086:: with SMTP id n128mr14927721wma.51.1613403896706;
        Mon, 15 Feb 2021 07:44:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/27] userdiff tests: do config teardown in test_diff_funcname()
Date:   Mon, 15 Feb 2021 16:44:13 +0100
Message-Id: <20210215154427.32693-14-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a teardown of any custom "diff.<what>.x?funcname" config after a
test_diff_funcname() test runs. Nothing currently uses this, but a
follow-up commit will start setting custom config before certain
tests. Centralizing this teardown makes the tests simpler.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index decf7961f9..4cb0b7ba2b 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -78,6 +78,13 @@ test_diff_funcname () {
 		git diff -U1 "$what" >diff &&
 		sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <diff >actual &&
 		test_cmp expected actual
+	' &&
+
+	test_expect_success "teardown: $desc" '
+		# In case any custom config was set immediately before
+		# the test itself in the test file
+		test_unconfig "diff.$what.funcname" &&
+		test_unconfig "diff.$what.xfuncname"
 	'
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7

