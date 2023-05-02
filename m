Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BAC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjEBPv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjEBPvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:51:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279F35A9
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:51:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24e01ba9e03so1757871a91.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683042678; x=1685634678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAUe6Z0aP/bdHf5O107LHPsXsr9y2nyNnCuCDO7tZ9c=;
        b=OpdzjQFh8bCxDMWB+/qHsltgzm6joaiWbzRa9cDH75xveyK4trwo0raXkpklF1c9wo
         JIDxMX4GwvxfR7pfIb0SN1Hg7d3DbOtCYt2yqlMsFoHuit+jeZfap8cNECUSilYxD7v3
         XesM1IzN39kpZJY8gvF7LpJHPJ1pO/mczBEfDkk+Kkg9HTsMEAOgzdaDaoFX5ThmWfdW
         Y9gGXpxR6sz07i0UoqUQG/UAJOHy8e6WBvgpC4dfHw7Vx3VxgPa95OH5+6DjpXIJ8C2g
         1luEflsTFQO0UNnXQJbAVPfy2PUD4lJ+O8HGUFC+6VJL6mkuf0UkIewn0u4APqlSeBCL
         A9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042678; x=1685634678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAUe6Z0aP/bdHf5O107LHPsXsr9y2nyNnCuCDO7tZ9c=;
        b=PzU6vPzo9hD7Sg3Ay0GVXNfnUbEoZWv/EE81j0ioYbwApQxwcZaIAIVs59HAg9DAYI
         z5uwouanWCgzT2FYAIGoWdGk0sfWXVqPFPjjbpvlyhAy1YNbNR9aPD+awtw/+MansiE4
         NHHqNJ3gUQYKCpsJOyA+RLiS+jh6EJ4PQXXNqaggT9x9+fwRvAE+XBvnCunj8OIgSUEy
         08HRqR/a3JGlSfeG3rsreyrtsh4Rx1k+XJb3M0tN4mLATZTv5M3CI33g57nQ8BwuexbV
         GOEDYVxazaI7sR6wlAJSN6Yev/xuSRV0WuXbp9EzEgv8hoiau06Wp3ufbXrduBeOibkd
         3NiQ==
X-Gm-Message-State: AC+VfDyznZHu0MlN+wZLL2Et0dd7byMDlU+DtUr4YVqk6i3p6KjLwYFZ
        lrnTz/mjH5BE0aUUWfQ6EzoQqH4Q+LA=
X-Google-Smtp-Source: ACHHUZ5Blu2QbXr3Nl/irqqPahGz55tMvA+yddZS0QytvRxZyuvcWjiTf4HfhyNrjN04zi44U0SJWw==
X-Received: by 2002:a17:90a:644b:b0:246:5f9e:e4cf with SMTP id y11-20020a17090a644b00b002465f9ee4cfmr18138972pjm.43.1683042677591;
        Tue, 02 May 2023 08:51:17 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b001ab0aec388bsm1645606plg.135.2023.05.02.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:51:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Han Xin <hanxin.hx@bytedance.com>, git@vger.kernel.org,
        xingxin.xx@bytedance.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 0/2] negotiator/default: avoid stack overflow
References: <cover.1682473718.git.hanxin.hx@bytedance.com>
        <cover.1682513384.git.hanxin.hx@bytedance.com>
        <xmqqildb3dnn.fsf@gitster.g>
        <9ad5f246-e21f-0a13-1a53-1ae3307c3f0e@github.com>
Date:   Tue, 02 May 2023 08:51:16 -0700
In-Reply-To: <9ad5f246-e21f-0a13-1a53-1ae3307c3f0e@github.com> (Derrick
        Stolee's message of "Mon, 1 May 2023 21:49:14 -0400")
Message-ID: <xmqqv8ha20ln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> Changes since v2:
>>> * Rewrite the commit link in the typical format.
>>> * Fix the incorrect check for the COMMON bit introduced in v2.
>> 
>> I see Derrick pointed out a logic error during the review of v2 and
>> this round corrects it.  Is everybody happy with this iteration and
>> considers it safe to merge it to 'next'?
>
> Sorry for the lack of confirmation on that. I do think the v3
> patches are good (the cover letter says v2).

Thanks.  Will mark the topic for 'next', then.
