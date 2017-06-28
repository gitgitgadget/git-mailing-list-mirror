Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C3F22023D
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbdF1A5H (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:57:07 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34325 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753437AbdF1A5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:57:03 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so24650462pfs.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqTe5Pon5mh0lilY9cqDUNFP/zLG4SVKZJyWtiFzG8E=;
        b=jIH9fmAYzd5drcSavX4U15WNANK/BlL8zstwe9AhUfwvsmGI5h/iNYinxJlqB/RmCP
         x7xGAkaLKU9WMYopGumIcLo55Pzfg6DRI4Y1sweZdOz4F8zc7+AqOPHAlvaWkgSdAmvt
         j7unSUOdvP7gQ+o1opDl0+GwmzsA6RTG0VxdFRseQvKMJLXG0b95OU+LvvHOOuVe5Wbe
         AuaWuP+InEELiKVKataEKY2spmVWmpzUzHIvLj0GbJmI+H90lNZSbm3SQAr03Lo5ptB5
         +lgOh6/P03k+n9yl7IjCbid/j4e+gNaFTdrD+LR3BfhF4gRS+bfL6mGG7eyxkvPbLpkB
         Fx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqTe5Pon5mh0lilY9cqDUNFP/zLG4SVKZJyWtiFzG8E=;
        b=Emz0VABEYL1JKzGlauZKTu6HIDKCMec1JZKLXeUWD9nwyCeUWDVsTia+EQFb7t3u7f
         x06Er4UUbsRnhMBALGf6Bl9JK/yn0t9uKt0zhKgfMNcUQ+sY06mmHfDvho8wRLKE8TrJ
         1UN62zzkwrJO+VDBf8tHDwy1TtKmkev+ZFoI+BBaOsp0pyHaqIaP7qlh4GMlC4p5yME2
         b75T207tmVRtP36Iy1wReK9f5mhv/zypXWKBbeSHoYZMxIPvg7x2S0OgxIqULnFDbk7X
         g60QwegVNTsfT74+RNHL1EFHXWnETfGiNUuHX/DGXnqWXcS7r2dpUdRbYRTXyboZiPfq
         hwpA==
X-Gm-Message-State: AKS2vOw+hrGJB5CZp0BT2O/hRa6ISh7fEdx/n+b20H9hHntBwkeI0xns
        b3IeAkF0t7bJK8Y8
X-Received: by 10.84.217.148 with SMTP id p20mr8728004pli.148.1498611421816;
        Tue, 27 Jun 2017 17:57:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id 85sm818447pfr.90.2017.06.27.17.57.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:57:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] diff.c: better reporting on color.moved bogus configuration
Date:   Tue, 27 Jun 2017 17:56:48 -0700
Message-Id: <20170628005651.8110-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170628005651.8110-1-sbeller@google.com>
References: <20170628005651.8110-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 31cdec05ac..015c854530 100644
--- a/diff.c
+++ b/diff.c
@@ -276,7 +276,7 @@ static int parse_color_moved(const char *arg)
 	else if (!strcmp(arg, "dimmed_zebra"))
 		return COLOR_MOVED_ZEBRA_DIM;
 	else
-		return -1;
+		return error(_("color moved setting must be one of 'default', 'plain', 'zebra', 'dimmed_zebra'"));
 }
 
 int git_diff_ui_config(const char *var, const char *value, void *cb)
-- 
2.13.0.31.g9b732c453e

