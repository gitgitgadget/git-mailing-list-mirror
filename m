Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A100CC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820C12075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+vC1KQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgEFVsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730029AbgEFVsk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 17:48:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EBC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 14:48:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so1811408pfv.8
        for <git@vger.kernel.org>; Wed, 06 May 2020 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rdd23K0VKYArxPfWBu9HOIWcLwj56JRKrRMqxp2eb6U=;
        b=E+vC1KQYMcQlM7mroQ8Xh7acIwFoI852/glwBWoHoWOgXSqsuwYuJB4Yc77lQU2Rt7
         qWWcXY6PSUEoiZPgg4cV9ehfkM7iuBArza0fCwq1fn3lZtCJeQgMvqqljUGQZiBAGedE
         DuA2m2mXt4Ak2Ux+zHIsUMsciftiihzovQba5YJW64cYjHynd39bGdYtFagnZO9DtmKz
         kUIms8vqj+3ws1BgBZLzHJ8m3vl4kEga1dl0dn0J9fCzdgtYDxrecpa3eI5nn2j2RnWO
         I39Xj4bEIzQ5+iTvU4NPB2mZYNtHKFYp53soKgZgUR5rGrPeIdg6ievvrMbit+4+Kw26
         ipjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rdd23K0VKYArxPfWBu9HOIWcLwj56JRKrRMqxp2eb6U=;
        b=U0Tj541UH0dKLPhK5tzSLNLhh58jj9lkMpgVSciRpSJjNEfc+x7X64BDwWzyhPhTJJ
         I4vlLvtLcBT311drX5Jtd/ZlR6iRxXmuB9iL20O0D/ysHzxDAtZzEHlp7cHmEEwywOt7
         LB7qATaqcR88QfKWJCrrtxC3e1c1pkiHlETL+EabuJU6pkJzzujglX7SH6sCC1e6PV8J
         ETuFpHUgYcCORmLJ1oTQ9IpYA8TGhWNvrAXQbtHwtx/T3AUQP91ho7ODo4Xg/dAzHpZv
         vOigcL6zYYJKwhvxujYV6qGEmvgwX3rku/vAGgzWcOZqYWs1CVuDD8cV1TCb5Aj3mXcB
         3qjw==
X-Gm-Message-State: AGi0PubN+T0X9KXcL77zeadx0Qt8iMO5ZeWop0t1PvKZHwu0+2tPU+n5
        NtlS1dAwLpOWHmMeNIPQA+3FT/f7
X-Google-Smtp-Source: APiQypLO0s18pt9yW+EF2k1fFHwwdSBMbJcyCtait9A/PfmMeRr+JdEpzNBe+76i521xemWZZ3Ne9Q==
X-Received: by 2002:a63:7805:: with SMTP id t5mr9065363pgc.141.1588801720024;
        Wed, 06 May 2020 14:48:40 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm2703432pff.47.2020.05.06.14.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 14:48:39 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/4] credential: correct order of parameters for credential_match
Date:   Wed,  6 May 2020 14:47:24 -0700
Message-Id: <20200506214726.81854-3-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200506214726.81854-1-carenas@gmail.com>
References: <20200505013908.4596-1-carenas@gmail.com>
 <20200506214726.81854-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the beginning in 118250728e (credential: apply helper config,
2011-12-10), the declaration for that function used a different order
than the implementation.

All callers use the same order than the implementation, so update
the declaration in credential.h to match.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential.h b/credential.h
index f51703d9ce..c0e17e3554 100644
--- a/credential.h
+++ b/credential.h
@@ -189,7 +189,7 @@ void credential_write(const struct credential *, FILE *);
 void credential_from_url(struct credential *, const char *url);
 int credential_from_url_gently(struct credential *, const char *url, int quiet);
 
-int credential_match(const struct credential *have,
-		     const struct credential *want);
+int credential_match(const struct credential *want,
+		     const struct credential *have);
 
 #endif /* CREDENTIAL_H */
-- 
2.26.2.686.gfaf46a9ccd

