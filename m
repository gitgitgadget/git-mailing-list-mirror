Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD061F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeHKBGn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:06:43 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:47709 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKBGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:06:43 -0400
Received: by mail-qk0-f201.google.com with SMTP id 99-v6so10842005qkr.14
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pi8Py/+Ryx0h5DauzM8bcd/r7qDgDhl8V0ff3ZVQX1I=;
        b=bcZlFOi3bEdhO63gDMzmvkUd3Rfzj4yv7jeI4Gl5rqJ0eGDkzOVIt2abl10I5ivh/t
         xHM7PqESyCpaxmL9VBE0Os7TnS9F+UgU/WOJC20PwKtGYBCCJssED7vtw8DzK7m2t2fe
         YmMEvnyVJuhht04sDKm8UE953QcEveeEfI/PL5TqLL8FYvSN/GM9SdwIAAVSgKitbiL9
         JWqz+Z5bx1Hf+dNjI3FEyRkRNgW6+7c7/XzcBzUwYkPtGEURZicuWz8LYR6kLcvmuzuw
         mSAEEDfouLSyMliE3PMEa7/TiMLOrgDWzJn2Eb4nMAGSRh6CgY3FxOAjb0PorjivEGC9
         rY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pi8Py/+Ryx0h5DauzM8bcd/r7qDgDhl8V0ff3ZVQX1I=;
        b=QAAxAoR4a0rKG/pou8DntWaeTDEHu41yPSjdBL+kTKLM1H8w7UZpP2aDKNOxKDIISV
         rMSkmvwwdELp+d8lm+SpCv8XOIbJ11GyhXnW4uruv4cS7W1tf8SUV2NIwcvOe+CSTglw
         d5VPAwvMIABYiOTMqt9zFCDs+KaKqQsIsyDVZgb06xfKwAtp/BK9nDn/i4WOP0ZSPBZf
         WUJWZN9P/h+QhH9wqLFFDfEfOkTxpzuZnb4OTFh4mAZNYW4SoftfXq1v+G1KvNto4jwn
         kr4qnTOPXqXnoZ3PUgzCjggISXmjFGgB5dSqnrrngoGMdN+yo2mDnXBs/b4IdzW4iVhT
         gX/g==
X-Gm-Message-State: AOUpUlG+VbazmCqvWazUqq6ChpVxTjw4F+hoi3xV1yyELwhp4VumVha8
        OVf3Gk4RLrz00zXBAqDCiJDyv0m8sOWK
X-Google-Smtp-Source: AA+uWPyiAY/X+qP6i+TBLoUb2inGryU8NBDUcGB0SB0+7BT2AUutjouhrP14to4Z578HClX+AV0B0qLwedno
X-Received: by 2002:a0c:e801:: with SMTP id y1-v6mr4334898qvn.55.1533940492975;
 Fri, 10 Aug 2018 15:34:52 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:34:36 -0700
In-Reply-To: <20180810223441.30428-1-sbeller@google.com>
Message-Id: <20180810223441.30428-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 3/8] diff.c: simplify caller of emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the previous condition we know "set_sign != NULL" at that point.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index ae131495216..f6df18af913 100644
--- a/diff.c
+++ b/diff.c
@@ -1202,8 +1202,7 @@ static void emit_line_ws_markup(struct diff_options *o,
 		emit_line_0(o, set, 0, reset, sign, line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
 		emit_line_0(o, set, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-- 
2.18.0.865.gffc8e1a3cd6-goog

