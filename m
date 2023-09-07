Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F4EC8726
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbjIGRls (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbjIGRlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:41:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938F01710
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:41:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c3726cc45so1236013f8f.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108454; x=1694713254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=No+GRFeYLREtfDYEX1YEZUh4HpY0Sm3t94iyoSrvMfw=;
        b=d9wW/7U7BIruJK6gmOGeXbIZGD2JyhM3Gv4tcWSnFF8GocLcAaQAWdEY/5Ez9B6x/4
         137mgq7vX+dN8342h9GqEApEozem+nSPr/gd4EVGcsxsJw+5jJHU9eTZQiKFp+aa9WUb
         qPpqnkMmN/e/LwAW/OPObryWE6zCp+8Gqb2RfpxDs2qBAeJjmDH5yAaQB7cfNkHJUeQW
         Ua1R99sZ9FxoGBZI5i6HltNapkSv6RbNxvK8kh/HPVkFE96wqV5iDZoTdhMoPCPj47Dk
         PF/YJ2JbSNlkw3EqqQrWnmMrtlQOJDUzfb+XyoLaf30FAzrKMUtABJBtS3EAwW3dUPGy
         H66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108454; x=1694713254;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No+GRFeYLREtfDYEX1YEZUh4HpY0Sm3t94iyoSrvMfw=;
        b=f3UcnXz2NwHpRhzNpAFjVMkY5ki5TiN1BhLyfudASwjP0UJbQg3TRTRGKoV64xPR9X
         UNO9WgTg+UTuRJFNd7ZWWVOJG8M9pVHGDmEQC9smxLKUvGkaOSLGjaxUAdQKXpttg1Vc
         91oYAwbSa64cOi63GNqmmSIMUdlmfeeQ5f9kfBQJwyZ+AwCQHzCM+9dDqBN0JWhD3TX9
         cBUf4PCimWotOSKooGjK4ctSlzp6q1oEfySq88QJM5vCeV4UAeFLUsmxVm8M13a1YhB5
         b9eqZTJT7ZcnK/Ws/KzJAQ5owNG+aGyoJ8uKA1v/d9t/m13xwXPM7YxGnumXJUn4PrRN
         X1uQ==
X-Gm-Message-State: AOJu0YxtJE3Uozf+8SW5OI/nTEsShrJkm4/Krpgq4ONvD/ls/Tqu3O7T
        8rME+mbAPG1I2Ky6MN6Le2y8nKI57Ho=
X-Google-Smtp-Source: AGHT+IHb8OtxF/95HzToxjzhHdJ8g076CEhsgiy7YzWLMhCZjwnedQAnAtzAQC3HfAzEDxqYWaHkIA==
X-Received: by 2002:a05:6512:36c7:b0:4f9:51ac:41eb with SMTP id e7-20020a05651236c700b004f951ac41ebmr3334779lfs.16.1694068406242;
        Wed, 06 Sep 2023 23:33:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d11-20020ac25ecb000000b005008cd93961sm3022908lfq.192.2023.09.06.23.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 23:33:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <87edjbuugw.fsf@osv.gnss.ru>
        <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
        <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
        <xmqqledjm4k2.fsf@gitster.g>
        <CAPMMpojTLswqubRk0Ly3RQqkrnpx_9Hiu_TRK1=ASPbPNz4ApQ@mail.gmail.com>
Date:   Thu, 07 Sep 2023 09:33:24 +0300
In-Reply-To: <CAPMMpojTLswqubRk0Ly3RQqkrnpx_9Hiu_TRK1=ASPbPNz4ApQ@mail.gmail.com>
        (Tao Klerks's message of "Thu, 7 Sep 2023 06:53:58 +0200")
Message-ID: <87h6o6ebm3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Wed, Sep 6, 2023 at 10:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Tao Klerks <tao@klerks.biz> writes:
>>
>> > I like the nomenclature, I like the simple "zero (i.e. bare) or one
>> > inline worktree, zero or more attached worktrees" explanation.
>>
>> We have used "main worktree" to refer to the working tree part (plus
>> the repository) of a non-bare repository.  And it makes sense to
>> explain it together with the concept of "worktree", as the primary
>> one is very much special in that it cannot be removed.  You can see
>> that "git worktree remove" would stop you from removing it with an
>> error message:
>>
>>         fatal: '../there' is a main working tree.
>>
>> It probably does not add much value to introduce a new term
>> "inline".  Here is what "git worktree --help" has to say about it.
>>
>>     A repository has one main worktree (if it's not a bare repository) and
>>     zero or more linked worktrees.
>
> I've definitely changed my mind about "inline", I agree "main" is
> better. I'm not convinced it's the best word we could come up with,
> but if it's well-established, I'm happy with it.
>
> The problem I (now) see with "inline" is that it seems to imply a
> spatial proximity that doesn't necessarily hold true, with
> "--separate-git-dir" or other ways to separate the main worktree from
> its usual "just above the .git directory" location. "Inline" is still
> a reasonable qualification of the main worktree's *metadata* in that
> situation (index, etc), but I think the word would not be sufficiently
> clear/representative overall.

It's not to argue in favor of "inline", just to clarify: I took it from
inline-vs-attached as used in e-mail, where "inline" means that you see
attachment right here, inline with the rest of text.

I also admit I didn't happen to consider --separate-git-dir at the
time.
