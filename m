Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA27C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EC8206BF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzVc14PF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgD0OWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD0OWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 10:22:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE1C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so9079941pfx.6
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzL+dEEph4s91YgjbNYfz5rWPTiXwkCd+p97wjy49HE=;
        b=qzVc14PFGKoHlB1Qdrj8is6ts5Z9SBP3HjqptoVhAeZSb5LwayTUWqnQpst6qkdgQo
         zM4pweRY+gJEBVPMA7uCfvGd+m9N6vmTjzDH7OKxiRYUgPK39P5/L3QqYiUtqNTkgT8C
         mG8T527t6bcmpjF/G9ckiJXouEzmEQ7AbhZgDI8zBMXnFYmz/IM8MAcOy3+6Pf8eug9C
         v+jsX1HhDT0zP19iH++hjYJkcd2X6LM2Uv4r0yebLqw4/DdC/xrUifLpCr5oBgaWJqM4
         +YAyFwY9e0jI14BTANpDcQQEyS7iKErGm6/FhaWepmmfvu6taA1S6iPKGC0HEKE4DMpw
         90hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzL+dEEph4s91YgjbNYfz5rWPTiXwkCd+p97wjy49HE=;
        b=awtqoyibJ5LGE2sCzw7NsT4XnrQWBBT7AjsuYxeqINF7dXUpRDlLXimiqGBi1u7Y4z
         ba/vXaEI88JxAJlcORDJqAuyUJ9aEOHY29VXeQ1TVSpjPwlV8Awag/i3fWvplJ284IKV
         i3uTflfh0M1CkaUtxjwGMaRUIW6sMPoM6f/BUKI/fXlo8o6PYJzvR7j7HQAwjYzO5voF
         Y6vWg+7M9DC6ErRPKxAC53307nk5B8sbeQ/JghyxrlAR+UwpfTTBCpFvbuOHeWTJH9Jt
         y3SanZsdBO/o+h8wNtDBb1dHuzeHKUHywS4zIdc4WARkhdlrW8rnBRwgEKsuc7cavpxx
         /DMg==
X-Gm-Message-State: AGi0PuZD9GVFONYq52vJsWyngF1xBeNeRhutXRQ+GhwYcm2uTbhTppRC
        czvcc6DJ4FXaWtSTzskDJfTI1+7d
X-Google-Smtp-Source: APiQypIn29rribsRO13+CTe5ZkYaxJw7sdiF5u7YCDXsWYD1TlynOwA1IGYRBCMqdCLUNp8nvKpCvw==
X-Received: by 2002:a63:6b44:: with SMTP id g65mr22578827pgc.73.1587997368873;
        Mon, 27 Apr 2020 07:22:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id c1sm12589602pfc.94.2020.04.27.07.22.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:22:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/4] Partial fix `make sparse`
Date:   Mon, 27 Apr 2020 21:22:33 +0700
Message-Id: <cover.1587996765.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
In-Reply-To: <cover.1587648870.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change in v3 from v2:
* rewrite [2/4] based on Ramsay's suggestion

Change in v2 from v1:
* = { 0 } is an idiom to zero the structure, it shouldn't be changed
* change in [4/4] for prototype
* ignore diffent function prototype


Đoàn Trần Công Danh (4):
  test-parse-pathspec-file.c: s/0/NULL/ for pointer type
  compat/regex: move stdlib.h up in inclusion chain
  graph.c: limit linkage of internal variable
  progress.c: silence cgcc suggestion about internal linkage

 compat/regex/regex.c                | 1 +
 compat/regex/regex_internal.h       | 1 -
 graph.c                             | 2 +-
 progress.c                          | 2 +-
 progress.h                          | 8 ++++++++
 t/helper/test-parse-pathspec-file.c | 6 +++---
 t/helper/test-progress.c            | 9 +--------
 7 files changed, 15 insertions(+), 14 deletions(-)

Range-diff against v2:
1:  c9a1812abf = 1:  c9a1812abf test-parse-pathspec-file.c: s/0/NULL/ for pointer type
2:  290ba923b5 < -:  ---------- compat/regex: include alloca.h before undef it
-:  ---------- > 2:  8d18c53bc8 compat/regex: move stdlib.h up in inclusion chain
3:  39f8d85c2f = 3:  4e7580e1d1 graph.c: limit linkage of internal variable
4:  41eecf18ed = 4:  d66d9aa677 progress.c: silence cgcc suggestion about internal linkage
-- 
2.26.2.526.g744177e7f7

