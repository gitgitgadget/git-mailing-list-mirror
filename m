Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 800891FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcHJTzW (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:55:22 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35760 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936180AbcHJSgX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:36:23 -0400
Received: by mail-pa0-f46.google.com with SMTP id i5so1816993pat.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:36:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xXhQibAkhrb/YkUzPVBui/jDZGeR5D5FX7ezYUa0R34=;
        b=NYElJ/VIGunJmdu9vF7Gxi+E400/67v2JXMS4/1iGW0MQWvz985/EpAWvJTHHkQ/Se
         +TGumWFBi8wS8MnvhA1xWT6DjJaPTUiSchUOY+vWNqR35Wu1+COVGvf9BT7Wh9NdAolv
         H18sIK1T1+7CVHUtGx//Dm3Cfp12PB/gNPpUNDeaf3XxZMnxfUdPVNvCCBgWGRZeR1I/
         HzcpIyHSQveqrUu/yZZQ8jf7nXKgLk2+qSQElbFkaYG6A7UCnjKIFkFrbkgCA5sRk10A
         9IcmiBFdzWinOuKD/MfarUk6zSoicOU1jfZ978ZXrEtMDkEGuswo9SVl3sU4y+fHVxyZ
         wYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xXhQibAkhrb/YkUzPVBui/jDZGeR5D5FX7ezYUa0R34=;
        b=XBxaW10wggaBIeEp9hTcosNSF9EKbL6qUQ4iM3TG5c5Wi2r6BWSJ/UX6ZoaP9gMfJS
         3CCCapRSUfuo4W5K/X98DuHOMPOc3oaU6bzrqvT75BSjPJeBaUGM2cEsmpp8acKNrtES
         7iRiHdwXfY6SOZSXql5V3ny4wA8dOYCCRZyJn0bq9TXVSAeN8J8ZPEVYgAstdAHACHKc
         bZKFmc+S71zjRB5u3vWcW1jKAjmIEH84PJkiP5myGEOuYjc5ADga9SvfKuQvACSN1M1c
         3DCvXS7WYHIJDP9mdOdcjDWlRkPnZYlnimNzb4MM+y7L4WGMO7c/uL37/fWtdm8txL3S
         tOKQ==
X-Gm-Message-State: AEkoouupqnTW3AT7ZtFNXxiPrxQQA/p09oJHHrbBjW5gHWNw9/O52K+Gl6stcIET1mQRXe7W
X-Received: by 10.66.217.170 with SMTP id oz10mr9027819pac.61.1470850091709;
        Wed, 10 Aug 2016 10:28:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1d6:11b1:1dbd:105])
        by smtp.gmail.com with ESMTPSA id ao6sm65788851pac.8.2016.08.10.10.28.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:28:11 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	jrnieder@gmail.com, gitster@pobox.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] checkout: do not mention detach advice for explicit --detach option
Date:	Wed, 10 Aug 2016 10:28:00 -0700
Message-Id: <20160810172800.23575-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.665.gdb8bb2f
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When a user asked for a detached HEAD specifically with `--detach`,
we do not need to give advice on what a detached HEAD state entails as
we can assume they know what they're getting into as they asked for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 27c1a05..fa2dce5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -655,7 +655,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path && advice_detached_head)
+			if (old->path && advice_detached_head && !opts->force_detach)
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
-- 
2.9.2.665.gdb8bb2f

