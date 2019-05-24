Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026121F462
	for <e@80x24.org>; Fri, 24 May 2019 00:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfEXAPo (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 20:15:44 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52725 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfEXAPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 20:15:43 -0400
Received: by mail-yb1-f201.google.com with SMTP id w6so3867124ybp.19
        for <git@vger.kernel.org>; Thu, 23 May 2019 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4HLm+nx9Whu7xVfVPGVK4+x2km1riYX5XcyIoFEbX10=;
        b=b3mTXb0pJWHOBYrLTxrg8geWsGPB7rgElmPp7s2Mx+fvPO28hK+r9T3DkKG2oKTH8d
         8ErniMf+NdgAPsWR2dkgfN+acB8MgGf2rLQ7/eL5JIzTJBMVXpr0krrkQ5n1C1ZL7k8s
         Rxz2knM2O7DWwPHSb+fkz1VNOz0I6xNcE7j/FnywzAHNe6ktdZ8wqNON6UEOhrgmxwtz
         MWDbo4wWKfAqX24H1/eMz31OlL7FjlSmJBfhCoOfpuR/7z9pxSwu6/wJqeQ65cMoaK/j
         Z3tXoa/kaQOldzZU1gw4bp3/jo0HM9bWoSu04QabssCw5lSifdF9qGW7U8CekYe+etaP
         nFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4HLm+nx9Whu7xVfVPGVK4+x2km1riYX5XcyIoFEbX10=;
        b=etE8WR05EMhqA7t7XeeIRjWmrbu/TH+8Zsu6R91rk+U4NnDPtVgVTvBkgYNF7nwns4
         TAFKlgIUeCF4/owCdIBh3fLw5OycpEXMZENSPKRYO7pn2r2txop2CxaXDex8tNYkQt7G
         VzgJBvspiUQWy3LISfVtwrlpMw4o2jwYQsGUDox3s3zMkAxp4bu0bs/ienn27Vr3ekzT
         FdMmwFuAvUIfWTC7r9kU/TYBpBRwXKG9Q/kQb/YkonuMbJ35kv/lKY5SNmnd9j3mBIoL
         NfxK3bNPI1f6zED01s3KVybYEh5Bnt+7WMJFCuyQConXogMJdYPYd7jAoD7VhW2EEck+
         /Ycg==
X-Gm-Message-State: APjAAAV0TwW0+TN799HAv1mQMmsA/tnhAMGJkCZWPCE8Q7XIW8Eb0Jhv
        YqzFimxGmAk6Fz008XPwFG6+yGqN4vqEVJaW0NRvmMJ9kMHhKC0LqUTcKyhNJsbk3Y7k9aqF8Ak
        MN+a0m5Zy/WCxTlFGTBCI9T9ugIXNmJr8QSKWXgUzi/hR5zcd9dm7ZmEY8ke8
X-Google-Smtp-Source: APXvYqxH9jeYSolMLZdaTpg6AvxFbTs0Urhf94846pS4qC8A8G79vlZ+HnqdzytnrVMjefXqukbMOZGRDB5+
X-Received: by 2002:a81:4c4e:: with SMTP id z75mr45856028ywa.416.1558656943147;
 Thu, 23 May 2019 17:15:43 -0700 (PDT)
Date:   Thu, 23 May 2019 17:15:25 -0700
In-Reply-To: <20190524000150.GD70860@google.com>
Message-Id: <20190524001525.12952-1-delphij@google.com>
Mime-Version: 1.0
References: <20190524000150.GD70860@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] clone: respect user supplied origin name when setting up
 partial clone
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Xin Li <delphij@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..822208a346 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1215,7 +1215,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			remote_head_points_at, &branch_top);
 
 	if (filter_options.choice)
-		partial_clone_register("origin", &filter_options);
+		partial_clone_register(option_origin, &filter_options);
 
 	if (is_local)
 		clone_local(path, git_dir);
-- 
2.22.0.rc1.257.g3120a18244-goog

