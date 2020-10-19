Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B114C43457
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AB822314
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1o6Zfdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgJSTfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbgJSTfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:35:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC43C0613D0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x7so1047342wrl.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KQ/Om1iJNa++UOs6ipGuMhVM81spY9yADMMzBFismRs=;
        b=d1o6ZfdhbboMA3PGz7mj1XNEJgIQ2AAda5JpH0b7Y6Qo1dSexCPzDQMl6WSxKCCLxf
         QbwCFIVbyd3xz8wkqFJgUfKEgvzjJzdKsHGtiQq//YT4W474mgtyUxPLvNOgJ+RdyF8Q
         BK/FCyfGS3WIjaeDHA4ifEdJYMV7yrBIco7CjwRF9C8eFzoOeaRFO+8XyIBoVbAHFh9G
         pfwnweRUNvyGFZTRfJYfnDqgt9YU+JCgn1i4TaZSr5xoGWwp9bkrGrgOz8aZJsx5TXff
         EsP//ACTGs+nIKz+I69ymoTEkFwACtNFOYYB0fL/BuIZWNsbxJ7lLRGkVmF0uFY2cCpC
         F9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KQ/Om1iJNa++UOs6ipGuMhVM81spY9yADMMzBFismRs=;
        b=j9/QnZF8p/1nQxrG85SPzmKKcjnWM9G+VbliuaL6vC5Vb5+Axfrohaml4ckb++bUEU
         7W0BvxsD1aQJpcsbPOvfKsUX8UqtBUFXWQcJ/qOqlVGbSFaaAzd2DYk4WpnmA/Lgffiu
         0xtFlTt+D68eCWLnEuYMximYLb6Pv+RfaxxKLEAw+nedkvRUJ7oxBq/V2DaLD5PU1BOb
         16JvIieYpbrq5R1206u0yd6Xh3ZIJVw2LXbkb1wuhiATAya7VB2JCTuM7HyW5FpmFEg3
         L97hp2osw5HuUPJxdhUmq7fQQm29Ol0MbWx94JAXWq8DxnfwUXz0PWE45LvEoiajxfYz
         +beQ==
X-Gm-Message-State: AOAM533ixpQD6GC1ukRGwG/4nfHfe91bTe9MYY+90y6sIQPP3lszibHe
        uSMTBPPDSPXSHTLaXicUXX64VF+RaDk=
X-Google-Smtp-Source: ABdhPJw9+4dgZ8aHKQHXCLwkMWBKswYkHqtEgg2+ovWgn4hPSSQHYxtNuRHvO49DW97xNlaC7akpGA==
X-Received: by 2002:a5d:6845:: with SMTP id o5mr816119wrw.87.1603136145511;
        Mon, 19 Oct 2020 12:35:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm675776wmj.31.2020.10.19.12.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:35:45 -0700 (PDT)
Message-Id: <9ffcc5b78e358d0ed4da2c52ba87174dc94e544c.1603136143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:35:41 +0000
Subject: [PATCH v2 2/3] sideband: report unhandled incomplete sideband
 messages as bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was pretty tricky to verify that incomplete sideband messages are
handled correctly by the `recv_sideband()`/`demultiplex_sideband()`
code: they have to be flushed out at the end of the loop in
`recv_sideband()`, but the actual flushing is done by the
`demultiplex_sideband()` function (which therefore has to know somehow
that the loop will be done after it returns).

To catch future bugs where incomplete sideband messages might not be
shown by mistake, let's catch that condition and report a bug.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 844c253ccd..657a702927 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -471,6 +471,9 @@ int recv_sideband(const char *me, int in_stream, int out)
 			write_or_die(out, buf + 1, len - 1);
 			break;
 		default: /* errors: message already written */
+			if (scratch.len > 0)
+				BUG("unhandled incomplete sideband: '%s'",
+				    scratch.buf);
 			return sideband_type;
 		}
 	}
-- 
gitgitgadget

