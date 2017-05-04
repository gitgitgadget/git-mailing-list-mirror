Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627CA207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbdEDN4t (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:65305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755377AbdEDN4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:46 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxPgU-1e7gXS27GE-016t5b; Thu, 04
 May 2017 15:56:32 +0200
Date:   Thu, 4 May 2017 15:56:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 10/25] cat-file: fix memory leak
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <4a707986baa04875ef59f7c17886df8fe52e704c.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:F4mj11PvZSlTXC9l/gYiZfIcrCUKfhQjlMmdeoTchXcz5UfdJPh
 6VLq1czF9WYYPpNHR0UeBzajuh/iwj3T2EPc6f8eERVxUt57/aNdZJiK5pSfIRuitb53kR/
 baVQ/Ji8Q/M1n+5LUMkzYP8YwffTCmk9ZU4rUe45S1FB9799kJafZB2gZfyeievBx9TJEvZ
 YYej58ubtKvt3LI8q7Yag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hDVW6yBY9Io=:EPEXWamnmavCbYQ8Ib57jy
 LHPncPjyLCBx7bSd70MEvjPGB6WiPiZt5YSvnnDqAuG4c7BXUZt3kLrWxkG+N6UFbVvGnjOiP
 zRa2GLrcoZTMtpgb4c7dhJWsbacG/iO426I/l5Hg6dbg1e1splC+IE7n9lcatJu2yBupEbQ6n
 nI4bBD2n5/8uCJDS04yiHBjSkqmu88wdnsjjQ4GbfVR4fUFncG5LaPDoFlYoPXgmw1mSsQZAH
 jBYKkZjy2PzpaowY2DgSz3eW/Z6GaxDfEaIJ4Z7oqaYN1Ytg7n6CUX2KhasUAU3rsEWkETiz8
 VFzP5Vr56RYSInsPz8J63wEaeCy+p5rhpSlERcp9hv2Vcr7LZ2hztPq4kfgXxq8J/rV9I7XjJ
 u4lQmNtxNtQyfp2+7OrXPUVx38j8lW7oVJI+ZG6QIghEL4r+AlmZfRtPjfRyC4vg3Z50QTJ7p
 F8F+4vehprLpZ4UI7eXRS/plAu3axrSOZ9uh0kZbOlT9Yz1dFTtk+HnO4XieUTV1Hji5BXuwC
 vGeQaEnicFrOe+lS9WbeMFpqcdHu/zDgk0ahGh7mZeYiJOLhkbvcYWnY7Ej+H3uqhZnSX9wB4
 +x0cXdXEgOTcGYpcQBzSyJHI0vkz50iyJM4E3eFyvMoURlbZmZ9zLlycg3MVLG3ztHwHeVc99
 FT7REUZets5zJpAq/KsvvX6djvLNFk+85y7/QHe0JWTGcrPHr9J1EyoeBT/NWF9dIZkuGsxaQ
 B3yeDbHREJWc7tEQfWLIXY1E2y3ETKbwzCH6NsfZt4naDDIsrX6eWA5KtRDEZZO2j9o5tmqVK
 WrTXJ5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a6390..9af863e7915 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -165,6 +165,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
+	free(buf);
 	return 0;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


