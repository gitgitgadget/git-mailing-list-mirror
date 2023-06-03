Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B00C7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 03:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjFCDC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 23:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbjFCDCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 23:02:22 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C580CE6A
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 20:02:13 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f81ffc9065so50301cf.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685761333; x=1688353333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dw72NoDpSJ8cEO/Mv15kmdB8VLyqXRMvi3yfoOFFt3Q=;
        b=oNCAAEX1q7NERFjWTrz+TmlGDuggWNdv5DgzIQWJU/PslBIDSeTsyBUZ+AMwOOoFzm
         Hh6sGq/2/ytcwkhYEnuFmVNeRaxhZO8vpWvN95pqp4kKO7ZrHT/YpCGGaGdOzGBy8p67
         V1qUVQJLXpZXZgfaxAL8tmMHAPPrw1gFHFkPCUUSZiJTm8v7F6QUxWv5pUaGi3BLxRQS
         bce7ZtG+cpb+1VKP5Ju6hHXpQ1E9vZUDAVgqt1ZuVCKa9ceSAM9a/lJ+dR0s+N1J4fMA
         pgO+kmUevQexFnXFM6eidsEWupw74doDiVp9GGAZfCuE9ZMXAU0q2WFJ9/7nlj2wrlsg
         qS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685761333; x=1688353333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw72NoDpSJ8cEO/Mv15kmdB8VLyqXRMvi3yfoOFFt3Q=;
        b=CG0wdbcjND6VKS5S8UeHY6Q9tqJNmRDw8qOh/Isl8CaXyaixxLFa/+p0Q0VUXsvvpZ
         jq3FTwX3WHhSGqW8CZgg2CIwm6NjlhCkOnrjGE+I12ZTLsEqaWI4FbqNwhhbPIIIKpLl
         J9lTH1j3hwcehOB8s2ri6ApdMgjsUajVVqxj1OMlkNATFxy0pBWrgPZnvWwUSQdvPtSs
         5vL+SDioqYfkWrWEK9E+mSmHkQf13M2J02aFtkTSQlQQcNqbLGoxHWMG26fXzMRnP+Hc
         w8ArAqJuqiWDjr7Iyvv2xGzf5fYcxbkCGX+t4ZRF8FzVrUmaf4oo3F7eCiMJRZDpIZhf
         F3cg==
X-Gm-Message-State: AC+VfDwrO4BwfaqJy48vkD5S00mGdHClRe/nW2YGiIA5r3L8r+9cYIsK
        GLpVvGZRJR/DQkV76oOppR9MG65wUMXa7iTW85dEcQ==
X-Google-Smtp-Source: ACHHUZ488qadMQU6q1fDFPod2gx/y02RPztKxDc73+4yZAHOtR3En4xlFQ8WuPY4TRFL23ihi5ZfEpxVL8XCmLKm72c=
X-Received: by 2002:ac8:5986:0:b0:3ed:6bde:9681 with SMTP id
 e6-20020ac85986000000b003ed6bde9681mr408648qte.0.1685761332686; Fri, 02 Jun
 2023 20:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
 <20230602192700.1548636-1-asedeno@google.com> <xmqqilc571hf.fsf@gitster.g>
In-Reply-To: <xmqqilc571hf.fsf@gitster.g>
From:   =?UTF-8?Q?Alejandro_Sede=C3=B1o?= <asedeno@google.com>
Date:   Fri, 2 Jun 2023 23:02:01 -0400
Message-ID: <CALVMLfK4zD4ifgtQLfXBKFJH43hfLevmvVdsZ-ydKCt8kuPfqw@mail.gmail.com>
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     asedeno@mit.edu, git@vger.kernel.org, newren@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the dupes; resending as plain-text as per list requirements.

On Fri, Jun 2, 2023 at 9:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Alejandro R Sede=C3=B1o" <asedeno@google.com> writes:
>
> > =E2=80=A6
> > Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> > Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>

They are both me; it's my way of sticking with my historical personal
address and still attaching my work address for work reasons.


>
> This is a bit unusual; do you want to publish both names (I am
> assuming that they are the same single person)?
>
> I thought somebody in the earlier discussion identified the topic
> that was problematic by bisecting.  It is a shame to lose that.

I identified it earlier, by inspection because the machine I build on
is slow and this was easy to track down.

> Perhaps it is a good idea to rephrase the beginning of the proposed
> commit log message to mention that, like
>
>     592fc5b3 (dir.h: move DTYPE defines from cache.h, 2023-04-22)
>     moved DTYPE macros from cache.h to dir.h, but are still used
>     by cache.h to implement ce_to_dtype(); but cache.h cannot
>     include dir.h because ...
>
> or something?

Happy to rephrase.

-Alejandro
