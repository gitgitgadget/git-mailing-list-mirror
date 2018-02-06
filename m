Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6451F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBFAVv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:21:51 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38037 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFAVt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:21:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id l18so166354pgc.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xtEA6PseusrYN7Ud1Iuff+hbhEf2MhPy89U0z0TvgaM=;
        b=LuGKJy2Icp8ADVdHXJNB3yPbjxDQzTd9HXtGDLqRGnB5WquIfddCPyhdI+SAgx4Gk+
         sRzyWpQxzcM4FUVw+4z2smeM4WXwBsGbu4FJ1Hf9AuomaSHcRU817Oig09zuFl9F/DTu
         eyNCpBGwUt2N+3VBrg9rAmhm1JiEZwMCdB0DsRfdRNmo2YmHi3cDxKdF8sMbTzx09mWx
         6cfAOne2JcPuLQW/Gb4OYLqJDvnYY489lJV3M1p9kehpVXstuNKTUFTl/xrbRAOBIECR
         jvR1Dki7fPQU2RVGE45vv9u7t5LcIrIZgwpr0wY1FKtZNCI3dRSGNRSsS/cMkJqimPnG
         7E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xtEA6PseusrYN7Ud1Iuff+hbhEf2MhPy89U0z0TvgaM=;
        b=k0NMb5lUe/hssoK/ysjOpCpKJwlAExKsjtInbWp1ZJ97MNijFJNrsDJXACzZarRgDE
         uQzhGULwEIyZwmmH1gvSGa86hqcpIRcghXvFclG3Pcxh/p8/0QYTBJONYMkRgmUvJqfJ
         1eZEOudHe3T4GgSg0Un+Nv+SQ/gLrTJfchukXnWOfE1bsp0kbUMJwEhEEmpkxQBZMCme
         OJBE0TkQE+aAsnAc8Q88ziiPw5qZRP2qEvgTl4UlL132B9kDUBTlyHUukxIib4LGwKQ+
         dw3EPrt10zS1UkT8zZzRvvtlASRY5vCVJwqe5z1Q/tS4AvHUY/JGjihHPuTG3euknN0P
         3/ng==
X-Gm-Message-State: APf1xPCU4qUZgnPlFwrpQMk2YZNFKcphsbW07dMj8f4RjJz2LwoIPH5f
        2/oFV5GNZi3zMfOVJBKiWmWQTtkkTIk=
X-Google-Smtp-Source: AH8x2274iJ/Dncqop3X59TqKdplzU9lvvii6K6x+aSfmSV0Yz43bsYwBvhZhQaxflzMVDhd4nl5AtA==
X-Received: by 10.101.64.67 with SMTP id h3mr448581pgp.168.1517876508948;
        Mon, 05 Feb 2018 16:21:48 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q20sm5725333pfh.178.2018.02.05.16.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:21:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 123/194] streaming: allow open_istream_incore to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:38 -0800
Message-Id: <20180206001749.218943-25-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/streaming.c b/streaming.c
index cb7f8b2042..94651ffbf0 100644
--- a/streaming.c
+++ b/streaming.c
@@ -500,10 +500,7 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	if (r != the_repository)
-		BUG("r != the_repository");
-
-	st->u.incore.buf = read_sha1_file_extended(the_repository, sha1,
+	st->u.incore.buf = read_sha1_file_extended(r, sha1,
 						   type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
-- 
2.15.1.433.g936d1b9894.dirty

