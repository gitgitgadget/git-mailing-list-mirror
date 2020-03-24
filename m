Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BCC54EEB
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EF42080C
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUG6YS9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCXJIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:08:51 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:43070 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCXJIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 05:08:51 -0400
Received: by mail-ed1-f43.google.com with SMTP id bd14so5984078edb.10
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YoJSoxawLxJDX7WiXcrXkfPxruPblgcDru9Uu2PtoEg=;
        b=hUG6YS9peOG9Ig/4EGNCPnZdlwNWj9xhJ8Lfg6hH4xoHbPfIdIOFPLzDd2ShpQJHN2
         UuLbf7jw+N8ZMg9HkPeVl7fpoz2lnSF/YPFLCHUtjRGGgXESao2cvPGD8EdUyKOMzzu2
         tMIDxwWYHC3R7ykBqZWy/AiNcxenKdtWsIGZCMTzq4QT2IS7jkX3qKP+HN2HL/TIlGZQ
         al1b0jLXRKPyTPCKo5O4sBaMqcH9Y/gsPoVFpwhYJEvmB1tGjacr1zhOBuAZQB5Er9KP
         9HhMPLk1uKb/CP1ABR7dWd1bWPAiZtJIUnno0tCGxdUPnUzOmmMPiMXQx1CZ3aWOQxPI
         v5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YoJSoxawLxJDX7WiXcrXkfPxruPblgcDru9Uu2PtoEg=;
        b=GBp7PGk6iw4b0pOVjoo1zWLC1HfcUs0AK9khD8LKThMV4A0CpoP7zjhTEFfA/UL6gW
         gboaXxBj5k95nhaEhvlkyS2pSX0RofY3HiNAx7wfhYTuVPqcl9uiw16Am8NAvKYisE4m
         EbM8KJDEB9BeBeQBe3ojtvlzK9MrXiFpTmIK/mbBunhbwlW+8J6B2OfL5XEdnHwR3gr6
         HEpCt1S/fjPs6+cuMCdxC3i+kZiQMrGljwQS8iXOMJExPeSuyo2SdokrI1wUQOZ7HjfZ
         YYRYF/2n7xgFzt2BbhfxgLvO/1ydHzzj1OTHIkHw7tdHhlIPkbLdzc03L1O+641sTSk5
         Dbpw==
X-Gm-Message-State: ANhLgQ0MpxhLyBIxvad4l1aewGwvy6bgBI/QyWu8uzHPGaxvlBNvUiKA
        /7ZkEksuV3s+Vjh5ChCOiZHPgqKrLDewOoS7MIM=
X-Google-Smtp-Source: ADFU+vsX2Yf3RXaEtNwN9snP3bKGKI9/Cghe+/IhJB5XyR23XwnwRCkqMxvYTzU2Q3UinrLWxIf/9X7/lbpWjoaikzg=
X-Received: by 2002:a50:d744:: with SMTP id i4mr11364453edj.87.1585040928579;
 Tue, 24 Mar 2020 02:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200323171554.5254-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200323171554.5254-1-shouryashukla.oo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Mar 2020 10:08:37 +0100
Message-ID: <CAP8UFD3BMEqt1+gGgGPHdMQ+BzY6Q84rGcp2UNK=WLusYQuy4g@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal v4] Convert submodule to builtin
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Heba Waly <heba.waly@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Mar 23, 2020 at 6:16 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:

> Prathamesh implemented and improved the subcommands status[https://lore.k=
ernel.org/git/20170713200538.25806-4-pc44800@gmail.com/], sync[https://lore=
.kernel.org/git/20180114211529.6391-2-pc44800@gmail.com/], deinit[https://l=
ore.kernel.org/git/20180114211529.6391-3-pc44800@gmail.com/] and some more.=
 The relevancy of this to my project is that some helper functions(located =
in submodule.c) such as print_submodule_summary(),prepare_submodule_summary=
(), etc. have been implemented beforehand. In the case of subcommand summar=
y, use these functions, integrate them with the basic scaffolding(mentioned=
 in the table below) and implement the module_summary() frontend function.

The last sentence above is not very clear to me. Do you mean "In the
case of subcommand summary, I should use these functions, integrate
them ..."? Or maybe  "In the case of subcommand summary, the things
left to do are to use these functions, integrate them ..."?

> He also ported various helper functions such as set_name_rev()[https://lo=
re.kernel.org/git/20170619215025.10086-3-pc44800@gmail.com/]. He kept offer=
ing improvements to his conversions till around January of 2018.

Nice!

> Stefan Beller finished the implementation of the subcommand init[https://=
lore.kernel.org/git/1453418323-29587-1-git-send-email-sbeller@google.com/] =
as well as laid its foundation[https://lore.kernel.org/git/1453255396-31942=
-3-git-send-email-sbeller@google.com/]. He implemented foreach[https://lore=
.kernel.org/git/20180509002952.172347-5-sbeller@google.com/] and improved d=
einit[https://lore.kernel.org/git/20180327232824.112539-1-sbeller@google.co=
m/] & update[https://lore.kernel.org/git/1444960333-16003-6-git-send-email-=
sbeller@google.com/] as well. He also ported various helper functions such =
as resolve_relative_url()[https://lore.kernel.org/git/1460767813-25916-2-gi=
t-send-email-sbeller@google.com/].

