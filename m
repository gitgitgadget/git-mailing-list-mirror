Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F372023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934688AbdEVOS1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:27 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42970 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbdEVOSX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:23 -0400
X-AuditID: 12074413-0c9ff70000001dc3-5c-5922f32d8281
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 40.20.07619.D23F2295; Mon, 22 May 2017 10:18:21 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24F023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:19 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/25] refs_ref_iterator_begin(): don't check prefixes redundantly
Date:   Mon, 22 May 2017 16:17:36 +0200
Message-Id: <c3840954c13e008ad4917a7ccf3faf5ae54b01cc.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqKv7WSnS4O41a4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxp0vK9gK5rBX
        TL/zgLmB8TVrFyMnh4SAicTBL/fYuxi5OIQEdjBJ9F14zQKSEBI4xSTxud0bxGYT0JVY1NPM
        BGKLCKhJTGw7xALSwCywgVnizfTVQAkODmGBUIlr0zJATBYBVYmuKVUg5bwCURKX2/pYIHbJ
        S+xquwi2l1PAQuL3rANMEKvMJXr/rWaZwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGu
        uV5uZoleakrpJkZIEArvYNx1Uu4QowAHoxIPr8ZjpUgh1sSy4srcQ4ySHExKorxH3wCF+JLy
        UyozEosz4otKc1KLDzFKcDArifBq3wXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YW
        pBbBZGU4OJQkeI9/BGoULEpNT61Iy8wpQUgzcXCCDOcBGr7mA8jw4oLE3OLMdIj8KUZdjjn3
        vr5nEmLJy89LlRLn3QFSJABSlFGaBzcHljxeMYoDvSXMa/IJqIoHmHjgJr0CWsIEtMT6mTzI
        kpJEhJRUA2PfhkYezjTnHtatRmYNfvM+On46fpLx6ocLy5Ri+a865/Ly+dw78ParkpH6vFcG
        wT+8GpUUD0Wu5b9wd+qBgC21TdIPdlr6XZoXvOj+3lS1+b/Knq6qdgr7eU0hs67a/1BDsa07
        255Z2ys/5HtwP2QWWfrGpWud94TZIoxvxEMNzv/krrs8N0OJpTgj0VCLuag4EQCljgDx+QIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The backend already correctly restricts its output to references whose
names start with the prefix. By passing the prefix again to
`prefix_ref_iterator`, we were forcing that iterator to do redundant
prefix comparisons. So set it to the empty string.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 8af9641aa1..8494b1f20d 100644
--- a/refs.c
+++ b/refs.c
@@ -1247,7 +1247,13 @@ struct ref_iterator *refs_ref_iterator_begin(
 	struct ref_iterator *iter;
 
 	iter = refs->be->iterator_begin(refs, prefix, flags);
-	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+
+	/*
+	 * `iterator_begin()` already takes care of prefix, but we
+	 * might need to do some trimming:
+	 */
+	if (trim)
+		iter = prefix_ref_iterator_begin(iter, "", trim);
 
 	return iter;
 }
-- 
2.11.0

