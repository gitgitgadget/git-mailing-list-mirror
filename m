Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7899C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 12:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiHPMTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 08:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiHPMS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 08:18:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155941144A
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660652271;
        bh=5pcCcRFWQTGoMtlgBtNINOi5ZWTP6nvckl+WVN3YWH0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Im+1N9UpHrKvt4UABWrMzlrulDUbWSn6Py8cSJ4zxEehAh7hr65m097NGii10/TbN
         a64ZDPyJ2NXXa0L/qAHFkP/bZLdf6870/nV4FMB1Zx7gV+AfsNLIU9b2pB0YvAg39L
         S7rVB0NI7eASTQuB6fkUJVP8tomNh0fyygsB+b+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQic-1oFiIr1Hj4-00ASbZ; Tue, 16
 Aug 2022 14:17:51 +0200
Date:   Tue, 16 Aug 2022 14:17:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
In-Reply-To: <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
Message-ID: <128n8n08-23ss-pnsr-n910-o39nr32q42n5@tzk.qr>
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com> <20220809185429.20098-9-alban.gruin@gmail.com> <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zZDl0ZzfOJ4k3bEQHJMmBbN0WfW9i1VCHOGF+nqh/75UJ1p7b34
 9KdjXSPTSaJy/I/K/j24W0NC6ozcfjw/qpQ+2ZYFmx8iQ87sZT0153crKhT65goPT9+qMsf
 gt09qaQzd6YrO0WFObx2+Bz//g438rf+blEDg6N2JaE3MNGduYFYe+rUKiu2if+0XPDGwmP
 eYRajxAn14cQWVh35TkYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AMQ+dTfy7d0=:7b2HTuU0y4Sb4WtadiKFSq
 f/wVza0TAJIPuLN9iaSgolJaSPY5+RRE0EHfNIyFDMEO5xmpuxoAQmcKvfwkjzOh1L25piBDQ
 Yc5R7TafnFP8tJJZ80RkYkT1FUXbdmcY9DnyJGKKhIwdSVLQH3x2KmNMWgeP6qotHpihpvoIm
 mospW3y43lDqmx5khB+jrAKonBQmxXVr2zDDrl06CRe84sLuQhtD7kpbERTuS5fRdx2T+pSi3
 CWBSQ39gBxCEY+kxcejNUD80V/M3cT+9kAAWkaYBsvSEYdwy0cuLmSVVM5pv+gBUw3lPlD5Yb
 yTRHKW73QnZWCrox2gkggFDzGTNVAzFJTFcGuuJFZbltlrcX3yRlRBqXUH+oP0GUhi1zp6DxZ
 19QnymeMhEZQPiF0sGqPLIyH6VsprMN58WJHb0Ov/Wdj62GtGDFLuR1PeS48yyMN6i5Y07c7m
 MqzD+XlMg119gO5bU1Fo2teUVgV592B6r17+CRTmumOBnpAKYCTVDqVQMWphL9x9+LY89Yrzv
 4B2Tz6QQ0WtKlvy6KZJKQRRIIcfkuBuafBrZQNeiJNwIcegJcqF13WR4/bXDSjt/af7GlpQcb
 HUIgdT92ZcVEeC/FMMtWMSXfxax2Ng3TX2V1xN89gEfoHXE8chsgrzh1SgIaaSKKWvKPvv/Yc
 jOkzfbInPkRW5RlMlORDFya+NH0Sw1QE+ccTUDIvzqksi03jYMTFXLrOjd8gNP4xO0bgr05dS
 6ZylJCJ+e1CbM530tKG1fSVJpfFps+ldhIYmk7661Sebsf+Ub3HPTNJfUD+O3aUXwPyeb0wfn
 nnlKRp7TjfZBlVf9GqxMjwodNOPBcPPpO0r2CPLuximlGAlGj2PVwMzOVZHKJuFMEUVmn04Lm
 s5HidYal/x8/Lf4c3AVfqIZGHXUz9YNB80n9ynJDyMvAw7DkDmGAq+3N6rJ8J5MIrkdFQoFyA
 H3OjGcCAWymQxLyw03khbFD3heKonCneW1V8SU2mLRLhU7VOX4hY1kEgK7VTmFUvdqApy4GJ6
 YzXCJQaFSHUTG9FOv1TKkb9h5fjttu54DwmaLGeGOnsxI4sXltJ4+P1ZslhGRMzLkGR3HjnLL
 NqJGLN8ZzRfTJQIue0OBAfi3ATpcWyrRHg6xqpKNXyOHo8HoDatjsY5TA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 10 Aug 2022, Phillip Wood wrote:

