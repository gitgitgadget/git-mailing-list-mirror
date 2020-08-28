Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAB2C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7CD2086A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXM9vR0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgH1Mrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgH1MrT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483E4C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so1176338wrt.12
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=HXM9vR0EUWVF0uqOEGtL99oEWRvtB+uetlY/V0gxz76X1lySFhJuDHhgAzfl9doa+O
         6kX7cixW3KVS4wCg+ydtZCvkM/kyVa6OWdfayOj2Vfhltqo3LYVrZ7MSGgZXHFrLcySq
         MhUj7Dkbfg8p229oIQH8VX5dVmClqtrfGgMIapy2wEMuyDLtDYg2cEpw2QErdNrhtmMp
         feVMA8+ZR3qKEL1B3v8zfJ1JKVbf0++S/Ke41kHBBK2EQ7MAed/zvpfrjvKhtAAzbelx
         y0KdoCKFA3JCMyZ2T2RzsNhUjFbddwXGx6+PGXW7AkCm+dMh/sv2PI1UpB4PS2VROa0Q
         AFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2I9Y2hRuXgRqT6FgB1KECR88tDHWd7i0V/IscrZ+zbo=;
        b=GUV0xbuvi7+c1gf4kmj8cb7DkXGAiC4tve0btC1RnsSFcvM4gLAiCn5PxfVHwKw3iq
         xo+CYGJMiOQeh2lyl3oLxzD+zJx2zRZ0PhqKxLo1o9v9UAN1/wBP0ZsEIkumC/5xjavY
         rA0A00kNihR9gHFfraZO52kvM1sl+WVEaix/nktSRTIYqLuWeXO8eTBurAhwiNI8D6vX
         tJS/aBeT27kMPrXfAMV2hJPsvBOItLjprrsDqeTI/bkidQMKTkcx179JA77P2FykmiBI
         zR8M4969xJ4YXkkG/i71MRoGnWO2uYUIrrUy5M6Mtv9PGfdZPKISfnBXPnjiUCzcVaP6
         V8Lw==
X-Gm-Message-State: AOAM531r78ZsdoB2ujtWbU4tADWlJj44gXDcVXnRabuDnLBuJMwZJKNV
        Bq8pdsHu2//LmtwgRwd29rPjeSbDjpQ=
X-Google-Smtp-Source: ABdhPJwn0+h6DeSdq+KqtUAyxBQWEPVR7lKlG6gWEyjIGtKw25oySxbHUT0sjlMTDfXJK0F8UGDQuA==
X-Received: by 2002:adf:e449:: with SMTP id t9mr1425895wrm.154.1598618835792;
        Fri, 28 Aug 2020 05:47:15 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:15 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 05/13] bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
Date:   Fri, 28 Aug 2020 14:46:09 +0200
Message-Id: <20200828124617.60618-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there can be other revision walks after bisect_next_all(),
let's add a call to a function to clear all the marks at the
end of bisect_next_all().

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index d42a3a3767..c6aba2b9f2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1082,6 +1082,8 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		  "Bisecting: %d revisions left to test after this %s\n",
 		  nr), nr, steps_msg);
 	free(steps_msg);
+	/* Clean up objects used, as they will be reused. */
+	clear_commit_marks_all(ALL_REV_FLAGS);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
-- 
2.25.0

