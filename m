Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4F020133
	for <e@80x24.org>; Sat,  4 Mar 2017 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdCDC00 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 21:26:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47554 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbdCDC00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 21:26:26 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9E6AD20133;
        Sat,  4 Mar 2017 01:50:16 +0000 (UTC)
Date:   Sat, 4 Mar 2017 01:50:16 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: [PATCH] http: release strbuf on disabled alternates
Message-ID: <20170304015016.GA25408@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This likely has no real-world impact on memory usage,
but it is cleaner for future readers.

Fixes: abcbdc03895f ("http: respect protocol.*.allow=user for http-alternates")
Signed-off-by: Eric Wong <e@80x24.org>
---
 http-walker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http-walker.c b/http-walker.c
index b34b6ace7c..2c85316112 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -314,6 +314,8 @@ static void process_alternates_response(void *callback_data)
 					while (tail->next != NULL)
 						tail = tail->next;
 					tail->next = newalt;
+				} else {
+					strbuf_release(&target);
 				}
 			}
 		}
-- 
EW
