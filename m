Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C41E2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbdGKWEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:04:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34767 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754244AbdGKWET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:04:19 -0400
Received: by mail-pf0-f180.google.com with SMTP id q85so2567027pfq.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mN6vJM0CjvAZfSXdGMKqEDvQpFXSNjW3Xglc7FkiZZg=;
        b=ACSKpx1nNeAxYbEHBMsvhh+te1gxYJWVRRQyCtx+JMCdKCCYTJqzNPEJZmb/TZiqra
         N9sSVuO2z9TvR4su+9yHu1INQJeFm2g1OqR1CMIFXVIDmdlVcujrILRZjTORhXyL8Wcj
         gHcQxWVB0B/DjIBGa2ZIPD00weUThWDYZmIzZB/BtwdsQNWmIFenX0HdHeMHSXM0U0fO
         Dg/bNgihlE4DOBlNdAC7t0RF3CR+XsVtmbRJ2fiFkYpJP2clz6oQK0FpoVVDKCgtoDPQ
         2qKKFI9hkEfNWiDoCxwDJAdwkMucVl8J0+Drz2l8rgvtI3yeVtxng/y/yvicMgaCm7Wk
         EOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mN6vJM0CjvAZfSXdGMKqEDvQpFXSNjW3Xglc7FkiZZg=;
        b=AK+DEilof/vi2w0nRDPpCL9Xaoj3WkeX5OV+z8dVXc+YqgysmT9IOBycS8oQ+B5t2e
         C28BiTZNbfMf/SXFjfmFOaAVwXhTK/AYyTsTa35MvCGKOVPQ3gkSjWbu/YTXEacsE3FV
         GFydjElp4Wc7QzgaZYmsiTj1HjTzeYooB5z0EwP16J+pj1PKf8hVhMuIuEhrhuEXXZVi
         +bj8rq+QeQDLDYENvKGHkDAuNUvAibDwcZMAQWMaeBkx++47nc/KcEMXIH6vNiNleXpe
         nfxq7QfN+TQmVC5W86FsKkui1F6Qfb4cIaSNZHcakdTZ7JjRPx6PhsyO9KrTdKdDTms8
         j+uA==
X-Gm-Message-State: AIVw113JJaQ34Yi7I7CFkFMTh9EXNdoYnzYjjQB1IQ6+iIXVID8+iDl7
        q+rHVozSNHaX8dZSaAalmw==
X-Received: by 10.99.174.67 with SMTP id e3mr572923pgp.75.1499810658119;
        Tue, 11 Jul 2017 15:04:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d18sm542782pgn.27.2017.07.11.15.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 15:04:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/3] setup: have the_repository use the_index
Date:   Tue, 11 Jul 2017 15:04:07 -0700
Message-Id: <20170711220408.173269-3-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170711220408.173269-1-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the index state which is stored in 'the_repository' be a pointer to
the in-core instead 'the_index'.  This makes it easier to begin
transitioning more parts of the code base to operate on a 'struct
repository'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index 860507e1f..b370bf3c1 100644
--- a/setup.c
+++ b/setup.c
@@ -1123,6 +1123,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			setup_git_env();
 		}
 	}
+	the_repository->index = &the_index;
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
-- 
2.13.2.932.g7449e964c-goog

