Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EF4C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 22:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjEJWpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 18:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJWpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 18:45:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEF535BD
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:45:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115eef620so53700509b3a.1
        for <git@vger.kernel.org>; Wed, 10 May 2023 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683758730; x=1686350730;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3B9Hp0Igb6wHIfS5wmXdbR8fkB5CMNZEKsT0MiJQbA=;
        b=ZjQ8EM3Bm5pXAtu9mDmJC4NKNOYceLtTPkKVNeiQLcyPfnjmdXc8QzMjhLHIkKgKhg
         PLZ54UMtzbfjRY3zo6SlOEzwu0IdxqfiZjXgFisOLG9M/+u8uzReZTGFQB6UhGIAKh2Z
         s34goTwNrd7ueepvW+C5dIoznTZx4IKc5imUjDxlx4qiXmzzgHoWGBe4haa5vvjr6b67
         5Pyg0+SdWzwBRYy+Ico10LUtRvvR2tS95AlP77qi+zhIFCXudJrEkDOfuNnlpupQBUAd
         kfgnn6CR+eI+lg3i889p2ujGHYkkVZ3WDqdgXKf8DYwRvInat8hnnNJlD30htFdaxQuu
         y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683758730; x=1686350730;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3B9Hp0Igb6wHIfS5wmXdbR8fkB5CMNZEKsT0MiJQbA=;
        b=Rc8SriDjLgJ7R3exK34+/PV7osglx5K3sArvqJFJeJMn3K3hzZkGhXLIV28V0/Vn6W
         MSHQeRr6XW930G4ccVMRMLJzhercgfhtmYmJwyGxsXC792+jApTT80y2rbP+rRs8TNIA
         nKa+taVkPwUAlIBkxZJ3aNnZsIodTBgQFezTe+a6EDtZdyyy6+8jrIqGSfs+b+C8Ib45
         orAr4k3y4492GFRGnV62rXZ2mNc2kg4V5n27lpu6x+4vDKTGcxb6Batb8c3rYFul3NBI
         qYCjDPnO/uClAw2Ssrkl2CDHWXnWGoS9HSOUDp3/v22D7FUEKxPubmo5QifaT0u9Q2JC
         tMcg==
X-Gm-Message-State: AC+VfDw3okptYQSD0zcv4+gyFbtwHM1Jectv4cOMUSAKXj+ImhERUzk0
        WeLPQrsDElCD8ZG2KXJ5tXM=
X-Google-Smtp-Source: ACHHUZ5Mw3PTv+SD05scn8nTa589ecTisf7TRv3jKsTTIDsbK20kG3l0IwyCUJqmbr8LPVdZGnM+QQ==
X-Received: by 2002:a17:903:1ca:b0:1ad:bccc:af77 with SMTP id e10-20020a17090301ca00b001adbcccaf77mr1593003plh.18.1683758729716;
        Wed, 10 May 2023 15:45:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a6d4ea7301sm4283376plb.251.2023.05.10.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 15:45:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] cocci: remove 'unused.cocci'
References: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20230420205350.600760-1-szeder.dev@gmail.com>
        <230501.864jowjh15.gmgdl@evledraar.gmail.com>
        <xmqqlei86o7s.fsf@gitster.g>
        <230501.865y9chs69.gmgdl@evledraar.gmail.com>
Date:   Wed, 10 May 2023 15:45:28 -0700
In-Reply-To: <230501.865y9chs69.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 May 2023 19:28:50 +0200")
Message-ID: <xmqqv8gz24c7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> A better way to spot that would be to start parsing the coccinelle logs,
> and detect when we have unknown parsing issues, and error on those. But
> until then...

Until then, I do not think a rather costly test that has found only
4 instances of the mistakes the test was designed to find is a good
way to stand in as a replacement.

Let's drop it, as it is easy to resurrect if somebody wants to run
it from time to time from an old version of Git.  Or is it a valid
alternative to move it to "pending"?

Thanks.
