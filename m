Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF391F406
	for <e@80x24.org>; Sun, 31 Dec 2017 19:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdLaTTt (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 14:19:49 -0500
Received: from shout02.mail.de ([213.128.151.217]:39710 "EHLO shout02.mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdLaTTs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 14:19:48 -0500
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout02.mail.de (Postfix) with ESMTP id D38175FDE1;
        Sun, 31 Dec 2017 20:13:20 +0100 (CET)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix02.mail.de (Postfix) with ESMTP id BBA6FC0182;
        Sun, 31 Dec 2017 20:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1514747600;
        bh=edMe3qblbqjJvFt2jJN90YhoPHJt5zRGjtJDAj7Z97I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0F61YjW0zo32CACP9yp4F3xtQY3OicVeMTS0Jihm/4eAQg/0WWLu8GYFrx8mVIxQ
         3bK/yPAyamOU0nuuP8V6fYAH0P+xb9+AUwpYOQI0mBWij4g1D71U9WugLNEbcbCflV
         +8+rg7sr1QShdw+t5DkKMJU1id3+4D5j0Da2SZzI=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id 5AD8B80449;
        Sun, 31 Dec 2017 20:13:20 +0100 (CET)
From:   Stefan Moch <stefanmoch@mail.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Simon Doodkin <helpmepro1@gmail.com>, git@vger.kernel.org,
        Stefan Moch <stefanmoch@mail.de>
Subject: [PATCH 2/2] mv: remove unneeded 'if (!show_only)'
Date:   Sun, 31 Dec 2017 20:11:56 +0100
Message-Id: <20171231191156.28359-3-stefanmoch@mail.de>
In-Reply-To: <20171231191156.28359-1-stefanmoch@mail.de>
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
 <20171231191156.28359-1-stefanmoch@mail.de>
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 763
X-purgate-ID: 154282::1514747600-00006A20-81866805/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit a127331cd (mv: allow moving nested submodules,
2016-04-19), introduced

    if (show_only) continue;

in this for-loop before

    if (!show_only)

which became redundant, because it is now always true.

Signed-off-by: Stefan Moch <stefanmoch@mail.de>
---
 builtin/mv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index cf3684d90..8ce6a2ddd 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -286,8 +286,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		pos = cache_name_pos(src, strlen(src));
 		assert(pos >= 0);
-		if (!show_only)
-			rename_cache_entry_at(pos, dst);
+		rename_cache_entry_at(pos, dst);
 	}
 
 	if (gitmodules_modified)
-- 
2.14.3

