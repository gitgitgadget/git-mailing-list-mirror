Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1E1C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 00:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiGFATO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 20:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFATM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 20:19:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBB13F43
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 17:19:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z14so12790419pgh.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAoNMmdrNo5cZO3yoeETcws0MClanb5GdgTl6Lg14OM=;
        b=bzkA7C5sumuP1p1mLgGmVxxFtwyw//OtUXlgoma2GmQgn/7HQtb1Z3tkZTVpvdqiGp
         V1jZtv2v+QzRUxoU9MnsuFzlgYevwk18RMjfgasCaSONRtfFX8DmbeO0EG+WbrNiWvmD
         bCrsYG8fIFKOP+YU0TCNLcrcYrLICrsDDhgcpb4FkMh5dIqDj8pFnwy73as51OGu9XiJ
         3Cn0QkwsufIWFt90MMoo7uEzikMwhBWpFO9J1JMzZeUZuWxTh/X+xWI88le3TDe+t6Tf
         Fs+U8xJm9S5+xUnFrFvESIA9k6AHyWeFm1BvFk4xJgFgcerYOo+JXCaN4k7ZheLZdD8v
         bGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAoNMmdrNo5cZO3yoeETcws0MClanb5GdgTl6Lg14OM=;
        b=PF9SqTPqgQooWOua8b2LCsYWUr/NpdI175wfJb56aVAX16RBmipIBC5gTLrUk2cfvA
         8Y0dAJIVVmhe/FNti+pBRBsmt94bTHK+1bktW2bg2N4zIHnFUKOzdVgYAj0120Wjbcky
         cTeQExAgfr4+oKnILqKnVmgI2eOX91HljRp5eN5XHAsbj4KsrRC0mGudFbN3JjQ8aA4l
         7s1PfYgmk/h6gqxkvGpdKe/RpMdU23BLf66xtlABH5esW47IOY5beSEEYwI/Z1H1Ro7v
         NCxfPbCXwuchtIOK5fqicbxb36I5cWevcNz08wLABoAmb7fEf5lQVtZZmaTcBSmuO+92
         2+uA==
X-Gm-Message-State: AJIora9hV2o8H79FuDuDYpSGZDSdMk2prYAe9QDq9NmRJUNC6Q05QnhO
        cdN6YKj8D4uXFUZSeb0hSKRL/0FJR1Z12KGsOA==
X-Google-Smtp-Source: AGRyM1vzei5ex/F0qHnJYLi8VCaA6ln6SqJidc1VhakCg4RhzOZUC9CmM5UzMlTbidIpHDNJTsbkPmeXob3t9k5quJY=
X-Received: by 2002:a63:2603:0:b0:40d:9b49:8984 with SMTP id
 m3-20020a632603000000b0040d9b498984mr32221634pgm.337.1657066751904; Tue, 05
 Jul 2022 17:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhVC3Z92hBsK0FbE4E_LV1CSxjR1zmu+MO8=iwR02BKqnwgUA@mail.gmail.com>
 <CABPp-BEkEKQZR=1duxSS4AVv9u5tnPk5CaLCM_fQWPbAqfSMxw@mail.gmail.com> <xmqqmtdnjut5.fsf@gitster.g>
In-Reply-To: <xmqqmtdnjut5.fsf@gitster.g>
From:   Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date:   Wed, 6 Jul 2022 03:19:00 +0300
Message-ID: <CAMhVC3b+ByoxRn1o1WDvb3Rk07j_YQu9bd4w+STAgzNqkxK5ig@mail.gmail.com>
Subject: Re: Why `git am -3` apply patches that don't normally apply?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yep, thanks for the detailed explanations. It let me improve my answer
on Stack Overflow:

https://stackoverflow.com/questions/25846189/git-am-error-patch-does-not-apply/72797965#72797965

Although... it'll unlikely receive a lot of views :( But whatever, it
can't be helped.

Regards,
Yuri

On Tue, Jul 5, 2022 at 9:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > As per the documentation of -3:
> >
> >         When the patch does not apply cleanly, fall back on
> >         3-way merge if the patch records the identity of blobs
> >         it is supposed to apply to and we have those blobs
> >         available locally.
>
> I suspect that we would need to update this part, as the order of
> "fall back" was swapped sometime in the recent past (and we have
> fixed a few bugs that were introduced as fallouts).
>
> Your description on how -3 works when it does the three-way based on
> the concrete example was very clear and easy to understand, by the
> way.
>
> Thanks for writing it up.
