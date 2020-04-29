Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC7C83007
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FD82076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lWBjZPkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD2Wje (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wjd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:39:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F51C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c21so1426653plz.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7dkz/Jd0fjk6gIBT8np814V6zRlWTh2MCX37MDQT3EM=;
        b=lWBjZPkXDy1rbKK+JaBFtNUTeqdTYl6gACJZ2D5qkJ6tjWIBo0cickMNrvZRu0Preh
         kppGJGh83brU646ZMgGcw/e+QAwfVQS8bZdaGSzm7OD3i59mo3rT9kVVXUB1p5AI7imM
         yZjTaPU1MTGnKEfzbIJDS9Slk71/0Yyiza6+luOjFXpK8xMgSCg2R0SmG2VME+koI4M5
         AF56A9SMuzn0eO8f6F9Va2/Ytp/dlNECd2hCuVvV9p+IwAM9udnT0VU29Y/p6S3aXRHc
         aP2xyEzoDv6p+dCQzs6CuWBHQxE4EdGwsomB4cSjA1WbfrBidv/cSlYHti8nQrLwCIj0
         7X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dkz/Jd0fjk6gIBT8np814V6zRlWTh2MCX37MDQT3EM=;
        b=gITbDpoNPPPFySpZmXKxZmMtN7HPiOQB0eaW21E3kLK2dpAQyibWlONgvBJ/7e9nnq
         fYsTAbIOuT4bR5vRor2F/esF2w0YhvnA7AHA8HnccKXAKqP//pmpNhK8PWFFA362BVvW
         dwaikCIWg7Y255GHnESHte5YQCR/wJweYpLSC2AnkIonpZHLaJQI/vXk2mpRPPjolWmS
         apbvzYI9Do7Y3RZXanxMx2leNTOdrzEFzVK+sZRIQ+7MDgHBTfDFpS6Pu1I/LcZZTJe5
         TQNPhh9dSsu3TcORT88CCNoi+8KlPMoGbWh75IYZmug5WXGlWmRaUjp/TZV2ZgTMWXLv
         XZUA==
X-Gm-Message-State: AGi0PuZrreALxYmOVliomC8ekENQ+6vbl8uo4j1/DHWQIH5M+vhEReHl
        F20A0iiGYStFVriWhkt7MwbkKyr2ObGBd7TS
X-Google-Smtp-Source: APiQypJL2qEXzC4+T7856uB+mhAVdoWil1UiZaJOvLTD6EGllTUnyHqv86gLx9UkQRWY23DotOT/MQ==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr629934plp.277.1588199971370;
        Wed, 29 Apr 2020 15:39:31 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v94sm226509pjb.39.2020.04.29.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:39:30 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:39:29 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH 1/5] commit: make 'commit_graft_pos' non-static
Message-ID: <8ac4c63735f2e48dc83e9f31c9fbbbfb47d7e79d.1588199705.git.me@ttaylorr.com>
References: <cover.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588199705.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, some functions will be moved from 'commit.c' to have
prototypes in a new 'shallow.h' and their implementations in
'shallow.c'.

Three functions in 'commit.c' use 'commit_graft_pos()' (they are
'register_commit_graft()', 'lookup_commit_graft()', and
'unregister_shallow()'). The first two of these will stay in 'commit.c',
but the latter will move to 'shallow.c', and thus needs
'commit_graft_pos' to be non-static.

Prepare for that by making 'commit_graft_pos' non-static so that it can
be called from both 'commit.c' and 'shallow.c'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit.c | 2 +-
 commit.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index c7099daeac..b76f7d72be 100644
--- a/commit.c
+++ b/commit.c
@@ -110,7 +110,7 @@ static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
 	return commit_graft_table[index]->oid.hash;
 }
 
-static int commit_graft_pos(struct repository *r, const unsigned char *sha1)
+int commit_graft_pos(struct repository *r, const unsigned char *sha1)
 {
 	return sha1_pos(sha1, r->parsed_objects->grafts,
 			r->parsed_objects->grafts_nr,
diff --git a/commit.h b/commit.h
index ab91d21131..eb42e8b6d2 100644
--- a/commit.h
+++ b/commit.h
@@ -236,6 +236,7 @@ struct commit_graft {
 typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
+int commit_graft_pos(struct repository *r, const unsigned char *sha1);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
 void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
-- 
2.26.0.113.ge9739cdccc

