Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04BECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 09:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiIWJzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiIWJze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 05:55:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45514E11B2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663926929;
        bh=2fBRYnltrnZSRNkQDFCkm8Z61zc1ECUzFC7LxQsK3so=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XtJwdwbhWj52QYABOdoYtAni2sKmMyQkrEi2q+wJQCxm7mzsTwP8lneXqc8HOwqa6
         zSA8XcXD9ZUn2Anj4PEjps8ZniRqSYMQzItzekJ4heHDcjabFh6mrxIC4tlMZw0hae
         aW1KTkiFkU7jsUFl645xoegVYIlx6y2JC7JUta/w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.113.77] ([213.196.213.28]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1pJd5d0VQO-00zoUH; Fri, 23
 Sep 2022 11:55:29 +0200
Date:   Fri, 23 Sep 2022 11:55:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3] merge-ort: fix segmentation fault in read-only
 repositories
In-Reply-To: <CABPp-BGizu+dq+8Hbqo5EjKFAWU_Ni9RwQ6p+4oUMLp0oamu7w@mail.gmail.com>
Message-ID: <916o55op-qpqo-5o41-931s-8q54p7301sr2@tzk.qr>
References: <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com> <CABPp-BGizu+dq+8Hbqo5EjKFAWU_Ni9RwQ6p+4oUMLp0oamu7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CZh1k7ss9CT85TfKADawKYXsvFyZF1vovQahjoKQPMZwKFVyxdR
 kW0u1JcFjNo8KDnZPk5RuT1v3nrECZX0lW/lBHxZZzFY1qygvgiFLPPQ21IkEyOP0lsMH90
 BHhSwR6/Mx2r2ZvTmcci5xprHGQ4iPygxCG+keTE1D/KlAkLFFwsPBQkORUWvy373Buqyjn
 +s9C/5RQJY87OZ6C0jiug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CPUDTS5l5bA=:JJdCPx5wR9AZKHu3bXJYAy
 6BK4bW1GKYV9lBf8VZhYwJ/d1ueZNXfTQB6vhpGKGYWdCrw9COXpTohhEVVF/N/dxVNqTxBRo
 gI9OYbj0DcuC3OTbCGVA5y+buwsHvMsaAjvZibX2lewItf3Psb2R+cKtzDsOWCSW0nWU63CKD
 MXvTzP2YGyFXFMoeO99wd/1/SPMEbIo1IchCQq8YQqxJOXD8oisdJTZ3vYEd62NHXsVO2QRex
 +9IZjpPMZqsYm+ul8U+p+9gT1Hp/b49VaaCKmtgqt5a5qoGm+WTee7ZTTXk+/sZNzyxmoD7U8
 GrzW5SRVgmht9DGGQKOj64b/YHhIhcl717Y7RGpBxrZxUHWMf6l4GzVeMy6WREYCAsDOFU+sd
 ZQzALdTNWQo99Lot+s2sha+EX54VGpwcMn8fO4KUgf/kJaCUNeq2iV4csij69M1D5XS7sSJC0
 LNKGYjHh9DdIxzGvSAu+jcZBdFdm16vzxp7a8r4ifF8/CUbGOYsSpcYMzPuB4E6ZOjZUe1y/c
 Gr7AH4UkwqrXEWyR55EjrWzyQtxD1WzCs85PFI7o7L9Vd2+qE8GGmxxm+pcjS9Smed/41/TyM
 hKtDuS3AgBkDp1fukftz97i/pK5ccNFC+axiwjziX4jIp8b0qnaFCroXY9fdz3qdeLAvlI63Z
 MheyJ0E8ueuIjPy2AEPoypUN9Nuh/IqoHjhRXZS499wCJwB8JOG/G+S9XrSM060DphOLEeJ20
 abNTopy9tZOO2DbNcyVyZFoe/J181ddQmcmYwrXn/GIeo5Y6BdGSa0ttYeIUnvoVHzd2uhsbS
 tbLSwxB4hhsuDEk2batUYdhrt65ZAzV2/Lornung2DtBdNO17Er18Z2x9zZlNS8lt0/kSejCQ
 fEjxHnxuQn0AD8sVm1+aHHjo/flNuUL6C/2SoTtRYhK+tbocD550oFVeCBvdhpN8ZFqDHXjbM
 eV0V17ANoV/sDChx8ToUfN5vgknnsTy7U0pURs6RVdlqzbQIY7WkcHorYsuuqofnryyAW6ubJ
 ACXeGSm8Z5wnVhSlryFEElkVHP4oCPcyDc0cuZqTeOsT/59NwB73iTJYsgeFtRIRF69DZ34Tu
 JJ4mYdMnOXxaR0M4g+FKWSsY6UL9p6w7IWIzVC2KiHOq5NvYYQy7ts6g4BBPc3Yv55qvKGheE
 G2noYma7iguvctD5wJMvz8ACw8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 22 Sep 2022, Elijah Newren wrote:

