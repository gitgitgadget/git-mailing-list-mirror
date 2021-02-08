Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7A4C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B83E64E92
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbhBHTio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhBHTh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:37:26 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED8C061793
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:36:46 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id h8so5423733qkk.6
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6gO2cgS8ewDRHfbdaPfAQttov8KIwwliJd3apWplbc=;
        b=iMEptez18aEDEN+KrjorQ53G1RbWx6F2oiHcZK/XqqCAcYc43GIfOpOFLCLIbg0Gg3
         +CYHH8JSPg/rb4F4D69yrWWw8INcuh/0tv6lSfwNDLJZnhka+pYgAhKWbK8A4L5OHYDh
         Y8YthzRsYqPCELxU4wDd4z4F7qrZFsO+GBq5He97/FxAfk7ZUQzxA0DFrRXAYn5FSvgE
         V+e9GOSD1a9MyYVdWVqRk3F9l4xe2Lc7KgnHgnLoajRkc49HPoFoH6sPv7gBYwususHK
         VCYNn1ZnLZzccpJzRaR9oTOnuymIHagPYv5eSNS5ABTTLrG191xrxwt9W9QdZRMH7PbX
         YNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6gO2cgS8ewDRHfbdaPfAQttov8KIwwliJd3apWplbc=;
        b=r/I4o6qpYnw1L73+sRXLSL04P5/vM00BMASO5krdlSvz3lICjm9zoieeQmQqMybVuV
         uZb8AOFAqa+MS4wgpeThUWF3mrOjrShWXsg9XAm95UUr3UeF04KP+CIDRE2i33Es+Gfi
         QNUj5PrxJJZRYsWNon/52dmxdhqPr+Ztl75KHir1EFr2enBwFtvmrID5nwqJFV+McP6n
         Ahlzc1D5XSUISKAV7iFgU+I3+dOixUpLdqxfvZyrOyoWohOpa+ZmYZtBZdVH92eHPMsX
         1cvUYOjcH/W6IxHSN6DwHZ/ccZF0jk7KcAQNOB+bwZetFpbNTrmyIuSPyAsoxEXT8SPQ
         QtCg==
X-Gm-Message-State: AOAM533WuD6af83Px/9ff2hY1oP5Dl8XEgTyZ/rs65wUW6H/3QugCnFv
        0rgXVlIla1UwgSE5NVZnmnvoTJOk5JEx9Q==
X-Google-Smtp-Source: ABdhPJzazE6xeoucDekrNKGkAdSNdjIU9nDgcMuMO1HF6Iu1x1TqMQt1+YJnrAgnTjm3dOz/c5sfhw==
X-Received: by 2002:a05:620a:1477:: with SMTP id j23mr18107236qkl.462.1612813005074;
        Mon, 08 Feb 2021 11:36:45 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h6sm15143808qtx.39.2021.02.08.11.36.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:36:43 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] checkout-index: some cleanups to --temp and --prefix outputs
Date:   Mon,  8 Feb 2021 16:36:30 -0300
Message-Id: <cover.1612812581.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are some minor cleanups to the checkout-index output when using
--temp or --prefix. The first patch fixes a few wrong uses of `path` in
write_entry() when it should be `ce->name`, and the second patch removes
malformed entries from the --temp output list.

Matheus Tavares (2):
  write_entry(): fix misuses of `path` in error messages
  checkout-index: omit entries with no tempname from --temp output

 builtin/checkout-index.c | 39 ++++++++++++++++++++++++++-------------
 entry.c                  |  8 ++++----
 2 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.29.2

