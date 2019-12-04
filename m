Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422C8C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B0921826
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSbQbQxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfLDVZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:25:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37798 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDVZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:25:06 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so333148pjb.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mcvSIFKED6eEr6cLl9VnEAcgMfrYd6ySclhfRxTwBA4=;
        b=QSbQbQxc9jjDbj5BmjW3sq6glQ24leClu66A/10NHtA/sl3ZyGFCePZRC81jnPe00s
         +pmpZ7uN4jpG5BVV8N1vcj+4S0bbjVQAkWOpuPCP30eQrGz9Il2V12VZb2AhRH/HDrl7
         voVD2xTDmqjHrU2jakzdt9alECX+do/oxGObwvB2Iz7F4IFrDriu/elqma0ZLjhR9Nz3
         OV51uLX54myK+uPaWGEi9siII0jSqJCOHHE6dbHIVixnqJfe+2iBGvxN+lhUOGycjJxa
         wDfL0PJ8qxt3TyKZS24lQEaN2cGXHrmMRIM9i3VqhM6Knz/ZKEBJhd3y6S030iY1mzwy
         Zk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcvSIFKED6eEr6cLl9VnEAcgMfrYd6ySclhfRxTwBA4=;
        b=A0reIVciRs0yGp+0411tVHAbdb/xqCtFEq5zlYLaLPgAn7gWeo6tQ/qzSwrQuwtj1I
         Zu6EwBn+TEmeQYZh1Mh8HyAomncNGKl0+p4fvVgMlkY2tyeIqhQbiZGoiG67myV6csg6
         XG8fvStVoExwfT60+AwfrZjqyS1rg3KH37MgIBOpBOeEA4QDqsWzy10b2WeQV9kQ+E4M
         B2eIWoCpLPhkSCjuGZPaztPuZL6a25CcTc9J96llbuLL/JxKXQrI7wveNWhHtrZv/iNq
         68F5hlCXHuZzasNKRBs2G+FyX7m7UkyHYZTrMJN/K+v8bCM2ief40SFBYUwLJOPR8lgp
         Mk3w==
X-Gm-Message-State: APjAAAU1h/mBLdHGrXp60tqrgZiM1sTW1raWrcf/Cz74qwSnIyyRUga3
        EGwrLSIzN/j9PR8WjK0cmemSRv5t
X-Google-Smtp-Source: APXvYqyDPqJZ5Vm3xiA90OP1QNTUEf/0yF8fJ9SZ/Jy5Zi/82IrZSyNNRyEecX/DmnW/Dzq+27MSOA==
X-Received: by 2002:a17:902:760c:: with SMTP id k12mr5416974pll.33.1575494705786;
        Wed, 04 Dec 2019 13:25:05 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id m45sm7533038pje.32.2019.12.04.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:25:05 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:25:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 3/5] t4014: use test_config()
Message-ID: <a55eacbad7ca0f15d038fa61d33190b1beb663a7.1575494618.git.liu.denton@gmail.com>
References: <cover.1575445582.git.liu.denton@gmail.com>
 <cover.1575494617.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575494617.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of manually unsetting the config after the test case is done,
use test_config() to do it automatically. While we're at it, fix a typo
in a test case name.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 69267b16f0..c7cc643adf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1939,10 +1939,9 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	test_must_fail 	git format-patch --base=auto -1
 '
 
-test_expect_success 'format-patch format.useAutoBaseoption' '
-	test_when_finished "git config --unset format.useAutoBase" &&
+test_expect_success 'format-patch format.useAutoBase option' '
 	git checkout local &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse upstream >commit-id-base &&
@@ -1951,8 +1950,7 @@ test_expect_success 'format-patch format.useAutoBaseoption' '
 '
 
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
-	test_when_finished "git config --unset format.useAutoBase" &&
-	git config format.useAutoBase true &&
+	test_config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
 	grep "^base-commit:" patch >actual &&
 	git rev-parse HEAD~1 >commit-id-base &&
-- 
2.24.0.578.g4820254054

