Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8489C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD0F229C4
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 17:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgL1RSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgL1RSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 12:18:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB0C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:17:43 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t16so11924553wra.3
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 09:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJqcwu2Y0KPuPXnuZUCIkf43A4kZGNUkpyf7Ny1ZSWY=;
        b=g5bFG0Wuvy3EuMOH+bliv7Q/0iOPVs2SYHHGjpuO7/d05yduGJfmZnu+zFlYNwFdkr
         loME9lHbatQObvQ2Upm6TLGVtTgLBGatK3fVsLlI2vtSjAofwib4texsQ26DMC4JnWzx
         EoOCijGIFB8C527am62kpMKcW2O6gNFQ75PePRldpjoItNIoXLIjbp5lv3o4Cu0f5vQB
         o/2YcfDpyrsbEhy2spF5BFOWfTqZgOPMwO4YmRREd5B30jUPIHF8oaXMmK++yz2U6S2L
         PQWxcRKtvfL0ocieI3mbyd5FE9RTdpjIjjap/fs8WsYSYcX6kVp83HCDYgpQq71vZEu3
         z8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJqcwu2Y0KPuPXnuZUCIkf43A4kZGNUkpyf7Ny1ZSWY=;
        b=k5gDKEE6ud/f5mwP10HnlP9MLLBDzYthfrdtCgxkX07DK1JHBBVQnzNbZCm32uBngf
         rEy32lNTW031lQ5og00QxASXTwSwpqRtg3ow5J1NbOJt5Hlx0k+N/gzJ/tPJTzJQTRZ5
         7GW7ReuP4ds8vmn+A8jMs9xYrPtejhqOHnWaBNLVxIrJkrwsQiJg/jdaWDd3KM20pgjV
         zjWn2gTWDq4xLTjZdG6UcJ5vdN3qkkcHZnSl9zqi/33Y/63+MCqXwyF0L0teP6V1LVR/
         aJeOX2mvjsnc2Pny22/zWXEQE7/uzJd/79FwFzUGpZvl/BGs0RMpTfaZ2tUZpQzB3y0c
         yQMg==
X-Gm-Message-State: AOAM531zGa7DcfNg3kwz9GLuod4p8pOv0yeewmEpu5ZrHalrsZ/wRFJI
        o2Tb63lZJK3hp1fem1McHPqbRbH2b1IMsg==
X-Google-Smtp-Source: ABdhPJyOOmBH0ZqpagiUAm1/dnMAEpFicKGxIud5sTnNRai6iFU/IDdhtR1lXNi3M7pLMrB3swsHVw==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr51043506wru.86.1609175861517;
        Mon, 28 Dec 2020 09:17:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20072834wmj.28.2020.12.28.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 09:17:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] CoC: update to 2.0 with less upstream divergence
Date:   Mon, 28 Dec 2020 18:17:32 +0100
Message-Id: <20201228171734.30038-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an alternate version of this update which is hopefully easier
to read diff-wise, and produces a smaller delta with the upstream
document.

With this version the diff to upstream is ~30 lines, with Junio's it's
~60. Specifically for this one:

BEGIN DIFF

diff --git a/code_of_conduct.md b/CODE_OF_CONDUCT.md
index 4e2473b8399..65651beada7 100644
--- a/code_of_conduct.md
+++ b/CODE_OF_CONDUCT.md
@@ -1,5 +1,10 @@
+# Git Code of Conduct
 
-# Contributor Covenant Code of Conduct
+This code of conduct outlines our expectations for participants within
+the Git community, as well as steps for reporting unacceptable behavior.
+We are committed to providing a welcoming and inspiring community for
+all and expect our code of conduct to be honored. Anyone who violates
+this code of conduct may be banned from the community.
 
 ## Our Pledge
 
@@ -61,7 +66,13 @@ representative at an online or offline event.
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
 reported to the community leaders responsible for enforcement at
-[INSERT CONTACT METHOD].
+git@sfconservancy.org, or individually:
+
+  - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
+  - Christian Couder <christian.couder@gmail.com>
+  - Jeff King <peff@peff.net>
+  - Junio C Hamano <gitster@pobox.com>
+
 All complaints will be reviewed and investigated promptly and fairly.
 
 All community leaders are obligated to respect the privacy and security of the


END DIFF

And for Junio's:

BEGIN DIFF

diff --git a/code_of_conduct.md b/CODE_OF_CONDUCT.md
index 4e2473b8399..ac13a84d1a4 100644
--- a/code_of_conduct.md
+++ b/CODE_OF_CONDUCT.md
@@ -1,5 +1,10 @@
+# Git Code of Conduct
 
-# Contributor Covenant Code of Conduct
+This code of conduct outlines our expectations for participants within
+the Git community, as well as steps for reporting unacceptable behavior.
+We are committed to providing a welcoming and inspiring community for
+all and expect our code of conduct to be honored. Anyone who violates
+this code of conduct may be banned from the community.
 
 ## Our Pledge
 
@@ -60,8 +65,14 @@ representative at an online or offline event.
 ## Enforcement
 
 Instances of abusive, harassing, or otherwise unacceptable behavior may be
-reported to the community leaders responsible for enforcement at
-[INSERT CONTACT METHOD].
+reported to the community leaders responsible for enforcement by
+email as a whole at git@sfconservancy.org, or individually:
+
+  - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
+  - Christian Couder <christian.couder@gmail.com>
+  - Jeff King <peff@peff.net>
+  - Junio C Hamano <gitster@pobox.com>
+
 All complaints will be reviewed and investigated promptly and fairly.
 
 All community leaders are obligated to respect the privacy and security of the
@@ -115,20 +126,13 @@ the community.
 
 ## Attribution
 
-This Code of Conduct is adapted from the [Contributor Covenant][homepage],
+This Code of Conduct is adapted from the Contributor Covenant,
 version 2.0, available at
-[https://www.contributor-covenant.org/version/2/0/code_of_conduct.html][v2.0].
+https://www.contributor-covenant.org/version/2/0/code_of_conduct.html.
 
-Community Impact Guidelines were inspired by 
-[Mozilla's code of conduct enforcement ladder][Mozilla CoC].
+Community Impact Guidelines were inspired by
+Mozilla's code of conduct enforcement ladder.
 
 For answers to common questions about this code of conduct, see the FAQ at
-[https://www.contributor-covenant.org/faq][FAQ]. Translations are available 
-at [https://www.contributor-covenant.org/translations][translations].
-
-[homepage]: https://www.contributor-covenant.org
-[v2.0]: https://www.contributor-covenant.org/version/2/0/code_of_conduct.html
-[Mozilla CoC]: https://github.com/mozilla/diversity
-[FAQ]: https://www.contributor-covenant.org/faq
-[translations]: https://www.contributor-covenant.org/translations
-
+https://www.contributor-covenant.org/faq. Translations are available
+at https://www.contributor-covenant.org/translations.

END DIFF

Ævar Arnfjörð Bjarmason (2):
  CoC: Update word-wrapping to match upstream
  CoC: update to version 2.0 + local changes

 CODE_OF_CONDUCT.md | 154 ++++++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 51 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

