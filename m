Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19FDC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiLLWqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiLLWqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:46:35 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC3D57
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:46:34 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o18-20020a170902d4d200b00189d4c25568so11611977plg.13
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hscUdynSG6YVZn84sRRxflERLuTDYwtLboS7BDgf9Y=;
        b=V1cSHUEYFXjZOjwl/yjO4cN1MfkHFx+4uDdxNYHovEOl5/LIm4G0r1duHfPuMSINdu
         FTRHszTrFEtTtPPe7sLw6A4nLkGhsE9WP+25wKQQio7iqYkCtsPO2DNKW5WpJGp3fmNK
         AFRIEalBrjU+KcygtdI6mFkLON/2sbrt60SvOL4VCYcOgUECopGqVxKEFvQvaqfRCKXD
         cNgzPoJqZG8wOSzTdKL5J2UUz/iHHZeHU1dDnWzXAYmKZ67lLzZ82LCaEKiKWUYgoMlC
         DjxJhXItPdRl+SoV0BVi0S9Lj/mYeHlMdEJ/p/ZZo6DoUHDYBqktMAb/QrOOEDQoBHbR
         V2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hscUdynSG6YVZn84sRRxflERLuTDYwtLboS7BDgf9Y=;
        b=4H1De3qO3L6gBiNT149ecyRiJ6KINFEjqio/0BVwtUDTrx/jqDQZwUZXuG3GASN+Jh
         mb1oTsyaHpSsJakS/LAlYWx7nzm1f+xF/VK4NepmK2oayGXxP7/3Mn0rGtiOGWv7Xvly
         UVqj2bZ7mX9xXyjShOYGyNqXjFJ/VQHrx28W4pzuJFUXp/6gCiH5gnlrLm9N7Hh0SXhS
         eaJ750BIldI2pgkdM0dlqMbOyOxPdGnjml4BKOHfjeukEliKzWhj/tolRBzLNHytDF62
         o/w2oaPIg5OiXFd17jfOd5c0ID7iwCHkerSSJERZZGafs3xsLVnxK2iGMClgXyasR8Hm
         OFLw==
X-Gm-Message-State: ANoB5plwm13bElyhteG3ftknKsJp4v13ekOaX3aPTUr5KpFQR1TOAahj
        MxmybleWsw0k3whk6E1ccbyKw7NxJR5Efht+a3P8oOI2+lQ6ZpN/2mi0flh2m8Xq7EodTYW0+4T
        tf9jLsjl0afw6He/aE7v1mTOiAzCZfinX1KWwCouSE0B+/G+yC84VFd0MsPpRxDyELOvCR86Lnf
        CD
X-Google-Smtp-Source: AA0mqf5Y9Mjijcj5cPe+LBhE+wNMkzkMGrT8e2AqVPBRJo60h5ppp635DMEy1wiKyy0PuIJVPA9AazEOjwwmArp8SSd7
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9159:0:b0:572:24c7:34da with
 SMTP id 25-20020aa79159000000b0057224c734damr80271308pfi.73.1670885193935;
 Mon, 12 Dec 2022 14:46:33 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:46:30 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212224630.2553391-1-jonathantanmy@google.com>
Subject: [PATCH] http-fetch: invoke trace2_cmd_name()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ee4512ed48 ("trace2: create new combined trace facility", 2019-02-
22) introduced trace2_cmd_name() and taught both the Git built-ins and
some non-built-ins to use it. However, http-fetch was not one of them
(perhaps due to its low usage at the time).

Teach http-fetch to invoke this function. After this patch, this
function will be invoked right after argument parsing, just like in
remote-curl.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was discovered at $DAYJOB after we noticed that there were command
names missing in the trace whenever a user did a fetch that involved
packfile offloading.
---
 http-fetch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/http-fetch.c b/http-fetch.c
index 31bc5c7767..258fec2068 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,6 +5,7 @@
 #include "walker.h"
 #include "strvec.h"
 #include "urlmatch.h"
+#include "trace2.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
 "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
@@ -137,6 +138,8 @@ int cmd_main(int argc, const char **argv)
 	if (nongit)
 		die(_("not a git repository"));
 
+	trace2_cmd_name("http-fetch");
+
 	git_config(git_default_config, NULL);
 
 	if (packfile) {
-- 
2.39.0.rc1.256.g54fd8350bd-goog

