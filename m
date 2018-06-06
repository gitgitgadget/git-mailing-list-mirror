Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0481F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933811AbeFFRDU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46765 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeFFRDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:16 -0400
Received: by mail-lf0-f66.google.com with SMTP id j13-v6so10207518lfb.13
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYKv3Alrq9lSFukiUX+FxpryHsfaFdMevrixXaLGFD0=;
        b=bz0YwrMro9A/wtUZPpRCgvG+AKOts3cYdafE8HlX29fzWJSdVVMAUsj2nb4mh3RPJI
         /DHD6XeeFa54rrw7eyIWCZ59Oo+2Ee0pSMSPWqYH1YFMhM+vhKrqgNnhFOn2/RcZRfFL
         pOpAodplV96h2Lih/Julnvc0m2PjOlxFSHtfqAPJVKZrG/Z8QFRZFcXFKAkPNDYy/Igl
         y2CqavbNGrchRDExbzGDE6ONzPy7NIgwgNDugMofQGpB8c+THUSs+Bq1mJsZ9p8uERJz
         k6Qen2EM+B/kbDglSKRzVtfLDJnrfh17ABljrvhxAGJ3cDMaH4tYY7TWP6ND3H3mWJfD
         hTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYKv3Alrq9lSFukiUX+FxpryHsfaFdMevrixXaLGFD0=;
        b=cMsixpP1ruWOxUm9Ut2b/SKMmzqHmp5TBwjKSfkHIVunqXfpJbKaygk5YGXwhEwJeo
         UqXjOzl6R2Dli+66/3hn+F5uSGmXxp4htnJmh7Yaq0dyngV+Wg2qXVb0qb5H4gok4DCo
         Bl/GoZFM0sVpN1MaL2D7DXuj3kkUtQQW6gDaeXFmPG99vHLOuuoHSAfsXkN3LwLR5Ylv
         F2eVprNThkcb2/4Rm8O5gLOyJPEC0yoyk2BYHWeBahfSUoMPN6Wo/o08gBba3nRYn4Jx
         vBAgOF4q3PnWRKlQCErAbgz90Y9xOTq7QlBkb6CK5H/8WNqPsiOyGoo0IrxK1N6ZqGKb
         IgXA==
X-Gm-Message-State: APt69E0EqxiSM+c6Ee7EYOWYVxxU0GIqdbdVsrRRLqqoMIZCa0X/QArx
        EwiIyV6qBbV/fsbUu13FP6s=
X-Google-Smtp-Source: ADUXVKJilCY1HkD5RdgxsrVm8pIFoVwhdvhqL/VWLjA9ZppQ6hLIevqW3wk/zbWUUWnyHdGJ1W6nQQ==
X-Received: by 2002:a19:4355:: with SMTP id m21-v6mr2537248lfj.121.1528304595519;
        Wed, 06 Jun 2018 10:03:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 20/23] checkout: avoid the_index when possible
Date:   Wed,  6 Jun 2018 19:02:40 +0200
Message-Id: <20180606170243.4169-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d2257e0d82..4dbcab3727 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -230,7 +230,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_index_entry(&the_index, mode, oid.hash, path, 2, 0);
+	ce = make_index_entry(state->istate, mode, oid.hash, path, 2, 0);
 	if (!ce)
 		die(_("make_index_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
-- 
2.18.0.rc0.333.g22e6ee6cdf

