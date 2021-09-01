Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07209C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A5360FC0
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhIANHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346575AbhIANHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:07:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12FC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 05:54:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r7so3653213edd.6
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUlj+AD5rrddEQxQUQde0n4CpW4+k+uYo7AUMr0Z/jA=;
        b=VQgEcBmQfjzwsX17kMBR/T//udOHK8NjFv5LmVJ8hiuwdMj97Rdm3boaRuvO44D7qr
         Ga6NxIkskEpV8GFK+/nZDc6T+D1u4NtZfTP/Jugca8CWRx0PQvLlmGcJrUMGs125y2X2
         rDqb2bbRD5iT3/TnATD0pwC2mtejB4vhbjRrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUlj+AD5rrddEQxQUQde0n4CpW4+k+uYo7AUMr0Z/jA=;
        b=Ajv4YNW4FpibxVlp10zDXlO0xviiQm1vIsZirKyVSjKfeWarFlERbe0BTmsmnBsJXT
         wX89kpIHPvbFiY/anA82dtyLInX9a8FM4lDEjUhO+MqWvH6cawRs/+zOtPxqtDZ9fGj3
         8bOgfqIPWY3RdvSTEogWGZXGF+knGz/ahysVgVeSPV+xt694TQSJX6ResFexbM+UeJ1A
         v5jyw12VMGpS0C99AJVzHY6OFZ9sY2OPAb8gFHPMOYhB4A5TY2TB0+iS5ysWgjUKF1rK
         g6R1kUDyobnWK9/VLoFYR5NMqMd92TJB5yyLnCSZBvP7sd59CJPEZteo4Ge3eTJ4fVrL
         hbLw==
X-Gm-Message-State: AOAM530uwS4OSw2pD8dYv0drH2ZyWeYrJecaHqtqszLPD/2Of4+fyhGD
        rKtSRSxE4LsGlAdS4wtRkvr5su66mdtn8g==
X-Google-Smtp-Source: ABdhPJwhB1KUM+upFJPOFCYNqD4KXIfCFVblmwg3IoiwA3ROsQigsrepIH9gI3QMRTK3MbJzJ60dwQ==
X-Received: by 2002:a50:eacc:: with SMTP id u12mr27596287edp.140.1630500897404;
        Wed, 01 Sep 2021 05:54:57 -0700 (PDT)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id r8sm723207eds.39.2021.09.01.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 05:54:57 -0700 (PDT)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        git@vger.kernel.org, ps@pks.im
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH v4 0/2] send_ref buffering
Date:   Wed,  1 Sep 2021 14:54:40 +0200
Message-Id: <20210901125442.34446-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <xmqqy28htrc6.fsf@gitster.g>
References: <xmqqy28htrc6.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes:
- pkt-line.h comment
- fwrite argument order

Jacob Vosmaer (2):
  pkt-line: add stdio packet write functions
  upload-pack: use stdio in send_ref callbacks

 cache.h        |  2 ++
 ls-refs.c      |  4 ++--
 pkt-line.c     | 37 +++++++++++++++++++++++++++++++++++++
 pkt-line.h     | 11 +++++++++++
 upload-pack.c  | 11 ++++++++---
 write-or-die.c | 12 ++++++++++++
 6 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.32.0