> On Thu, Sep 22, 2022 at 12:46 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 99dcee2db8a..f654296220e 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3571,15 +3571,15 @@ static int tree_entry_order(const void *a_, co=
nst void *b_)
> >                                  b->string, strlen(b->string), bmi->re=
sult.mode);
> >  }
> >
> > -static void write_tree(struct object_id *result_oid,
> > -                      struct string_list *versions,
> > -                      unsigned int offset,
> > -                      size_t hash_size)
> > +static int write_tree(struct object_id *result_oid,
> > +                     struct string_list *versions,
> > +                     unsigned int offset,
> > +                     size_t hash_size)
> >  {
> >         size_t maxlen =3D 0, extra;
> >         unsigned int nr;
> >         struct strbuf buf =3D STRBUF_INIT;
> > -       int i;
> > +       int i, ret;
> >
> >         assert(offset <=3D versions->nr);
> >         nr =3D versions->nr - offset;
> > @@ -3605,8 +3605,9 @@ static void write_tree(struct object_id *result_=
oid,
> >         }
> >
> >         /* Write this object file out, and record in result_oid */
> > -       write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
> > +       ret =3D write_object_file(buf.buf, buf.len, OBJ_TREE, result_o=
id);
>
> This sent me into a bit of a hunt to try to figure out what the return
> value of write_object_file() is.  I know it's non-zero on failure, but
> don't know if it's always positive or always negative or possibly a
> mix and how that maps to the idea of "clean_merge".  I gave up after a
> few indirections, to be honest.
>
> Anyway, regardless of my inability to find the answer to the above
> question, would this be a bit easier to read if we initialized ret to
> 0 and then did something like
>
>     if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
>         ret =3D -1;
>
> ?

You're right, this is a better pattern to follow because it makes it
easier to wrap your head around.

> > [...]
> > @@ -3769,8 +3770,9 @@ static void write_completed_directory(struct mer=
ge_options *opt,
> >                  */
> >                 dir_info->is_null =3D 0;
> >                 dir_info->result.mode =3D S_IFDIR;
> > -               write_tree(&dir_info->result.oid, &info->versions, off=
set,
> > -                          opt->repo->hash_algo->rawsz);
> > +               if (write_tree(&dir_info->result.oid, &info->versions,=
 offset,
> > +                              opt->repo->hash_algo->rawsz) < 0)
> > +                       ret =3D -1;
>
> This makes me wonder about write_tree() again.  What if its call to
> write_object_file() returns a value greater than 0?  Is that possible?

No, `write_object_file()` returns either 0 or -1, always. I followed all
the code paths.

Here is a tangent (feel free to skip over this lengthy analysis):

These code paths include a _very, very_ misleading one. In
`write_loose_object()` (which is called via the call chain
`write_object_file()` -> `write_object_file_flags()` ->
`write_object_file_flags()`), we call `finalize_object_file()`, see
https://github.com/git/git/blob/v2.37.3/object-file.c#L2030). And in that
`finalize_object_file()` function, we set `ret =3D errno;` in two places
(https://github.com/git/git/blob/v2.37.3/object-file.c#L1833 and
https://github.com/git/git/blob/v2.37.3/object-file.c#L1850).

When I read that, I chased down what the conventions are for `errno`
values. Now, while
https://pubs.opengroup.org/onlinepubs/007908799/xsh/errno.h.html does not
say anything about `errno` values being non-negative,
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
very much says:

	Values for errno are now required to be distinct positive values
	rather than non-zero values. This change is for alignment with the
	ISO/IEC 9899:1999 standard.

Terrible, right? If we set `ret =3D errno`, that means that we return
something positive!

I then even dug up the origins of the `ret =3D errno` statements. Turns ou=
t
that yours truly introduced the first of these `ret =3D errno` statements =
in
9e48b389990 (Work around missing hard links on FAT formatted media,
2005-10-26). :facepalm:

So why did I do such a thing? Well, back then, the `ret` value _already_
contained an `errno`, thanks to calling `link_temp_to_file()`, which _did_
return an `errno`. In fact, there was no code path in
`move_temp_to_file()` (as the function was called back then) that would
return -1, it always returned either 0 or an `errno`.

And after coming so far, after one hour of analyzing, I finally, finally
realized that there is no `return ret;` in that function. That function
has a `ret` variable that is never returned _from_ that function, but it
used to be returned _to_ that function, by the `link_temp_to_file()`
function that does not even exist any longer.

In my defense, this terribly misleading code was not even introduced by
myself. It was introduced in 230f13225df (Create object subdirectories on
demand, 2005-10-08).

tl;dr all is good, `finalize_object_file()` returns 0 upon success, -1
upon failure.

> If it is, are those error cases or not?  About half the callers in the
> code base that check the return value of write_object_file() check for a
> non-zero value, the other half check for a value less than 0.

And then there is `apply.c` where the return value isn't even checked at
all most of the time.

> And I can't find any documentation.  And it seemed like too much time
> for me to figure out what its range of return values was.
>
> [...]
>
> Nice to see that it didn't take too much work to propagate the -1 value
>from write_tree() up the hierarchy.  Nice work!

Thank you!

> I think we've still got some separate problems related to propagating
> the return value of the other write_object_file() call, from
> handle_content_merge().  The direct call in that other case is okay, but
> the higher levels at process_renames() and process_entry() seem to
> fumble it.  Your fix for failed tree writes is still valid without
> fixing the failed blob writes, and I'm happy to tackle the other half if
> you'd prefer to hand it off.  But, if you'd like to tackle that half
> too, you might see fewer error messages when it fails to write to the
> read-only repository, since it'll fail early on the first blob write
> instead of only failing when it gets around to trying to write a new
> tree.

It'll be part of v4 ;-)

Ciao,
Dscho
