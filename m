Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10579C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0F620674
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJAIBRyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfK0PNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38579 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfK0PNf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so10569823pgl.5
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1hvW8QhnzDhzjh6pUdqTfMBwlK3LyjCTzvsbe0GPpw=;
        b=uJAIBRywk/CycldhQMDedtXoHDO6U9Drp3fD/D2ScPvqcyI8cbhOlcYYuMYeibfhPI
         KSHybr1Gl417qySIKMGWb2poDeLnoRhfwduTfWWcjiYzXPoaJW03hlS9F53xjxQi5f7Q
         RkKnBlCxmMatcBIvwUkOXZZGshTY/vyMzRKDbfO0jBUDaTwZvKMawOaXPuVYBVRiJ5Lk
         HPe5QlAt93/+zGIjWT5cJZcwjZxyJTOSARekg+rK167X0ERxtX9BM6cU9kdmKOIw7At+
         6M1VGcQolYvMuUga5z9GR/vGB9RY3zE7OM0nIJh/AsW2vXBoi2fy1jd+nf/XJ0eSyWSm
         Jp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1hvW8QhnzDhzjh6pUdqTfMBwlK3LyjCTzvsbe0GPpw=;
        b=KsUMACFR4rO8i/IcOgCoLjt182BVwHWmxLjuG0fyxZCK566yi7cNS/2xLZkaiwDbRc
         bP7OkEHOLwX8fZn0T9ad+SAzoarYu+QG8CJEgxb7I8oy1A9goBbNWNg4Y9iD9sJiLpal
         vxT+GGq+ttFeimqUyh33ldYApNNFxzEw93K51fo+jKMPTsvHyKcWBiw9ITmKgqUgj5rT
         ewLYZHmx1UllVTPol5q+S3ghXL/Sm+N896YD9K+urdpjpV1SWne6WxtvYNVz2b4KezV8
         T1D7moBINYthN3Wzrqf0YTWeLIwtuPyO9RkkapGXFVrlmb/xZHI90qsEv1ZAlYMvabnz
         ZXkA==
X-Gm-Message-State: APjAAAXrlSO0HPLgZhYbeqv8Yy7Vx5sG6QjLocxvja3omePvzelc8p71
        lMPW8lDqUU1riokvm7o1MhPvH+Cd
X-Google-Smtp-Source: APXvYqy2lAsJEmIqKfGdAa8ugeMxhepT5XB7ZLwEATxQ2KhENr/i/KjKEkDm9HAAl+NNCWXj0Q69yw==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr49186830pfr.7.1574867613397;
        Wed, 27 Nov 2019 07:13:33 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g192sm16883674pgc.3.2019.11.27.07.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:13:32 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 1/5] date.c::datestamp: switch to reentrant localtime_r
Date:   Wed, 27 Nov 2019 22:13:17 +0700
Message-Id: <1e7e08b3c7a9d75d761b8ff63ddb291f6cca14e4.1574867409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.158.gd77a74f4dd.dirty
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, git was intended to be single-thread executable.
`localtime(3)' can be used in such codebase for cleaner code.

Overtime, we're employing multithread in our code base.

Let's phase out `localtime(3)' with the favour of `localtime_r(3)'
in this public interface.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 date.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 041db7db4e..553f8e79a2 100644
--- a/date.c
+++ b/date.c
@@ -959,10 +959,11 @@ void datestamp(struct strbuf *out)
 {
 	time_t now;
 	int offset;
+	struct tm tm = { 0 };
 
 	time(&now);
 
-	offset = tm_to_time_t(localtime(&now)) - now;
+	offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
 	offset /= 60;
 
 	date_string(now, offset, out);
-- 
2.24.0.158.gd77a74f4dd.dirty

