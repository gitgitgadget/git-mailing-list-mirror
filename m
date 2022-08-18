Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F0C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbiHRPX5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Aug 2022 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbiHRPX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:23:56 -0400
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [217.11.48.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057BB275C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:23:55 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy06.manitu.net (Postfix) with ESMTPSA id 38D4E580077
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 17:23:52 +0200 (CEST)
Received: by mail-il1-f175.google.com with SMTP id a9so682342ilr.12
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:23:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo2UHaGSOjlv4kAT3bbugJMQfo7GlMrS7WmUAatGZCLgFQOoiFHw
        iYIr82ZZDG0+RyLFf8ZqoxJe5EXFlFIEGOCkzUc=
X-Google-Smtp-Source: AA6agR6e3+xHDFkxMKBDCAQbofn0J2S0xn7eVIfXHu3oggs0yUpijzWlKOkEW/pMEaCuyfJb/XyIth/zlQGh3AvRoNs=
X-Received: by 2002:a05:6e02:1a85:b0:2e5:eaf2:3849 with SMTP id
 k5-20020a056e021a8500b002e5eaf23849mr1698864ilv.111.1660836230817; Thu, 18
 Aug 2022 08:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
 <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu> <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
In-Reply-To: <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Date:   Thu, 18 Aug 2022 17:23:39 +0200
X-Gmail-Original-Message-ID: <CAA19uiTDeVmUHRVd8JK+qLmwTCN_eiY49yEJERi1mLn9oU4hYA@mail.gmail.com>
Message-ID: <CAA19uiTDeVmUHRVd8JK+qLmwTCN_eiY49yEJERi1mLn9oU4hYA@mail.gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to error_resolve_conflict()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Do., 18. Aug. 2022 um 17:02 Uhr schrieb Ævar Arnfjörð Bjarmason
<avarab@gmail.com>:
>
>
> On Thu, Aug 18 2022, Michael J Gruber wrote:
>
> > `error_resolve_conflict()` checks the untranslated action_name
> > parameter, so pass it as is.
> >
> > Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Michael J Gruber <git@grubix.eu>
> > ---
> >  sequencer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 51d75dfbe1..8b32b239b9 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -537,7 +537,7 @@ static struct tree *empty_tree(struct repository *r)
> >  static int error_dirty_index(struct repository *repo, struct replay_opts *opts)
> >  {
> >       if (repo_read_index_unmerged(repo))
> > -             return error_resolve_conflict(_(action_name(opts)));
> > +             return error_resolve_conflict(action_name(opts));
> >
> >       error(_("your local changes would be overwritten by %s."),
> >               _(action_name(opts)));
> > @@ -3753,7 +3753,7 @@ static int do_reset(struct repository *r,
> >       init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
> >
> >       if (repo_read_index_unmerged(r)) {
> > -             ret = error_resolve_conflict(_(action_name(opts)));
> > +             ret = error_resolve_conflict(action_name(opts));
> >               goto cleanup;
> >       }
>
> Perhaps we should have the error_resolve_conflict() function take a
> "enum replay_action" instead? We could just do this more isolated
> change, but perhaps that "while-we're-at-it" would be acceptable to
> reduce the risk of running with this particular set of scissors.
>
> Then we could note in a comment in that function that we do not want to
> translate the string we'd get from action_name()...

Rather than setting out to do that, I'd retract 2/3/4 just to get 1
done, which was my original motivation ... or switch git to C again as
I did for a while in the past ...
