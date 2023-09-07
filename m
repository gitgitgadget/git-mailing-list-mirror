Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6168EC8744
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbjIGQkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243581AbjIGQiI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:38:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2DB273C
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:30:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d20548adso1130781f8f.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104146; x=1694708946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTZiVHD7Dy47C2G1POahYLjCNkC/+FHp1IXLLCvkc3w=;
        b=QHgD8Rgj/vkXCosJ+5FO0cS0FDgdNJIMpo0RNkUKeXdjT8JJM/MyboShml0jNsN2Td
         6HuOPjpbn/UzvqNoE+0tFk8qZGXSg4SGhOoS7XmuR9UBp9/pthhjIABa5ailhdrx8qw4
         vzrgFaq9UIyQOZS6RQAV6nnqzlBpXsKNTA5O67nWB4L0a8BKxepLyMSY1Oqt5ax9JZXj
         DO4guwRHd7OmWIXFTifiOMf1SLj/Ux0jgsqpab67F7JmTCgVyqNIkNeu2Zl8IQOpjbhe
         9DRZEG/W1PQ86KRZwwIZSM1L4itT+ofo/QSb1fDzDK4nWH3YP2KXMLmtiM0zJTiuHUuO
         CJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104146; x=1694708946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTZiVHD7Dy47C2G1POahYLjCNkC/+FHp1IXLLCvkc3w=;
        b=R0iL5ZC9DD46J3RPGGQ+XkpYfuaAosl4SRixeFfWvNItQlK80SjnWlYpnZbLkXtE/6
         UGg94++6F/lC+dvC9aH+VY3F8/yv1WvQQiG6iqyyUABg/E+jbiXJJH5IZ1ZTpFHm3fjn
         5EEbb1plr/vwLWcDA9XN7TzpUiKBMvBBvzba8PzZY3OSbRX+Vn0JUSCIxwR+C8ceyDqe
         x0b82U+ax2ZH8p58GTcAgBkWAz/ehGN2vtUx07vjwOX1P0TV5gimgEkjf2xQqKyy+2oR
         e6vuS3SlRllgaiU5HqrVxwSW/lx32VVDkRR9K0p7oJK6fgMnUU5SLTN1T2vbMSF5Z81x
         Ix3g==
X-Gm-Message-State: AOJu0YznWDTlAlojvr8NXAFhHTbfRrpEC7AFKER/GMtCU6I9zgtsicdj
        UkPDW4nSx1KIyx8AX2dMUQsYxbUJZZ/+x9Ob/Ue+kMNQ
X-Google-Smtp-Source: AGHT+IFq7Kjy57NRFk5aspgjPpSsjcToHiDO4/fk12JEjrOQZwPwjib4RfZjGYEnI5chAD7gsKRJdEPoCeUNAb6JiPo=
X-Received: by 2002:a17:906:73dc:b0:9a9:ec12:4825 with SMTP id
 n28-20020a17090673dc00b009a9ec124825mr314854ejl.56.1694075843357; Thu, 07 Sep
 2023 01:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com> <20230602102533.876905-15-christian.couder@gmail.com>
 <87cz1nst1s.fsf@iotcl.com>
In-Reply-To: <87cz1nst1s.fsf@iotcl.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Sep 2023 10:37:11 +0200
Message-ID: <CAP8UFD0Jj5KrAyAa6uD_gTYNxSy8zLtjk8Pg8QyCc0d5ZZfRvw@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] replay: add --contained to rebase contained branches
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2023 at 12:13=E2=80=AFPM Toon Claes <toon@iotcl.com> wrote:
>
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.tx=
t
> > index 439b2f92e7..6fcaa44ef2 100644
> > --- a/Documentation/git-replay.txt
> > +++ b/Documentation/git-replay.txt
> > @@ -9,7 +9,7 @@ git-replay - Replay commits on a different base, withou=
t touching working tree
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git replay' (--onto <newbase> | --advance <branch>) <revision-range>.=
..
> > +'git replay' ([--contained] --onto <newbase> | --advance <branch>)
> > <revision-range>...
>
> I'm not sure we need this, or at least not right now.
> I've been testing with a repo having:
>
> * a13d9c4 (another-feature) yet another commit
> * c7afc2e (HEAD -> feature) third commit
> * e95cecc second commit
> * f141e77 first commit
> | * 7bb62ac (main) later commit
> | * 506cb0a another commit
> |/
> * e7acac6 initial commit
>
> I tried both commands:
>
> $ git replay --onto main main..feature main..another-feature
> $ git replay --onto main --contained main..another-feature
>
> and they both give the same result (especially with the commit following
> up this one). What is the upside of having this --contained option?

This is expected. The thing is that:

$ git replay --onto main main..another-feature

will only output something to update 'another-feature'

while:

$ git replay --onto main --contained main..another-feature

will output something to update 'another-feature' and also something
to update 'feature'.

So when you use --contained you don't need to first find the other
branches like 'feature' that point to commits between 'main' and
'another-feature', as --contained will find them for you.

> Maybe it's better to defer this patch to a separate series.

I am not sure why you are proposing this. It's true that there are
other means to achieve the same thing as --contained, but that doesn't
mean that it cannot be useful already. If there were things that
needed to be more polished in this feature, then maybe leaving it for
a separate series later might allow this series to graduate while
--contained is polished, but I don't think we are in this case.

> And another question, in git-rebase(1) a similar option is called
> --update-refs. Would you consider reusing that name here is a good idea
> for consistency?

`git replay` outputs commands that can be passed to `git update-ref
--stdin`, but for now it doesn't run that command itself. So no refs
are actually updated. If we ever add an option for git replay to also
update the refs, it would have a name probably quite similar to
--update-refs so it would be unfortunate if --update-refs is already
used for something else.

--contained also tells about the fact that the branches affected by
the option are "contained" in the revision range that is passed, which
is nice.

In short I think it's just unfortunate that git rebase already uses
--update-refs for the "contained" branches, as it would be likely to
confuse people if we would use it here for that.
