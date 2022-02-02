Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8892C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 23:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiBBXTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiBBXTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 18:19:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73297C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 15:19:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ah7so2112359ejc.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 15:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcsCbs0++pJ60pB/Cq1Uj5kjNwi47I+0nJ8TdrfpChg=;
        b=JF4HXC8Kgjd4HR66Gh0kte2ejxZUWm8bDAiIzWYH6pR2CvoTK3L+EXQ1OXx2eYVq3H
         UH1S+KiWIztPnINPMrEn9WrHuhQRuz72l/2JdH0wYb408FmLCJq1Nb53qBnfRwEyXlJv
         UIjJgYW3Vx4xQNBDNrw6YkdUsNujQnSRZv6VvZqNlunGFlNZ3gn/A0H1JuOCYT9QJdOs
         FKU1D1nN3tIykzPFF6hbpjUH6aBfdHKtm2oZ053VW3Nph2bQ5C72x5ix5sX7foYjGOI7
         HX9jtbumyQ2TzoJrkBdvx+taoLh2wJQaKlOJWgJdnZMBW1eRZCuMR/gPG0quq4950GNt
         0eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcsCbs0++pJ60pB/Cq1Uj5kjNwi47I+0nJ8TdrfpChg=;
        b=vbZhgpqDiTKvO1CDQx+I2AUjJrvtcvD8V/QgVQR1mssxlRhDGBPQSIH2DN1TJPUw+j
         zfH2pnZnOGEc2YykQyEQXlue5Pkocid1lbhJVcM8Tg0Zki0WLSvXa08LDVQnNNe16FdT
         gc2wus5fkuCUuJSuOoY2WKoWeAhq1aPm31xhRSh77KviRk8g4s85VsRGczYsUEFOwauv
         TqHYcE7esGrOdgMODs9wAdoBwrodpycKXYqW8UD50W0+P6AZTu2CeCviY4XFm8aX4+k6
         nXENKnpO687WxWLW18XITCFQcRNfwUnhHVgYGZ5liTWNCGe47loy2ay07IFH3mqoMKF4
         I/qA==
X-Gm-Message-State: AOAM532MBWvnzJ1CKSZnKDd67dyTxM9b61KBCfj49di0XnEPtOu67Qm/
        fu51elFOfQ6gK4KobPcip+1dfl+wGEkr88YPsVA=
X-Google-Smtp-Source: ABdhPJzDHZA9WVGUOLrONqM6tVM76ihswFSFgKlfujDZkyB1/z+GTYg3yMa7B0uyZXEdfuP3DHF0v72Fn5DDr2fLl5Y=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr21316691ejc.328.1643843948986;
 Wed, 02 Feb 2022 15:19:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com> <c322e4c6938b7270b6e90998994642074a2813e0.1643479633.git.gitgitgadget@gmail.com>
 <xmqqr18lvts0.fsf@gitster.g>
In-Reply-To: <xmqqr18lvts0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Feb 2022 15:18:54 -0800
Message-ID: <CABPp-BGd38Yb_LaJWLG+oiTit0CVRkE-5vmviGfoUOtBFP6yMg@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] merge-tree: provide easy access to `ls-files -u`
 style info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 1:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -450,7 +451,11 @@ static int real_merge(struct merge_tree_options *o,
> >               merge_get_conflicted_files(&result, &conflicted_files);
> >               for (i = 0; i < conflicted_files.nr; i++) {
> >                       const char *name = conflicted_files.items[i].string;
> > -                     if (last && !strcmp(last, name))
> > +                     struct stage_info *c = conflicted_files.items[i].util;
> > +                     if (!o->exclude_modes_oids_stages)
> > +                             printf("%06o %s %d\t",
> > +                                    c->mode, oid_to_hex(&c->oid), c->stage);
> > +                     else if (last && !strcmp(last, name))
> >                               continue;
> >                       write_name_quoted_relative(
> >                               name, prefix, stdout, line_termination);
>
> OK.  The addition (and disabling of the deduping) is quite trivial.
> We do not even have to worry about line termination since the extra
> pieces of info are prepended to the pathname.  Nice.
>
> > @@ -485,6 +490,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> >                           N_("do a trivial merge only"), 't'),
> >               OPT_BOOL(0, "messages", &o.show_messages,
> >                        N_("also show informational/conflict messages")),
> > +             OPT_BOOL_F('l', "exclude-modes-oids-stages",
> > +                        &o.exclude_modes_oids_stages,
> > +                        N_("list conflicted files without modes/oids/stages"),
> > +                        PARSE_OPT_NONEG),
>
> Why does "-l" give shorter output than without it?  "-l" strongly
> hints a longer output than without, at least to me.  Just wondering
> if this will not become a source of confusion to future scripting
> users.

Here's another example where I was struggling with naming.  Something
like ls-tree's `--name-only` would have been nice, but I was worried
it'd be confusing since it only affected the conflicted info section
and does not suppress the printing of the toplevel tree or the
informational messages sections.  And the name
--exclude-modes-oids-stages was long enough that I wanted a short flag
for it, and just used the first letter of the description ("list
conflicted files...").  I'm happy to change either the long or the
short name for this flag if anyone has suggestions.
