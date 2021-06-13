Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B7CC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E894E6108E
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 18:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhFMSDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 14:03:37 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40886 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhFMSDh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 14:03:37 -0400
Received: by mail-ot1-f46.google.com with SMTP id l15-20020a05683016cfb02903fca0eacd15so8592634otr.7
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8j57p/AxxLHw4eeWd4bW7A3f8dWJ4TCO5QKSMZ3q9VI=;
        b=HKXKoJ0GsAtbCMZxsLE6ZWr23BdY5aj9WVV8EbMOzmflFEQKAIy80aQ36jwyNSIFVn
         twlFmc0MVF6sMJvYfl7dRoDp/7AmI3XZCa2/b4cCa9OQWSqOC689x9J+Nb9dZVekP35K
         gmN8o93+rgHpNjtYLCdtdogZJZyA6WRRHGp2eYNCFLV73m0GUXd6H0qDyN9aa981YpMh
         vZN5TqcklyN8Gxiyk0ihidb1Sidp6OyP0zNKwCdHmE3cA2v40mv96DR2EyJ++1XL+wq0
         y1e/WHwcY4TEo/G4U0hijS1wNyEGT1usIZyPiYLlAojHhSrj5wbGVqT7t0gkMA6RHbzF
         177g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8j57p/AxxLHw4eeWd4bW7A3f8dWJ4TCO5QKSMZ3q9VI=;
        b=sIKaFUo/YzU3QauEWm7zffT86/EgCeUHCeeStgolJfe0ngeiupgUfJS3GbnkjimkZV
         GtbvguZH59FBq14vVppPo1z3L20D4g8AdqQ73zOiU6dROLiCJOWn+KsDK9XW5T+gODV4
         eSkoM3N9JVuAastPIfuIJKr/Q7rozbZ8DjOy5qvTkGCIZ7bE21vUWN7F4d/hdSpzlebZ
         WEf01Cmm5fR/FIHfBKjaVoF9fwF2GWEdPhWRYndJV0qNK6afeMwgbb5MPQH6X7RR4QG9
         BCESBTMDzrJziDmD4WYj21H8a6pe2ACyHq8Zq6G/4Xhxc6LWgwfE6d6L/nYGI6z9+uG+
         EbgQ==
X-Gm-Message-State: AOAM53219NH588qKC/G+XtUp6YGLXB4TywTPfblWt6T+4Sn8visWVoci
        s4EBWo5aDB16+vA0gSOcOl4=
X-Google-Smtp-Source: ABdhPJxVl/p8leob9/PtAoY648IT0omIQgYs/Suyen0oUcQHeeq/UTAoQX4NXbDvkGUww4qXDca1Yw==
X-Received: by 2002:a9d:7987:: with SMTP id h7mr11201735otm.98.1623607235597;
        Sun, 13 Jun 2021 11:00:35 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p7sm2483491otq.9.2021.06.13.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 11:00:35 -0700 (PDT)
Date:   Sun, 13 Jun 2021 13:00:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <60c647c1d9b5c_41f452089@natae.notmuch>
In-Reply-To: <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sun, Jun 13, 2021 at 09:31:55AM -0500, Felipe Contreras wrote:
> =

> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > =

> > "zdiff3" is identical to ordinary diff3, only it allows more aggressi=
ve
> > compaction than diff3. This way the displayed base isn't necessary
> > technically correct, but still this mode might help resolving merge
> > conflicts between two near identical additions.
> > =

> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=

> > ---
> > =

> > I'm re-sending this patch from 2013 because I do think it provides va=
lue
> > and we might want to make it the default.
> =

> I take it you didn't investigate the segfault I mentioned.

I don't know how I was supposed to investigate the few segfaults you
mentioned. All you said is that you never tracked the bug.

> Try this:
> =

>    commit=3Da5170794372cf1325710a3419473c91ec4af53bf
>    for style in merge diff3 zdiff3; do
>      git reset --hard
>      git checkout $commit^1
>      git -c merge.conflictstyle=3D$style merge $commit^2
>    done
> =

> The first two are fine; the zdiff3 one segfaults within the xmerge.c
> code.

I can reproduct the segfault, and here is a simpler way to reproduce it:

(I have a hacked version of diff3 until merge-file learns how to use
merge.conflictstyle)

  cat >b <<EOF
  A
  EOF

  cat >l <<EOF
  A

  B
  C
  D
  E
  F
  GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
  H
  I
  EOF

  cat >r <<EOF
  A

  b
  C
  D
  E
  F
  GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
  H
  i
  EOF

  $git merge-file --diff3 -p l b r

-- =

Felipe Contreras=
