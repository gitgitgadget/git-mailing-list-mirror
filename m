Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75511C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470DF60F12
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhIDRvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 13:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhIDRvp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 13:51:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0878C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 10:50:43 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g14so3912384ljk.5
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ80arC3KTmJHJxgKkOjiZomgOZUYrI1fyaTHsw3GL4=;
        b=ptUE8yqqI1nEVk1OTCNisgDQnf3e4TTNqwGvkrsvla6MiSXZhpVcYz2s+PwObX8shY
         Zu6456FxTwwT/gE7EY77tf9/IbZXP+oVc7AlUEARcHeazyChvBjoByrNQ8lrKXW3W8N3
         LHpr4d0wvU6AQsDygfS9uUYTtLsSoqOD2NvZQsNGUU1Emq86FmPlcO7XdfkRrV6SLQ1i
         mLYb2IhihLrSYtymwjlKEdhIIAv1ZjAAaE9GhlmaPyNbrMmCLqFtqqPFzpETNVIUl0A2
         5cgZcPB+J5kMrKGC5q+JR8fERXr4BLa/frT5+OjiUw1AeBbhAw014LrzTtMoQkCzlPAX
         V7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ80arC3KTmJHJxgKkOjiZomgOZUYrI1fyaTHsw3GL4=;
        b=RxEBqwAuB6Ia/UPrXlulZkCqZjoXWNA0azlV0ENXLOuqFgYOnjZ8Cw89pYA94POeZO
         BFjUN7m3ObfErURFA+v/B2BRuuheIei5R1zfplpqPZaqyWQn2JwohlogJQRjs4j9C+25
         X5afLTnD38kjJFnJLDqls+C+EuFX42qbYecPzXtZ5sSjVGGAI28JZiC7d4wR3VXHZpvi
         Ouikf6lvLp0+54JeU1At4O5hKSI3pjfmQpIn/boy4S5G76+u05O5ncIfesb8Ntj0XIv4
         or3tr4SfDPHQ64LvRcSea4skjLVtwWqkVOeS+ZSgCWN7XG+a7Uux1Kggm6Lrp+nWY1GI
         hAZQ==
X-Gm-Message-State: AOAM532TFJLlSXjqaePrcloif39B6tqusldbAKybEFwzdxj9PSQ+cJzF
        vG+0VqdeaI4cKzI9uPkfGsLoy/l+N+cHoDonNpoDYQ==
X-Google-Smtp-Source: ABdhPJwpJbjSB3RuYKMnIbTuvARpCHKUZIBcP7ewIAiVYZoSkQVCUm53mdJ5mVTUGt0RdgTAe3AKfoYAFxMQmkQYZiA=
X-Received: by 2002:a2e:b0ee:: with SMTP id h14mr3516477ljl.297.1630777841713;
 Sat, 04 Sep 2021 10:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210616004508.87186-1-emilyshaffer@google.com> <20210819200953.2105230-1-emilyshaffer@google.com>
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 4 Sep 2021 14:50:30 -0300
Message-ID: <CAHd-oW6Ko2s7uXZDbEBHpVhjNiXNcR74DriA-V=9cfOcN6bjFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] cache parent project's gitdir in submodules
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git <git@vger.kernel.org>, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Emily

On Thu, Aug 19, 2021 at 5:10 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> Emily Shaffer (4):
>   t7400-submodule-basic: modernize inspect() helper
>   introduce submodule.superprojectGitDir record
>   submodule: record superproject gitdir during absorbgitdirs
>   submodule: record superproject gitdir during 'update'

I left a few comments on patches 2 and 3. They are mostly about things
we have already discussed on the Review Club, but I got the chance to
experiment with the code a bit more after that, and I thought it could
be helpful to provide these inline suggestions. Hope it helps, and
thanks for the series!

Thanks,
Matheus
