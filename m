Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FDC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiIVTuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiIVTum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:50:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C2D62DE
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663876236;
        bh=nwEVvxid+dbv6tslHs7MN3zQ8Ux5aVLBpFjDUVVaJ2s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QuSBiCtXAban5Fc2sSavipdT57BlnfU4GJzR5m3D7/Su/++OE8+0f+9Tv72HpVGOS
         lksT9IXStPB3xHHzPPDRVhMMxeyMpB16Cgt2yiCyD38mdm28wBf48ahGO6mW1SOjGL
         8HfDRnj+z8tc4LSBZiCb+4F9wIhgWwosNR6M/x94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.113.77] ([89.1.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1ouT4b13xF-00PhQz; Thu, 22
 Sep 2022 21:50:36 +0200
Date:   Thu, 22 Sep 2022 21:50:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only
 repositories
In-Reply-To: <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
Message-ID: <n920r07n-8443-2r5o-09pr-q20r99q6o12o@tzk.qr>
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com> <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4xTzZKqPHIB0/rqSvoV9toF8aKjx5HuJUiDTe4xPahEZO79JTFP
 VUQqQjnLpdJ4pG7dzomRptsuYLk0TxJjn7laR+abvSa57WUHuf719wFhLgrIXO2YsfIvOjD
 C8g98LaYPJNQWrH/qVqtszSYWZYnInGo9UWFJQK/XszpJPX8P7CI2eCOQ+xeIUWeucp1aZ0
 84aSrRUbsAjGe8dHhptAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uP1WRDD28fw=:u14G0LH/u6YVTsPJ+WdzvT
 JWun2CrL3rglBy77A1WgzN9hjr9W3WjMV59aiVwcIIWOkFvt++LqmHzwOz12b8SKqfkOtZbWR
 XbwWdpg7bi1GMy3vCnCwr4esExZVWaT4SErcKqe0oU2wIjX/DcqL0fyYm1i8JRpVG3YQ1VMqJ
 VlMd0497a7jvVxTxTze9K41ymjNdODH+qGJtIH1CFuVmu+NEck8My8GIP6WcTvD+esaW5b5id
 TsqKEPR+8AkwJW1Ca/+NKYku8OiXpAZ1xUun8Jp5GYRC1Z80JjNfZHIpI2squefImeQNfQ9+Z
 86YXJGVbKubKrFlrqyuY7OOaKbucnGUZJcuiFpzczwp5UxwhNFRM7Ck0umuDYOvaUc1VEYcHC
 LHXco85SSXP5EPyHAZkI0YbufK8hwtEjCiIEMlbNh3ooZCm+yobgzCTbQH/NH1WTDzs2kCpXl
 79Z8vhTvAfWI/WfK9NnbVm241EZNkLbGUTiQf4YlF5/TufdQQnvxOfxIXkpICPk5+MUkc5Jjz
 AG6K25qdDPKQm7ymwfBospTZJiXEkn5vgVpIqovNVTab6fQrxesJX6+j77TpFDnUvrOvwi6VC
 Ecys4YbhJA/amHONksfidUr98IA0yATvnSOaCAKPFxelODY+Nr+VJXnkDypE7iwwv1snOqVHo
 NcVqGv1qyxW4lCN1QI4AnYHgXl7v10CAIaFUpA6qKnFS44obPHOFKFhQob12DVFcTiAAmeCYP
 eTFZJK28WImlEZshWBDhe0TkuLw0smNayTJ8ltm6lmEpJV0NVZ/GJJyLYf93vxHwfyX3IvuZV
 OcsvD8zOpuo9SApWV0IfVF8BKK+YP6DPhAcXv9CGuuT9c7zszUkhn0KTdISXRBxcx+VmWy9SQ
 YTeyBlAR2lN7Krky0rslXNI7rUTwRBNWXyfc37LAbnGbc/lZM+j5GnXIHNPIaSHJ6de29iCcX
 42DhHMqOO/0W9pKbGggXRUUkGV9m6cWodKi4/lU8XBN8veM+WN5P9npixmH4y29pGAUhopBZP
 k3dbzFWMzkihQqtTe4hN31REFRG18EexRsJM2xeeOlORbH7GUq50cGN7wUntiDA4JYtwTwfcp
 tyWwjtQtMPXWW5ePwd3sqXoNo/W1o9NrtupULXa/r9QJPt/QBhZuzYKTuRQAMYITkC/D5iXi3
 hwurFO58TI4gUqIlMyu3yEXhGt
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

now that I have studied more of the code, hunted down Coverity reports
about `merge-ort.c` and `builtin/merge-tree.c` and essentially have grown
a lot more confidence about my patch, I'll take the time to respond in a
bit more detail.

On Wed, 21 Sep 2022, Elijah Newren wrote:

> On Wed, Sep 21, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Independent of the question whether we want `git merge-tree` to report
> > the tree name even when it failed to write the tree objects in a
> > read-only repository, there is no question that we should avoid a
> > segmentation fault.
>
> Ah, a read-only repo.  Looks like we didn't bother to check the return
> status of write_object_file() in one of the two cases; oops.  (And it
> looks like the other case does not correctly propagate the error
> upwards far enough...)

Indeed, that was the actual root cause, but I had failed to even look
whether the return values of `write_tree()` and `write_object_file()` were
respected. Narrator's voice: they weren't.

> > And when we report an invalid tree name (because the tree could not be
> > written), we need the exit status to be non-zero.
> >
> > Let's make it so.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     merge-tree: fix segmentation fault in read-only repositories
> >
> >     Turns out that the segmentation fault reported by Taylor
> >     [https://lore.kernel.org/git/YyopQD+LvPucnz3w@nand.local/] happene=
d
> >     while testing merge-ort in a read-only repository, and that the up=
stream
> >     version of git merge-tree is as affected as GitHub's internal vers=
ion.
> >
> >     Note: I briefly considered using the OID of the_hash_algo->empty_t=
ree
> >     instead of null_oid() when no tree object could be constructed. Ho=
wever,
> >     I have come to the conclusion that this could potentially cause it=
s own
> >     set of problems because it would relate to a valid tree object eve=
n if
> >     we do not have any valid tree object to play with.
> >
> >     Also note: The question I hinted at in the commit message, namely
> >     whether or not to try harder to construct a tree object even if we
> >     cannot write it out, maybe merits a longer discussion, one that I =
think
> >     we should have after v2.38.0 is released, so as not to distract fr=
om
> >     focusing on v2.38.0.
>
> That's fair, but you know I'm going to have a hard time refraining
> from commenting on it anyway...  :-)

Hahaha, of course you would ;-)

> [...]
> > @@ -446,7 +447,8 @@ static int real_merge(struct merge_tree_options *o=
,
> >         if (o->show_messages =3D=3D -1)
> >                 o->show_messages =3D !result.clean;
> >
> > -       printf("%s%c", oid_to_hex(&result.tree->object.oid), line_term=
ination);
> > +       tree_oid =3D result.tree ? &result.tree->object.oid : null_oid=
();
> > +       printf("%s%c", oid_to_hex(tree_oid), line_termination);
>
> Perhaps also print a warning to stderr when result.tree is NULL?

I ended up not even touching `builtin/merge-tree.c` but instead ensuring
that `result.clean` is negative if we fail to write an object (which could
happen even in read/write repositories, think "disk full").

As a consequence, we do not even reach this `printf()` anymore, as you
pointed out, a negative `result.clean` is handled much earlier.

It is handled via a `die()` in `real_merge()`, and that will need to
change, I think, if we want to continue on the batched merges.

> >         if (!result.clean) {
> >                 struct string_list conflicted_files =3D STRING_LIST_IN=
IT_NODUP;
> >                 const char *last =3D NULL;
> > @@ -473,7 +475,7 @@ static int real_merge(struct merge_tree_options *o=
,
> >                                               &result);
> >         }
> >         merge_finalize(&opt, &result);
> > -       return !result.clean; /* result.clean < 0 handled above */
> > +       return !result.tree || !result.clean; /* result.clean < 0 hand=
led above */
>
> Thinking out loud, should this logic be at the merge-ort.c level,
> perhaps something like this:
>
> @@ -4940,6 +4941,9 @@ static void
> merge_ort_nonrecursive_internal(struct merge_options *opt,
>         result->tree =3D parse_tree_indirect(&working_tree_oid);
>         /* existence of conflicted entries implies unclean */
>         result->clean &=3D strmap_empty(&opt->priv->conflicted);
> +       if (!result->tree)
> +               /* This shouldn't happen, because if we did fail to
> write a tree we should have returned early before getting here.  But
> just in case we have some bugs... */
> +               result->clean =3D -1;
>         if (!opt->priv->call_depth) {
>                 result->priv =3D opt->priv;
>                 result->_properly_initialized =3D RESULT_INITIALIZED;
>
> That might benefit callers other than merge-tree, though maybe it
> makes it harder to print a helpful error message (unless we're fine
> with the library always throwing one?)

The error messages are already thrown about (this is how it looks like
with v3 of this patch):

	[...]
	+ git -C read-only merge-tree side1 side2
	error: insufficient permission for adding an object to repository databas=
e ./objects
	error: error: Unable to add numbers to database
	error: insufficient permission for adding an object to repository databas=
e ./objects
	error: error: Unable to add greeting to database
	error: insufficient permission for adding an object to repository databas=
e ./objects
	fatal: failure to merge
	+ exit_code=3D128
	[...]

> > diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-wri=
te-tree.sh
> > index 28ca5c38bb5..013b77144bd 100755
> > --- a/t/t4301-merge-tree-write-tree.sh
> > +++ b/t/t4301-merge-tree-write-tree.sh
> > @@ -810,4 +810,13 @@ test_expect_success 'can override merge of unrela=
ted histories' '
> >         test_cmp expect actual
> >  '
> >
> > +test_expect_success SANITY 'merge-ort fails gracefully in a read-only=
 repository' '
> > +       git init --bare read-only &&
> > +       git push read-only side1 side2 side3 &&
> > +       test_when_finished "chmod -R u+w read-only" &&
> > +       chmod -R a-w read-only &&
> > +       test_must_fail git -C read-only merge-tree side1 side3 &&
> > +       test_must_fail git -C read-only merge-tree side1 side2
> > +'
> > +
> >  test_done
> >
> > base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
> > --
> > gitgitgadget
>
> This is a reasonable workaround from the merge-tree side, if we expect
> merge-ort to not correctly notify us of issues (which may be fair
> given that a quick glance suggests we have more than one problematic
> codepath, which I'll discuss more below).  However, I do think
> merge-ort should be returning a negative value for the "clean" status
> in such a case.

You're absolutely right. That's what v3 now does.

> If merge-ort did that, then we wouldn't even get to your new code
> because merge-tree.c already checks for that:
>
>     merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result)=
;
>     if (result.clean < 0)
>         die(_("failure to merge"));
>
> I have a hack above which sets a negative return value, but it's only
> a workaround since it comes from a late detect-after-the-fact
> location.  Here's another ugly hack, but one which highlights exactly
> where the real problem occurs:
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 99dcee2db8..c2144e9220 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3605,7 +3605,8 @@ static void write_tree(struct object_id *result_oi=
d,
>         }
>
>         /* Write this object file out, and record in result_oid */
> -       write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
> +       if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
> +               die(_("Unable to add new tree to database"));
>         strbuf_release(&buf);
>  }
>
> die()ing, of course, is not a good choice, we should really return -1
> instead.  Unfortunately, the callers aren't currently prepared to
> propagate such a value upwards (as reflected in the return type of the
> function) so any fix in this area is a little more involved than just
> modifying these few lines.  Also, there is one other call to
> write_object_file() in merge-ort.c which does check and return a value
> of -1, though looking around it appears the callers of that other site
> do not always correctly check and propagate a return value of -1
> further upwards as they should, meaning we are losing track of the
> fact that the merge failed to function.
>
> Given the lack of correct propagation of -1 return values in the other
> codepath plus the error here, keeping some form of workaround sounds
> fair (though it may be nice to print an error that something fishy
> happened).
>
> And then, possibly post-v2.38.0 though we may be able to get it in
> before, getting correct propagation of a -1 return value from the
> source of the error would be good.  Would you like to look into that,
> or would you prefer I did?

It turned out not to be too bad.

Essentially, to propagate `write_object_file()` failures I only had to
change a couple of signatures (with the corresponding `return`s):
`write_tree()`, `write_completed_directory()`, and `process_entries()`.
And then, of course, I needed to change
`merge_ort_nonrecursive_internal()` to respect the propagated error by
setting `result->clean =3D -1`.

Pretty straight-forward, really, much less involved than I had expected.

Thank you!
Dscho
