Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9418C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 02:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjDUCnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 22:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDUCnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 22:43:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C210F3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 19:43:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b7b54642cso1377668b3a.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 19:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682044995; x=1684636995;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K6lEd/MbxdTI84QMukpw30kYAGhjhykmOyWMnYLHew=;
        b=Ntn0h19OsVICXYmStFVxRsNCtZe9Bz00bsOM9F4tK4fCwdxJxVSebR4QFR+u2CgGlF
         WvSIAG/d21woiufLUyOvfco4Kdjst/N9wZpBRZTKkiOuvR3eWjRSMmTMsfgkYBDw9KBd
         jYgMa9BPR1Us0niRYZI2L8H8KlTm9e4U6nDY1rtCgGL12fEUoCPfWWbe437SVNjkuk6w
         vB9isbqBc3BvUMzTIsyKwxBYEB7G/gCLzyKGGUHYQYS0bJYqFgPLCAAj1p4/6xQV6feR
         XLlW6G4G8ojItDvZFR9+y7gxqcBfBEo+0spxzt1D4sH3ixj1tHbHscCfwY17BbLYuBb/
         wHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682044995; x=1684636995;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K6lEd/MbxdTI84QMukpw30kYAGhjhykmOyWMnYLHew=;
        b=EDT/nzZn9J6ssBx3k43qDWEYB9NmIPTy7BXSSBbtfoMNesTf7eQimfAt2X2hzZafhe
         qtVFqxRL1HA2lCzxuO8wUj86BRqELLF1UqHm77lPr3pfAV6hgl3Ws++fXcSKG3Od1tDW
         Bvc6ylrCqPBQoEujEoM/fGt/rK0FAx0K7oeKibwIWuO572iT7ojl6uKHtIIKXKDeV31j
         cjYFvfKbmOLhF+BPXKahyAxJkKdYsytvtw6jbmNOy7poq6Hqm/MAfwa5aqTUwAP6c8m2
         iZE66BBZZ5R2wWuyRQSZwh6DMeCLW4ni4W1I3NidojaQGF90+dQbxw1/+Uv6i+EzSvc7
         dVZA==
X-Gm-Message-State: AAQBX9d2lA1QMBjaoLlSzmMPVCuOuxrRQYNNPgRvCpZteuOJPKql/3qk
        lh0BFt5a3k118AjOAw//uh1VEkinPxs=
X-Google-Smtp-Source: AKy350Z2RD7mNvn1X6pSLW0/daq4SGMxQ2s/eqzevgkH9Ms0DyMzlLImoxlhwvMmc+oaeglWLItfDw==
X-Received: by 2002:a05:6a00:814:b0:63c:1be4:5086 with SMTP id m20-20020a056a00081400b0063c1be45086mr4571309pfk.6.1682044994828;
        Thu, 20 Apr 2023 19:43:14 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n41-20020a056a000d6900b00637b0c719c5sm1879309pfv.201.2023.04.20.19.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:43:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] cocci: remove 'unused.cocci'
References: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20230420205350.600760-1-szeder.dev@gmail.com>
Date:   Thu, 20 Apr 2023 19:43:14 -0700
Message-ID: <xmqqmt32lzul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> When 'unused.cocci' was added in 4f40f6cb73 (cocci: add and apply a
> rule to find "unused" strbufs, 2022-07-05) it found three unused
> strbufs, and when it was generalized in the next commit it managed to
> find an unused string_list as well.  That's four unused variables in
> over 17 years, so apparently we rarely make this mistake.
>
> Unfortunately, applying 'unused.cocci' is quite expensive, e.g. it
> increases the from-scratch runtime of 'make coccicheck' by over 5:30
> minutes or over 160%:
> ...
> That's a lot of runtime spent for not much in return, and arguably an
> unused struct instance sneaking in is not that big of a deal to
> justify the significantly increased runtime.
>
> Remove 'unused.cocci', because we are not getting our CPU cycles'
> worth.

Will queue.  Thanks.

