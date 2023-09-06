Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B235EE14A9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbjIFWed (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjIFWec (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 18:34:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A1F19B5
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 15:34:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501cba1ec0aso432792e87.2
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694039667; x=1694644467; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LaUvghtUKhJnIBFFvUdl8bgFfN/oe4pixGM41XfQuLQ=;
        b=FmCAoPXraXFfYFb09D+M2tgEMCi9stzFcGpRLxn8ZV0EfcxES1QeDeUtiAF2Dntk6q
         MB4gYTU4vE0bgqQeqo9RhjHIeZs1/+Kbedh4ZQCo2hMjqo5Ft/sBamF7P6mqLPgkUqI3
         eWTgWCmOicOQgvQ0djQ6On8r2HkH2Y+qT5tYZczoAsMUEdzm02Vu6AjoY3DAyRrwKZ0p
         GkiiE6fcGhbdUXiIeSncOXZNPyDpmoPk+AyIWVef7T5cDA8EFErQy2H/O0ziXIH2GLHL
         6MXD/avPQPhgl7uHTFVjGFOgEq8EQdJ9HaROwbVy9SrNxwWkBlfOMluz6HmQ1830yxfH
         EAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694039667; x=1694644467;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaUvghtUKhJnIBFFvUdl8bgFfN/oe4pixGM41XfQuLQ=;
        b=YA1YE6cHFlrvupA7mWrpO8iB0k5bnZlQuWHTOuOjWs732EW1+2OhzynxYTmOAmN6it
         HgN7X9hts7qRr2YCwf84ppoEff+1QMKtJ1ViUAQHsElOLu2zBBOmNZM0der62Jty12UM
         vMKt8kDMilLJ+SuG4X3aW+yzFZGaWYP9nSVjWKTFw+2JOk/Qjmuu1vJQmvxP2b6NC//8
         DoweYNZ2nOMTOr64KfvWAZ2urLJ//6GfJPjev8DEif5aG42wA8cD+N4FgP4aFVomZYqY
         ye0Kqrr8sLov6wz5O62gO8+fQW9JD3WRfnDOeGr9/qPQVlwXntWTR5HEWut5i++qirLf
         jOCA==
X-Gm-Message-State: AOJu0YzbeV8A2qG8Q0Ur6eTakYKSpyrvWkpOUU6PDvO890SHfZ4FMQ8G
        +8cAwchLKnzWzr3CdlCAD5lr0q8LX8A=
X-Google-Smtp-Source: AGHT+IELRDin3t5PocTloUPnAVgaM1f3pYWYgPAlHq1wK+EeQWMYv2lMoukKwrVtOfI+/SiB/OrliA==
X-Received: by 2002:a19:2d17:0:b0:4fe:2d93:2b51 with SMTP id k23-20020a192d17000000b004fe2d932b51mr3391953lfj.27.1694039666596;
        Wed, 06 Sep 2023 15:34:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g22-20020ac25396000000b00500829f7b2bsm2893056lfh.250.2023.09.06.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:34:26 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks <tao@klerks.biz>,
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
        <xmqqledjm4k2.fsf@gitster.g> <878r9juflz.fsf@osv.gnss.ru>
        <xmqqy1hjkkxc.fsf@gitster.g>
Date:   Thu, 07 Sep 2023 01:34:25 +0300
In-Reply-To: <xmqqy1hjkkxc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Sep 2023 15:15:43 -0700")
Message-ID: <87y1hjszgu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I agree "inline" is not much better than "main", nor "attached" is
>> better than "linked". I just pulled mine out of thin air, and what's
>> already there is probably fine.
>
> Heh, the initial draft of my message you are responding to used
> "primary" (and "attached"), because they are the word I am
> accustomed to use (out of thin air) on the list a few times, before
> checking with the existing documentation to realize that we use
> "main" for that.
>
>> That said, to be picky, "main" suggests
>> that linked worktrees are somehow inferior. Are they?
>
> I'd say that 'main' is different, not necessarily superiour, from
> all others and they are equally useful and usable.  The difference
> is that it cannot be removed.  There may be other differences I am
> forgetting, but I do not think it is about which is superiour and
> which is inferiour.

Well, if worktree created by "git clone/init" is not superior compared
to that created by "git worktree", just different, then "main" might be
not the best choice, but then, provided it's already in use, it's
probably not that big deal either.

As a note, "primary" also suggests the rest are "secondary", and then
"primary" one might not be there in the first place, leaving us with a
set of "secondary" without "primary", that is a bit confusing.

"Embedded", "integrated", or even "default" come to mind as
alternatives. However, if "attached" is decided upon, "inline" just
follows naturally.
