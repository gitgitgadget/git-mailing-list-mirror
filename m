Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5891FC6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 19:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCJTZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJTZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 14:25:49 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8651340E8
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:25:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so8452698pjn.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 11:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678476348;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jT9X9HAGZVRjifUzUeBepOyoazmkiT07QnTN845GGc=;
        b=L2vwmaqRXMTH02DAQZtd0A8V5njQvWmIQZ1bIycT/lg+FgbJTFNcwDDLSv75RxTdWw
         JQib+YBuUqki4zdIQuJMSJGiNaTyeQViMms/SqxeTmtU+Bmb2MAsA0rnFjQ7PAZvTuPR
         kWW0Ni5ctzvs8yIYYIcizdgzzxzHh0pHb3DTXCdGnfhpn02w9R7yD22z9CID3RpIE6Bm
         +iG6kNwTyUViUgqk+7GV7lRaT2Qdf4uF3fKKB5l+t4jLhLG6X2cvS1lV8M2AQBKdPNIX
         IkK1E2LkXXRphwXfDfIzv+WjM21rzAkIlrSP1LFavpMjYcJDunVbIv6D+XGKhv2G/yDr
         1tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678476348;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jT9X9HAGZVRjifUzUeBepOyoazmkiT07QnTN845GGc=;
        b=xJI0ODFGTF2x+WJ/TOk9KEH9712OJ5SXJOFM/BTBr56WQRdsi3Bb8bD/hkCfnNaboc
         KbMyVubBe2aU3LNdAbxqB7fWPxFJY3xL9/FE8vJrD0Ob4mtyZE782AxhU3VmUVZszs1u
         HbyHKVEPDyTd0dMgmAKS4ig7CmGFlfglrzqqlKAweNIz65OHafIyqoUI6qMFZEkEvufU
         Q3nWiG3jbNIrKzDaQCPqBQ+Ym90pX0+agutItPRD1CZ9GojJfdpB9Wo8Tf5vNQaQuhv1
         sFky2r9cAjixUpCoN056qJV8yPBmV2MUJi/03o3IRoL3/XLDy/XT8QLrUW/+KAiZJfy5
         vEaA==
X-Gm-Message-State: AO0yUKVLLgjvXRkfccZqPomXBp5hZzow3ZpbuZjDeXZ6M8H6QhPnISGs
        Zh4oUBT1nReG4p8EXgL+EaM=
X-Google-Smtp-Source: AK7set+S45lNKvLf/BEupGKwW4Zd2zxxasr+YEKB1Q12nkr58FKiNfwhZRHA/M1/xqzVNx7+8jenRA==
X-Received: by 2002:a17:902:ea04:b0:19e:6e9d:4bd with SMTP id s4-20020a170902ea0400b0019e6e9d04bdmr32894508plg.43.1678476348068;
        Fri, 10 Mar 2023 11:25:48 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id jk10-20020a170903330a00b00186b69157ecsm333492plb.202.2023.03.10.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:25:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] test: cleanups of aggregate-results.sh
References: <20230309173032.959968-1-felipe.contreras@gmail.com>
Date:   Fri, 10 Mar 2023 11:25:47 -0800
In-Reply-To: <20230309173032.959968-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Thu, 9 Mar 2023 11:30:30 -0600")
Message-ID: <xmqqa60k5ryc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Basically $title.
>
> Since v1 I'm now passing the directory, instead of the file pattern as
> Ævar suggested.
>
> Also, while at it, let's silence the print of the command.
>
> Felipe Contreras (2):
>   test: simplify counts aggregation
>   test: don't print aggregate-results command
>
>  contrib/subtree/t/Makefile | 4 +---
>  t/Makefile                 | 4 +---
>  t/aggregate-results.sh     | 2 +-
>  3 files changed, 3 insertions(+), 7 deletions(-)

These two look sensible.  Any comments on them by reviewers on the
initial round?

Will queue.  Thanks, all.
