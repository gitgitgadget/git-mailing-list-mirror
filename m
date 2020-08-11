Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF8C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B70E20782
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="mp76nl5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKUv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC802C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so121435qke.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMuh9652CGyiO0bmz3tWXIVImi3zNm3ghnf+7Y714js=;
        b=mp76nl5e8c5ubUiP1rUOgmPTvo06ceSaGO2UPkEypTbN7G9xGl876w/feYXXHZwkOw
         vMj2WizX6QXG/SfxqaKaEhfo3syLIQChLo4sJRd3JM1Vn1wNX1+gVc4rm+XBoAHUR+7c
         QiVbu6z+mpBIwG8hqyXX5wjnJ6DnGqriZM6YurYai2gJtJMHp7lfyEXesZcjpuyoOPDT
         zQ52ByLuiQWVmqS4H0oqx09gKb7QtT+uDzpAF4q+Vzvo+gfTFx3l3DTRDxFS/HD+mZqp
         y2VhUh1PZmfi2k/RjC/UdmdntKmLzBK+666BSghIp06E6bB97ifygRE1nDT9GoJCwWVk
         TNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMuh9652CGyiO0bmz3tWXIVImi3zNm3ghnf+7Y714js=;
        b=XuKGIz8JkjRtNpdbPRUcbXAD6gcdQsfJLXkxBSdtkLPIZfzXxq7qwRpAvL9ZfQLd/U
         XnLY2F6wcgecmJva4EQc6WG6E3aymXnt/4toUGvcK8V+Q0VlxXp1y3rJf8AoaP8CfKM8
         ItLPT5NciPKpdp9ZjoAvv3IaJW4RVjiw7EB+kNYSNbDMeJQ/WJbHZmdJbKfDt+OBlWdl
         JXljiKLS0DXTMy/mb+HzsDmvqu8xQ/+SfyKC0fQ0BgvjEM3DTAXHI8WeOElXoe0w8wSn
         SmltUi/5budKdMoGm2b7ZhWtCmaid1BCbF+xovEhiMjgFiVyptPJp2sQgAprjSBpAMPC
         xi8Q==
X-Gm-Message-State: AOAM533D3JYJhLRo+A0vnb0DpRSA1c/boS+/UA9lq1nltUC1EXFYRVuJ
        B54A0qlhbq6LSszZ0HU+4to76GkH7nnB9F0C
X-Google-Smtp-Source: ABdhPJwGYvYfGNh8H3wfXhh25QSh5Ua+wEUriuS006xPontzpp9LmrB3CU6Ii5CGMmh+ZihCarMMsQ==
X-Received: by 2002:a37:9b95:: with SMTP id d143mr2819789qke.272.1597179085706;
        Tue, 11 Aug 2020 13:51:25 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id i68sm8618qkb.58.2020.08.11.13.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:25 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 02/14] t4216: use an '&&'-chain
Message-ID: <9fc8b17d6fe9e1f7b177627e67420443e7a2e98c.1597178915.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1597178914.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a759bfa9ee (t4216: add end to end tests for git log with Bloom
filters, 2020-04-06), a 'rm' invocation was added without a
corresponding '&&' chain.

When 'trace.perf' already exists, everything works fine. However, the
function can be executed without 'trace.perf' on disk (eg., when the
subset of tests run is altered with '--run'), and so the bare 'rm'
complains about a missing file.

To remove some noise from the test log, invoke 'rm' with '-f', at which
point it is sensible to place the 'rm -f' in an '&&'-chain, which is
both (1) our usual style, and (2) avoids a broken chain in the future if
more commands are added at the beginning of the function.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t4216-log-bloom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index c9f9bdf1ba..fe19f6a60c 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -53,7 +53,7 @@ sane_unset GIT_TRACE2_PERF_BRIEF
 sane_unset GIT_TRACE2_CONFIG_PARAMS
 
 setup () {
-	rm "$TRASH_DIRECTORY/trace.perf"
+	rm -f "$TRASH_DIRECTORY/trace.perf" &&
 	git -c core.commitGraph=false log --pretty="format:%s" $1 >log_wo_bloom &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.perf" git -c core.commitGraph=true log --pretty="format:%s" $1 >log_w_bloom
 }
-- 
2.28.0.rc1.13.ge78abce653

