Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40627C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180CC60F6F
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbhHZVfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHZVfT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:35:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AADC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:34:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t15so987782wrg.7
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mG7ZrKJPLxc5s4+q1vl1eQ9cTyzuNLNUc7JF5+pWql8=;
        b=NOWaWNDOXe6w2BjkHg7nLNaO32c6xwlfHD8clYOorSpeTPyVeNGzszy4NUB+epD2fj
         Ow900OcMjDArL47/2tndBfhAEz8I72J85zsUCtPQTavF2DuaBo82uxs1nBOa8pkERAnL
         yWUeZgg86+yHyjd4xADODEUQyWRUejJj263sBRhwsQOXl7SUMb7nJrZn18pzDkbe9eSH
         eLT46lGjF/iXMWq9TeJ1RXYfksPrFvjnUlQFpXLqqnZpQcEN2jAiGWjbHD+b5vQcpJGK
         focLWdvMEual85hJ5mDPQft+/zAtBb+eN0wUwlqnyntw1076BZtcOmpSiPYgXmmX3G0v
         V8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mG7ZrKJPLxc5s4+q1vl1eQ9cTyzuNLNUc7JF5+pWql8=;
        b=IrOVo+K1WFRHJ1DfYUsoBptu312sQ9wDt5MnN/cP9loTMtO7d/hrbuxdbWw+sKTfaZ
         UvcOs4KHMt43M3Bno6f0GVrb7wXW9ZlQrS1KoGMSlvtbylg+wv/WHf/vf4kK9Y1idMZV
         SSEfIU+BgVmwUHH7NXKwDKFF7845ukJZYjOMNo42kfmR/R5Ir5VOFtgEkrTIyE9M/MC0
         dkSYNd15HKYKlxLgbrfahtYWO9gpuIedl7bSDxtgmG3F7XU8M0KRnZu+gRaGSlxGVkKD
         b5V9CtwMPmU5G+i/00n+Ogt0sX9qxh10c3BdgSemNPjxmsr7r1lAnJbHj/2F3uvxOntz
         fv2g==
X-Gm-Message-State: AOAM532l/EmVcuzRq+cVjE0gejv50KKfYqS/9VcaMChtNW5KfVfGNjC2
        5je04UA5aYqsWI2Hp27aTUvSunTxczU=
X-Google-Smtp-Source: ABdhPJzp/Tax/T8ZiGM5u28OcyAVvcRt8Y66YqnB9pt/OxqRGPxcVLsOLt8ypkV4xaK9IGekq6hUdg==
X-Received: by 2002:adf:8070:: with SMTP id 103mr6412020wrk.74.1630013669797;
        Thu, 26 Aug 2021 14:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm3639347wmc.46.2021.08.26.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:34:29 -0700 (PDT)
Message-Id: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com>
From:   "Christopher Yeleighton via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Aug 2021 21:34:28 +0000
Subject: [PATCH] pretty-options.txt: describe supported encoding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christopher Yeleighton <giecrilj@stegny.2a.pl>,
        Christopher Yeleighton <ne01026@shark.2a.pl>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christopher Yeleighton <ne01026@shark.2a.pl>

Please fix the manual for git log.  It should say what encoding is recognised
(namely if supported by iconv(1), except that POSIX character maps of
iconv(1p) are not supported), and that an unrecognised encoding is ignored.

Signed-off-by:  <ne01026@shark.2a.pl>
---
    log: describe supported encoding

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1079%2Fyecril71pl%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1079/yecril71pl/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1079

 Documentation/pretty-options.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 27ddaf84a19..4f8376d681b 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -36,9 +36,13 @@ people using 80-column terminals.
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
 	command to re-code the commit log message in the encoding
-	preferred by the user.  For non plumbing commands this
-	defaults to UTF-8. Note that if an object claims to be encoded
-	in `X` and we are outputting in `X`, we will output the object
+	preferred by the user.
+	The encoding must be a system encoding supported by iconv(1),
+	otherwise this option will be ignored.
+	POSIX character maps used by iconv(1p) are not supported.
+	For non-plumbing commands this defaults to UTF-8.
+	Note that if an object claims to be encoded in `X`
+	and we are outputting in `X`, we shall output the object
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 

base-commit: c4203212e360b25a1c69467b5a8437d45a373cac
-- 
gitgitgadget
