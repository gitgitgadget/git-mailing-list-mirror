Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BE420259
	for <e@80x24.org>; Tue,  6 Dec 2016 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbcLFMye (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 07:54:34 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34371 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbcLFMyb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 07:54:31 -0500
Received: by mail-pg0-f68.google.com with SMTP id e9so19787662pgc.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 04:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjZS9rKDHXtnUGWr6BNGerrTTpQtKBPGY2pRGV9DDuo=;
        b=vPr1UZeiEvmnmggC+iEJ8VcVkYIXHh2ODpGwxo8O8zqQr54oaCJ0NgMC+mjceE38M0
         MICbjytAqtMfq4l5MmAqERrNYkLKtBNo+gG47hAWqN5nzu9gPLq9+lmHVDHhA465oMwz
         7LhXWetBXWovs0ii76sItkUVZUjo0CDGDG4H/lVjDO5L9cw4iffWNdVLkftjtpREfcjH
         PRf1Hflupyt9ccmRbMZUhbM9WYigchgEFw+Wo0ZVhhXtK82XODml+3JfwVsBIFFcSHM0
         QzkMP86EBSXERl3i//lxi5qwUxk30DVAZPlQpzZQRWm2i4FxAsgJD4Q6/JPuNYrpy3Zv
         ZokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjZS9rKDHXtnUGWr6BNGerrTTpQtKBPGY2pRGV9DDuo=;
        b=hdAtw7OblmqJfoaD1lOq1HNXOuCEq7nvtIFh3wr9Ecq0vJxFF47qb5zzSxGLqQyBJZ
         tE3zgGHx1Knd9Qmz+BLmsItafgkTOEXgQN+DNj1wYuAqNYISPqTAYvmDtGqHGlFjNJI/
         Ia5SshnOsWA+P8YP2ke7kwkPJldR8Aa8dR9KFmb7AIDpFIw+Mw1gjd0OglWjTgLVI3XF
         YGE7/fy3cNUTSLcCa1hSYkQLCYFvBXuzwgkwFSLlf6ABAs9h9HE1Js6hCwVc1PLIuxqk
         zjGNklpO8C7z2msLuY9xuhUQxQCZISl+rF4KjVuT8eUKAIXaEqMTiJ3zeJHEC0UbzKIN
         nd6w==
X-Gm-Message-State: AKaTC03iyryygSxdoQSa2787CaYTHfrUj5p/3LXm9AJ3YEjD5QqadUrfDpRKUU7tvQfXDw==
X-Received: by 10.99.138.75 with SMTP id y72mr111425252pgd.90.1481028848252;
        Tue, 06 Dec 2016 04:54:08 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id m19sm34864903pfi.24.2016.12.06.04.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:54:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:54:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/6] shallow.c: make paint_alloc slightly more robust
Date:   Tue,  6 Dec 2016 19:53:36 +0700
Message-Id: <20161206125339.16803-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

paint_alloc() allocates a big block of memory and splits it into
smaller, fixed size, chunks of memory whenever it's called. Each chunk
contains enough bits to present all "new refs" [1] in a fetch from a
shallow repository.

We do not check if the new "big block" is smaller than the requested
memory chunk though. If it happens, we'll happily pass back a memory
region smaller than expected. Which will lead to problems eventually.

A normal fetch may add/update a dozen new refs. Let's stay on the
"reasonably extreme" side and say we need 16k refs (or bits from
paint_alloc's perspective). Each chunk of memory would be 2k, much
smaller than the memory pool (512k).

So, normally, the under-allocation situation should never happen. A bad
guy, however, could make a fetch that adds more than 4m new/updated refs
to this code which results in a memory chunk larger than pool size.
Check this case and abort.

Noticed-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

[1] Details are in commit message of 58babff (shallow.c: the 8 steps to
    select new commits for .git/shallow - 2013-12-05), step 6.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/shallow.c b/shallow.c
index 2512ed3..75e1702 100644
--- a/shallow.c
+++ b/shallow.c
@@ -447,6 +447,9 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
 	if (!info->pool_count || info->free + size > info->end) {
+		if (size > POOL_SIZE)
+			die("BUG: pool size too small for %d in paint_alloc()",
+			    size);
 		info->pool_count++;
 		REALLOC_ARRAY(info->pools, info->pool_count);
 		info->free = xmalloc(POOL_SIZE);
-- 
2.8.2.524.g6ff3d78

