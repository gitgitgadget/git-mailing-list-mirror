Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A93C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiAXRa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiAXRa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:30:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5BEC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:30:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c24so55681445edy.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yHpSDthfhKEo5mlfg+K0EfIVt4RD6kmDnsUnHGgseP4=;
        b=YKNScUtAbG0mK3BRb3LaqmRxAVnge2ApVGdxAoZAWN9nP5ibofsCnmFYay9AxNBI5i
         Flqa9Mbl8LMIS9SVzxJKHmBUuy8it9MWL9oNKs/0fB+b/XizxjjZM0B5/9WQJpfmRQ5/
         +NB4JAeDUhgCbQS51+xnqRYc/AbBezVE5TsNr+MYlU2wIDwB/Z9p6f18Hk9Ti8tyx0ej
         Sy6ERwTKv7lSUvdQPxJg+/Jn5seQE292Bdkygl3wrWHIJHigjTSm7b1nWFwsfmueoqyp
         bjXjKX7ymXSt8VphyxlDPTqpvOJEUIoNCLsq/exfQQvEe3sE/gMMBs3Xy9qi7okIhdgf
         olxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yHpSDthfhKEo5mlfg+K0EfIVt4RD6kmDnsUnHGgseP4=;
        b=qFcw/4PAR0koIOwWVajOr2EDEC792uLzL/Og7uS57VYFzPMyFd6j9Flu1RtccMZMLc
         eN7ghhkU2+PtIjMW2bUHu/lOflHXZuGcPEImdsLvcew74P7NAdLlC6CwJIqL9NrTnwCk
         NvMOp/+zUPqH4nxru2I5mMthPdNLtNS/T8gmgovHLOpIS70r7q3gB6le1AAt6IWOFl3M
         yp5qC50DJUDdH+WNcQACKdikIIPy4gAz4wJFFmoQIW7T0usVjWRj5CSzcZWU3iMfouFE
         C+Ef56IxsKbbQzXEuQabWfKXqEnZWfbgyLmv8kbC7IU9wTPcvxR1DwXeNoyQ6+ah1Dqq
         KTCw==
X-Gm-Message-State: AOAM533/zHLjAi2Mgv1g0lcIbyg/bBuvu1YSQe39L0sdfhSm4cGZdhjk
        xKSc3g0oJR6Y0nFVgYAE57usruqJdwIXVbPc+QU=
X-Google-Smtp-Source: ABdhPJxgMx5DzLjgpAmMEYwZDLMg1zwNndQe3+XT5qNbpvtMrbzAU8ELGxow7FIhNRSAk5fvp7nbpbkO4IQ8hWLUEaw=
X-Received: by 2002:a05:6402:5216:: with SMTP id s22mr1017238edd.359.1643045426760;
 Mon, 24 Jan 2022 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <050add3e4986c457cd467b36eb4fd1f215b7406d.1642888562.git.gitgitgadget@gmail.com>
 <220124.864k5tigto.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.864k5tigto.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 24 Jan 2022 09:30:15 -0800
