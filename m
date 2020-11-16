Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D6C6379D
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50337221F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQGpX5Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgKPQIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbgKPQIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:43 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D3AC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s8so19244393wrw.10
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z0intue/lSwO9yFM240zAhjoEqzGBf2u2fwvfA8xtN0=;
        b=QQGpX5YviIBltB9B1HSETMKJ7cPULX8nt1bCnvxB1jPx0B5e065BOowKVUqNLocMa8
         6mzcmOkoOzeRAoeAJsO5PMsJBNhXOUy9OSnX6LJt1ySpbFc/hWnwEXvwEOBmBzEtspYT
         a47QXOKXwsKpzU4guSpsjZqgKY6Ox8DomHc2OpevvG/lkcldAnWm0j3vkGt24e1v/Y3p
         1X56ojpCMgk8Jqz6WYi0Nofiil1pn9Tjz4DIwyuKMJY+INYUO0f/fvXGnRzESaO9dX6u
         wGJPfweARTyiBTBYg/eE4IYcXT9FmIT0w2iIqcsrkwj59BYnQn22ZYuJa6YjZOv4QjfQ
         O0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z0intue/lSwO9yFM240zAhjoEqzGBf2u2fwvfA8xtN0=;
        b=VMG1Gg7FuC2eKim2uRnQCo9hHdxtzuVOiKwg6Y098rHVCSR9xcz81kj1eVObv/lYkU
         zIDmcPgvrvRb/SdOY5rPuaDO5SNxusRTvga1a4dVyCRHvKqwHck7PmqhZjI/kM5xbxOK
         cXhrhLDRpwAhbWtDVRr3ssJMCeMVWQBqKZiXyNwvWb0ymGtOgYQkNZ6GvXyrB6CQSapu
         aS8kAuW/uN67jpIbWFBhhyUdAiowWTiO47gWK18mSGJqOFjcVihP8PO2BQwL2E7onzqZ
         V7wRm+UZLlPtBeAtt45S4nQERCzjHQKmy2ssFK4kw2bgN04N8S4JUQNe+hvR6YtFotrf
         flyw==
X-Gm-Message-State: AOAM530esQ+2R4trlU4MZEOLCFNuLqm9F9CSKC2JB5z+zhjCCci2mxju
        wkdbevn0RGbffkukK6WBEJe4wBu6dGM=
X-Google-Smtp-Source: ABdhPJxBGcBA6I9yUXSRnKza1gzon6ozbjbCvzUt9HSiRcFtN9bTlTRd5pVHYcmz4sYna6dTAjo1gg==
X-Received: by 2002:adf:9e07:: with SMTP id u7mr19237301wre.47.1605542921953;
        Mon, 16 Nov 2020 08:08:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm6820210wro.90.2020.11.16.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:41 -0800 (PST)
Message-Id: <094a4ad90ced8756ded9a225d2fd3886574ef6fc.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:30 +0000
Subject: [PATCH v3 09/11] add -i (Perl version): color header to match the C
 version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Both versions of `add -i` indent non-flat lists by five spaces. However
when using color the C version prints these spaces after the ANSI color
codes whereas the Perl version prints them before the color codes.
Change the Perl version to match the C version to allow for introducing
a test that verifies that both versions produce the exact same output.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-add--interactive.perl | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e713fe3d02..adbac2bc6d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -483,10 +483,8 @@ sub list_and_choose {
 		my $last_lf = 0;
 
 		if ($opts->{HEADER}) {
-			if (!$opts->{LIST_FLAT}) {
-				print "     ";
-			}
-			print colored $header_color, "$opts->{HEADER}\n";
+			my $indent = $opts->{LIST_FLAT} ? "" : "     ";
+			print colored $header_color, "$indent$opts->{HEADER}\n";
 		}
 		for ($i = 0; $i < @stuff; $i++) {
 			my $chosen = $chosen[$i] ? '*' : ' ';
-- 
gitgitgadget

