Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8AE20968
	for <e@80x24.org>; Tue,  3 Jan 2017 19:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757680AbdACTJ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:09:58 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33608 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757314AbdACTJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:09:56 -0500
Received: by mail-pg0-f52.google.com with SMTP id g1so178525163pgn.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4IAXDnDCzHNiKAs4GcGOF3VjQDPTT0UMCpooP7Qys2E=;
        b=GZSThGhT9jGk5XislPYEm0GTWxQrLjFLWeJTaT5IAA5jSCMNuUAJLLHbbeoTyOfcCt
         lwz4uff7eQLqNyQ6HL9IoTemSPpZsXF0vjNsA3stNafA+okM0AJXF55Kq3qzuUmRH0l8
         uirDtL9hU5oXBQesRN1zTchMTqyHcmjWS++X5uWDNSv48ZkTFQDC6AmhYb9+T9SLVfHt
         HNmhhmYg8Wgkt0gcege6NzK7e4r63BXUPKcuNScRVEofST1J6ygDeBgYU1i2Xthc9AyX
         y4r1ZKDMZAEN+FW4p+hAYpj3udYu0CLTZfAG/zncZsJl9C6tTRmhzAcJM3wQLTdmK3Zl
         MD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4IAXDnDCzHNiKAs4GcGOF3VjQDPTT0UMCpooP7Qys2E=;
        b=ExPFHa9+vZPjIJAF7mclIfuv0CZbxp5fdcJTUd3VOIxZW2DzHl51zwcsmL86utdXKm
         wZKIIPW8X1n6d7qT3Rr0pLIBQ0Lg4GAlDHVsTrKosY6oGoRv3T6P+B8dKPSqFRtpelKm
         qtDglH3HmNCtjCNFGray5DhUkMGQuYmFqUJAY3e3Oi5HofM2zsIKgPcUAySN0Ybrmipf
         Ejj6gt8aHPQmJ6sOlnBP8ahGrRMG1ZB6/Ud+zX9Ef7IhdpQzHH4m5J2NRbTjFk4Qdy4v
         0RAa4CtfShHEgU+T2HoZ68Yoka8FE1OR3t0I2jGH67AKg5jhX+HXwC4XZ2VndeJMkP+m
         TmNg==
X-Gm-Message-State: AIkVDXIAiiuiDUYcGtkE3la/h3F7JMh8Eyi8O7xzD2mDyCi5z+fwu2Rih7povnwpcZ5m6cgr
X-Received: by 10.84.241.129 with SMTP id b1mr122322857pll.135.1483470596238;
        Tue, 03 Jan 2017 11:09:56 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id q5sm66947112pgf.45.2017.01.03.11.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 11:09:54 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v4 0/5] road to reentrant real_path
Date:   Tue,  3 Jan 2017 11:09:18 -0800
Message-Id: <20170103190923.11882-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <1481566615-75299-1-git-send-email-bmwill@google.com>
References: <1481566615-75299-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only change with v4 is in [1/5] renaming the #define MAXSYMLINKS back to
MAXDEPTH due to a naming conflict brought up by Lars Schneider.

Brandon Williams (4):
  real_path: resolve symlinks by hand
  real_path: convert real_path_internal to strbuf_realpath
  real_path: create real_pathdup
  real_path: have callers use real_pathdup and strbuf_realpath

Johannes Sixt (1):
  real_path: canonicalize directory separators in root parts

 abspath.c         | 225 +++++++++++++++++++++++++++++++++++++-----------------
 builtin/init-db.c |   6 +-
 cache.h           |   3 +
 environment.c     |   2 +-
 setup.c           |  13 ++--
 sha1_file.c       |   2 +-
 submodule.c       |   2 +-
 transport.c       |   2 +-
 worktree.c        |   2 +-
 9 files changed, 173 insertions(+), 84 deletions(-)

--- interdiff with v3

diff --git a/abspath.c b/abspath.c
index 1d56f5ed9..3562d17bf 100644
--- a/abspath.c
+++ b/abspath.c
@@ -62,7 +62,7 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 }
 
 /* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXSYMLINKS 5
+#define MAXDEPTH 5
 
 /*
  * Return the real path (i.e., absolute path, with symlinks resolved
@@ -138,10 +138,10 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			ssize_t len;
 			strbuf_reset(&symlink);
 
-			if (num_symlinks++ > MAXSYMLINKS) {
+			if (num_symlinks++ > MAXDEPTH) {
 				if (die_on_error)
 					die("More than %d nested symlinks "
-					    "on path '%s'", MAXSYMLINKS, path);
+					    "on path '%s'", MAXDEPTH, path);
 				else
 					goto error_out;
 			}

-- 
2.11.0.390.gc69c2f50cf-goog

