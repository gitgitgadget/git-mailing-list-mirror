Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E8FC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362226103D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbhIHCSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhIHCST (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 22:18:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285ACC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 19:17:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b6so795979wrh.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 19:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uIPp3CfnsAAnjK9crt2NMpVuUsqUMwT1HywtehAKhzE=;
        b=IrxbTGgiUCtS/SkALwOLJIi23sUxNTxwTannREMpQBS5m6jVdumHxJPBDcqtP82jLb
         yFh9LE9KKmOQ+ZownFNBFb38vaQ1jR3/iQuTjQXu/LzAu29BHlTCOELs5iimfcYnT3dR
         a8K+rBVAmoCaHgADiznXKAhAnS7BCuP+VU90mmhj2C6AyGGh21NDmkH0cqr5ViGHv9HR
         Ax9cmHQ8Z3/9Qr54d5b8JPcbxt7wD5AYaKxLCc1bcMPtEEPLK2JA7Em1aSeJ3y0RmFVC
         m8mw0k+etfO3IOPrZKbAbKVnXsIl8GwTiIdlw0GRCwSxInjr333TdwJcnMTLWSe0H49k
         9iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uIPp3CfnsAAnjK9crt2NMpVuUsqUMwT1HywtehAKhzE=;
        b=EnbawcA4VEoussxiGrWlDlSWtgcHnBTG4Nu7UZKBHhCB/9ZwShk6qNLc3O0W/j8KhC
         TSSAEm1EXK7R/Q8c4jh94LVa1TJkpBop2FMcbOIIxJw6fGXPczr46t8vemSwX6qlSdp5
         S/VeAR1MgjRq4cx2KCDISjUa24XUcGMh/+coyW8Vf4lu9azRoYhuMfM22+zV5wCyYund
         PTuzqBWFIWPQv6+3iJ4ME7pjWq8uijNmMkh8FHihncIwGWEmiQnKf3Kx35RQuQm6UtG5
         U6lVLYCER/hp/nrkA3GzkTvl0ONM0w+j/l5hBLBSQL+WYNyvWDwZ1/NwYYZau035PcEC
         35cw==
X-Gm-Message-State: AOAM533nxCv6DvUm3C4As3QpZ0XZxN/SjMGfcvvhVc2AO9/hz4opsEVJ
        jANqq3bJp0A04fVXp3b9aEfeJA+IDXA=
X-Google-Smtp-Source: ABdhPJyzT0K+i7T74qHG5anT0oq2LRdm+ud370m3Pg/SHDh4zV40YW1UpT/5ek9RwetkLdkN1P/07g==
X-Received: by 2002:adf:c506:: with SMTP id q6mr1241301wrf.78.1631067430761;
        Tue, 07 Sep 2021 19:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d29sm652597wrc.6.2021.09.07.19.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 19:17:10 -0700 (PDT)
Message-Id: <b8a418bc63ab0a4add25724a11eb5f992e3d4472.1631067429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
References: <pull.1087.git.git.1631067429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 02:17:08 +0000
Subject: [PATCH 1/2] t4151: document a pair of am --abort bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4151-am-abort.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 9d8d3c72e7e..501a7a9d211 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -23,7 +23,11 @@ test_expect_success setup '
 		test_tick &&
 		git commit -a -m $i || return 1
 	done &&
+	git branch changes &&
 	git format-patch --no-numbered initial &&
+	git checkout -b conflicting initial &&
+	echo different >>file-1 &&
+	git commit -a -m different &&
 	git checkout -b side initial &&
 	echo local change >file-2-expect
 '
@@ -191,4 +195,31 @@ test_expect_success 'am --abort leaves index stat info alone' '
 	git diff-files --exit-code --quiet
 '
 
+test_expect_failure 'git am --abort return failed exit status when it fails' '
+	test_when_finished "rm -rf file-2/ && git reset --hard" &&
+	git checkout changes &&
+	git format-patch -1 --stdout conflicting >changes.mbox &&
+	test_must_fail git am --3way changes.mbox &&
+
+	git rm file-2 &&
+	mkdir file-2 &&
+	echo precious >file-2/somefile &&
+	test_must_fail git am --abort &&
+	test_path_is_dir file-2/
+'
+
+test_expect_failure 'git am --abort returns us to a clean state' '
+	git checkout changes &&
+	git format-patch -1 --stdout conflicting >changes.mbox &&
+	test_must_fail git am --3way changes.mbox &&
+
+	# Make a change related to the rest of the am work
+	echo related change >>file-2 &&
+
+	# Abort, and expect the related change to go away too
+	git am --abort &&
+	git status --porcelain -uno >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

