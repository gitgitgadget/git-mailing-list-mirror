Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EDDF208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdH3HM1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:12:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33723 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdH3HM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:12:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id r62so1065819pfj.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8LkrZgAz1Yty4zgkmpfNmfSU4cTZEugn+l78XTXJJo=;
        b=ZXw6ydTmqj5zvg85pFqhEKTdr5hlLegl4L7rQz46pu2IXtUHvBWUgXWAXCbezDytea
         yS1qDMPMobGavXWTLoVKgbm93Zv8tQ96PMcE9CnyKkl1jr9TJTJEZWtTEkm5hoyo/CeX
         Q5oa+2ifmbQb77SW3AFqTZzFfDdak3rw6LQi6bJ76HKX0RnOy9MWo3Bfs515N+9YYSTx
         JJQJ0MeUmNOXwaoWYPzwTe6kVnGOKEA8XuHpthh0zOOMbePyY3Ay/eFwgeyb0TIj+nq6
         pgkkrtpYG0+x03b/7AT6ZbPMln7nTiXRRJ81/TDhF5xkgPS+R2uksIZ5B5/sK+nwFCfq
         5hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8LkrZgAz1Yty4zgkmpfNmfSU4cTZEugn+l78XTXJJo=;
        b=LuBf/EY0NKRAJz/0U9MFMX2qC6yyrTNAcybZZLN5KMa8q+PyvdlNXTHGav46hSKgS2
         W+KoAi2DVmY+EHjD5AippQj53enc8rZh5wvuwvGlcPQq+yjNtN4v8FRWQnGIELiWWTHS
         8LR47NJOww4ZeWuluwJwGiwCf3v/nvMzfIHKnUQX0yiVmkeon8zydWqx/8Bx24W9/tTr
         gFaMfxisDhn6ABhIeZasIFTHbhNDhCI2LlVoU9B+tQfvhY7wdc8ZHg83hR+Yx7Ix1Ys6
         2U5sK0mk2YGwpjd5hQieQroUl9MOb76EmL5NAMOCq+Nx7uT5uuNs1nzNE+AgCb+918s4
         hCLA==
X-Gm-Message-State: AHYfb5jHAQ/QjXKXOs6FNqW31jSJ1zhCIdnudAVm4YxRHqJmAWd/DcgB
        MDnY1NkwZ9v3SiXGoA4=
X-Received: by 10.101.83.143 with SMTP id x15mr655604pgq.264.1504077145861;
        Wed, 30 Aug 2017 00:12:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id 186sm7950406pfd.186.2017.08.30.00.12.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:12:25 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:12:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 29/39] pack: allow rearrange_packed_git to handle arbitrary
 repositories
Message-ID: <20170830071223.GD153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 packfile.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 51af035965..977e714d9a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -850,11 +850,10 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-#define rearrange_packed_git(r) rearrange_packed_git_##r()
-static void rearrange_packed_git_the_repository(void)
+static void rearrange_packed_git(struct repository *r)
 {
-	the_repository->objects.packed_git = llist_mergesort(
-		the_repository->objects.packed_git, get_next_packed_git,
+	r->objects.packed_git = llist_mergesort(
+		r->objects.packed_git, get_next_packed_git,
 		set_next_packed_git, sort_pack);
 }
 
-- 
2.14.1.581.gf28d330327

