Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbiF1ITw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbiF1ITG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66B65EF
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c4so10391114plc.8
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfKkdjno+WrBH9glqxySVKSZf4JT07QftT/YpA39pt8=;
        b=XA+H+QXOV5RdSenrIuUsEe3UppVIn9cAkobyuFtuEJ9cp7kAc9AkpzPk6dA1RJraEI
         NvZLch1g5PMk2vasCeILNiIUubqPJtK5uTVP+5lA8DYB6cViX88Jym8s+EoN/BO3Z/zx
         VQfYt6/GkwljV16c5MKsOCtryDzEw1XVkeMzG3WA9pAsN4Y2MCHCKpybYrZBEOIuygXU
         zv2Vm6ePa9jTMkIEfD7Wd121rXyUYBaTHNDjrQ0nZLZOjtppEUJ5qkS1uQ6jbhRwMVH8
         3eLiFtc9FOiQe1RuJcs3YLOMWS9TmuNTFdcZnZB62o39gQKbUl+KXrKu18KYlb9sHcyW
         wjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfKkdjno+WrBH9glqxySVKSZf4JT07QftT/YpA39pt8=;
        b=Ycp0IghNj/UfwaC0jJIbxTh96sZbIM5b7M+Rgn9K2kuNIXzX7YOrmqKz7w68wijYwx
         3fAmVNW0dZQCSs4RHfS/KIhDpbLQmOnKOQq76Y82kg8pOMqcHIwELcQGu2C4Ig88x91Q
         HTMzQLgDy6BGoqbm2nCx1/jOPuQiUxrJ4YGl85GcdlTw0L7QnWpzZETPEmXsRlX5Xij7
         h+lbOmAiXcSgtLUixzBZzUqGTdp5r8xr+fRNlcPSQD67gOHV09eow/ZbhoMwWeDJbtU5
         rI+Tc15h90cH1D1vRXJxHzeBA+fLqrPtdlNjBKkbX99WBMxgBUn+lbO6aWEGssPGZT36
         1sWg==
X-Gm-Message-State: AJIora9+5QNgt8dCTfzajhRpxh5rwST5VCyjxG40urgXONCZBXOFzqwK
        2xMvuFTDAKqxfmjBb/OyW/c=
X-Google-Smtp-Source: AGRyM1vtGjrpaW1peqdeZs0kglkTZlMlrwBCUkIOi/2yu2AbrHlUZFf8FSNVZfxC11MN535Ev48zCg==
X-Received: by 2002:a17:903:2145:b0:16a:65c:353c with SMTP id s5-20020a170903214500b0016a065c353cmr2529645ple.44.1656404291336;
        Tue, 28 Jun 2022 01:18:11 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016368840c41sm8551206plb.14.2022.06.28.01.18.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:18:10 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: [PATCH v5 5/5] tr2: avoid to print "interesting" config repeatedly
Date:   Tue, 28 Jun 2022 16:17:50 +0800
Message-Id: <f3b87a33da2a9bd2cd5148fcfe1d55a6281d8b99.1656403084.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.gf3b87a33da
In-Reply-To: <cover.1656403084.git.dyroneteng@gmail.com>
References: <cover.1656403084.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can use GIT_TRACE2_CONFIG_PARAMS and trace2.configparams to
dump the config which we are inteseted in to the tr2 log. If
an "interesting" config exists in multiple scopes, it will be
dumped multiple times. So, let's fix it to only print the
final value instead.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
Helped-by: Jeff Hostetler <git@jeffhostetler.com>
---
 trace2/tr2_cfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index ec9ac1a6ef..632bb6feec 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "strmap.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_sysenv.h"
 
@@ -10,6 +11,7 @@ static int tr2_cfg_loaded;
 static struct strbuf **tr2_cfg_env_vars;
 static int tr2_cfg_env_vars_count;
 static int tr2_cfg_env_vars_loaded;
+static struct strset tr_cfg_set = STRSET_INIT;
 
 /*
  * Parse a string containing a comma-delimited list of config keys
@@ -101,12 +103,17 @@ static int tr2_cfg_cb(const char *key, const char *value, void *d)
 {
 	struct strbuf **s;
 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
+	const char *prior_value;
 
 	for (s = tr2_cfg_patterns; *s; s++) {
 		struct strbuf *buf = *s;
 		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
 		if (wm == WM_MATCH) {
-			trace2_def_param_fl(data->file, data->line, key, value);
+			if (strset_contains(&tr_cfg_set, key)
+			    || git_config_get_value(key, &prior_value))
+				continue;
+			trace2_def_param_fl(data->file, data->line, key, prior_value);
+			strset_add(&tr_cfg_set, key);
 			return 0;
 		}
 	}
-- 
2.35.1.582.gf3b87a33da

