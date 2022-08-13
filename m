Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0413FC00140
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 02:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiHMCfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 22:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMCfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 22:35:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F01EECB
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 19:35:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kb8so4790412ejc.4
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uZj0MedhNGj9GzZl3ovBz2Af2l7Z44smo8otGNBDF9w=;
        b=jr9xFMvB9BKF1TtLHiOn/quuTwtOUuU/YLhBZI5RMxWfHq8CGNA84AxI9BdEZi0ovZ
         foZ/6doze2jpFdryToWduMVoahMO8ckTLetQrZoIawJx4vDcg6/n85aBO26FdB1K2et2
         pubG/8NxrTBRFiJPUavX1D7NTErC4zj/O+aRB29oycFD2KJ/KbHB50ensiaRbvWEI/0g
         TIhsTBBuCXfTNp+e6MCo9mGHyMQguu9DO4KgvNu801XWxb0wyS2XTw7acnNK//59DKpX
         /jgSA9drmb/IiAoj4DSO945q/jKEcF1vGEGpRqB9WJtP0gARNb9+WhuLioAu5eoNhnt/
         GN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uZj0MedhNGj9GzZl3ovBz2Af2l7Z44smo8otGNBDF9w=;
        b=MxTFPAlEy4v2Ib6qJlj4GHSfyTiT957AdQtph1uzDIl890l5Kk71YGHPvFHRRxgLk4
         h2gZVqGnhWqEbnMkgmd0uhmpnXuEtBMnCo4EqbbVKT8fld63QmrLgq8d2F9sdmbvabAr
         AxjR3UPsuzsCcc1RoQgBzSj97dUulhUXcPEal3FPSFBwnM9FSVN2bvjxNIdljddUkWVR
         DMLMnXoGxKF25JHuqmpQUAPE5Q1I9WvsE2LXCzTdNN93PIE+7ZQqyC+yAwcxsHBeQV7u
         i+MoDDQxP/bv2Xws86BKykbcKeRsQnkB+SybLV6DnNizI+wFlFvy7gVLBjX87VvB5N15
         fHCQ==
X-Gm-Message-State: ACgBeo2yP4hV4boXx0Cj00tfWFFtF49QbIHvcDkqUr+WuldIKrnsYaWQ
        moEeATTh4Ks75tStLIkTF+jPYCXSoDzm+JS1VawQ04Ym
X-Google-Smtp-Source: AA6agR54OXRwPqgcynUwdk2yiidm7SoQmNa37WUQy6Y2NglnjGGqX9N5XptlF8Xil/RnZVpUjJNKTrplYoDa/QJlI8o=
X-Received: by 2002:a17:907:7389:b0:732:fc99:cf6a with SMTP id
 er9-20020a170907738900b00732fc99cf6amr4232379ejc.335.1660358148417; Fri, 12
 Aug 2022 19:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20d7c54f-7438-1124-7a9e-fdc902a4cc18@intel.com>
In-Reply-To: <20d7c54f-7438-1124-7a9e-fdc902a4cc18@intel.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 12 Aug 2022 19:35:37 -0700
Message-ID: <CAPx1GveLZm0NH7hBqRSKHJMXttT8Wwnqm3ebjUEpbEXNwh+61w@mail.gmail.com>
Subject: Re: [Question]: Does "git log" involve some stochastic operations?
To:     "Wang, Lei" <lei4.wang@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2022 at 7:11 PM Wang, Lei <lei4.wang@intel.com> wrote:
>  > git log --numstat --since="2022-06-01" --until="2022-06-21"
> --no-merges --format=%n%n%s%n%H%n%cs%n%an\<%ae
>
> The number of the commits in the output is slightly different. I didn't
> do any sync operation in the repo, so the only reason I can found is
> that maybe git log involves some stochastic operations, so each time the
> output will be a little changed. Is my assumption right?

The `--since` and `--until` date values use the *current time* if you do
not specify an exact time.  For instance, "yesterday" means "precisely
24 hours ago" (86400 seconds ago), and "--since 2022-06-01" means
"since 1 June 2022 at whatever time of day it is right now".  If you want
commits with timestamps that are since *midnight* on that day, include
the midnight part in the date.

(This is probably a UX bug, of sorts: to mean "at now-oclock on a given
date" we should probably have a syntax like "2022-06-21:(now)" and
when a specific date is given, the default should be midnight for "since"
and 23:59:59 for "until", or 23:59:60 if that's a leap-second date.  But
changing this is probably not in the cards.)

Chris
