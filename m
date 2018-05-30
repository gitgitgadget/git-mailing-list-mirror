Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CE51F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937268AbeE3IEi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:04:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51262 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937127AbeE3IEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:04:16 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so22031535itj.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U6PJISp6vVKPPoG9gcR7xmw70AY/fD4+hufGIsJxQeQ=;
        b=SBs3judxV3dCGKJ5yytfpyna75nPSfpT8IPDIXCfvZlMgquj5oc4oc2C+waq7HbyZE
         OYzxL60qtd+9axaizSQ12rDdVn0PVbc5uGZWItaFsPOWWw7OJNFQ7xMj3BFPyEdMtwZj
         4cU3CLs8Z7P6WggPbl+xgFiANBHmoGfOKImgPwYHCu674X5yK3q8Mf1GfGtDEzeYV30Q
         P6C9KFTpVSTacPOkcDtSs3B/nJGqpXRrggbzwJFuKwMip8eHW7eNW2g0MeKYOsWgHOJA
         q0jTdHGhUvU6jJaPWgvs1XNZ43hMAFR3KrDvUOR7AAQPNw5KTtZZ0QQyOERlRm5Du6aE
         KpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=U6PJISp6vVKPPoG9gcR7xmw70AY/fD4+hufGIsJxQeQ=;
        b=In4BsdEFKDZjgtOaA81JzwmQPRcVh5dWuWQZ+j0wS7nQFumSTvGpMHSRq7d4SGKMJY
         foVTe4IELWgQXrygl7XSgzvc3GPxbgvspCtBcLhzivjazGLfkKw9YdeOUNEnJoAQ5H8A
         nFCaUWAnrqdiWzTztL/hna/+Kw/HYVxtq5MTm5N7hAZa9osdS1cDW3aq5/TFCc6EYh32
         TxLypGr6DDjfzB4DR7djYsgYYyvFAX/t5zWwEyPp98dLW5Hhs5/VCwt1CgzfTpV16dK4
         5FDmz/zwfTKPSIa59vlwnU1dGmvPHdcs6UVuCwFvHzFOlABfhJrDc2gr0zLYr6XSQBMe
         KA+w==
X-Gm-Message-State: APt69E2nSlD/FZ40jTEJGnAEZyqNMfo1gRAXDTrPa7FRfy8LwxHah/lY
        h0OZvDt3JizwwvLcA3TKzZI6mA==
X-Google-Smtp-Source: ADUXVKKsdvWJZbthv7ZvxKmTotnRmEePB+CX77om7M5sxDVEKMTfXFbuXzbqASbw7H762nzN7JDVOg==
X-Received: by 2002:a24:9d0a:: with SMTP id f10-v6mr635986itd.61.1527667455892;
        Wed, 30 May 2018 01:04:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17447561ioa.82.2018.05.30.01.04.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 30 May 2018 01:04:15 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 4/5] format-patch: teach --range-diff to respect -v/--reroll-count
Date:   Wed, 30 May 2018 04:03:24 -0400
Message-Id: <20180530080325.37520-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.1.1235.ge295dfb56e
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --range-diff option introduces the embedded range-diff generically
as "Changes since previous version:", however, we can do better when
--reroll-count is specified by emitting "Changes since v{n}:" instead.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/log.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index e38cf06050..3089d3a50a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1121,7 +1121,11 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	if (diff.len) {
 		FILE *fp = rev->diffopt.file;
-		fputs(_("Changes since previous version:"), fp);
+		if (rev->reroll_count <= 0)
+			fputs(_("Changes since previous version:"), fp);
+		else /* RFC may be v0, so allow -v1 to diff against v0 */
+			fprintf(fp, _("Changes since v%d:"),
+				rev->reroll_count - 1);
 		fputs("\n\n", fp);
 		fputs(diff.buf, fp);
 		fputc('\n', fp);
-- 
2.17.1.1235.ge295dfb56e

