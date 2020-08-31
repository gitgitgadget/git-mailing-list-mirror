Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6363C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F27E206F0
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFKkevJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHaKvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgHaKvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B031C061755
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so4939355wmi.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InUKzhmVJZsVoLdzQXNZrn9VeJlbgKIHXnzWsess1dk=;
        b=uFKkevJEgYbTDKCr6voE9ZCAic0AhftDZXcfotgzGcFvAm7a/jn9+Hjn9gw2ezpnvS
         2RqY/49obWcvZG26EBvdvQ0kOP4/KrlWrS6PJC5z4kmraWZKGEg2JBgd9vMZZrwjTryk
         NlbVgHVDiDl5duCZcbhty1lhsBUVbw31hnSByaDhz++v2pKmKNqbDl8CsNZVcoxvdnvA
         81b+rwiyQVPJ4OGSmsdqI4qoOTQ3wqLk+8L8IHU+993/rWXiPrCKzCkfLTe+uBR/KVo1
         vGJgQBsmyuWsgO5BjHwv2XRJhudd5sbwojyPzsSwbcTZqAkCmbxrcU8iNzKYRw0wLp7U
         tsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InUKzhmVJZsVoLdzQXNZrn9VeJlbgKIHXnzWsess1dk=;
        b=kLJH25N/ULzbFXYX2Sy2RHLMiw4iUqOHCUqCTQWRP1Q9wYON+/KqGGHlUkfmaKJb+t
         HOieyVt6kPe3SVYa5woR768TKnRL+xVEWQHJhHVZvveU2tbtcbyhAh90s+K25nWa60IO
         5C314b2HuVwgaaEZa5OtB9IvpGu42JlLk+o0ztYxzzsjBgATR7pGfs1bwzzC+tqAs8ol
         ukGeDX/xX92zjh/HnVmEDsfW3saQCnfpOcPP67NDmMJE6LtO1umtduTOdUdvhS6FJJ/g
         +OBlcG2wM8jQjeCHCR1cDK0Tbi/q65SqCTLXqT9enrGdm9QHFYTdzjtmWEaUwyCIruew
         dyDQ==
X-Gm-Message-State: AOAM531tHRH+zuq5vIB0aQH7jGygfce1i3i+Oat50qv46d1mpM7pxthH
        PvD0kc+3+CluNQ0j9OOyup85xW7HADs=
X-Google-Smtp-Source: ABdhPJwlQLcBBkkQZluOoLzKK0PRR6uSD1JzZOwd7/Bmch1Xi+X3hS/xMhbLlViDrioLqRtoZQjlGw==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr851979wme.172.1598871069525;
        Mon, 31 Aug 2020 03:51:09 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:08 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 01/13] bisect--helper: BUG() in cmd_*() on invalid subcommand
Date:   Mon, 31 Aug 2020 12:50:31 +0200
Message-Id: <20200831105043.97665-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cmd_bisect__helper() function, if an invalid or no
subcommand is passed there is a BUG.

BUG() out instead of returning an error.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index cdda279b23..f464e95792 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -720,7 +720,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_start(&terms, argv, argc);
 		break;
 	default:
-		return error("BUG: unknown subcommand '%d'", cmdmode);
+		BUG("unknown subcommand %d", cmdmode);
 	}
 	free_terms(&terms);
 
-- 
2.25.0

