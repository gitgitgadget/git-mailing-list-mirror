Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E2FC47259
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC62208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUqu/Z0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgEAPak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgEAPai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B5C061A0E
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so75614wmc.2
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=N+OYlNIdFj9SqGVPBqA/nbDPJTmYCtz6vCoqvufPBmg=;
        b=kUqu/Z0GyU74r7oQ5VPy1gx5n6z3tV5Duo7pb0nqtd2ugZtIPRYeiArsR7AzMYqJl2
         k4x19Sgxbe+dISSBrELuqnQgRHUMpO1osbt6bUInCur54xzC9QWlTHVT7oqMfZL/YsV8
         OxJWZEvlOpZXZSLwFvugyDvExo+po5uBXg8Iu6Go4d+/sOIYfjcB5J6Dh5ZoGttP38VU
         NGM7jcj2YQqrGFKk+S0kV2rFhmlHDah+/k7wbMk5oa+u4q4FWcn14cSgtfGg3PQvUDah
         M7VgzWSH12jqdAu3U5SLE/ggwWGE4NjOY4NiXxKyvOgAlteV7OB72bHASpt1/l9EG+Xm
         /1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=N+OYlNIdFj9SqGVPBqA/nbDPJTmYCtz6vCoqvufPBmg=;
        b=kaGnTYryA18sEkLv3wdsAmNDJzM+jDCbCcNvnwoi+qO8/tGf/sLtUc2JWmMwO2mYr0
         NPUD+FD7GariZO2KWpvAPGwx7dDtiuAoMLfoUg81v+ZnZwsQEFJrdO54r5XlGQjfze/h
         QIWAKSw5ziuFuUEcbotiHk9+85SsY9m0fcM1IdhJl8oH1l0fFdBDbA8LnKRjsEo5w+M5
         S1/GbRrzm8eSLoSF40qDjouAXgbEWdxkkDYGo+rHCxwsV8XXUu08jmALvdmNvVC/BpOo
         07VM1XAA+Fg2zcsk8uhbF88JvApbZ9pkqWbx31YAQ2iSJKaTKpxCGlzRxuQx442m2dub
         GEfA==
X-Gm-Message-State: AGi0PuZwZpqROvFQT4SZHdw99P/gzwjkNtVXnn8SpDhChcdfF9vhgZMK
        sLCPsGSOR0G/mKLcFUBXsQfutz9F
X-Google-Smtp-Source: APiQypK8ZMCV3RK45l7wtXKrwQsHoc9TIIDou4BTqkSOR/5g0IxlQFd6rlfwooxCz/qcpJOhc5NO4Q==
X-Received: by 2002:a05:600c:2c0f:: with SMTP id q15mr69202wmg.185.1588347036957;
        Fri, 01 May 2020 08:30:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm12231wml.23.2020.05.01.08.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:36 -0700 (PDT)
Message-Id: <1f326612da05dfa74ebaaee6a852d5ef92a4ed29.1588347029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:25 +0000
Subject: [PATCH 08/12] line-log: remove unused fields from 'struct
 line_log_data'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

Remove the unused fields 'status', 'arg_alloc', 'arg_nr' and 'args'
from 'struct line_log_data'.  They were already part of the struct
when it was introduced in commit 12da1d1f6 (Implement line-history
search (git log -L), 2013-03-28), but as far as I can tell none of
them have ever been actually used.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 line-log.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/line-log.h b/line-log.h
index 8ee7a2bd4a1..882c5055bb8 100644
--- a/line-log.h
+++ b/line-log.h
@@ -46,10 +46,7 @@ void sort_and_merge_range_set(struct range_set *);
 struct line_log_data {
 	struct line_log_data *next;
 	char *path;
-	char status;
 	struct range_set ranges;
-	int arg_alloc, arg_nr;
-	const char **args;
 	struct diff_filepair *pair;
 	struct diff_ranges diff;
 };
-- 
gitgitgadget

