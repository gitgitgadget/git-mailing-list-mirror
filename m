Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9371F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeHIUIk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:08:40 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37135 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:08:40 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so5549791ywg.4
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yoGjIUiziMUO4z9cKrGQa+dPz6TKZuDeqWC+ZqUlQWg=;
        b=ZqAvdkJ8TN2igTQOMsXY2CDECotdyPfiS4aEcUuN3AUbWgjN4H1azAWBxVstY3ER4j
         h1riTuGr93Yrq4nHV58tG88nQBSs/scRBcr+fVQA2F3u0R1aFwSRXpBFiRYDl7CsiLi6
         QkeBXUNv4zZI6XlAJXFr21t+59VaWmQnhpRloNYBniSuD7ykDhvL4PTqRdLI8C7Smzn9
         YIu5jDzTSL853qn6IxEuUwarWfulpfFt+HR7ANB/MNj8NMLaSS4hgBRB4kZXbpzH3YUO
         ZX3RucrK8Auq/Zlo7PDr+kgtzRFCjHDvV2qw+qI6i1LFfSDpl4MzdVX+9Gio9lrlJocj
         l0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yoGjIUiziMUO4z9cKrGQa+dPz6TKZuDeqWC+ZqUlQWg=;
        b=X6pIJvfMB9R0xjJJoH0FOz8xoMJoLBiCwYaaPejUlG2eIFD32oRUkxSlLhNWQLill0
         hLLipakSOvcnI09A2m5Q04a0XgFt2oMq2ArUuhGsxvKs77V6GaJsYqBOoG9f9v9pVXOx
         OhAV0yJJqVMfTTyY3Vtf3q42q//fCGVZEDgwFTdJPi98m5+HwA7Smo9lxi94SFEo78sh
         0+dzvbTnGHtz2kkTZCEvSEA3BqZggHDn+TiqXwmGypnYTDKSXfLmt95q/WCHuo12Sq5t
         eaO627NfE5PfvHUPeUDIpH9VOoIkIQARUH3S5W66+sNNa/P9ZF9+n8LuoH6Ww20xN4Jw
         f6yw==
X-Gm-Message-State: AOUpUlH3PUYfujZxlrNgfKFmu0WP0j30vkRZsWkJtFhb8NvZmrOe/B9W
        zgC3rcvke9s/eX+H3TTHdYaJvFPEI3JRCdpZNbbp8A==
X-Google-Smtp-Source: AA+uWPyTsVzzez1mY4MtdY1jfxPYoTAu1O4L3RTWkdvTK3AjJCnuuG046IDfpfY3jiHFfLsBQR7ksOlbIR3QnjeWuXY=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr1642870ywk.345.1533836565281;
 Thu, 09 Aug 2018 10:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-11-sbeller@google.com>
 <CAN0heSpsbYWzujzyteWuhto9DTXzvAkP+vt++d7ar3ob6Zx=Gg@mail.gmail.com>
In-Reply-To: <CAN0heSpsbYWzujzyteWuhto9DTXzvAkP+vt++d7ar3ob6Zx=Gg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 10:42:34 -0700
Message-ID: <CAGZ79kbkLDhiqYrd6epPVP7dLLR7AFApyas=_mgeCucngJONMg@mail.gmail.com>
Subject: Re: [PATCH 10/10] fetch: retry fetching submodules if sha1 were not fetched
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 12:50 AM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
> > Currently when git-fetch is asked to recurse into submodules, it dispat=
ches
> > a plain "git-fetch -C <submodule-dir>" (and some submodule related opti=
ons
> > such as prefix and recusing strategy, but) without any information of t=
he
> > remote or the tip that should be fetched.
> >
> > This works surprisingly well in some workflows (such as using submodule=
s
> > as a third party library), while not so well in other scenarios, such
> > as in a Gerrit topic-based workflow, that can tie together changes
> > (potentially across repositories) on the server side. One of the parts
> > of such a Gerrit workflow is to download a change when wanting to exami=
ne
> > it, and you'd want to have its submodule changes that are in the same
> > topic downloaded as well. However these submodule changes reside in the=
ir
> > own repository in their on ref (refs/changes/<int>).
>
> s/on/own/
>
> > Retry fetching a submodule if the object id that the superproject point=
s
> > to, cannot be found.
> >
> > Note: This is an RFC and doesn't support fetching to FETCH_HEAD yet, bu=
t
> > only into a local branch. To make fetching into FETCH_HEAD work, we nee=
d
> > some refactoring in builtin/fetch.c to adjust the calls to
> > 'check_for_new_submodule_commits'.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
>
> > diff --git a/submodule.c b/submodule.c
> > index ec7ea6f8c2d..6cbd0b1a470 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -1127,6 +1127,7 @@ struct submodule_parallel_fetch {
> >         int result;
> >
> >         struct string_list changed_submodule_names;
> > +       struct string_list retry;
> >  };
> >  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_L=
IST_INIT_DUP }
>
> `retry` will effectively be `STRING_LIST_INIT_NODUP`, but making that
> explicit would be better and the next addition to the struct would be
> easier to get right.
>
> > +retry_next:
> > +       retry_it =3D string_list_pop(&spf->retry);
> > +       if (retry_it) {
> > +               struct strbuf submodule_prefix =3D STRBUF_INIT;
> > +               const struct submodule *sub =3D
> > +                               submodule_from_name(spf->r,
> > +                                                   &null_oid,
> > +                                                   retry_it->string);
> > +
> > +               child_process_init(cp);
> > +               cp->dir =3D get_submodule_git_dir(spf->r, sub->path);
> > +               if (!cp->dir)
> > +                       goto retry_next;
>
> So here you just drop the string list item. Since it's NODUP, and since
> the `util` pointers are owned elsewhere(?), this seems fine. Other uses
> of `string_list_pop()` might not be so straightforward.
>
> Just a thought, but rather than pop+if+goto, maybe
>
> while ((retry_it =3D )) {
>         ...
>         if (!cp->dir) continue;
>         ...
>         return 1;
> }

I really want to keep the retry list short and pruned, as this
function is called O(n) times with n the number of submodules
and the retry list will also be up to n.
And with that we'd run O(n^2) times into "if (!..) continue;".

When we use the 'pop-no-work items' logic, then we're still in O(n).

> I haven't commented on any of the submodule stuff, which is probably
> where you'd be most interested in comments. I don't use submodules, nor
> do I know the code that runs them.. I guess my comments are more "if
> those who know something about submodules find this series worthwhile,
> you might want to consider my comments as well".

Thanks for your comments! I'll try to think of another way to
represent this more easily in code.

Thanks,
Stefan
