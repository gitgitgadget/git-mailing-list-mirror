Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC928C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9F060724
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbhIGMrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbhIGMru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:47:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:46:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so19445215ejb.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BLlI0/OjMoAJ/C4ynIt9eb9u/odyufT7F7H9HNemG0k=;
        b=FiJbWHbAg0TWvL77+jLbcI5RgnCglSPhyCt6L+2/yaFbVZ6hSlmB0vRN2FK62d1zzk
         tUG0aIqGtT66UaTzm6+TnsR1z+w6K/frqHX3c6FpNXt5i6x3wtIp3Lnwz7pEtgqJ1VHE
         Ncxo70LgO7pPf4xgTevHHtrmc4Sf17Id1HE6573nD3tLFCBEn3KZQEtG4RKgaJuDnKyy
         TFyYFyhNWQ8xMbvpzfx5thYQYKIYUuM6qRTOc7Q6cM0RLN66XGIUEvGUVhVmh8ze/6x/
         R2LMn28uiaavRyMa7XYrfZZU5Pdd9Tqo/ckT16LDXJPzOqHAfce6x5+KqSL9xa4MbwiR
         Vd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BLlI0/OjMoAJ/C4ynIt9eb9u/odyufT7F7H9HNemG0k=;
        b=im4IgBbWrCNZZjqW6VWb/TIXRSXkovjc0yiOa2m59SwP8ihcdXanNftZEOJK3ELC4r
         aLYRbrxc65A5Rj9M+VzywpQcqxFjWBJvewtTlIqoXz3LMWnsJ6exglzf0snFNHNBEjn7
         HYqQEEvrsRG4QX9p4jsdJf+CUWrQCcs2SDzXnrGoXWZo74hElzbID07LVx3Kmlm60rL6
         ss91s2MZPjdYLhgAJOXBMdTZcaTUmYNaKtCcBqh0TNN84qQctcWeEBwx0imI4qJfOuur
         ZweS3QHwkeUUsMtCU9GgVV1gWjbIUUBtkvCmPBrMJapVVAMVzvEllAYcHDIDNCbbhHrr
         hV0g==
X-Gm-Message-State: AOAM531oCQ381jQGgRQ8lxIomld+9x1ZvCXzR1DgvHQZwQdXAFE9A6LK
        o3rPTmSKlIwg3iE4yqmUbVV2p8MUPwY3GA==
X-Google-Smtp-Source: ABdhPJzQZC/mUVYmyS/yMr1eT7RLzSSTixI9s2o4COv0ISHAXmrzrAoG3GdNY3ppWOUOhwcq497m7A==
X-Received: by 2002:a17:906:c055:: with SMTP id bm21mr18591279ejb.350.1631018802823;
        Tue, 07 Sep 2021 05:46:42 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cz15sm3104339edb.50.2021.09.07.05.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:46:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 08/13] submodule--helper: remove update-clone subcommand
Date:   Tue, 07 Sep 2021 14:46:10 +0200
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-9-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907115932.36068-9-raykar.ath@gmail.com>
Message-ID: <87o894lfim.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Atharva Raykar wrote:

> We no longer need this subcommand as the shell version calls the
> 'update' subcommand instead, which does all the cloning within C itself.
>
> We also no longer need the 'update_clone_submodules()' and
> 'update_clone_submodule()' functions, so we remove those as well.

So in 04/13 update_clone_submodules() was renamed, but now we're getting
rid of it. Maybe there's not an easy way to avoid this churn, but if there is...
