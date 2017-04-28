Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D625E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998073AbdD1NuS (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:50:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:49424 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755605AbdD1NuR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:50:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MN604-1dAhzZ1QVs-006d3l; Fri, 28
 Apr 2017 15:50:05 +0200
Date:   Fri, 28 Apr 2017 15:49:49 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 03/25] winansi: avoid buffer overrun
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <56849b5d1edefb55d5c648d2930d07fe73244bfa.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tl7yZtlNPqXz1OdxGY9sGhB6gh3cACE+fry00UFlfRHnhOobJT5
 V8ebxgkbKob6BU94Lrn1MK/Y0cOAK758xUbCUEWzlOvidI90XHNkZfyhDxk94r8ptMZKAxD
 5+IOIRivpuWF5OHJVIAmMvobac6L0qHZRyqsXFLqqzmoHwgfF7bLP748GqOkyDNbAmaoBfB
 oRq5gPeLkIZb4lFUFqdAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BrLKuLKik7M=:6S3v4PhPbqHZVzJVRLKr5P
 pTuu6ElOdZBG9B9H++3myqq3KNsJJK5gy3On/P8yxeNBcyOQRFDAf2zoc4Ld80NMrHdqswRMW
 Klk7MLq9qv1v9Fu6AhICCfNlg54LoJTnhGqa0oPU/nTcghm5wpIIY8+Us7Syz7ba3Xw6UkxkU
 r9Fk1RW42SUe0kxqP5/WKkFT0Z0JDYRZPRIEzyUa7J8qXhcxgTH1PfV2wG7BF0d8Q0JZykdr3
 /7PEGrByQcB23VQHAp7N4VTo7BRXXtStL53k8F+7SyRHP+mAaPByqa9wORdmwE+vzsKV6/z9F
 udlFQUcP+qufWIrY8+rY5SmH1DlEQhdwn5xgtpcuQhGXTIohNR682FXfvNaYkqYFx9VAgAQ26
 cZmYa0r14rJtqX7LA7L4yPk7biYlzHmUiu2T1CHxrqZGXJHDvyUr3Q4/SopAICrcsKkatVe3h
 LheaqxVJIer0vTeGU4IIrXbWRhdRxcu/qUfc4ad/GMrfN5hAUVOeAh4Xl4ydLPkrPYsJjJMGw
 2A1np9AuxQsdJXCC96WSUOOjlBqAAgvEdrwiB6XT/GAV73ktY1kFOcleRsvHFDpLhOKe0bGUb
 ouP+qz2bxoIZDtVVtz+PuyDqETCFOfxpJ5EoUgnThhoTEd1mTSeO1C075hwr29EjJwHOFlTOH
 3Gkf6E5UzcgqKAfokJzJA+hZnazgX2CFvC2HV7OWcPEZG9THnCsSlJQsZBP9FVi1iorYfLz7R
 u9LHskdzBVOpTtqL6CfhttKi5AdzgwCE68T0JX1NXqgG72ue0xcUPJz7h1llhVxSTYru/BNtB
 K7duiHi
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
index fd6910746c8..861b79d8c31 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -135,6 +135,11 @@ static void write_console(unsigned char *str, size_t len)
 
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


