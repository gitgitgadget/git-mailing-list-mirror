Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AFAC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE4260F45
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbhIGVGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346766AbhIGVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC45C0617AE
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g16so33146wrb.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l8z9o2v5U1jTIzXPH+7GeQ1zKN07gZFlF+avMENwnVA=;
        b=FlxJv0G4q2HAqVgS3rrT7leZy7Xr36QF3ssKn4+2aGEscrPb+6FjyXyHjuyG49iDNQ
         DOc8u6DNPC1ab7RDxCrFYgQLgffrGEtqYfjUAUKOGvcE1+gE1PqMnKTRwAdEI/tosjAE
         SZMnlDAhUcqW4khu/HblH6CF+T9kRKioq8wIGtvx2r/dlorQ4XogKdXEQRKoU5SQ6PSI
         5AcqNY7ypb7BgMN0NG9oBvhetHPDSv0z0vMWr6yFvjqopmU8IF1uTYagYMJhNjWt8oc5
         9ImqKA+hze3vcpOcDIRNcvZU77R07GVriBO0n48r8d1UKQqXSRgXaBZNJHoBp5KRI6MJ
         1UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l8z9o2v5U1jTIzXPH+7GeQ1zKN07gZFlF+avMENwnVA=;
        b=w6ghvYVl2+AY5+1OfyLuSseWleiShvHCLBHJ0+0NWcUiV8wSm6gv1UO7BEZzWaO4+W
         JCtrvX89J+xzdl6lp5TRsaCLdUJTlZ0nnmyBZ8FRsDx6qLLs779mLgtJM1+/IoWfVMgv
         wQiJKAjEos3SPCNlHpGkaRZexZ1ehjg04D/uZOimR9jAQ7Zrsia+QJmzYZthwSLFxNyl
         N+oWqG1RaEfxADs8Agqf/FveAWU1Tx5b5PBKa5yLao3J0zeKbLsaCYsqt5k1CGdBmGqq
         +W3E4+DTCjqT386tlSLDkmWQozvLbWNOzhQ02My6z4KkhiAsu1BURtzgOKfzf+qCqyCX
         f+sg==
X-Gm-Message-State: AOAM530qqErNrnVfgfV99556jr6DP0nPGvTGNxnIKNCwdyqUcuqZXJYk
        BGrTv0tXlhLYnAk5fiPzCv9nr9WK/dU=
X-Google-Smtp-Source: ABdhPJxy/WRO6f2GMSZYRKWJTppi3vyErSVjtXaP44UPC9a/vwkcgS+rWA+d7SQ7lgiAxNfurHswGw==
X-Received: by 2002:adf:e404:: with SMTP id g4mr312398wrm.143.1631048719809;
        Tue, 07 Sep 2021 14:05:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm154975wmc.22.2021.09.07.14.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:19 -0700 (PDT)
Message-Id: <6905c8746ba2049e9ddfa8ceff5c714559ebdb86.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:10 +0000
Subject: [PATCH v3 09/11] rebase: stop mentioning the -p option in comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We no longer support `--preserve-merges`, therefore it does not make
sense to keep mentioning that option, even in code comments.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b8eb8e8304b..c4d4cf25028 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -909,7 +909,7 @@ static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-/* -i followed by -p is still explicitly interactive, but -p alone is not */
+/* -i followed by -r is still explicitly interactive, but -r alone is not */
 static int parse_opt_interactive(const struct option *opt, const char *arg,
 				 int unset)
 {
-- 
gitgitgadget

