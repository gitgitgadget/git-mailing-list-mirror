Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A0C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBUW1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBUW1l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 17:27:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6746831E08
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:27:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ee7so8084122edb.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwsmWxVjWZ/AeM2GPAp5PEeCY+5VclGZn36e3omnzCM=;
        b=Bj1j5iicYnJIymO3v1Upk6lff/gQIu4I0YPLulLcrSB0AUc5LpjUcTCbZRoi/aOrx/
         YwdO3M6iM96OcTtz+bGzJvJe2Kt4mex5VWwqsjVGWCWgNwzWi3X0ku2GtOBkAQkwm/rn
         wyA6nDKIbWzQ4YjPgvU54PfA9zM0x5DMo+Qj6kuspgPosl8+N6b8kGXPDqxs3wKMZ+B2
         J0WaowKahuQkILBgBNjwZ5TDm3SevlNW/2UGEt/sd9IvHXKQHP0gw0mikCP38MQ9Obji
         GSCgOwo25E0YPIzK+R8zamvuMnCpDQYhGfhT2YMyyK4Z6K1KNquG/mlyuE+V4IeP263n
         kB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwsmWxVjWZ/AeM2GPAp5PEeCY+5VclGZn36e3omnzCM=;
        b=yvnrh9zmEOx6KN1V8oKX3SbDMC2MCx2MQpda16RGNV1lg15fyKNxPHMgzYYyDneIWy
         zJXPFIBPEgp8TEuNRwVgmhsafwffRIsLXZ/WntLu3GpG0yMYxXqZZFbgRpE3h/6uCu+D
         hdHX9uKmFOubcdluafu7Soi/N2bsp9YpDYi1wTGbHLjAW/ZeIO1NaORwIO8cQqh5KPOe
         ycUDwgCXfsL/IxJYEaWqaJca9pRKCTYwUmYSB0epfN6T96foAwaOpYGFMh1XrM915lCl
         hOYe0cWJIoXxauMVnOczN6KMU0kaa15LHzjc+9ql7S8iIuRkTY27PHU3sLMfceFy47Ee
         worA==
X-Gm-Message-State: AO0yUKVN7HKpHKRP2evYkupoAIi/GZ2sqBLfkLg/E5ToKGA89xbu8wTu
        /4SumYyQo7qM28cTDJz5r30rLjPYFj6DgJ5qCSE=
X-Google-Smtp-Source: AK7set95S19bi6PRt3jyDz9uAmKS0EW2U5uAy4WLKktKo9rtqjvulG/cVxUFZZedgLZbdoOQgFRfaMwPKMTricmXMFM=
X-Received: by 2002:a50:ce5a:0:b0:4ac:b69a:2f02 with SMTP id
 k26-20020a50ce5a000000b004acb69a2f02mr2895625edj.3.1677018458917; Tue, 21 Feb
 2023 14:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20230218163936.980-1-andy.koppe@gmail.com> <xmqqa616g8yv.fsf@gitster.g>
In-Reply-To: <xmqqa616g8yv.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
Date:   Tue, 21 Feb 2023 22:27:27 +0000
Message-ID: <CAHWeT-Zy=iJZoVAWZHqnGGFb-KMbg1fk_mmdE2T=K4+xRHpG0A@mail.gmail.com>
Subject: Re: [PATCH] restore: fault --staged --worktree with merge opts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Feb 2023 at 18:38, Junio C Hamano wrote:
>         Side note 2: it is conceivable that --worktree --staged
>         --ours may want to (1) resolve the conflicted path to stage
>         #2 in the index and (2) check out the result in the working
>         tree.

Same with restore --worktree --staged --theirs and stage #3?

That's basically what I thought these combinations would do when I
noticed that they were accepted. I think they would be quite
convenient compared to separate restore and add. They'd be the
equivalent of 'svn resolve --accept=mine-full/theirs-full'.

>         But until such an improved behaviour gets
>         implemented, it is probably better to error it out for now.

Indeed. Unfortunately implementing that improvement is beyond my
knowledge of git internals.

>> +test_expect_success 'restore with merge options rejects --staged' '
>> +     test_must_fail git restore --staged --merge . -- 2>err1 &&

> What is "." meant to be on this command line?  If it is "the whole
> working tree", it should come after the double-dash "--", no?

Sorry, that was accidental. The command requires a path argument to
get to the option conflict error, but as you say, putting it before
the "--" doesn't make sense.

Thank you very much for the thorough review. I'll prepare a new
version of the patch.
