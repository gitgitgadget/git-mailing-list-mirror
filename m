Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBC820285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbdH3SUU (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:20 -0400
Received: from mout.web.de ([212.227.15.14]:55082 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752679AbdH3SUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:18 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu1Be-1dLJrz1hLi-011RHq for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:17 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 32/34] vcs-svn: release strbuf after use in end_revision()
Date:   Wed, 30 Aug 2017 20:20:17 +0200
Message-Id: <20170830182017.21309-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:plhR5ma2B9NQgKMxmlI5f7FXkWRqcpvtniVMwK95Ut6dTEVubbc
 oSScggaLLfUcrvWs99pyuM4nUYik6bd7dameKT3BVv8Bh99vSPGUXyoDv5VKhSTScMdIbkk
 r3/c8PGM7Js8zTT8AD0PijWR861BdYXGTu7GMIiJYqbEX4B0d/rptFJ5dL2eMe+0BkUguzD
 OtSQdZWUEvpZDKvtA/13g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f8rgqI0S4Qk=:6crV7Ty9JiGHtr1J2joje2
 1jJHw0r9X9uFdiPyZytIPXLonITJ7urTfr1e4ZKedtFz5VK4UGUmV8rLaO9jqu64oQrP6Y9XZ
 EJysSMv2ABUhUssHSSoY0vVzYhXPwPWUhJfwXL5tusfuJcUdIgeNOiPaMoFUPWqLowVd1Gen0
 sPpS8pRi5/Z0fKCdpWZCbqklvO6kcq8iPhFbXQW6YIXwvQ1gKjNb6pDL28IKHtJyLQSXaiwCK
 rVN/XOrbMYanWtQFya788TTUUpMh59/vX2ah3XT8ehulu0l+Zz3shFRoYWv5hWRogArFqCsAZ
 RVJ60IanwPyGHhjTGlsU7bQtgf12vckoaVnAp3oHcfswAG4httntPd0SQVfh96skp0BP46nNn
 omfowqK5cpDyhsLcvRFKsD3uWdeKm40fvLYzp+dfazg1+jqjyIma863bfn0kFuOjRkN8fGbsX
 jrD1KwnmnMngDHMh5IytnTcALDjVn101nhHLztdWKQNRwL+RL1pZIPhIYBR8/V9HsGphUhFrl
 +g0D704fZotaB+r6VBxG42VF1P+330DCGNUaDb6G76F6FS0LkQ/EfGd2HzAhMzCXZbdL19us8
 wxY9I+UTbAovePkw8ZFZPrTc/MUp2jAEDO87x75j2PTCmpLqagiTTSiQu4+BDoCxtYakuO45V
 NHmyVlAyhUfC5QS2Jld6VqWH19nJy30mL0uYmZA225+zB5tWmECe5GEvAFp2/eYx1/n259B1J
 FMI7dNVsyy0C1KewhLK7Yq+bBoyDOAa0/7MExSGAmnuIBycGdocCd9Lh1W3xP6zYlPFCn1Qn8
 V+hsvcJnv6Hz3yWXEw8hKIsoZzPrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 vcs-svn/svndump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ec6b350611..08d136b8cc 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -311,13 +311,14 @@ static void begin_revision(const char *remote_ref)
 static void end_revision(const char *note_ref)
 {
 	struct strbuf mark = STRBUF_INIT;
 	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
 		fast_export_begin_note(rev_ctx.revision, "remote-svn",
 				"Note created by remote-svn.", rev_ctx.timestamp, note_ref);
 		strbuf_addf(&mark, ":%"PRIu32, rev_ctx.revision);
 		fast_export_note(mark.buf, "inline");
 		fast_export_buf_to_data(&rev_ctx.note);
+		strbuf_release(&mark);
 	}
 }
 
-- 
2.14.1

