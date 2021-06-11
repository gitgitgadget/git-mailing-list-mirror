Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDEEC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1D7613CF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhFKRZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:25:15 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44607 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFKRZL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:25:11 -0400
Received: by mail-ot1-f45.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso3814797otm.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yzA/GHuRAErPV7/e2E6v8C68RuLQ4DF6p43reGSOkHk=;
        b=F8mNuyEuL6VsV1RRWnGg3bIruVV8Q6hAB/m6j71vpln6P+igklrW2cSKPDf/IKqANP
         9LOfw3L6jj/AjmBE1OVodWCktlUwQx1b1fYSKUj551uYUcY3zSABUSHjryvXmoL76BZB
         gqH5qDzZj29M1bh4qzwf6NdZ5BrBW/X3R+yacIUpjoIIyRLBnvaBr5ikdrxZecfH4j2+
         n/DkTfRjylUovXHOVCQp4+VIxXjjals1vVOvBRLxLBBz8HuBSUlK97gwUmB6UfKQt9rO
         hlGg/s7xHK8d59zFVGh3GweTnlRkd9aNIzZo6CEAbih3MYeuMUhj30bziuoq682TuMEs
         yM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yzA/GHuRAErPV7/e2E6v8C68RuLQ4DF6p43reGSOkHk=;
        b=kI0H+ZpHm8kwx15uRfeL/cyIqWsNcjQy/hlPndP1hLLD9jd0XcTUHoTS1KbKURffwK
         ZY+IHxXybUvXRaBu8ktuRZGOCDav1TgXbJpEN+vD54P07DNAFRG0LMxnFHAvylZgWSQ5
         QS8fUhhGYUmU6IC27WXaOqLnNyGcfK9gC0EqIPMwyNENFEgScvgwZqGTtqp0CD7iP2qX
         eMJhml9D2jlysxyCbHTPyBQy+OEm5PNISbJiwjjk2ytX/Rt1a1iDrfOBmMQ7FTY1WjHl
         jPJXQXunxTsFPoX85nK+iXXfLNIV7k3xZ9DN3uRd93/wTRRSRdqF6fhfq6SpVxhBjYGW
         xW2Q==
X-Gm-Message-State: AOAM533PDH8dhfI4SrrDCx+ujl1wMTnB0WKM6Vz1fAQpihV6mDr02wKm
        t6FpiRONlJrZPs6CUysP6mI=
X-Google-Smtp-Source: ABdhPJxKMnUij7xc0swiurYBd6RDH4Ym4wJ16/spfIbaCEqkjUPyhQKyfKixrucUepvEXY8LvXYKYA==
X-Received: by 2002:a9d:64a:: with SMTP id 68mr3979182otn.68.1623432122507;
        Fri, 11 Jun 2021 10:22:02 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 7sm1232692oor.30.2021.06.11.10.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:22:02 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:21:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c39bb3b5cc4_8d0f20817@natae.notmuch>
In-Reply-To: <dd5a1b6c-f0d3-f135-d03d-5d1f9205503d@kdbg.org>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <xmqqo8cc3maq.fsf@gitster.g>
 <875yykipq2.fsf@osv.gnss.ru>
 <dd5a1b6c-f0d3-f135-d03d-5d1f9205503d@kdbg.org>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> then diff3 must display the conflict as
> 
>  12<ABC|34=AXC>56
> 
> to be technically correct. RCS style can coalesce A and C outside of the
> conflict and display it as
> 
>  12A<B=X>C34
> 
> and *that* is the helpful part of this simpler style.

I have trouble translating the above to what I'm familiar with in my
mind, so...

diff2:

  1
  2
  A
  <<<<<<< l
  B
  =======
  X
  >>>>>>> r
  C
  5
  6

diff3:

  1
  2
  <<<<<<< l
  A
  B
  C
  ||||||| b
  3
  4
  =======
  A
  X
  C
  >>>>>>> r
  5
  6

I personally don't mind at all having a few extra lines in order to
visualize what actually happened.

But of course there's zdiff3:

  1
  2
  A
  <<<<<<< l
  B
  ||||||| b
  3
  4
  =======
  X
  >>>>>>> r
  C
  5
  6

Which is the best of both worlds, even if not technically accurate.

Cheers.

-- 
Felipe Contreras
