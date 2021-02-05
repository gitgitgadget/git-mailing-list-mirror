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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130D7C433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C192764FBB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhBES7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhBEPCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 10:02:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CBC0611C0
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:29:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j11so6490320wmi.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q7cKnUpUO/gDwwMLsD/crPwNAKcy0rWwvfrJg8VmXY8=;
        b=XQe/QQCCF1c6lWTmQyif2qc9/SnQNqieQVea/zxbMcy/4rH0LNELNz39olP/4UIygU
         zzEf2/izuQSTbJuS0clQ9R4t7q1DUCQdGDv0GeHiZO5tyROqHnpKIQQCesXdZiMyyPCR
         YAzmKRqGlnZvCE9NEjzHGp0s2W4b9cAFNYVZkS9QxNOouRp2l2ZcmOpDAKomzuokorkB
         tzMlxhnmfHgRy7HlbOj9Js7wufW2sb6l4embloBaWMRtDoS0klQ+TSLzd4qODCEj+vXI
         H4EhsW644COxvzTy3FMEcC13DJSGdM4/QRe3oY9H5H4nKeDqvBDKlBQScRfElziCZO+Z
         VyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q7cKnUpUO/gDwwMLsD/crPwNAKcy0rWwvfrJg8VmXY8=;
        b=Jz73DTVSz/Op3nt6J7KBj6eELPDAiSgNipp1zoE8GfecVDNthfFLbTZWVX3egTPsFH
         jjdbnYBWauuOg9YDieOog+0/ILdFx8H0hfTwt697aP6RUrhTJoZ4J9kwhQz7g+M1HK3a
         rZiWpDUUgnk6O/o38ahd/mWwqC0VsPsTutehuC4WpvvDE8xs17PwL9KPbhxFhRAVm1w5
         WXG4H4HjXWPOzA0CPzvU/H4XdWV0P9cYsgJzbdE0gn3VPkIsJN+vdROxlHTnefPDPARx
         cck6Unx9yq6gOvHeuqisIqz0PFLVFlGeRTlinLl4hm4d2oBPJzaNRqwOkXKVwd7PVyG5
         0TEQ==
X-Gm-Message-State: AOAM533EbIzsIdd1Jv/YAJsBDJuQSIl7yo7CcmczaaFoZEm90Y2kTSgk
        tXO8d+/TY8cHGlm0NRmts+VQIBDQkN0=
X-Google-Smtp-Source: ABdhPJx2v8w8SX0P1xy7ZpY+c5tAdW7EgQcJAx1Xn6ZbMSomg18nmUK3bclWjIqR3u84MbCDspHu4w==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr3958147wma.22.1612536294475;
        Fri, 05 Feb 2021 06:44:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a132sm9070797wmf.42.2021.02.05.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:44:53 -0800 (PST)
Message-Id: <08c5f8732747de138c6a98322beca95e919ba11d.1612536290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
References: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
        <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:44:49 +0000
Subject: [PATCH v6 3/3] range-diff(docs): explain how to specify commit ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are three forms, depending whether the user specifies one, two or
three non-option arguments. We've never actually explained how this
works in the manual, so let's explain it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 9701c1e5fdd5..a968d5237dae 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -28,6 +28,17 @@ Finally, the list of matching commits is shown in the order of the
 second commit range, with unmatched commits being inserted just after
 all of their ancestors have been shown.
 
+There are three ways to specify the commit ranges:
+
+- `<range1> <range2>`: Either commit range can be of the form
+  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
+  in linkgit:gitrevisions[7] for more details.
+
+- `<rev1>...<rev2>`. This is equivalent to
+  `<rev2>..<rev1> <rev1>..<rev2>`.
+
+- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
+  <base>..<rev2>`.
 
 OPTIONS
 -------
-- 
gitgitgadget
