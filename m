Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6371F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeGVKyM (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41873 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:11 -0400
Received: by mail-io0-f195.google.com with SMTP id q9-v6so13247248ioj.8
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zwzs+D4zMEwEd1XcIHEEAIR4LP4LaUtQkex94MjlZvA=;
        b=MyuMzrvxeX9Gh6wPvpfkmhVAjdDs+ZKM2bjscCt/8R0cb4tRG7jqY2r0AXGS12tilr
         1r1mjsRVVqSL7faA5antD61aCXNSPDB1tcd5uGLX1USI/B+aPABg15Oijv5nl146WNLB
         G5wRd5M3LSYV5bfvyltXVaUP55ycBMSaeHWwRrd3e4GDT84p0CF1JCgWAACwJppEvJl8
         7wch8J1HJwUTctKkMVvbM099hRMUoiwnMw61aAJMX6tmN4NRsgg1qbvKhpM4Ti1I6STf
         hpM+NrLyb3pxcUaNVSjE1YSb8TLfA6tO5bxJQIyoJK+gmsrzQC0+QRd6GSNdS4BeO/gu
         6pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Zwzs+D4zMEwEd1XcIHEEAIR4LP4LaUtQkex94MjlZvA=;
        b=cMHS2roRQPc84bQUZrGx4KLVJGEoY+2CJu5Bp+X8F8MywU7gSG09VVa0NCYcNh8zk0
         XODpEYCsd6YfbI/T1GkszS6fBOJeHL+mx54/TA119zFUdFkVDDCroKsKcExU0L/6vutB
         42T5etNgWqm6I2qLZoPwab7rgjGisKnAquHPNA8UNR3LPGdoeSInX+529YStOEbRaOQn
         tXSP8PkeDfgessVfBmL3nXUJ6gZSD7fH4+EGuxDTG2yJWyj8A9++UER1cuvK9VqmFJD5
         mFyt8dNbptw5+WWnHXZNj07HbSdI6O3r5o2y9LwD0SRLIqHA+1qXvIv4Vp4UR2rThL5b
         qddA==
X-Gm-Message-State: AOUpUlFUS1OjSD+qQbqJpyXBWLcYWej4CA57+2VtDP45eD/xxck82cyT
        OCBQl+rQqFLYYcfklOYlTrEn4q4i
X-Google-Smtp-Source: AAOMgpd1VGRGDcIlCHZqdebrZfxMCf3qY4IGM1WYC/Z58nnJlTi3SZMp2bKY6nQhnofcvbDwCRCohA==
X-Received: by 2002:a6b:7b03:: with SMTP id l3-v6mr7085463iop.36.1532253482346;
        Sun, 22 Jul 2018 02:58:02 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/14] range-diff: respect diff_option.file rather than assuming 'stdout'
Date:   Sun, 22 Jul 2018 05:57:10 -0400
Message-Id: <20180722095717.17912-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The actual diffs output by range-diff respect diff_option.file, which
range-diff passes down the call-chain, thus are destination-agnostic.
However, output_pair_header() is hard-coded to emit to 'stdout'. Fix
this by making output_pair_header() respect diff_option.file, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 347b4a79f2..76e053c2b2 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -328,7 +328,7 @@ static void output_pair_header(struct diff_options *diffopt,
 	}
 	strbuf_addf(buf, "%s\n", color_reset);
 
-	fwrite(buf->buf, buf->len, 1, stdout);
+	fwrite(buf->buf, buf->len, 1, diffopt->file);
 }
 
 static struct userdiff_driver no_func_name = {
-- 
2.18.0.345.g5c9ce644c3

