Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A762D1F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbcG2XiX (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:38:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34484 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbcG2XiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 19:38:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so17717552wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:38:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8Hbn5TTNpZ4dY5DoNYEE7SGDEcvbJfzCTSFu3ri+uQ=;
        b=095jE/ksx3Ql1wl6Gpm2362RJl7QDowR23Jdp690/81Je2chBxpW4WK8u2i9UEHVho
         oBDuVsgFfv49/8QA8LFhz/DsXbai0heHaKj4BrNFwV8v+ty1xtbmkd2lTZRmHbgiIk2E
         5PIqjQWSdFZ3Vp/mm/dQsXwviH/2hgC5Qfv6rDybnhA/rrbMZezTFRc2w0NVCGI+zTWq
         4oYhWfoWnFF+84ZmTwouJjQ53l0vNXSiPNObe95wHTGZhcET2Ic77ZR9nVB5iXgh/oBo
         paAxF8RVX8DTQ07XHq2oRfLBfi7cEN3w3i2/oOK+Y0oL0W2lweSRy+6d3RBNc4VT5Ick
         Dd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8Hbn5TTNpZ4dY5DoNYEE7SGDEcvbJfzCTSFu3ri+uQ=;
        b=c+GKn++6zOkj5qaU9H+xofICGvwl6tuc7yxQum62hN2AI6w2WXfCD/OZlgxKi54MDB
         qcw3MXfzfoy8VhDgJ0GkZ6baQgwaPcwVnImP82xCcubTx1CS4WFIVAvrM0I5VqEIDR8P
         Mp/GNaxw57BW30UoMDVmzc32d576J8C4Lz+Ihi4y4FKCriw680H1ZO+YRKtV3i04Gc1g
         7QIVroGyJfc90vRoora02FYxEHTF/oB62aP7KHKO0jEj6vTFQvOWvxBagNGiOiDyTc0W
         y80NSBXqYJJho8k608atrCwFNekaNPyBYW5UJH85YgnOSD5kkD1A/fpQDHBejCk1DeVj
         2aUw==
X-Gm-Message-State: AEkoouuPwKBq1RO4SXg/O9PMboFqnTgngOxNZLFvZWLlGR5kZRojt594IKRCY4uOAnUJPQ==
X-Received: by 10.28.17.9 with SMTP id 9mr3392501wmr.73.1469835491518;
        Fri, 29 Jul 2016 16:38:11 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id i1sm18663212wjl.9.2016.07.29.16.38.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:38:10 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 05/10] pack-protocol: fix maximum pkt-line size
Date:	Sat, 30 Jul 2016 01:37:56 +0200
Message-Id: <20160729233801.82844-6-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160729233801.82844-1-larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

According to LARGE_PACKET_MAX in pkt-line.h the maximal lenght of a
pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
therefore the pkt-line data component must not exceed 65516 bytes.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/technical/protocol-common.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
index bf30167..ecedb34 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -67,9 +67,9 @@ with non-binary data the same whether or not they contain the trailing
 LF (stripping the LF if present, and not complaining when it is
 missing).
 
-The maximum length of a pkt-line's data component is 65520 bytes.
-Implementations MUST NOT send pkt-line whose length exceeds 65524
-(65520 bytes of payload + 4 bytes of length data).
+The maximum length of a pkt-line's data component is 65516 bytes.
+Implementations MUST NOT send pkt-line whose length exceeds 65520
+(65516 bytes of payload + 4 bytes of length data).
 
 Implementations SHOULD NOT send an empty pkt-line ("0004").
 
-- 
2.9.0

