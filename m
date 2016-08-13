Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF57020193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcHMJFu (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:05:50 -0400
Received: from mout.web.de ([212.227.15.14]:57163 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbcHMJFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:05:49 -0400
Received: from [192.168.178.36] ([79.213.114.86]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0Mhljf-1buATM2jB5-00Mx0R; Sat, 13 Aug 2016 11:05:43
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mailinfo: recycle strbuf in check_header()
Message-ID: <57AEE2E6.2090508@web.de>
Date:	Sat, 13 Aug 2016 11:05:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gqLuCOKSWpXYz8dAT51rHPrgQR59n4VYvh4JBiNR4fmmZ95Hs+h
 l+N9iw+C3BRaHpZKMbQCRYT8yvW0ZiqsjcDBZvFnTw2mkvFPJynHqDvcH/c4tH8fFSnCx3I
 eUGCRqSXCBo08y9xEkSzg2wzaGCDk5Mus4N3tn+/G7ts/STHcGpAYgDB/yuaAsZZdx2jmZl
 nRnKZA9S/RywRR0SivnwQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2UbJIwk1/J8=:n+yi3qUdR9x8fJt1smbPyL
 bpUKVbgbGMJRgBdsMyUgSP3jdFwvfxh1Pfb9NTqi0HYQ6NrlA/kpf+Hgpni3AcdwXubg5YmwL
 6PydPL5Uf/533ik5YCtGKtGDpmyUz5/PoA1XyJezU2ga4GdY5GwcxM6O6PvhuWTea038Ci6OT
 BjIjzF2035HP7eWfBeaJ4WUXYS9GV1+yU7nU6E+5gB5L+RVdS6Hf/NA2qN3zYxPEOmpGYsq/h
 BI4pqPrD4DMZuaaV+RuIatQV/FUO9wv5RfUM/Pe8NoOR4/PSRtnMCQnlT/OxMNU+LAzTEqkeg
 ZqgN6WTkVmIwxSK05Aien9Jgsa8KwkIKeordpNVOhwtOTPxtUDLGJcX15kf60rRie1eOqt6s8
 xUdegrZX5Sya8EIMRtSsX0Tw2ptM+ZpCoUW08GGeyPaQoxZ8mrVUuuRlkXDonFl9VwqttdTco
 6pIghHTtQVCaSwhp00whT0uYNw2VHTTpGOHvXvncA9Yn2Cb/h9o0W2qUD2QZTdC2HoZvNyhY8
 77omrMUBnBUmwAMrckb+85jJ6tIngyFNv+XPuWuQbVKaS6VmRhtT3+/l3RPZVPUCrYWoAdM4m
 THuH9ku5yej6hEq7rnMJTzKQB+jfDPBS6EB5bfJMJOuhtWB0ejZHwuHplDFNeTRJCscdZtbe2
 5+EAiXFCihY7cks/MlPZYMtqW6G0RM+PvWaE3tAk+/qPpOhfwoKk502fN/ZESg29GLDV92Zw1
 9Fl2rDLxA1MYNOS+k+yV/UeJEvT2AXTN/XlTrPuxqaWGegN1ABtJSeJqqeqXOcc2xbh7C+KCj
 vnB/kVX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

handle_message_id() duplicates the contents of the strbuf that is passed
to it.  Its only caller proceeds to release the strbuf immediately after
that.  Reuse it instead and make that change of object ownership more
obvious by inlining this short function.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 mailinfo.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 9f19ca1..e19abe3 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -179,12 +179,6 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 	}
 }
 
-static void handle_message_id(struct mailinfo *mi, const struct strbuf *line)
-{
-	if (mi->add_message_id)
-		mi->message_id = strdup(line->buf);
-}
-
 static void handle_content_transfer_encoding(struct mailinfo *mi,
 					     const struct strbuf *line)
 {
@@ -495,7 +489,8 @@ static int check_header(struct mailinfo *mi,
 		len = strlen("Message-Id: ");
 		strbuf_add(&sb, line->buf + len, line->len - len);
 		decode_header(mi, &sb);
-		handle_message_id(mi, &sb);
+		if (mi->add_message_id)
+			mi->message_id = strbuf_detach(&sb, NULL);
 		ret = 1;
 		goto check_header_out;
 	}
-- 
2.9.3