Nice!

> #### Current Status of the subcommand and future vision
>
> The current status of the conversion as well as the direction I will take=
 for the conversion of the subcommands are as follows:
>
>         add: pending conversion, full code needs to be written for the sa=
me. Need to implement callback macros and structures, i.e. struct add_cb,
>              ADD_CB_INIT, as well as frontend function module_add(). Othe=
r helper functions may be needed in the process as well. Compare with shell
>              script and try to =E2=80=9Ctranslate=E2=80=9D it into C. I g=
uesstimate around 400-500 lines of code for this(including helper functions=
).

Happy to see a guesstimation!

>         set-branch: pending conversion, full code needs to be written for=
 the same. Need to implement macros and structures, i.e. struct setbranch,
>                     SETBRANCH_CB_INIT, as well as frontend function modul=
e_setbranch(). Other helper functions(such as remote_submodule_branch() &
>                     get_default_remote() which are already implemented ma=
y prove helpful later) may be needed in the process as well. Compare with s=
hell
>                     script and try to =E2=80=9Ctranslate=E2=80=9D it into=
 C. This subcommand may take about 200 lines of C code to implement(includi=
ng helper functions).

As it looks like it requires less lines of code, do you think it might
be better to do this one before the 'add' sub-command?

>         set-url: pending conversion, full code needs to be written for th=
e same. Need to implement macros and structures, i.e. struct seturl,
>                  SETURL_CB_INIT, as well as frontend function module_setu=
rl(). Other helper functions(such as remote_url() & resolve_resolve_url() w=
hich
>                  are already implemented may prove helpful later) may be =
needed in the process as well. Compare with shell script and try to =E2=80=
=9Ctranslate=E2=80=9D it
>                  into C. It will have a similar implementation to set-bra=
nch because they are =E2=80=9Csetter=E2=80=9D functions. This subcommand ma=
y take about 200 lines
>                  of C code to implement(including helper functions).
>
>         summary: pending conversion, work in progress; callback structure=
s, functions and macros have been created, also, basic scaffolding of the c=
ommand
>                  is done, i.e., functions module_summary(), summary_submo=
dule(), summary_submodule_cb(). As this is a prototype, some functions may =
be scrapped
>                  or added later. Other functions to complement the subcom=
mand have already been created; learn from Prathamesh's mistakes and implem=
ent a better code.
>                  After discussions with Junio C Hamano[https://lore.kerne=
l.org/git/20200318163234.21628-1-shouryashukla.oo@gmail.com/T/#ma3912b761b6=
deda937691a19c1a070e5e9b34bd7],
>                  I intend to add a =E2=80=9C--recursive=E2=80=9D option a=
s well for summary so as to obtain summaries of nested submodules as well.
>                  I estimate about 400 lines of code for this subcommand(e=
xcluding the  =E2=80=9C--recursive=E2=80=9D option, yet including the helpe=
r functions)

Nice!

> I aim to follow the same approach as Stefan and Prathamesh as mentioned a=
bove.

I am not sure that you talked much about their approach above.

> Though, there is about a 3 year gap between their work and mine, the mode=
l for porting seems to be consistent even if coding style may vary and migh=
t even give out improvements over previous implementations.



> #### Contribution process and interaction with the mentors
>
> I will keep committing changes on my GitHub fork[https://github.com/perip=
eridip/git] and finally post a bundled patch on the Mailing List.

By "bundled patch" do you mean a patch series?

> I will make sure to keep interacting with the community as well as the me=
ntors regularly.    I aim to write weekly =E2=80=9Cprogress report=E2=80=9D=
 blogs, which I will post on my website as well as the List. Apart from tha=
t, I will document anything new I learn as well as my journey in the GSoC p=
rogram on my blogs and maybe as self-answered questions on StackOverflow wi=
th the aim that they will help me as well as others in case of reference.
>
>
> #### Project Timeline
>
> I have been studying the code of 'submodule.c', 'submodule--helper.c' and=
 'git-submodule.sh'
> since the submission of my microproject. After studying the codes, I trie=
d to devise an effective
> conversion strategy for 'submodule'. I noticed that 'submodule.c' contain=
s various helper functions
> for 'submodule--helper.c' whereas the latter houses the main "converted" =
command as of now.
>
> The subcommands =E2=80=98set-branch=E2=80=99 and =E2=80=98set-url=E2=80=
=99 will provide easy conversion due to the vast array of helper functions =
already available for them.

Nice that you found this!

> Hence, I have coupled them with other commands and tasks such as the conv=
ersion of =E2=80=98add=E2=80=99 and improving CLI parsing.

Hmm.

> In spite of the easiness of the aforementioned conversions, I have decide=
d to convert =E2=80=98summary=E2=80=99 first because of the large variety o=
f resources available for it

It is not very clear which resources you are talking about.

> as well as a direction of conversion available(as done by Prathamesh)

Do you mean that he already sent patches or wrote commits in his repo
about that?

> which will aid me in learning from the mistakes committed before and thus=
 help me offer an even more improved version of the subcommand.

Thanks,
Christian.
