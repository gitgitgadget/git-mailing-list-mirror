Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBBFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiJaOmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiJaOl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 10:41:58 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F137764F
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:41:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-36cbcda2157so109511867b3.11
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwd+PSZCbh5OuPCUPThC72emtMvZ5RFOe4uEU/O/cDE=;
        b=jgm9Ryjof4WvGsamP2Ra8NrXz5k4ytEWNsLbyekBQb7huN690WTUyYkOWH8VI+7Wq9
         jqCGhfZmd+MdQxqmj96yyWPGxjZMMu81BaGElzWiJ0g+6AVtHuMHQ6uUyqgD+WjGRPMy
         mYUB/k8GEcvAT6IWMa4aLkfWEkipR0huHYhCpofPvmemAe0earmQ/XkAC+iIt8ZOY5GX
         Cz4mZwVfr5Hrigj449s4nXxZBQIKC1yYzC33wsw1C0YZs1nVzS4GNYnMdwIv04xZhPYm
         0O44N5a0s8Ab8Rbv6PywRdmveHh0TbmDvwp8knNplG6d+thYkXfxWFEVlD/dX5Ftp/wX
         9RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rwd+PSZCbh5OuPCUPThC72emtMvZ5RFOe4uEU/O/cDE=;
        b=FKGQgJuEbDp26Mh/LQLvRlTmSY8Y29fU3XRFNJERQkcQh9kPPbk1KlO2SOgjKmcK0O
         I59/hZqXlOF0IpM7YV+akv1mJ5nP00SCakToUst7ZqxHuTo9uH4bKziTp2sbRpmO74Ad
         2tHYrySyyVI1vYmQtRhgSeVJLCxdKlwTPsE/+9xhj+JshR84TZBSBhiETpETw4DsCPeb
         NArzs7tZIbhyyEcHmI474KT6n4CeiBUFrufzjqK7IioR7uNSXEMXYhLnve0fsm1cPJC9
         Dne8EGXwFdt2zctkxYdVw5iLNxhkUMh8z5ONwhg8tGPYFZGTKvd9Rv76XRDktA/Egqqi
         Jjvg==
X-Gm-Message-State: ACrzQf1Lc4idLXlJTfXibxlM/n+Qs2lTHMF1681zshwICwpK9LIsvXzg
        Pw9KoSq5mKS5LZs3ZRf9F8bhjFsdImRo1V+VS3k=
X-Google-Smtp-Source: AMsMyM70QvCRfs03Wary8zc1iDo8PNlSTsuWzGQ+Kv08vuYHwqjZRG1cgHMuVcuuPFw2pwzDcvFH7ajv40md7V7DeHQ=
X-Received: by 2002:a81:a109:0:b0:367:efbe:e1f0 with SMTP id
 y9-20020a81a109000000b00367efbee1f0mr13176913ywg.365.1667227317208; Mon, 31
 Oct 2022 07:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com>
 <CA+CkUQ_pqQomaA=MO78PsC0oA8GcE0dJ415fpjcLx6k5HNaDiw@mail.gmail.com> <CAOLTT8QygkMyjFqxsOo8fqh3yWE3najwv+Y8ekr8MP9d_+dotg@mail.gmail.com>
In-Reply-To: <CAOLTT8QygkMyjFqxsOo8fqh3yWE3najwv+Y8ekr8MP9d_+dotg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Oct 2022 15:41:45 +0100
Message-ID: <CAP8UFD2skja6kE+w1vPewueQ2wzEck61wiZMftUyA+q=JZ+SMA@mail.gmail.com>
Subject: Re: [OUTREACHY V2] Unify ref-filter formats with other --pretty formats[proposal]
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Hariom verma <hariom18599@gmail.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing and Wilberforce,

On Mon, Oct 31, 2022 at 3:26 PM ZheNing Hu <adlternative@gmail.com> wrote:
> Hariom verma <hariom18599@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 16:08=E5=86=99=E9=81=93=EF=BC=9A

> > > Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifyi=
ng Git=E2=80=99s
> > > format languages=E2=80=9D during Outreachy Round 15 and continued eve=
n after
> > > that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
> > > `cat-file` and `ref-filter`.
> > >
> > > She already did a pretty nice job in preparing ref-filter for more
> > > general usage of its formatting logic. It will give me the possibilit=
y
> > > to make the migration of pretty.c easier.
> >
> > ZheNing Hu continued the Olga's work during GSoC'21. You can tell a
> > bit more about that too.
>
> I'm afraid I'm skeptical about the progress of this project. Yes, this
> project has
> been going on for too long, probably 3 years, and it is long overdue
> to be merged
> into master. Maybe we all need to rethink the nature of this project inst=
ead of
> rushing to start writing code.
>
> As far as I know, these unified format refactor are easy to implement, bu=
t as we
> use more complex parsing logic, there will be a lot of performance degrad=
ation.
>
> I recommend new contributors to perform performance analysis and performa=
nce
> optimization directly based on the original developer's patches.

Yeah, I agree that the project to use ref-filter formats in cat-file
is very hard due to performance issues, and I think we shouldn't
suggest it anymore as a project to GSoC or Outreachy applicants.

The project we are proposing for Outreachy, and that Wilberforce is
writing a proposal for, is about unifying "ref-filter formats" with
"pretty formats" though. So there is no need to touch cat-file code as
"pretty formats" are not used there. Actually it might not even be
needed to mention using ref-filter formats in cat-file (and the
related work made by Olga and ZheNing on this). It could perhaps help
with understanding the big picture, but that's it.

Thanks,
Christian.
