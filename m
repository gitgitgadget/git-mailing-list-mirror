Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C4E42081E
	for <e@80x24.org>; Thu,  4 May 2017 13:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbdEDN4p (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:57372 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbdEDNzm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:42 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWC9x-1dYcv82Xvt-00XLzj; Thu, 04
 May 2017 15:55:35 +0200
Date:   Thu, 4 May 2017 15:55:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 03/25] winansi: avoid buffer overrun
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <06f1457a87c9b6b5b4619682c8601bda18e3ff2a.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mUCzAxYIYGjIoJc/BtA4Jjs13AwY9o244A0MrmKOx54T1UTXIPf
 vFMCUXgd1sHJy4ow9PTBPc9cFgGUys8mI99c7YExTIA3sm0iDosYtAP5oEqGOl+yqSbWCMp
 xhW9ePQen+mb7+WJjhNHOj1G2J4OWeKKtKZop+TJBCPyswoIxuqi+Tl+O90MkjEHOXhkdUR
 ytNWKc20PUrHCIwk89uQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vJs/QE7OcRY=:oKplMY/DGGABXojduvEO1T
 Kn1F+R//v3c9CMVT0aKhJ4QhWGsKPoFFfqXXPLduc4eKHXFwPpdYg073i+u7/AhFdWqZv1rnz
 rF++aM8uxdhmmc+ePVK9WmfhDw7B1sD1lcPUByU0+a0yrwG4jHsr920theUcvyFBjr4XaxRmG
 0GdMicGXZvZGUNXi121WH6kwhgY0pH8U9Fa3OSyLfUJjcKq/fDQpkTFNX7OTWLBnLjFMBXEC1
 d5NJlCDdjTc1VkibeX/CEyvytHndFVddI5mcalOS5E9veAr/SQuczTPLAbCbrA9/hzxpwRzGy
 DfnODpA8zvhhgX75HAadJR7g2oHI/6EgfD8iH8vZUhW3cBGncGPIIyyYO5mUrutj0pGCBMl47
 m0vALPH12f5PiMSH/aP4eaIElrLtEzhf4NAoMuIxZzXxgpGbIQmsQrfwuZ4rs9WL1geDp1mnP
 euhqbaazC+GVaIJ66QNCpAlFa32kyzkq7QQIk/xgIaYVG4ys+AZu4dfmupdZwvv65oRBm0HI+
 B/3oUdrSSDSe/RHlRz6aetfGmi90tnU5z2Y3IYLK4oeRlUkMI5bt8GHN9cKYrpn1mLWauOPt2
 ZG9wsYvhOY5oeLWaqTunM5861MrsK18aVqWWemRb2QZtD1JzCh0O9o8tqhW/qYmyRuvNkY9KP
 LF9dVF2bX3EQbQj6VYaF06UgiXN+t6vgGuLDfL4bPfBz170tvcL4gfjg3swhri26gJUarZ2M5
 o8fxbe0OfJyg8w2YAwE9F9ASUPz9KS+L/6aMEJsMITrNnNa6/+tgev3fjnpIagONmUTVc4Uqv
 ucGRlJ+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we could not convert the UTF-8 sequence into Unicode for writing to
the Console, we should not try to write an insanely-long sequence of
invalid wide characters (mistaking the negative return value for an
unsigned length).

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index a551de90eb0..a11a0f16d27 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -140,6 +140,11 @@ static void write_console(unsigned char *str, size_t len)
 
 	/* convert utf-8 to utf-16 */
 	int wlen = xutftowcsn(wbuf, (char*) str, ARRAY_SIZE(wbuf), len);
+	if (wlen < 0) {
+		wchar_t *err = L"[invalid]";
+		WriteConsoleW(console, err, wcslen(err), &dummy, NULL);
+		return;
+	}
 
 	/* write directly to console */
 	WriteConsoleW(console, wbuf, wlen, &dummy, NULL);
-- 
2.12.2.windows.2.800.gede8f145e06


