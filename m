Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B79C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FDF2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdLnL09Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgHQTtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732752AbgHQTsa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:48:30 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4816C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:30 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v18so9959028pjt.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vlWj6sQupVeeVpguHPyc2Sty872voTY0vnj6EGjV9OM=;
        b=tdLnL09Qh8qWN7uN9Z4/HutWl48paFw/7xPnagh00823+OUUxZhRnk5bqDmANLBX1N
         PYbAma8xmiPB2KhLNf8hTpRSwi4QPixZQQh2TfIu3a2Gx80vAEz2upYtoshQnw1tXz0C
         AueGX67By6yU2LT3ivI5nFEDMh9x0ki5weLMvzr1bgiMhNJD0SIonwMl9WtY1hfJ4YrB
         ORCUwvkqSEDa1EpPGV6yln0iJj0Egbk4nPwXtgGZaaUeqLezng+TbQ6sVsW8cT4fzs8X
         57qGdqdiLCN6/5G1oEwnFnop4F9CeqDf3h7VtY0KzImfkKYL9j16hSaMd+r8BlzIRQPd
         DZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vlWj6sQupVeeVpguHPyc2Sty872voTY0vnj6EGjV9OM=;
        b=dK2edcWSMelneXR222W8++Jwg353LXUhAkIREoOp+ZAxWZJ+b65Xukx1otKVv1BcTF
         5yLhM3wM7G58ZL/OjfCQUKRLCLqRUZi4GgN6rCDgsR1nvTYC3hkBgPwjwbserQt2J5xt
         LRhH1+xfLgwNVpj0JsKqhmaMz4Nvc78DHor8y5As8TQ9s3kpE3J6q7RrV/PaTVptQ0Wr
         2lsNGh3aKeSwV7RajVry78dc1ixjN3EJ4q980O68cj1m/AfQCjIDo/tQdIe26xnvCBtO
         fNGPFCLHzRfOjSozFQYjNIZ0GLr2mGYz2DQ6JL99llK0ofAIBG5L4617pmEHnWaXV0z8
         hfDQ==
X-Gm-Message-State: AOAM532LaHNkF0G0xNNZZO0yJwG4YrnDVpKw8j/p1WO8xvd9ZainzQ2Z
        1wX7Zz6xjIZz35PVLz80OAFXLgXthuw41gr77TwiT1EKZK/m85oRB0bhuurcxvjqT6diTdr2lsT
        HLLN774LrjbwdUV3vvvBumJTkX4Im92M8wD5vHJuWe5tiohOm4vya3Z9mrRP2FrC/yKAUfe466p
        V0
X-Google-Smtp-Source: ABdhPJzP4mYL/CRKJRdNFEhcJfO1L/TL+R6lZR09AA0visRPIfKL7MvMoN+4R99edVZ4y9nmTHaQBPCdBnknzg2oKJk9
X-Received: by 2002:a17:90a:aa8e:: with SMTP id l14mr14793140pjq.67.1597693708878;
 Mon, 17 Aug 2020 12:48:28 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:48:17 -0700
In-Reply-To: <20200814193234.3072139-1-jonathantanmy@google.com>
Message-Id: <cover.1597693540.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200814193234.3072139-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 0/3] make packfile URIs work with transfer.fsckobjects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio, for taking a look.

Differences from v1:

 - Added 2 patches that document parts that Junio mentioned were
   underdocumented [1]. I'm not sure about only_packfile, since it's
   narrowly scoped (just an argument in a static function) but I've
   included it anyway.
 - Used <<-EOF instead of <<EOF.

[1] https://lore.kernel.org/git/xmqq8sehvw13.fsf@gitster.c.googlers.com/

Jonathan Tan (3):
  (various): document from_promisor parameter
  fetch-pack: document only_packfile in get_pack()
  fetch-pack: make packfile URIs work with transfer.fsckobjects

 fetch-pack.c           |  6 ++++-
 fetch-pack.h           |  8 +++++++
 remote-curl.c          |  3 +++
 t/t5702-protocol-v2.sh | 53 ++++++++++++++++++++++++++++++++++++++++++
 transport.h            |  3 +++
 5 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.28.0.220.ged08abb693-goog

