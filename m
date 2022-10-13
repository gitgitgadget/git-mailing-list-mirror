Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F10C43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJMPlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJMPk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE47448EAA
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c9-20020a05600c100900b003c6da0f9b62so1607423wmc.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUJQUdCePb0v6pwLUr1VCJk0/xvWMy++ReNKZuKDfU4=;
        b=hs89p/0KWzmjyZMOhpdGyasv5kBQHRlSyC6Q3tn4POiXpvW2ILhejAxUf8EouydClx
         k3XXqxmrJpJouECyH7t4yiBQ4Cl0b29VfMA5AhA5jherxlBNIEjQnMsWB6CqNguuqTku
         1M2fsX1R4Rr57PV9Jmb2Wv36WujtNUh6wY9f6jlt7YhdUXsr+5Cm0P2MIwcTCuGf3umg
         raPk8DwKMBka71iTOA3Afpj9Rm718QFlc1AlYyQzd3VxgVdeGKz9uZwilkT16D5wrpK2
         pPltHg1NA1g6Scu2HiphcvrKEY4RN+T52sKCeN9bTejxdlRn+ntdUBYo+KOvg+ILOlQV
         1fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUJQUdCePb0v6pwLUr1VCJk0/xvWMy++ReNKZuKDfU4=;
        b=CvCoFd7jfRBkMGfOf/oeHCZSFptiHsLkovmSMHDUokZH3nC5ap2XmG+eSkes2/pRVf
         bXg1IO4/bw1ahSfSueR6meUdOWE7FYXEX8In/KgBDxfHHnjiG2Omg26j8gizN1QnX7GI
         1ZjjblM+79ZA9sheN4YQmU/Rk1y+XNFZ9itNww2n/VeSwcKh5ht/AuE4ngbYQzuwamG4
         x/RWV19Pp7yCEzNavj/PokgVN445qViqqMlO6HH7TShYqUE289GAeofWioQQG3qUP0hd
         QF4iRUgNqYTpOjf/wk6ImVvKy0lqhLO69crvaIQMdbbkpLNMA1oTu4+IaaynOJZ4DYDp
         tCCQ==
X-Gm-Message-State: ACrzQf18dj08LAswcAdl6oiWZXxG+lQwv4SNTlu9EPKSEppFMehWlXyW
        Vs9YsXvUjTWnpZqcM544n5XRNYt9FXqhnA==
X-Google-Smtp-Source: AMsMyM75ObUQhDTqQH2wICR8DZ2x1Zfj4mZIw6+iBfkPkjv4rCq/V4LwNzscHgGF2NgQ0C4QylC/Kg==
X-Received: by 2002:a05:600c:5014:b0:3b5:889:58a5 with SMTP id n20-20020a05600c501400b003b5088958a5mr308870wmr.140.1665675593317;
        Thu, 13 Oct 2022 08:39:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 18/34] doc txt & -h consistency: make output order consistent
Date:   Thu, 13 Oct 2022 17:39:12 +0200
Message-Id: <patch-v5-18.34-517ff5a4565-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix cases where the SYNOPSIS and -h output was presented in a
different order.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a11f8c6e4bb..6f3941f2a49 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -31,8 +31,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a | --all] <commit> <commit>..."),
 	N_("git merge-base [-a | --all] --octopus <commit>..."),
-	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --fork-point <ref> [<commit>]"),
 	NULL
 };
-- 
2.38.0.1085.gb7e61c3016c

