Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8501D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbdEBQBK (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:01:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:56081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdEBQBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:01:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1diV4z37Ak-00hgnk; Tue, 02
 May 2017 18:01:03 +0200
Date:   Tue, 2 May 2017 18:01:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 02/25] winansi: avoid use of uninitialized value
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <758b5a5dbe83832db7362246127b8bd1ca7beb9f.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3jBwLc3Bnn+uoMkgDzsYptWKfrCCcgyNveoMaBaWfU1EM6LWMz6
 wHVljj+gmOp/fcUWk4Z5iOjGyKCI0XOKzGQRl0nVd1M1+YiFjVJSiNX7tY/od8m7PJslAL6
 ZZ+jfKzE1YwzwwIU+/TOjGTwyL0iE/+10b+3JptMHtlRHuv7C5Tgbo2nniRuzXTzundXYf9
 KsjiPa1Ly6UPa6oU+olBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7x2cwBOUUj8=:bY2TWQpwjt+gx1mqckTQqy
 v08mOsakNr/GviyCbrrI3awslui7rf1Y4+w14R36TLzwAhXnCBxjYvRQsKilyCoVRmVFCp6tr
 JfCd5g+PoPH+1cGwfhaxsT9TndA4mPKhWFZ4geJr4kjOH4Ls6ebeRh1HTg8EzU7t3ZpkGbmbr
 6jX/qHRcNAJqrxM42rw18RFa5zgrkw5ChmGsNuP8BRPJ9heDdIeKtVP/bDyv1v5LT0SUUcZdB
 1vwFRPCJ2cX2SqJue9WX5MkkMKXlbr7Fxp/sJ4NFdQjj0a4GxMC7mHKEQxQ0ptDL+/jjyvLru
 LywM0kr3umxTFFU783Ege+Yxls82uA/+7RiUMI/0qDg1zSkp34PhSwobdG0oKRhvVqkZqhoEC
 BpVOCee7JiPHLnj4q2UfQ8gqIPysRZsXGCbx+6ZPAd6/Fk8geIGo5PW3eckooHYQ9ZDkAC+ky
 PuEa4fqiURbX9xcilpP3aZak8cBqsMmzvIJQBnKvn3iJoaqhIHNpph+AwopF+JBLMIiAysNws
 84xuKFobxkv1kUNp74WQWPHipXASqAT5JhfYcd90ru7hIaOdkf/J2brd6hLaPABQO0TePUiq5
 H9/y+lck3lyC6iA//9Dqd3tR64L/Wxeq2/OHw3f2PXHQ0P5y+TySeSQMAFGpgDvg0V8cFTb0L
 BACyw/aGnGO9gYDHOlXUi7mnNq4A/E36R93LnXr0aJ2nnxwvFvcuy3Qk5yZAYaOQJNPC8wkmM
 XwNbDnQiFnFMkoCc384aL614U7do9ChS1uBEI9bWMguetzw8mc/dU6G/4jTDhk5VUvMyHWDcX
 jB2h7zV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When stdout is not connected to a Win32 console, we incorrectly used an
uninitialized value for the "plain" character attributes.

Detected by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index 793420f9d0d..fd6910746c8 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -105,6 +105,8 @@ static int is_console(int fd)
 	if (!fd) {
 		if (!GetConsoleMode(hcon, &mode))
 			return 0;
+		sbi.wAttributes = FOREGROUND_BLUE | FOREGROUND_GREEN |
+			FOREGROUND_RED;
 	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
-- 
2.12.2.windows.2.800.gede8f145e06


