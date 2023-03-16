Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCABC74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 22:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCPWXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 18:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCPWXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 18:23:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E1B8544
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:22:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l84-20020a252557000000b00b61b96282a4so1374562ybl.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679005323;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmceiWiTOAnD6dKaxW14PFwmb0hW8xX27Yy7g6cZUeA=;
        b=PgsskQIVI45AgYmk8g5Msg42n8YpL5tdL+IG2Q70ZlGNBzLeOtWejvM/1lpf7gjT9z
         VJP9URYAlcNPGreSp3mR0+Sji0hruh6qA6i55xHhMmDOYLFdpr3jzoMsFhd5l7LLn0yW
         qVfDg3LjN4RSD0GE0BENP9TgLWYeOAj5TI2K1ZnE+2BrPXme+yXnmDGei39hXyuvpX2/
         QLsovQxu/TFtwowthVCisKegiMyJIgcNO6oDlYJ6GluGxzqo2tRyoG15pr5dskJUcFNA
         OzUyIgwK1jKAEo7/8ijiWyfF6egAX8h0Mm4n72E9OAxFzOd6hlO21dpaIFSAgW9gk9V1
         XmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679005323;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmceiWiTOAnD6dKaxW14PFwmb0hW8xX27Yy7g6cZUeA=;
        b=C0+Jc7bzfSs/NpIUlfYk/+4n+VgTPcWpawJKTk7I8w+kpCgUjX8Lr7vKuN0m7oRzcy
         qivqps7CP2LPxdPet0ZjsAOS2Qu/C0/8BKlp3E012368h7tfZr7/mjPdSE9+laDoR00J
         zq6y+RN1g3i7O3pBTkcz0mBaaHltvHakjgOgQHftmGUMOUXk1rd2e/S7ks07lDheinHm
         hRbrj4678GtPdmq4czY1Ql6DG8f7lFOMkTsmf36R/wuGM7gMNfHN4Tz1dm7dxkJZrn9K
         EYJERRLeCXwvm2/lZCG7aDSmipoxfZA6dQ6IeDqPdiwFCG2D6JjHBdiUai8U8eNZsDAg
         RsGA==
X-Gm-Message-State: AO0yUKXR+sTsIyWBAFg3e8QfSEjc1ILsL0KXksy7g4Uk34RSK8M3ON9q
        iPa3+pNR3FywK6BlFBWkuoDQL5z9IMW6RdAC8xVk
X-Google-Smtp-Source: AK7set/MpbLiCvPHnjTm0fajvZVPyOVKxYfHHjsJKkBOeMyzN2tayC7NndNjihIu3M/lWKY99BUgHmWA3qIyT7BobKwH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9170:84f8:2856:fe19])
 (user=jonathantanmy job=sendgmr) by 2002:a25:f50e:0:b0:b26:81e1:f928 with
 SMTP id a14-20020a25f50e000000b00b2681e1f928mr17503635ybe.1.1679005323618;
 Thu, 16 Mar 2023 15:22:03 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:22:00 -0700
In-Reply-To: <3c83d9535a037653c7de2d462a4df3a3c43a9308.1678925506.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316222200.320596-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 7/8] config: report cached filenames in die_bad_number()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, thanks for spotting this bug! It is a minor one, but this now makes
me think that we should definitely do this refactoring of a struct
containing all the relevant config state and passing it to functions as
much as possible (as opposed to merely leaning towards the idea).

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Fix this by refactoring the current_config_* functions into variants
> that don't BUG() when we aren't reading config, and using the resulting
> functions in die_bad_number(). Refactoring is needed because "git config
> --get[-regexp] --type=int" parses the int value _after_ parsing the
> config file, which will run into the BUG().

You say "fix this", but are there actually 2 bugs (so, "fix these")?
Firstly, that BUG() is run into when invoking "git config" the way
you describe, and secondly, die_bad_number() only reading cf and not
checking kvi to see if anything's there. (I'm not sure how to reproduce
the latter, though.)

> Also, plumb "struct config_reader" into the new functions. This isn't
> necessary per se, but this generalizes better, so it might help us avoid
> yet another refactor.

Hmm...I thought this would be desired because we don't want the_reader
to be used from non-public functions anyway, so we can just state
that that is the reason (and not worry about using future refactors as
a justification).

The code itself looks good.
