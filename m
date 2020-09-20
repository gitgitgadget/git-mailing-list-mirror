Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE502C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9990720EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuKCOyq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgITLWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITLWi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA12C0613CE
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k13so6022862pfg.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5A/OJANxMU/wXJK9DY23VPVNuseHxMDJ8xntHmc1qk=;
        b=BuKCOyq619cIXxYkrq2Wm7kpQuT5Unrj/4yEQD0LF0qJp/mmbW0fqb7N7DZuX4eWua
         trvATJXnPEHXKicaayS9vRT/7BDQoNRS9lCS70Gao3jz/NSMVkJCDu/NgSoMaw3VhVuS
         UzVzjK7qUF/oph2Oa2jx6buSB1L+81/ZKKSLT8SV5LITq2809O4ujuCpVQDTnep0TLuU
         lWyNwOHlgqmhnTUyc0xk2lFxMoxCe0Y8XgW1yo1RE+0qr+ilSl7JokJ1FT4V88vIAbcU
         H1k7u0EiOMtY/SZ0slg5BiNwXtUAKPK2YJGUi7sske5IBZDSB2hINFslqmX90iJFvS7q
         eo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5A/OJANxMU/wXJK9DY23VPVNuseHxMDJ8xntHmc1qk=;
        b=rJcTnJZu87Qa9kM4Z5aoS8Z3romnN91GgyFbDCkTBYtK/aLOUQQx7fOIX9S3vOst+0
         5JFMlxBwY2IF5csH93gZGmGOTa+6zERzzDJx/GCgIgMl7y9wsYJHil9QzlDr+NoHxJkS
         k4jDFrXKxB2kSQgHBhCy8RQCEpH1/mFWMxZofSCE61vCx/TBAWPwYfNYuTQCR3hsN+Cl
         cutfR0iYYMndUb0brdNdOU1mpl/0RUqrk2uZi2wgUNRaL689Gb4/FEqlBmOIc+9QHv31
         jv4yKroaHm03GjJWNFIEEWKW5gHqV5ucN7TbVCrIHWeF/YoZi2Cw4Ia0g86h7rXWib9e
         C6fQ==
X-Gm-Message-State: AOAM5314x+iW31IMGnCNMzDkQVjT8wNtujIRz0C9S0PqSn6EDckZHWVc
        dgX8rDKyLo3X8YWGJmZRfjY7dVtsMbg=
X-Google-Smtp-Source: ABdhPJwjJIyApX9ffpdxFlI8yDVGt+qUG/tyAlNHA4KT/mKhr+L2ssv/jWT8SP02VpTBEYuOf2Bnrw==
X-Received: by 2002:aa7:9986:0:b029:142:2501:39db with SMTP id k6-20020aa799860000b0290142250139dbmr23011475pfh.42.1600600956926;
        Sun, 20 Sep 2020 04:22:36 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 01/10] t4068: remove unnecessary >tmp
Date:   Sun, 20 Sep 2020 04:22:18 -0700
Message-Id: <80e9066a59524ededbb0d0191a93e6e3154c5623.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The many `git diff` invocations have a `>tmp` redirection even though
the file is not being used afterwards. Remove these unnecessary
redirections.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4068-diff-symmetric.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
index 31d17a5af0..60c506c2b2 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric.sh
@@ -64,27 +64,27 @@ test_expect_success 'diff with two merge bases' '
 '
 
 test_expect_success 'diff with no merge bases' '
-	test_must_fail git diff br2...br3 >tmp 2>err &&
+	test_must_fail git diff br2...br3 2>err &&
 	test_i18ngrep "fatal: br2...br3: no merge base" err
 '
 
 test_expect_success 'diff with too many symmetric differences' '
-	test_must_fail git diff br1...master br2...br3 >tmp 2>err &&
+	test_must_fail git diff br1...master br2...br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with symmetric difference and extraneous arg' '
-	test_must_fail git diff master br1...master >tmp 2>err &&
+	test_must_fail git diff master br1...master 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with two ranges' '
-	test_must_fail git diff master br1..master br2..br3 >tmp 2>err &&
+	test_must_fail git diff master br1..master br2..br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with ranges and extra arg' '
-	test_must_fail git diff master br1..master commit-D >tmp 2>err &&
+	test_must_fail git diff master br1..master commit-D 2>err &&
 	test_i18ngrep "usage" err
 '
 
-- 
2.28.0.760.g8d73e04208

