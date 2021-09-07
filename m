Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CE4C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5503D6108E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbhIGMqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbhIGMqP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:46:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23452C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:45:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jg16so19440939ejc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sXhmQg3HT7boNaZYrmUVKKJOvw8N7mILSHdE89KxfWs=;
        b=EyFyQTZuSh0l0vuFyhw1BAOVFXFZVQsvDAVdISdtVdVeoOgTKQ7saD8BzHhiTZaK/w
         Jm3mn6+NBwJPYBEjkWkbjU9bXtbS+ocnO2MtvkKfJ22MhgCECG2Y+oaQ2KMEwDY9DIqY
         yo2H615NvqUoyzlQx/jp7bUADUxt1b5ORR0z1R+BhJpU8Qh/j3NHS+VlmEy6xUl+tkCL
         LlxUoRgoQy+WhUGXOMZhh+6QxyVBfaFG5e7qydjfiBgwQHJDKpsrxsVicM5ITrcyPjnk
         KdeHjJ6Cj9IJkXl1MGY9Uubsi9L1hL6rFu7GhKboJ4WN6/jP6zr6+xSJF6/S4ZDmh2IH
         2jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sXhmQg3HT7boNaZYrmUVKKJOvw8N7mILSHdE89KxfWs=;
        b=nt4sH8VIdLgW9MppLBcOncJ7P6zm4gNswu7VtnfZI2kHkLJozeciVxV0lyGxUNhdrM
         o/WFVByuwc4hD26M1PbJTl/xKRhkU2Jq8eL6gJUl5l84kaN3zsS7l9z9lb4Xpm5w8eBH
         etrJrO4eA7WGsAwKp1KiisCcNrdpbQJbh7qPhGUS/2LXnS4MRLkNSaI2FtD3gJhKDWru
         UB76WbQeeYRcapq6Sv3Af/0s8ligyac4HOpLNWYhi1dQOkZ1/C9f4tSH6+ti0tck9ODe
         YWvIJIgJicTCPC9sRsIGLg0ldWbqAlz3sAaP8AEMUaVp8BteUMJokphekMyHZfm8kI+a
         uzIA==
X-Gm-Message-State: AOAM533Z0NfAgVDgNgdl2VJvp6NUr81GI0tYsngJ/1xLprTqQJyIMrPf
        UIyTbTw8vXIEIjDMNoarBr5cn+Oke3Zfrw==
X-Google-Smtp-Source: ABdhPJwzJTA2XHtuTrONr2rMsBnrX/sF8fC6D+9F3IKpe0uRkQnYv33b5n65MR3XhlBS9LteN5TMxg==
X-Received: by 2002:a17:906:4f04:: with SMTP id t4mr18162324eju.568.1631018707451;
        Tue, 07 Sep 2021 05:45:07 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v13sm5444194ejx.72.2021.09.07.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:45:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 07/13] submodule: remove fetch_in_submodule shell function
Date:   Tue, 07 Sep 2021 14:44:27 +0200
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-8-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907115932.36068-8-raykar.ath@gmail.com>
Message-ID: <87sfyglfl9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Atharva Raykar wrote:

> This function has no more use in 'git-submodule.sh' after
> bd82d7d467 (submodule: move core cmd_update() logic to C, 2021-07-20),
> where we moved all of its uses to C, which has its own version for the
> same.

This commit ID appears to be a reference to your own 06/13, so the OID
won't work once this is merged to git.git.

Perhaps just squash this into 06/13 instead?
