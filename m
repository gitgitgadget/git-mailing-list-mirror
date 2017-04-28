Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E82207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032534AbdD1OD1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:53301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031528AbdD1ODW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:22 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVrQS-1db4m21iJs-00X8FF; Fri, 28
 Apr 2017 16:03:14 +0200
Date:   Fri, 28 Apr 2017 16:03:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 12/25] split_commit_in_progress(): fix memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <da7222c92aed4dc470965df7319411f1098e04e6.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rMey8003yDhJ61yyKARjUEL32XyfKjGnQ6jFHAjb5Sl8KlbS3jT
 BTL1OIPpdhm2YJ3Oqg6i/0htaolZxve/wTQSqKBNB+WJa1kgvWOew/aC5lBVoFp16P3uMk8
 gatcQqNUROLZbS73VLKRWkbk+a2HKsyHjwi0QHV4yhsAx+KltVMijoETz7aTI5OLvK/EnE/
 swLrYnEG6tFQEJu5R9m7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:60iNslOIk2E=:gwYAzYdw37XNg/rPInWBbA
 oBZSfAuVTw3xMgg6EjYjImAAqHGpZlhmI2sSDFZBpnLqG4umyt+Df7ToV79U6FgGphLl379K2
 OgWIi+SFX0BFdqJ8wuxZiq9g/+5ltm7YLpy5p/v+BKBCyUzcgpzF95pLaUW1qD3KbPezYqqCz
 xrHcwso1DSMPjxhlJ2ey2kgohizQXJi773p78zkXuvdEvb8N2jdUSZr58IzJ7Z5GYuvL54B4j
 qnSuYe7lXyCRoXjtjhoxFyYgJV+q0S+1bF6SApeFFc2LfdY/ENTwtLZPyqMIoCXzlRiddN0IX
 HWkwfvyBIn8LGn+fANioC26TtHAa1q7DrJPGYF5U2PdFAQC09mOLx13PvHvoXRZlTB5xMh2oa
 hFIbI/oynFFoHdwqoDJl/Ic/ElMMrqiiymJp5FKNmxctMaEXKMmhReaW4Z7dSNS6XJ2TejkiJ
 NnOk2JByLgwwAYTV/WNgbWuYei3xckhB2u+nGAP3gHBj4rSPWncCRHYSDTL6shWCDNw4tC39m
 qEOwCnMZEttRM1khzrRACdohVWkjGgYR8Y2tSjHa6Gg3U8gRI3gXtaN6pY1I0XJggitsYvJRj
 NYABnuuv6R+azU8RsEgo3QJ43M5BezE/ODd2ZIbKpQULoHXnl8I3ivmv/PdWYuDadLE7KlN31
 2Lickk7frNFXP3Z2m+OYTheypLD7NGBh1q6zGJiSaH/dhl8CEeBoH2UEroqIiYLQbyjkC65qU
 tXDysAhIRGkGkIjGY1+Ug6CCKUYTTqSH6sTdHOh1eK63TD/KN/yUt8nWC0seZt+Hv0DdVUwmk
 l/jNTp5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 0a6e16dbe0f..1f3f6bcb980 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1088,8 +1088,13 @@ static int split_commit_in_progress(struct wt_status *s)
 	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
 
 	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
-	    !s->branch || strcmp(s->branch, "HEAD"))
+	    !s->branch || strcmp(s->branch, "HEAD")) {
+		free(head);
+		free(orig_head);
+		free(rebase_amend);
+		free(rebase_orig_head);
 		return split_in_progress;
+	}
 
 	if (!strcmp(rebase_amend, rebase_orig_head)) {
 		if (strcmp(head, rebase_amend))
-- 
2.12.2.windows.2.800.gede8f145e06


