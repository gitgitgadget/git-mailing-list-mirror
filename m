Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD3BEB64D9
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 06:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFSGIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 02:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFSGIX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 02:08:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F983
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 23:08:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b52fd56b7aso9879445ad.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687154902; x=1689746902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3Jgy2h5IaNcgHb2b1PI3g4et3zsFXTrQuUVJIBpoIc=;
        b=ls3tN1uPjN8Rt7YHuTubU5NIKXd894HffvvDGZzwmPugO7FymXviUNujQVSRCAX2HC
         YpB2T918lMqbYaMScnGUCVOiXmzmWBFW2ok84jsASE4d4QTLpDd6gVFWmb13fCvxMTgJ
         mtVTiZtuzsy3jxotNUf4exgV2MsL/FMCV7Nzv/3klr7sSg6+L+fK8IIm3yetbEVhzEE0
         nSCfOJvI+y+EQB/BSFu0YXmnJTK4SdDGbhLLqmBLwPHdKJCMwx5MBni5fPOQwX559WfK
         siPmM1o6RjvvQIygAH7N3attWi8NjZ8E1wyinQ84ZtNqSe+RMffn4YfJqV44tzS6ZR7Q
         sfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687154902; x=1689746902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3Jgy2h5IaNcgHb2b1PI3g4et3zsFXTrQuUVJIBpoIc=;
        b=V14PL6V2/5ISHM9dATTAXX+FesEIH21omKydc9Ynm6U2tHe6fDYnXuWfjtOZtwHjcz
         Hleci79jPiaWaJZPuq8kgldN0zX9blUEKGE+II09xiyJmEQuJPjzSyTu780Ir1Ns7P/8
         LkvhvBe1PK8FSdurywnF83lah9YQu9cSBU/X/EBZcPX21YwIpcAo1J9VNCD6bR3mGqnX
         LdasdjjKoqqqcZAoiMVtZiN+pSbtSpniDhWgJcug7e+rMJXm6k7PgTRjuFND0S1T7ZrC
         WjvF/iUc/0vOXrwNjEg6o2KqqKvc8xQoz1renxfry9SVZwWF1uLXF1/NXDZnnI+I/mpz
         6yNg==
X-Gm-Message-State: AC+VfDyebEncx6iXmFPvM7NlWM8LO/Ij8sNKR0HXotf5gtAiCju7dBvt
        4NydbbRnjkUYDWiOVYBSdhs=
X-Google-Smtp-Source: ACHHUZ5vJZRm3HPJlVsGIUbed3+FVRGmqlm4uNg4pyZr3YW82p/EkFMPuGKb0PFwHa5buxwlWuyoaw==
X-Received: by 2002:a17:903:124e:b0:1b1:dfbd:a18c with SMTP id u14-20020a170903124e00b001b1dfbda18cmr5245698plh.39.1687154901778;
        Sun, 18 Jun 2023 23:08:21 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id jb22-20020a170903259600b001ab2592ed33sm404177plb.171.2023.06.18.23.08.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2023 23:08:21 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        peff@peff.net, sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Mon, 19 Jun 2023 14:08:15 +0800
Message-ID: <20230619060815.2291-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.dirty
In-Reply-To: <xmqqmt10v8nl.fsf@gitster.g>
References: <xmqqmt10v8nl.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> 
> > I was not following the topic closely, but I think there is a v10 of
> > this series anyway, so you may want to eject it from 'next' in the
> > meantime (I had assumed you were going to do so as part of the
> > post-release rewind, but it looks like that happened already and it got
> > re-merged).
> 
> I can do the post-release rewind again ;-)
> 
> I somehow had an impression that the topic was more or less done,
> but if it deserves another chance, let's give it one.
> 
> Thanks.

I have been on vacation for the last two weeks, sorry for not
replying in time.

I think that is :

  time-1: v9 was in next, actually v9 [4/6] will break the CI, but
          [5/6] fix it so the CI passed on the whole patchset.
  time-2: then v10 was tought a new `--no-separator ` mainly
          On the release point, v10 implicitly fixed the problem
          in v9 [4/6]
  time-3: 2.41 release work begin
  time-4: Peff found that the v9 [4/6] merged in next would break
          CI and a UBSan problem.
  time-5: I wanted to make a full reroll to fix the UBSan problem,
          by the way, separate the "--no-separator" to a single
          commit, because I thought it cannot catch the last bus
          on 2.41 maybe.

I think we are now in a new cycle, maybe we could rewind and use
v11 directlly? Sorry that it may have brought on extra work.

Thanks.
