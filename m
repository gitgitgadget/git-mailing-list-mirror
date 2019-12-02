Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F044C432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521CD215E5
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2b/eRrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfLBT00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:26:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfLBT00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:26:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so151179pfh.7
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YYmUBZEt5cmaNqbm6Wrg001KOjvHdsoohT0BvtfWo+s=;
        b=k2b/eRrC23gS4Lm26TYtdefPDHBE9ouvvsaZ5RRruxxb+meM5HDdqT164YcLLkQvBa
         Oq9g5z/ukYOIgKKXnIXaF5xC1VWAea7wOkVEdrBxDtTS/4HX0argjam5/NErleqXa/DH
         sQ2d3i5YFQO0UgWHyEeggcrXVfZgf6hJtjZ4lp4QMAvscDiqjVAt5FAT3jnI8Mp969DF
         i3dOzDIHdKRR8aYDCwNyF0rPI1qCuIXbeYXVrmQtczGZzoCHyPajNjaECOp5P6n2cFEZ
         8jKJgEJZ6sjSFepL4xRwaA412C2IJQq7i85PnfQJ8ft/6aFFBXLKfbN32JOpfUQxgZ+4
         r9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YYmUBZEt5cmaNqbm6Wrg001KOjvHdsoohT0BvtfWo+s=;
        b=lYE+tTgtlyFcoxf8bseSFPL1oj4N70ZhojZzHIBGA2xb+fgjCRHEIoreYNky612ciB
         i9aN1HvUc8DqsvvOmkyrQ8CIHZRUKBwJQ9RnZneMlo7XehZhsi/VV0BiH5MaGZ2imElo
         rxqbAh/cFkJ1MQIWA4mB/L6oYnu52ZMSWslE1YWHIrwbO/dC7fj5gReZJ2N049CFz6Nq
         GA+0fD38eNI9HA4Q3K7b3Jrh4r5OC8hw5TescNR/6KfRZTuX98CFfsCd9J2yvQA3nQA0
         JS0dMWiAk0rDKjp21EUurnN//cVjkq3udRyl6wTFVgzC3H22Jcr2qE/8s67dkbD3P97Y
         oKtg==
X-Gm-Message-State: APjAAAWh3Op5S373zdgBZMaGM3a0iVUlLjXDsXnZYPUQJkupjJ5kMhsZ
        daKhpuvCKwf61QfLOduQcegfC/Qj
X-Google-Smtp-Source: APXvYqwj/AZH1fOMCkzf5hROmhSawm+Go9UfrzHBAQ168349ksYkHHda1X2ycHy0zym3Co553h2s2g==
X-Received: by 2002:a65:538b:: with SMTP id x11mr667566pgq.395.1575314785013;
        Mon, 02 Dec 2019 11:26:25 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id m68sm262796pfm.85.2019.12.02.11.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 11:26:24 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:26:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] doc: replace LKML link with lore.kernel.org
Message-ID: <a7c8981ba50d7709418fd942866b0c57a6e37331.1575314676.git.liu.denton@gmail.com>
References: <cover.1574882812.git.liu.denton@gmail.com>
 <cover.1575314676.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575314676.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we're now recommending lore.kernel.org, replace LKML link
with lore.kernel.org.

Although LKML has been around for a long time, nothing lasts forever
(see Gmane). Since LKML uses opaque message identifiers, switching to
lore.kernel.org should be a strict improvement since, even if
lore.kernel.org goes down, the Message-ID will allow future readers to
look up the referenced messages on any other archive.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/technical/racy-git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 4a8be4d144..ceda4bbfda 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -51,7 +51,7 @@ of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
 only fixes the issue for file systems with exactly 1 ns or 1 s
 resolution. Other file systems are still broken in current Linux
 kernels (e.g. CEPH, CIFS, NTFS, UDF), see
-https://lkml.org/lkml/2015/6/9/714
+https://lore.kernel.org/lkml/5577240D.7020309@gmail.com/
 
 Racy Git
 --------
-- 
2.24.0.504.g3cd56eb17d

