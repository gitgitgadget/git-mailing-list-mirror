Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA4C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 09:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiK0Jhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 04:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiK0Jhi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 04:37:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D1A456
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so13144550lfv.5
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvf81xkqWfodb8THj0KEuhk8sI/Cb654jehnY5b40b0=;
        b=R2FTjPzE0GWg+0r7DB6zdCRNWZVB0IrEf1IOQQ1xKt1ls/FHbg4hrjcO0frpe8S3Hc
         rzQGWXMLwexjtY6EqvxwEx5N0o22O5vjvjwrCt9D2foshPni9D9DU9b6M/7zUq//NqOw
         du6aqLn8rEZ6qge5U3kjGP5l5vVmckbAWytlEqLDUzwEjugKRHSFhVOav/9hRhxX49eq
         TGtiEbv2Bu8SKiZJvky+A4hFzIr+46KsVRM1gBfQmLK9aDoeIyKhTE75yFGZo0bUPEoO
         oWQ+2rsgqhU3Hmr3rVjviAbRZveygRVdQgpzD5NU2SEDA2ENxLQtrr3R9ambs1rNwmxA
         oqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvf81xkqWfodb8THj0KEuhk8sI/Cb654jehnY5b40b0=;
        b=bzzD3baysqvPs5V1KT+tKo1PRElh1KylgiskvQ7Q0R3xKM1jNMDKS+C974hGww+jg1
         wCF7+iYgWS6Hj+qnEWvcme/SgE5/w6b2PsrmRza2b/5/OJADpSr2Fhm0U28MqdQ2EJvH
         bpZVerAgr73QAuM4vQyJhnJqwDmajGJMhlsSEBh13rj7eXUhQmeidTMT89F5anjHbXd5
         YrJogTZUYsFRvqUrhbisoJ4jlMsS6J6DwN60VjCaxbRsMcCZwTIPykXjmXqcz46K9P0b
         u+XVBlJgw3880c0wgwuGLEE/6yLkAdEvYvhnMYQ7aDVboAz7eETA63Jvfe8rovm0oiIt
         snZw==
X-Gm-Message-State: ANoB5pk4lgIMJTXA7UndhHUEE/ZhTiTDKAgRqgfyIYEA+3IKaBB3Jt24
        5H1VgAhWZ6W0+3EeKJAgN7Bn35hDWco=
X-Google-Smtp-Source: AA0mqf4Q5HA4MSAcddQXwNOcdpZv7cvAAs+fivMXk6G6o1zfb83rDVFnELIPGgBXwxxxZSCTuFSs8A==
X-Received: by 2002:a05:6512:3f29:b0:4b4:af05:4a8d with SMTP id y41-20020a0565123f2900b004b4af054a8dmr14965959lfa.415.1669541855540;
        Sun, 27 Nov 2022 01:37:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bd3-20020a05651c168300b002770a48fd12sm835615ljb.102.2022.11.27.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 01:37:35 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 5/5] diff-merges: issue warning on lone '-m' option
Date:   Sun, 27 Nov 2022 12:37:21 +0300
Message-Id: <20221127093721.31012-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127093721.31012-1-sorganov@gmail.com>
References: <20221127093721.31012-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lone '-m' is in use by scripts/aliases that aim at enabling diff
output for merge commits, but only if '-p' is then specified as well.

As '-m' may now be configured to imply '-p', using
'log.diffMerges-m-imply-p', issue warning and suggest to instead use

  --diff-merges=on,hide

that does not depend on user configuration.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/diff-merges.c b/diff-merges.c
index ddf9a411c49c..b3b3c9e44ba8 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -11,6 +11,7 @@ static diff_merges_setup_func_t force_func = NULL;
 static int suppress_m_parsing;
 static int hide = 0;
 static int m_imply_p = 0;
+static int got_m = 0;
 
 static void suppress(struct rev_info *revs)
 {
@@ -196,6 +197,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 		set_to_default(revs);
 		set_hide(revs);
 		revs->merges_imply_patch = m_imply_p;
+		got_m = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_func = set_combined;
 	} else if (!strcmp(arg, "--cc")) {
@@ -259,5 +261,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 	if (revs->merges_imply_patch || revs->merges_need_diff) {
 		if (!revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-	}
+	} else if (got_m)
+		warning(_("legacy use of lone '-m' detected: please use '--diff-merges=on,hide' instead, as '-m' may imply '-p'"));
+
 }
-- 
2.37.3.526.g5f84746cb16b