Message-ID: <CABPp-BGnOes7J_piDyBUeuLVm274w4-9G3k0vR-0it3z7TPn_w@mail.gmail.com>
Subject: Re: [PATCH 10/12] merge-tree: provide easy access to `ls-files -u`
 style info
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 2:11 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Jan 22 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Much like `git merge` updates the index with information of the form
> >     (mode, oid, stage, name)
> > provide this output for conflicted files for merge-tree as well.
> > Provide an --exclude-oids-and-modes option for users to exclude the
> > mode, oid, and stage and only get the list of conflicted filenames.
> > [...]
> > +--exclude-oids-and-modes::
> > +     Instead of writing a list of (mode, oid, stage, path) tuples
> > +     to output for conflicted files, just provide a list of
> > +     filenames with conflicts.
> > +
> > [...]
> > -This is a sequence of lines containing a filename on each line, quoted
> > -as explained for the configuration variable `core.quotePath` (see
> > -linkgit:git-config[1]).
> > +This is a sequence of lines with the format
> > +
> > +     <mode> <object> <stage> <filename>
> > +
> > +The filename will be quoted as explained for the configuration
> > +variable `core.quotePath` (see linkgit:git-config[1]).  However, if
> > +the `--exclude-oids-and-modes` option is passed, the mode, object, and
> > +stage will be omitted.
> >
> >  Informational messages
> >  ~~~~~~~~~~~~~~~~~~~~~~
> >
> >  This always starts with a blank line to separate it from the previous
> > -section, and then has free-form messages about the merge, such as:
> > +sections, and then has free-form messages about the merge, such as:
> >
> >    * "Auto-merging <file>"
> >    * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
> > @@ -113,6 +123,14 @@ plumbing commands since the possibility of merge c=
onflicts give it a
> >  much higher chance of the command not succeeding (and NEWTREE containi=
ng
> >  a bunch of stuff other than just a toplevel tree).
> >
> > +git-merge-tree was written to provide users with the same information
> > +that they'd have access to if using `git merge`:
> > +  * what would be written to the working tree (the <OID of toplevel tr=
ee>)
> > +  * the higher order stages that would be written to the index (the
> > +    <Conflicted file info>)
> > +  * any messages that would have been printed to stdout (the <Informat=
ional
> > +    messages>)
> > +
> >  GIT
> >  ---
> >  Part of the linkgit:git[1] suite
> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index d8eeeb3f306..7aa7f9fd54a 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -395,6 +395,7 @@ struct merge_tree_options {
> >       int real;
> >       int trivial;
> >       int show_messages;
> > +     int exclude_oids_and_modes;
> >  };
> >
> >  static int real_merge(struct merge_tree_options *o,
> > @@ -461,7 +462,11 @@ static int real_merge(struct merge_tree_options *o=
,
> >               merge_get_conflicted_files(&result, &conflicted_files);
> >               for (i =3D 0; i < conflicted_files.nr; i++) {
> >                       const char *name =3D conflicted_files.items[i].st=
ring;
> > -                     if (last && !strcmp(last, name))
> > +                     struct stage_info *c =3D conflicted_files.items[i=
].util;
> > +                     if (!o->exclude_oids_and_modes)
> > +                             printf("%06o %s %d\t",
> > +                                    c->mode, oid_to_hex(&c->oid), c->s=
tage);
> > +                     else if (last && !strcmp(last, name))
> >                               continue;
> >                       write_name_quoted_relative(
> >                               name, prefix, stdout, line_termination);
> > @@ -495,6 +500,10 @@ int cmd_merge_tree(int argc, const char **argv, co=
nst char *prefix)
> >                        N_("do a trivial merge only")),
> >               OPT_BOOL(0, "messages", &o.show_messages,
> >                        N_("also show informational/conflict messages"))=
,
> > +             OPT_BOOL_F(0, "exclude-oids-and-modes",
> > +                        &o.exclude_oids_and_modes,
> > +                        N_("list conflicted files without oids and mod=
es"),
> > +                        PARSE_OPT_NONEG),
> >               OPT_END()
> >       };
>
> Perhaps this really is the last formatting information anyone will want,
> but with a default of "<mode> <object> <stage> <filename>" being made
> "<stage> <filename>" with --exclude-oids-and-modes perhaps we'll want
> --exclude-all-except-filename etc. later.

Um, that's actually what this option does.  Maybe my chosen name was bad.

--name-only like ls-files uses would have been nice, but it's
misleading since it only affects the <conflict info> section of the
output, not the printed tree or the informational messages.

> It seems a lot simpler for new code to just support a --conflict-format
> option, lifting some code from the in-flight
> https://lore.kernel.org/git/db058bf670c5668fc5b95baf83667cc282cb739b.1641=
978175.git.dyroneteng@gmail.com/
>
> I.e. that inner loop becomes a slightly more verbose strbuf_expand(),
> but it's all easy boilerplate code.
>
> Then we just feed "%(objectmode) %(objectname) %(objectstage)
> %(filename)" into it by default, and allow the user to customize it.

"simpler"?  More flexible certainly.

I'm not sure that the flexibility is warranted, in this case, though.
In ls-trees, where users don't need to process the output and can feed
it directly to something else, that flexibility makes sense.  But here
the output *needs* special post-processing anyway since it's mixing
three different types of output by default: top-level tree, conflicted
file info, and informational conflict messages.  (In my previous round
I tried to split these kinds of output to separate locations so they
could be parsed separately, but both Dscho and Christian didn't like
that).

So, the default I figured should be to just provide all the
information and just let others process it as wanted.  But Taylor had
said earlier that if there were conflicts the only information he
wanted was a list of conflicted files (no stages, oids, or modes), so
I figured an option making that a bit easier to extract was
worthwhile.  And that's what this patch is about.
