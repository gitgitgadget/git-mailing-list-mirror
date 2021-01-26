Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB13C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BF120658
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbhAZV6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbhAZFHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 00:07:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC2C061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 21:06:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m13so672499wro.12
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 21:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=asANuMSKHMhYKFpgPSawrr2vDR7W1pTXe+RBR4cn6Pg=;
        b=SBbrDCbY1qFqCqtVgmc1r+XryfWbmailRDrzQgkx8/D9luuBNsdGwp0zLhpPDHwBci
         I5q8s+AxC+0nRRkFvaQG9KiZ4G6srvJfpLyS9Vs+MQI94qjfIPL2wu5L0U2rm/kpTQF3
         BWrBX36f2372vi4k9+DMKrMoIh+rHV423mWbJC0M0H4+IN2M9yAXnovCtDCWbNtOqanC
         HSxAjPfnhP9O1fnf8LeTqt9NhIZdezkNEvu0x8evxEQM0QerKoqd9DgfbxXUsxzXYPUc
         UA43bstN2m4utk6lhT+G8DoYuEjy4CTiopHGAQs/cpQVHUOJKoR2eBvWicuovwK7Egqe
         IRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=asANuMSKHMhYKFpgPSawrr2vDR7W1pTXe+RBR4cn6Pg=;
        b=YUBqekjmkGLxPqM29O6941WTSFsgV9ZkUDuGms786jOP1Ev6gzwfIfv+hvc26V+fAV
         CxUTDBIicwEZEaPfA8da15JT93mDjYIIihkrN95OH5KQuYS5uWVaBGmhFcZc28kWkQzH
         whqIRffyvLTDpItS7ww01K1ha5dfpMhmw0TIqMXkmjbk08qVeR9psS+htaSmBYYV+Kac
         j5JC5yVejz+iwlOgoahPD2acyb5XzfpgjS1vN3K3QqZod0nXcEd+nLPj790yBgUnovTJ
         TygMlbKGjUdEHSmINMUzOuLhxSkzcnvLeURfwLgwryld3xgRobq6O4XFnCUOR/rod+9d
         Jk7g==
X-Gm-Message-State: AOAM531SGVPl6JG8X5Ac9sJNdVhjxoJMD14zt5fmrsaCNjG/VkqdX2k2
        3QEYm5SEBdlxig5JDKuRaVZtVEE0NPo=
X-Google-Smtp-Source: ABdhPJxk/QGkJwpulcL1l9/ANByteIDOfIs1NL8VtSFWJdghUIV5PZ2b9DedrE+3qWR7TDqFXZhmUA==
X-Received: by 2002:a5d:58dc:: with SMTP id o28mr4059248wrf.414.1611637583810;
        Mon, 25 Jan 2021 21:06:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h125sm1534164wmh.16.2021.01.25.21.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:06:23 -0800 (PST)
Message-Id: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 05:06:22 +0000
Subject: [PATCH] strbuf.c: optimize program logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

the usage in strbuf.h tell us"Alloc is somehow a
"private" member that should not be messed with.
use `strbuf_avail()`instead."

I notice that `strbuf_read` and `strbuf_read_once` may
use "sb->alloc - sb->len - 1" instead of using
`strbuf_avail()`,so I change it,in the same time,
I change `sb->len+= got` to `strbuf_setlen()`,it may
better to use existing api.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    strbuf.c: optimize program logic
    
    use strbuf_avail() is better than use Exposed .len and .alloc use
    strbuf_setlen() is better than use Exposed .len,so i change them in
    "strbuf.c".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-846%2Fadlternative%2Fstrbuf_read_optimization-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-846/adlternative/strbuf_read_optimization-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/846

 strbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index e3397cc4c72..76f560a28d0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -517,7 +517,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 	strbuf_grow(sb, hint ? hint : 8192);
 	for (;;) {
-		ssize_t want = sb->alloc - sb->len - 1;
+		ssize_t want = strbuf_avail(sb);
 		ssize_t got = read_in_full(fd, sb->buf + sb->len, want);
 
 		if (got < 0) {
@@ -527,7 +527,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 				strbuf_setlen(sb, oldlen);
 			return -1;
 		}
-		sb->len += got;
+		strbuf_setlen(sb, sb->len + got);
 		if (got < want)
 			break;
 		strbuf_grow(sb, 8192);
@@ -543,7 +543,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	ssize_t cnt;
 
 	strbuf_grow(sb, hint ? hint : 8192);
-	cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
+	cnt = xread(fd, sb->buf + sb->len, strbuf_avail(sb));
 	if (cnt > 0)
 		strbuf_setlen(sb, sb->len + cnt);
 	else if (oldalloc == 0)

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
