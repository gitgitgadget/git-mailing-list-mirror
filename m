Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B81C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 17:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjANRNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 12:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjANRNT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 12:13:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A79031
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:13:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jl4so26408420plb.8
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3YxwjprH8/k5rQLo8foYTTBwd2+BFla9kEp0Sd6U3Ag=;
        b=I+Lv3ra7X/uteocJwE6H0fwdb2tz7+h3+JMCpVSOEm3BNPhOS8GRDi/sqpAWks8HEQ
         GYSLbejCi+S4/xWl2vcavDLvfCS2rzmVqBmMVqbWQKzdcmoLpWqcmizceu3g0VFlFOVX
         qbcV14aMc27O2rghqYH/UYUufp/nDG26rW2vyRYu88ti0RgoJrkwSVV7D5khEYtK+KmY
         lKNmUtjil1ZdG0kkdkFPeEkyh2uJvOm5bjqMgxTrl39r05Fxi0OBqu9nKzxDHE7ncKzm
         uwqf0l+tU0usGH9JMDQHqeVqLTd5LY0woiro5dnjWgKA3Su24UdcPEdS5kOJ3mVCu2I/
         Xh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YxwjprH8/k5rQLo8foYTTBwd2+BFla9kEp0Sd6U3Ag=;
        b=5R4A40bMlx7hblaDCBuISY5k8lg20UhDfMs1oM9nBsVwAlKV243IiVqBk+b8SMJSbR
         DfQkfIZnkY9PjRuFO+QypChf0VlEXP4e91fpHKmXdn0kZbayO3nDMDbCGDMwnzN+FSYq
         MFvR30OjTxh2EzzaGUliQ4TUaOyvh/ZqqnQyZeSd/03ueFzZWal/p0Vtkr8dbkX+KImz
         Ukc9zuvTrQGMqLjLPDZQFxgJ7msiQVEyl0ICCVx1S5mdQHJxKnawxHkGTRp8uH5foZXT
         0rq1gSewlrmULhYeog3ucl/ss6S8MdUAXHYD7mUVQ+3WsWJi+5HgwZY+0BkoYf8RcNCE
         y6gQ==
X-Gm-Message-State: AFqh2kp+16KN0Fsvz1y3TXpxUshW/0ezzeN7nu1v9devtzC+4pSq4Yak
        +lHutA4JqataScFuzkASNLFp3c7IW5E=
X-Google-Smtp-Source: AMrXdXsMs/LcYNU3tmFI1jBbjGa2FHncvCTp1NP+eiM9rEwmvKHTDj/rE7PN7gX/XpJkfPKTPhHvdg==
X-Received: by 2002:a05:6a21:2d05:b0:a7:92f2:9b65 with SMTP id tw5-20020a056a212d0500b000a792f29b65mr104400113pzb.59.1673716394810;
        Sat, 14 Jan 2023 09:13:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b001869f2120a4sm16201982plh.94.2023.01.14.09.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 09:13:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
Date:   Sat, 14 Jan 2023 09:13:14 -0800
Message-ID: <xmqq7cxpkpjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like a recent GitHub CI run on linux-musl [1] shows, we seem to be
getting a bunch of errors of the form:

  Error: http.c:1002:9: 'CURLOPT_REDIR_PROTOCOLS' is deprecated:
  since 7.85.0. Use CURLOPT_REDIR_PROTOCOLS_STR
  [-Werror=deprecated-declarations]

For some of them, it may be reasonable to follow the deprecation
notice and update the code, but some symbols like the above is not.

According to the release table [2], 7.85.0 that deprecates
CURLOPT_REDIR_PROTOCOLS was released on 2022-08-31, less than a year
ago, and according to the symbols-in-versions table [3],
CURLOPT_REDIR_PROTOCOLS_STR was introduced in 7.85.0, so it will
make us incompatible with anything older than a year if we rewrote
the call as the message suggests.

For now, let's disable the deprecation warnings from libcURL
altogether.  Ideally we may still want to see them to learn about
urgency of future need to rewrite our code (we only want to avoid
-Werror to stop our build).

[1] https://github.com/git/git/actions/runs/3915509922/jobs/6693756050
[2] https://curl.se/docs/releases.html
[3] https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index 981304727c..03a0bac8c9 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -69,6 +69,15 @@ DEVELOPER_CFLAGS += -Wno-missing-braces
 endif
 endif
 
+# Libraries deprecate symbols while retaining them for a long time to
+# keep software working with both older and newer versions of them.
+# Getting warnings does help the developers' awareness, but we cannot
+# afford to update too aggressively.  E.g. CURLOPT_REDIR_PROTOCOLS_STR
+# is only available in 7.85.0 that deprecates CURLOPT_REDIR_PROTOCOLS
+# but we cannot rewrite the uses of the latter with the former until
+# 7.85.0, which was released in August 2022, becomes ubiquitous.
+DEVELOPER_CFLAGS += -DCURL_DISABLE_DEPRECATION
+
 # Old versions of clang complain about initializaing a
 # struct-within-a-struct using just "{0}" rather than "{{0}}".  This
 # error is considered a false-positive and not worth fixing, because
-- 
2.39.0-198-ga38d39a4c5

