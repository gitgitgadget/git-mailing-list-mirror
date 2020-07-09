Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350C3C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B86206F6
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5ApMnFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGICQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgGICQx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:16:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364AC08C5CE
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 19:16:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j4so596439wrp.10
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Awr4aT+SbJtVzKY6f6/71JCvlB0BbqV5DvbvHwhzmM4=;
        b=M5ApMnFH6q2TvAr8pfOiXrZEEdqt5WAgkXQij1EkBRTIW9QPzYrMkR/EEUV68E8fHc
         VwoWoQCj+U0z1uKEJ548d0M8p8/pjwt9CCv0m91KYCqj1mNievR64DP4j3m8DElevnPr
         i1qwbubPORTildoDjCYp1oS7XGEOIusmyN9KDk6q2gBfO3xVcOuH+dAAWiqGWf98uDim
         oudGI6GbRzI9qpNUGJ5SYNHxS25th2BraKKuDzOD/iRqwKad4HWrqXIOiRatCPsxG1SX
         7HHZKq/cT2Ai0vHFbyFMS1KYkiUwNFgPUTdrgg+/XyIUhgvXTYvRpVaJ+m1YY/E/eo65
         Qeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Awr4aT+SbJtVzKY6f6/71JCvlB0BbqV5DvbvHwhzmM4=;
        b=GcteUS1iOEgUoqO2MlF+/ijI1ZS9ec4G+SE7HMnMaRr2RnwhjruHBAwXuN8ZwMvim3
         XBkPMi+AKhFYy0DYpGGGuD/Y7U3W6a1yGLduBfmWh0Ob742e9eQ2SI/1p+p+FtRYwaHb
         FX+btt2iWRlOb9yUFwW9XA5HZW8QsxtDguAGkmec66zCLPt/h80j88FzFor1yw0AZl+Y
         jYCwRQKnfqJi3JW+NjrIVMa57WsHGk7TNGTXNIOxKQdSs4HR4tobzH+dcNeC8I12pgGn
         rgwgkDqVJxexxH/CZO2Eh3aC1z4fjgn5x7BLtdFnTbEafa+I29lBjRB8n8zYU5tH07cg
         vE0g==
X-Gm-Message-State: AOAM531LcMKTJn01X/2q7+HSFDlUK5ysjPU+7MmzasMzWKguLoCrGpb7
        SF41Hc3ezXwVA/WmPjCj9RZ+GLLm
X-Google-Smtp-Source: ABdhPJwFFpSveYEPb27FGGhmtCn6TfIFaOTx0vutg9uE49KMnSenHViJq8D2rFWIalbM3xrGw91O7Q==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr60836508wrw.300.1594261011297;
        Wed, 08 Jul 2020 19:16:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm2981855wrt.55.2020.07.08.19.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:16:50 -0700 (PDT)
Message-Id: <3c573695a804c2103e69a2760fa28e4aa67f9f4b.1594261008.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
References: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
        <pull.590.v3.git.1594261008.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Jul 2020 02:16:44 +0000
Subject: [PATCH v3 2/6] revisions.txt: describe 'rev1 rev2 ...' meaning for
 ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The "Specifying ranges" section does not mention explicitly that
several commits can be specified to form a range.

Add a mention to that effect.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/revisions.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 1ad95065c1..d9169c062e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -254,6 +254,9 @@ specifying a single revision, using the notation described in the
 previous section, means the set of commits `reachable` from the given
 commit.
 
+Specifying several revisions means the set of commits reachable from
+any of the given commits.
+
 A commit's reachable set is the commit itself and the commits in
 its ancestry chain.
 
-- 
gitgitgadget

