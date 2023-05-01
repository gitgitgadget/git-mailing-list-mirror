Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCE4C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 22:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjEAWTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 18:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEAWTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 18:19:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A54EC
        for <git@vger.kernel.org>; Mon,  1 May 2023 15:19:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24782fdb652so2103267a91.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682979541; x=1685571541;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=walX/U/8EyMdKqsr+yvttpGeTNIcTCxAu+hXQRlKhKw=;
        b=p7l5SNBg8U1Dr66TSvL47j8q2OQTRWfCmcyW2/1sJLxk7Bv9WEA1X6YBLNQLCoWiys
         96nzgPPP631rLx1siQinsTimeMyUmR4GTf/8K2t8aLa5/brTdDlExK7ll1auSiUZc3pi
         ql46W05m5PfJzZEnVmUS45SXFfxgdMvChrOxt8DZncGNO4BCPQI0qBp688pH0iOmVkFa
         qwwgskKPejpzQqfuXONaj9LlMrwYzfMKjjrg0BqDls6FsikWtmcta35QxeKPqJdeffdc
         W3Pf+QEyQa/qCArX688zZvcAvkpj3gwJe83sjihGJie62ZjF7dSs5B3JngJ7C+ViPii9
         ndKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682979541; x=1685571541;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=walX/U/8EyMdKqsr+yvttpGeTNIcTCxAu+hXQRlKhKw=;
        b=grwctm2YLkX7A0Oj6dewHUUgVOy/W+b77LdWq8Y9TpeM4xfMGI1holXms6pe9xj3+5
         ONXPyCTHWlBwkyzrcnhLnBlXsDUe9sGTqPe3c0EfC2Ce6zZAv3xb1FwueS1D3ucliZlf
         cUdwDMQsMhLUNRUI2J3zP8rBXQllKfqxvGbEpxNgrE+zd44tpYx3ewxmOphpcOANzJag
         7iko0i+TPTZfcPuZt29YF0F3YA5579LxF8Z48he2BsofVWR3ee1JMsYl21lK4RjUax6h
         O4VlGNMLWCOzO/HM5t5LW7bm2sgh9VGFoeKns6SE0nZ4ZpMoXp3QsbeKXbpraAr5Rvg0
         BxTA==
X-Gm-Message-State: AC+VfDzBV3WepvlPWRQgkdrFoAegyunyEc0WrlWKCnqGcuhOG8nAn7RR
        KeFVjWjh/ooBzeKzssrDhuc=
X-Google-Smtp-Source: ACHHUZ6U9Kxq8YZBBIAh0kptcooZsG4TQcU9whsDR/E68dbJIxgSMJj08AnNUgFHNs09qqmonjOpoQ==
X-Received: by 2002:a17:903:11cc:b0:1ab:5b3:9664 with SMTP id q12-20020a17090311cc00b001ab05b39664mr1801386plh.41.1682979541497;
        Mon, 01 May 2023 15:19:01 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001aaff9be643sm1545748plg.89.2023.05.01.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:19:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 0/5] branch: operations on orphan branches
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
        <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
        <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
        <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Date:   Mon, 01 May 2023 15:19:00 -0700
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 27 Mar 2023 00:19:36 +0200")
Message-ID: <xmqqednz3dbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> The initial and main intention in this series is to avoid some confusing
> errors operating with orphan branches, when working with worktrees.
> ...
> In this iteration, v5, I've reverted some of those major refactorings,
> mainly the inlining, because it ended up introducing unnecessary
> complexity for minimal benefit in this series.  Maybe those refactorings
> make more sense in future series.
>
> A new test has been introduced, in 1/5, to notice if a behavior change
> similar to that observed in v4, is reintroduced in the future.
>
> Other than that, no functional changes are expected from v2.

This has not seen any activities since it was posted; presumably the
issues raised during the review of the previous round have all been
addressed?

Is everybody happy to see us declare victory and merge it down to
'next'?  I see everybody who commented on earlier iterations of the
series are CC'ed, so let's hear from them (and others who may be
interested).

Thanks.
