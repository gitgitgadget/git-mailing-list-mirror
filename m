Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E976208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbdHOMyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:54:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33695 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbdHOMxm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so1380150wmd.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cHOMhsGcxImmF3Ces93ygdNbf7D/5+C/YRAoD2rni4k=;
        b=hDIwYMix0gmXWT1D3pruV6RBgets1ZZLMYGSvd+abdenoFyariHqGWQb9HTe8DKtTu
         nKj0JZn9skIwp8i5Kr5ZWzmORBVyzHtHNnnfVay1ayoBwIWUKd+So0Yp+feiab+ZqZ37
         8ZkIAnHeiTeZ4fUV3fr2ZV5xSTNIrQ907+K2LneqKldeLFv5Fbf8fiu9C2IhppiL1giN
         P9Wzd+3PgBsi+juigYM0WUW7JYtq725ekc6Gzqh+LO/j1R6yjkwRN4KKRgNGyDkhcB7i
         xPpDu0wmhNDhsIIntQk/zW63RbpKIQdk1e/6lDaY/CoRbAXrN7MvYO1SUGJgroGHq2VZ
         LFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHOMhsGcxImmF3Ces93ygdNbf7D/5+C/YRAoD2rni4k=;
        b=UJQdSMkhblHFq5/1R4HTOWvr8ThZeaMEHbcw3d9MbUIMup36J5GIQqFgfvHEKZDPK5
         C5qyc8sVXMy6csc9CqQS2UYBmF0j5RWp6JSja1nSPtFSN48H3cTuahuCcbqzO/WFLIVR
         MYS9mlTWSv03a9wmh7u8EWRaaaQN84gMz+AMPBiYMbMWMudN1mMEONU7woZc3kg27o6a
         fme/OiXDsfItYnlJqicIo0iAOqL89Daudd4nyekV2krqVeuGGcq94SnWv4gxrJwF6wZJ
         7s2d3c+wjTRaS95RNkOpvPvxAvWOTcuv8p4ScSX5L/0eiyV6MksM/47yS7j7diyvocs+
         9pCw==
X-Gm-Message-State: AHYfb5iG6brys7yFS3+nNGWzVyPfE4BqEv5+hlgWF4IGGZ0w1p/AylTu
        zq/UUsZrZNb1A5zs
X-Received: by 10.28.88.82 with SMTP id m79mr1372265wmb.52.1502801620800;
        Tue, 15 Aug 2017 05:53:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] strbuf_reset: don't write to slopbuf with ThreadSanitizer
Date:   Tue, 15 Aug 2017 14:53:04 +0200
Message-Id: <931ffb00319f40e3c9e099f17eeae6a0c1de41ea.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If two threads have one freshly initialized string buffer each and call
strbuf_reset on them at roughly the same time, both threads will be
writing a '\0' to strbuf_slopbuf. That is not a problem in practice
since it doesn't matter in which order the writes happen. But
ThreadSanitizer will consider this a race.

When compiling with GIT_THREAD_SANITIZER, avoid writing to
strbuf_slopbuf. Let's instead assert on the first byte of strbuf_slopbuf
being '\0', since it ensures the promised invariant of "buf[len] ==
'\0'". (Writing to strbuf_slopbuf is normally bad, but could become even
more bad if we stop covering it up in strbuf_reset.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 strbuf.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index e705b94db..295654d39 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -153,7 +153,19 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 /**
  * Empty the buffer by setting the size of it to zero.
  */
+#ifdef GIT_THREAD_SANITIZER
+#define strbuf_reset(sb)						\
+	do {								\
+		struct strbuf *_sb = sb; 				\
+		_sb->len = 0;						\
+		if (_sb->buf == strbuf_slopbuf)				\
+			assert(!strbuf_slopbuf[0]);			\
+		else							\
+			_sb->buf[0] = '\0';				\
+	} while (0)
+#else
 #define strbuf_reset(sb)  strbuf_setlen(sb, 0)
+#endif
 
 
 /**
-- 
2.14.1.151.gdfeca7a7e

