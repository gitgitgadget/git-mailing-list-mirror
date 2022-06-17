Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C2C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 19:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbiFQTue (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbiFQTud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 15:50:33 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06733350
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 12:50:32 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id bq15-20020a056a000e0f00b00524c3c1a3cdso2418566pfb.17
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=W0vM+l05TQMxQ2KtvU43QKO1D3r/pNNP8WuZnUCQb3c=;
        b=o4JywUvp+kBlsDCLstoN7JWkRFHfVSQcsxLfe33i9Cr7zyJwvnMt917z5JKAnEPlDa
         bIAys5Sd4QJFOoQuErN+pu6bZGbnVXs38AvfDB9cTt7VMH26nb9PaLAEs+wEooa73Jls
         WOVXOh3uAyAdjFZHfHyiAMOI/k5HYRnoNIoZQtUV9Pfw30WTCoZXmEJv7AgVMTx4+Dyg
         SJUIOqkdYP1attZH73poQCkdlPrC39ibVYzRSP4nl1z3PZfkMAsEQaPODPG1U8BVrRJn
         vQ0eU5K0+vDz7UBYkW8mkG4/24xFzSO81rvInAreq8BdqmttDZnHgWF+fBRf3yC4H3ZQ
         JAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=W0vM+l05TQMxQ2KtvU43QKO1D3r/pNNP8WuZnUCQb3c=;
        b=zblYIRf1VP+u/qVNCN0LaRp3ZEQpd+mRfYqoiURUsne6Q/kpj9+vb+q5JrolFKOjO3
         tP6rKfS9r0G1r+P/QqA+1vOJPV+m/Vao6oMVvouLLG3TrROdvbvGarGnd2R7jpLMybrO
         OQowFEKGS1I3V08FaG7RU+Tfz43pr8JllMr4qJq79Uwvrby8ZJGA9Fhza3V2oOGSfde5
         /UndiI/2B/0rBGG2xBM3/qWFuK0Une0MYgEiq4tLVdLzZW4llr01PuI3PKZwXPcR9D9y
         Xa4JGzt8W9jzglEVx6wni2/lreAI358ArFg+f1jisTs48429XxOhl8tJXF/x+2yWhe6a
         I4zg==
X-Gm-Message-State: AJIora9E1pRuWmX/9ugHQtDLSAuv/ABX0WPbAk58n1UGz9qxhohaJ1CP
        gFTQ2X2xXLfpz4s8gHFjW5R6/B9MuXKPSilMZkCH
X-Google-Smtp-Source: AGRyM1s4Xj3x5WeFvqopIXrgHISRhA+rWBgywDwhhDjBa/mf0YrUBFi3hqWhoCiuLHorN6jg7tPIp3/Lu7XaIm/+Senm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:824a:0:b0:406:59b2:b5b4 with
 SMTP id w71-20020a63824a000000b0040659b2b5b4mr10613275pgd.190.1655495431889;
 Fri, 17 Jun 2022 12:50:31 -0700 (PDT)
Date:   Fri, 17 Jun 2022 12:50:27 -0700
In-Reply-To: <YqrTsbXbEjx0Pabn@coredump.intra.peff.net>
Message-Id: <20220617195028.2698928-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: Re: [PATCH] is_promisor_object(): walk promisor packs in pack-order
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Richard Oliver <roliver@roku.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Thu, Jun 16, 2022 at 02:07:41AM -0400, Jeff King wrote:
> 
> > Those rev-lists run in 1.7s and 224s respectively. Ouch!
> 
> Even though I expected the second one to be slow, I was shocked at just
> how slow it was. The patch below speeds it up by a factor of 2, and I
> think is worth applying separately, regardless of anything else being
> discussed in this thread.

Thanks for the patch and the benchmark. This makes sense to me.
