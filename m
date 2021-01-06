Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD5C433E9
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7B823121
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 14:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbhAFOoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 09:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbhAFOoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 09:44:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B79C061357
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 06:44:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y17so2627404wrr.10
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P2GMqPywAdEd2RC7DQzh+rWtlmGR2auDjQL4xLrlyLQ=;
        b=IGW8Ac1LPrAvMNyJ3ZrWTtGVhy2xuVosXp7St+eHcmzWVnG6y9KQwbDQRYCRskqugi
         lvT/iDM3dcV1JRCatluf7qASY1vl7IFFgvzj41ta5lqnC4+lPnmg1TF506SDG8qJ/yvb
         o5zU5rHBHPqNxoQaJTn3QJga8wPnrMXHiHG+cPllxwiuTsXBakfzv6jAOUX56pAvxE4s
         GmIiDl/hhpSDQJXHjOxt/wcSnjtrnkeia1NA6SJ5uDqlhSDnrfmV6d4PpByxeIHlrFyh
         lgf4o6yBFmWm+48m2g+wIj6oqePtoyCHQfoTpJbuYpIeZtTIIJ+E7VbWp7sGAf2UT978
         Ix7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P2GMqPywAdEd2RC7DQzh+rWtlmGR2auDjQL4xLrlyLQ=;
        b=MZPHnxqso8suDI3CU3M1zs9QnylA6kM6x6SuNPekZJSPCElnWhUpK0CWMXhC0NLJQX
         Nd1oyksQFsyJ9JfD/pDxxDNUWSp+1O6HgX48X8bTZk72OLcr5xiP4V1VuaE82YSs0mAk
         tURQLAxZOhI9pE4GnbvER60aWLtPT6lVU10gWK8Wpx7kSsCPpHKwU2hIL1waUsdBxRjt
         GMLJHDScDqZsJQk1CNamSLWO3cCpodRDYE7gtV7NHBrf/o4BK5ghyIVkLngZDzfGoqm9
         wL9z4sFnC8bk1VOe2RPR8w2Ak4zQrApwvMgF6Jj3V9ARz8x/SOKJHAVg2cMLDlR6CqT9
         b9mA==
X-Gm-Message-State: AOAM533UG6LZrYtnM9yB8RwvBzP1Oz7uFpoM83NOTBwqY0ya3V0HvWj1
        I4olqGwNhDydsfbSgsYyVuPTCbesfpI=
X-Google-Smtp-Source: ABdhPJxddaJZA+TEWnmxdPMlFCiSSQg/cFo7NFHbb4Yv00krmyniprZTWijtOHQYtqcmraFCz1DEng==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr4826531wrw.62.1609944246566;
        Wed, 06 Jan 2021 06:44:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11sm3245520wmd.47.2021.01.06.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 06:44:06 -0800 (PST)
Message-Id: <9d508df032bf1038fdbc67d14e11dae1210b0fd2.1609944243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
References: <pull.822.v2.git.1609933875.gitgitgadget@gmail.com>
        <pull.822.v3.git.1609944243.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 14:44:02 +0000
Subject: [PATCH v3 1/2] parse-options: format argh like error messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

"Keep it homogeneous across the repository" is in general a
guideline that can be used to converge to a good practice, but
we can be a bit more prescriptive in this case.  Just like the
messages we give die(_("...")) are formatted without the final
full stop and without the initial capitalization, most of the
argument help text are already formatted that way, and we want
to encourage that as the house style.

Noticed-by: ZheNing Hu <adlternative@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 parse-options.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 7030d8f3da6..ff6506a5047 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -82,9 +82,9 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   stores pointers to the values to be filled.
  *
  * `argh`::
- *   token to explain the kind of argument this option wants. Keep it
- *   homogeneous across the repository. Should be wrapped by N_() for
- *   translation.
+ *   token to explain the kind of argument this option wants. Does not
+ *   begin in capital letter, and does not end with a full stop.
+ *   Should be wrapped by N_() for translation.
  *
  * `help`::
  *   the short help associated to what the option does.
-- 
gitgitgadget