> On 09/08/2022 19:54, Alban Gruin wrote:
> > This rewrites `git merge-resolve' from shell to C.  As for `git
> > merge-one-file', this port is not completely straightforward and remov=
es
> > calls to external processes to avoid reading and writing the index ove=
r
> > and over again.
> >
> >   - The call to `update-index -q --refresh' is replaced by a call to
> >     refresh_index().
> >
> >   - The call to `read-tree' is replaced by a call to unpack_trees() (a=
nd
> >     all the setup needed).
> >
> >   - The call to `write-tree' is replaced by a call to
> >     cache_tree_update().  This call is wrapped in a new function,
> >     write_tree().  It is made to mimick write_index_as_tree() with
> >     WRITE_TREE_SILENT flag, but without locking the index; this is tak=
en
> >     care directly in merge_strategies_resolve().
> >
> >   - The call to `diff-index ...' is replaced by a call to
> >     repo_index_has_changes().
> >
> >   - The call to `merge-index', needed to invoke `git merge-one-file', =
is
> >     replaced by a call to the new merge_all_index() function.
> >
> > The index is read in cmd_merge_resolve(), and is wrote back by
> > merge_strategies_resolve().  This is to accomodate future applications=
:
> > in `git-merge', the index has already been read when the merge strateg=
y
> > is called, so it would be redundant to read it again when the builtin
> > will be able to use merge_strategies_resolve() directly.
> >
> > The parameters of merge_strategies_resolve() will be surprising at fir=
st
> > glance: why using a commit list for `bases' and `remote', where we cou=
ld
> > use an oid array, and a pointer to an oid?  Because, in a later commit=
,
> > try_merge_strategy() will be able to call merge_strategies_resolve()
> > directly, and it already uses a commit list for `bases' (`common') and
> > `remote' (`remoteheads'), and a string for `head_arg'.  To reduce
> > frictions later, merge_strategies_resolve() takes the same types of
> > parameters.
>
> git-merge-resolve will happily merge three trees, unfortunately using
> lists of commits will break that.

But isn't `merge-resolve` specifically implemented as a merge strategy? I
do not see any contract in Git's documentation that commits to supporting
direct calls to the implementation detail that is `git merge-resolve`:

	$ man git-merge-resolve
	No manual entry for git-merge-resolve

> > merge_strategies_resolve() locks the index only once, at the beginning
> > of the merge, and releases it when the merge has been completed.
> >
> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> > diff --git a/builtin/merge-resolve.c b/builtin/merge-resolve.c
> > new file mode 100644
> > index 0000000000..a51158ebf8
> > --- /dev/null
> > +++ b/builtin/merge-resolve.c
> > @@ -0,0 +1,63 @@
> > +/*
> > + * Builtin "git merge-resolve"
> > + *
> > + * Copyright (c) 2020 Alban Gruin
> > + *
> > + * Based on git-merge-resolve.sh, written by Linus Torvalds and Junio=
 C
> > + * Hamano.
> > + *
> > + * Resolve two trees, using enhanced multi-base read-tree.
> > + */
> > +
> > +#include "cache.h"
> > +#include "builtin.h"
> > +#include "merge-strategies.h"
> > +
> > +static const char builtin_merge_resolve_usage[] =3D
> > +	"git merge-resolve <bases>... -- <head> <remote>";
> > +
> > +int cmd_merge_resolve(int argc, const char **argv, const char *prefix=
)
> > +{
> > +	int i, sep_seen =3D 0;
> > +	const char *head =3D NULL;
> > +	struct commit_list *bases =3D NULL, *remote =3D NULL;
> > +	struct commit_list **next_base =3D &bases;
> > +	struct repository *r =3D the_repository;
> > +
> > +	if (argc < 5)
> > +		usage(builtin_merge_resolve_usage);
>
> I think it would be better to call parse_options() and then check argc. =
That
> would give better error messages for unknown options and supports '-h' f=
or
> free.

Again, we are talking about a merge strategy, a program that is not meant
to be called directly by the user. Why should we complicate the code by
using the `parse_options` machinery?

> I think we also need to call git_config(). I see that read-tree respects
> submodule.recurse so I think we need the same here. I suspect we should
> also be reading the merge config to respect merge.conflictStyle.

Valid concerns. Extra brownie points if you can provide a simple test case
that demonstrates the current behavior.

> > +
> > +	if (repo_index_has_changes(r, head_tree, &sb)) {
> > +		error(_("Your local changes to the following files "
> > +			"would be overwritten by merge:\n  %s"),
> > +		      sb.buf);
>
> This matches the script but I wonder why that did not check for unstaged
> changes.

Any deviations from the scripted behavior should be done on top of this
patch series, unless the deviations make the conversion substantially
cleaner.

Thanks,
Dscho
