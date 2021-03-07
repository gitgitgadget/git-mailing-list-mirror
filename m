Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F8C433E0
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E2650BD
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCGN3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhCGN3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 08:29:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711BFC06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 05:29:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l12so8531823wry.2
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 05:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stIflMGvTViSMlDJUuctW80knMDmFDJn0S9wZxSFw2Y=;
        b=GAoYJzNAD6UK06UtJ9pGkWoRQCjYP/dPtEIdShqvuym0LaDdA82j67mndSlmlMyW2v
         pMi3eYymQtNOFUJ+oyYO5w+9biwmAgWuUZAjvxNeMMUL+t+DGz3YfaQz7E1kEhPpcSmw
         uiE+a5g45hgYTr7UGiNCUjffBJZWLOS/5mRpPR4MXxzWjg1erqS263oWeD1m3ifxBJ9P
         Rx0DvUpeBcZDVU6X53Ftul5hCHzLrzF2tQWZ+Tl+gu2cIZADBT0nfAK9ua/4syjihZ4M
         BcCOIYlhFNdmohWHMEJ1usj64HlJmlrmtiZOf39XVul7WicC1f3AfWd+jC3SUf7/muUs
         4beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stIflMGvTViSMlDJUuctW80knMDmFDJn0S9wZxSFw2Y=;
        b=rgyvksJ7205VKU89xXvt5WrZCmEszgR1NyAEobAoerTueFVMSOrzJaQQ4Hp1JiH9DX
         rCeQ+ijtgNE6kJXjM6cD9EQ2bDcXbWuBCoIgO6CTk7+eyZyRr8lqKcTXykcyMylwDA8M
         CRqE/UqXfmuXKUmut80YnPSmcaN3VLZDCEt/1kbFHgFEG4s36M05cFt/6ffxHReUZ1l9
         yCwRpEoVYXbhCEBZ7SgdCLV7xgCnDM6QpKhgES4TagXRxxwEQEkV0V8rYeuFXVSqbIl1
         vWSp2m+nQecMrIijNGuDGlTcuzZckGWAlSCtxk5Bj3lzXrkx+yI+yHC5foMiv16BaCn7
         QuHw==
X-Gm-Message-State: AOAM5310NajcJNlZijTVjOk8j3e/WoqNT5Yp+Kp9kyEFLMr3CJR0Bg1M
        5W4jfHGt2BWjYjZxP6zab0fsD/hLTFXQpg==
X-Google-Smtp-Source: ABdhPJx1nwa2ohSBdKIXVGoe3F3ak8cnr+2LBbfe9gjr2780Oc/+iAaXS9yx8YrpzDd0+amDEhA0GA==
X-Received: by 2002:adf:fcc9:: with SMTP id f9mr18366575wrs.420.1615123758875;
        Sun, 07 Mar 2021 05:29:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm14144617wml.38.2021.03.07.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 05:29:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] mktag tests: fix broken "&&" chain
Date:   Sun,  7 Mar 2021 14:29:05 +0100
Message-Id: <20210307132905.14212-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210211015353.28680-2-avarab@gmail.com>
References: <20210211015353.28680-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a stray "xb" I inadvertently introduced in 780aa0a21e0 (tests:
remove last uses of GIT_TEST_GETTEXT_POISON=false, 2021-02-11). This
would have been a failed attempt to type "C-x C-b" that snuck into the
code.

The chainlint check did not catch this one, but I don't know where to
start patching the wall-of-sed that is chainlint.sed to fix that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 60a666da595..6275c98523f 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -17,7 +17,7 @@ check_verify_failure () {
 		grep '$2' message &&
 		if test '$3' != '--no-strict'
 		then
-			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&xb
+			test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
 			grep '$2' message.no-strict
 		fi
 	"
-- 
2.31.0.rc0.126.g04f22c5b82

