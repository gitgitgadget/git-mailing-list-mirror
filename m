Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36345207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967190AbdDZUT1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:62068 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967179AbdDZUTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:25 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVOE-1djzAK35J4-00gWzP; Wed, 26
 Apr 2017 22:19:18 +0200
Date:   Wed, 26 Apr 2017 22:19:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/26] mingw: avoid memory leak when splitting PATH
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <da7b1af7d820c3f573d449e46407e2774ebc04db.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FkH2XoTvJKgaB+YefwkDsGtnYuRQsz+d8EXfOvJX2PSaXu4DENK
 51J33VxNd+6MtoKRMVR4dRTumCH6EsNXv3Q7Sf+/NYTsE+/CjS+zPIERPNcg/8KlOEzeF2L
 z9VwA20o6irdaz8ZzJwaRCFiD3RFiDQoFWz9gO6WViZn4Z7FIUD39vD/3Y7k0bhYv3VvHAf
 vYNStgh3E3Ik9C2SefEVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dzg2PaIKgKQ=:YTMVeWMRWJehcna8J2bPdc
 N3W5Nx6wfKrsqv0EM7dxsOVEPxskH6ZHWrvcd/7kj6otNxKE8n7FMtMUqzGbqPWi4SJWxgVF1
 ml+tqVLYDNAfASLduPgzli6mMQkrLQXqCmgDCDuEtbjmgws1Fqmtfsv3L+QYCqZU6IJgwW4Tx
 VyJ+J4lrHOAhIF7w21NUAs75drokEF4g7nId4lWKKiyFSrSWgWanbN4mEPRuZkSxdO2ns4Lms
 SY57S80QxBHwRpfojXC3/ihHrW48JHciWgsnRuXFdrTY3P0F7HZydOQ75FhbbVzZLVMfYp9Iw
 eEXjx4WEgZiAVm4DlmiSsC3YtwgWUhAgqpIMPQcdwjSRNSR3KmoGrXDLZ8GpTbHpsXZa4gh1c
 FLaMWqKQ2NGJ3BA0xuX5Z2bI19imjo3rU4hmS/zbfV+4Wg5KKeXWcvWR4tzh2Ki2qjSpPK0gP
 0V6lug7kHyZaDdzfbtZj9E92cjJz6fQ/2YodFnz1dRWWj/FtCWaqmY6ROAv5myf2g3Czl8UO6
 AKapBgI8+ogFsWnK9+Ja75X9ABSmRDdsHkvM9IN5a6+RGab1JPkUvGrEPVqcdx2YJCO+Sxvw0
 KJUMk7a8P11t9y2J7ThiELqNKP7JOQalrY8ENtVvDPG1NIqqivKfEEu56vQHUuTcMtlPgTyos
 MzjxqAyQdE16GYiX+3gQ4v5HYqzsNcCG4MgkUHBnG8/3pzjCQ8krDJd4Neyku0tPqrtRXy8IL
 Qht4Lw/+W2hGofaCepVYiDWafgkeywchOx0Hlpw8kZw+Odd9WRfYdpD7J0wtuiMTuy3MtYgi3
 F0H0n8W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the (admittedly, concocted) case that PATH consists only of colons, we
would leak the duplicated string.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3fbfda5978b..fe0e3ccd248 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -961,8 +961,10 @@ static char **get_path_split(void)
 			++n;
 		}
 	}
-	if (!n)
+	if (!n) {
+		free(envpath);
 		return NULL;
+	}
 
 	ALLOC_ARRAY(path, n + 1);
 	p = envpath;
-- 
2.12.2.windows.2.800.gede8f145e06


