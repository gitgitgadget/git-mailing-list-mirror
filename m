Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0FC1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbcF2OO7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:14:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:63900 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbcF2OO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:14:58 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MgYGJ-1awRaK141H-00O0WQ; Wed, 29 Jun 2016 16:14:55
 +0200
Date:	Wed, 29 Jun 2016 16:14:54 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] commit -S: avoid invalid pointer with empty message
In-Reply-To: <cover.1467209576.git.johannes.schindelin@gmx.de>
Message-ID: <51b87a251ac80177ff7321ec0e182cbda6dd93a1.1467209576.git.johannes.schindelin@gmx.de>
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:suZwnh10Nx2rNtzqgZlelXkbvZxkcBfpM34OXQep6EFATnzussF
 +pNHaADolPSQdIsbVT7woIc6D+ogkKnl1kPw3Mt16gjwtZqjOkDeMqfy8ajpF2V1aBfyLnD
 Tx4O+JEFbFUVw2ZoFAIwjLVCX6qaIqQgmqGHYNllEt0QTXVq/b4QnLFv9YIRMTFYlOBvRw/
 rm3xx6x7kwVwxuvVtwbXg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HDr68FpkK48=:CqSvB0k0OnA693CX0NsDSn
 QLgqGMy7GJuX+x9mCS5VjujK2gW7BHi6a7FKlXJ4A+MEHiUAvD/CI35zOXWBBoYoAYwkq/Tm2
 8iBhANE7/V861a1v+fRp7lG2S4mOZrvMoMtYzcKldFgo1+r/P/yoqP2qIuZ1YUuZLmTL2QL94
 0gW9LSpFNoYPa5dFtsgvDfMn6TTIp9MclcZ22gSMZ5WQ8LdLkGzlSIgmhBtYsM9ROPrI2QUiD
 iwAfWTOxW5hwJg+BAxIEtfp8yx/uHQvyZvZ35YU6eROTPXz4FZaOVVnH+6vhbQZqoKkeYhWNE
 M8avFAlmOwyycIReRfLkoCRLbN4q+f/ppgR5xm+gRoWGZoFK2+ELdea4iRAYo0RACcfX2EjkT
 Ngd8U0rf1CPjIGNXlWDKXZC+Mt1aYZf3Ju3Zgrlgt9Fr+NY3g2aGlqer/jEhTspJaY1nwPaUx
 zNYLjl9oBTFjpSfNLkma1C8rssXzOwwq/Wkg0+m0xCQvEVr2tkahqUaKeEAmdMr+i7vZJfDAY
 VAKi/p/vroPlIDht0kJDyRHYYDNzstsjKEbx9UbQqPpCU4rUgtYR5/L2QZoo96ni/t5ShNEOF
 3tgQ1BjAtypvXox0iDS4VESE9RkSlnc1YJX7dcv+aPcyt+6j/FLPAfdePlD6jWVhkrWWLZcX8
 doC33naM7EQwZlPI+6kRKNvuQz4eaZ99dfMbGhdIXFfM6oPmS4pPE4qaLGD+oirZspbDOm1CU
 De72X415ERlIvIxC8rToIWV7ZtswFj/gifNhJjl3Vq7EaHHrd6gKgRkq3qtfU9zWUXB3njO96
 bmxnIAI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While it is not recommended, `git fsck` says that:

	Not having a body is not a crime [...]

... which means that we cannot assume that the commit buffer contains an
empty line to separate header from body (essentially saying that there
is only a header).

So let's tread carefully here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 24d4715..0bb51a2 100644
--- a/commit.c
+++ b/commit.c
@@ -1090,11 +1090,15 @@ static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
 
 static int do_sign_commit(struct strbuf *buf, const char *keyid)
 {
+	const char *eoh = strstr(buf->buf, "\n\n");
 	struct strbuf sig = STRBUF_INIT;
 	int inspos, copypos;
 
 	/* find the end of the header */
-	inspos = strstr(buf->buf, "\n\n") - buf->buf + 1;
+	if (!eoh)
+		inspos = buf->len;
+	else
+		inspos = eoh - buf->buf + 1;
 
 	if (!keyid || !*keyid)
 		keyid = get_signing_key();
-- 
2.9.0.270.g810e421


