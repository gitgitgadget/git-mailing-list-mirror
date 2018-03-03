Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50EC1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 03:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeCCDjj (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 22:39:39 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35865 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeCCDji (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 22:39:38 -0500
Received: by mail-pl0-f65.google.com with SMTP id 61-v6so6800636plf.3
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 19:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PWYlNTsfHhC/ebR6jSRatryIY4iDs6MteombJMo0ls=;
        b=dcYSsoFmzFHltSKJntZiKf65p24qaSM1E0FImAgtPIIQoBdGTWoSTz1Ze099k2lLCO
         U3MizTM9qcqQYCDIpkQBUMcdqzyADd10f2PapXGtdbhuT6PeFynDKRQY8NZv0MYPxosz
         JWvn1hrPd+/al457OEZXG88tAzKj1ucDT4lZeVOOs0lDpc+isJUJ0WlW1hbju6z0OHT0
         XP7EdjUu2Wmi5w/A2zSfjeh3Fnkph9zE7LZ3xX1anbCQoHPydY3tHGaZjzTwdjgLw+Yl
         ctZOLu6UMok1NcHTM7RKyDXNIpzRHX3mWgIvSOtgq0ucNEiaK96+gqCtyVn5a5MOYWnO
         nF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PWYlNTsfHhC/ebR6jSRatryIY4iDs6MteombJMo0ls=;
        b=m8849WWzz72qcoBfiAO4s3gZUB0zbbkPs6S8GhxfOU82OVw+0ZVmfSdxHCZGdf4tzj
         1n0/Ex6XvgtFclFUcbMazpmcPYSAopiet+hJbMixORG0KgZTWcsMdlT3HUg9BvzM1hmk
         2SM/gts0HDrmYWkn9vLyE6ObUh9iFEGZs9L39/hpq+FzsR221a+r2uzqhtDlE5jFllyo
         jP2liKLxfJQy/y7oe5LB49QL3u7+bbookB5QoiKndvx2GgNHlv2azT6qZp61Tq+5broo
         EBpuEUHLreYxg00WNkBrM2DEfzBhWeS8EpaLZWYWBhECsasOJCmgT7OI3Sjt1i+Q6u/E
         kFvg==
X-Gm-Message-State: APf1xPBlC3zeVv/Ubqj7wlmfOUo0z47E3/GfXWlzfrv3l7O7ONJhnDBz
        9DwOVfZQTssrl3w2BARWCqmwNA==
X-Google-Smtp-Source: AG47ELty8efnEM1AymVTG1KAnHmP//70EUcYN8CzPNGnOaIjKWpCrHq3TlpZldtMIdfXfbd9FDenHg==
X-Received: by 2002:a17:902:167:: with SMTP id 94-v6mr7260552plb.294.1520048378018;
        Fri, 02 Mar 2018 19:39:38 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j23sm1843885pfi.78.2018.03.02.19.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 19:39:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 10:39:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] worktree prune: improve prune logic when worktree is moved
Date:   Sat,  3 Mar 2018 10:39:18 +0700
Message-Id: <20180303033918.15751-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303033918.15751-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Worktree manual move support is actually gone in 618244e160 (worktree:
stop supporting moving worktrees manually - 2016-01-22). Before that,
this gitdir could be updated often when the worktree is accessed. That
keeps the worktree from being pruned by this logic.

"git worktree move" is coming so we don't really need this, but since
it's easy to do, perhaps we could keep supporting manual worktree move a
bit longer. Notice that when a worktree is active, the "index" file
should be updated pretty often in common case. The logic is updated to
check for index mtime to see if the worktree is alive.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 60440c4106..4d4404e97f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -101,6 +101,9 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	if (!file_exists(path)) {
 		free(path);
 		if (st.st_mtime <= expire) {
+			if (!stat(git_path("worktrees/%s/index", id), &st) &&
+			    st.st_mtime > expire)
+				return 0;
 			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
 			return 1;
 		} else {
-- 
2.16.1.435.g8f24da2e1a

