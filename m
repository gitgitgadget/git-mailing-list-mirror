Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB63C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382941AbiAYQom (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584136AbiAYQhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 11:37:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3C6C06175A
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 08:35:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x11so57892963lfa.2
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 08:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LUEDieb9ksCiIPdEsrkYyUcO1qH1HzmYzM2pbyvHLsQ=;
        b=WGDCfncTjWxdJAbtkS2T9/+gtYPtzEBXt9gLRKvVXxbZY5p+dq1k7uJ4kVQMxT4rVK
         UtX/vJPv927wgmS3UVmIrGgqZt4dUVnhn6Ktl+Fq44ouosqPdQCLc7KD9alB3NdP9ujt
         cdh/AQsj03yHSmHQMjzNAxPIE05OhU8pIeDHyw26UdR+VGAzw6jmEkyBAFBdpnBILinK
         6LGmcsU7Eg7T6SJxxb9P1rC9l4z/5fz/pqJeJJiVykXM+2QLAnnwFDW70HpBsuqxuWGY
         w3jI+TqXTUjHLsbVfk90yllxeuaQgoHIlbrGbkf6dqTqwZBb0zgusirVrJaduyQR0g0i
         DCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LUEDieb9ksCiIPdEsrkYyUcO1qH1HzmYzM2pbyvHLsQ=;
        b=J/tdaXASD3F8uUoKxdh8L/oi9s5lgEP6Zw98c8FulA8b0y0YFqUqlv+QUqv/hU8Y2z
         ZdRYlzNjf2w5B5LowV+tIvbd9+vhyV7Wkrei0PdgFmzYHk2sI30khv4mC1wXVLpXVNyi
         B3VzrA9wmJP9YJB6Zl62QkaQN2hR9A4Hcdj4xGaCovsysdcFZShRM3Q7XgXAPwcb3yz6
         iWeDYU1R2dQ5LCv88MoIpoU1BDrWT6xt7Cn+ohGwLIbkNNYx2869PiaBFbyiV9rczPzL
         hqzhEzPNGU+tH0GdFNiC9+Zaz7/8XFzUcBNOSFKIsKdO7ZzumlYHY0x9xr4z6FyqGnqp
         2JPg==
X-Gm-Message-State: AOAM5310gz0Zdbz9d2MVko4g9TqxUEug8KKhUG9g5UDtFFOaGaKtS8GV
        h3ZSmfnhktklPrCPtjm7xRlrE85POZ6JrBtVfl4=
X-Google-Smtp-Source: ABdhPJymuI/9O23szfQxqseLS4d8ki1uZaejOugohxw7XFwJMLvR1tt5jDjeuVK2j3ZTAiB5gIx6ukaHFubVEnuELSc=
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr16689390lfi.20.1643128509410;
 Tue, 25 Jan 2022 08:35:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com> <220124.86v8y9gniw.gmgdl@evledraar.gmail.com>
In-Reply-To: <220124.86v8y9gniw.gmgdl@evledraar.gmail.com>
From:   Lertz Chen <bojun.cbj@gmail.com>
Date:   Wed, 26 Jan 2022 00:34:57 +0800
Message-ID: <CADuS7Ao4YbeKxU8Kcw7QGH6n0zKJmhGxXmAJ-iAJ60wrGp=ybA@mail.gmail.com>
Subject: Re: [PATCH] receive-pack: purge temporary data if no command is ready
 to run
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     BoJun via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Chen Bojun <bojun.cbj@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B41=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 23:29=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Mon, Jan 24 2022, BoJun via GitGitGadget wrote:
>
> > From: Chen Bojun <bojun.cbj@alibaba-inc.com>
> >
> > When pushing a hidden ref, e.g.:
> >
> >     $ git push origin HEAD:refs/hidden/foo
> >
> > "receive-pack" will reject our request with an error message like this:
> >
> >     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden=
 ref)
> >
> > The remote side ("git-receive-pack") will not create the hidden ref as
> > expected, but the pack file sent by "git-send-pack" is left inside the
> > remote repository. I.e. the quarantine directory is not purged as it
> > should be.
>
> Hrm, shouldn't the tmp-objdir.[ch]'s atexit() make sure that won't
> happen (but maybe it's buggy/not acting as I thought...)?
>

Although the command is marked with an error, tmp_objdir_migrate() is still
executed In the scenario of pushing a hidden branch, which leads to the
quarantine data to be released to .git/objects/.

> > Add a checkpoint before calling "tmp_objdir_migrate()" and after callin=
g
> > the "pre-receive" hook to purge that temporary data in the quarantine
> > area when there is no command ready to run.
>
> But we're not purging anything, just returning early?
>
> If we'll always refuse this update, why do we need to run the
> pre-receive hook at all, isn't that another bug?....
>

unpack_with_sideband() receive the pack file pushed by the client and save =
it
in the created temporary quarantine area. Returning before tmp_objdir_migra=
te()
executes ensures that the quarantine data is cleaned up by programs registe=
red
with atexit().

> > The reason we do not add the checkpoint before the "pre-receive" hook,
> > but after it, is that the "pre-receive" hook is called with a switch-of=
f
> > "skip_broken" flag, and all commands, even broken ones, should be fed
> > by calling "feed_receive_hook()".
>
> ...but I see it's intentional, but does this make sense per the
> rationale of 160b81ed819 (receive-pack: don't pass non-existent refs to
> post-{receive,update} hooks, 2011-09-28)? Maybe, but the reason we have
> these for "non-existent refs" !=3D this categorical denial of a hidden
> ref.
>

Commit 160b81ed819 (receive-pack: don't pass non-existent refs to
post-{receive,update}
hooks, 2011-09-28) executes the pre-receive hook when deleting a
non-existent branch
instead of executing the post-{receive,update} hooks. I think the
purpose of this is to gain
the opportunity to perceive the push content through pre-receive hook.
If we return directly
before pre-receive hook, are we going to lose this possibility?

> > Add a new test case and fix some formatting issues in t5516 as well.
> >
> > Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > Helped-by: Teng Long <dyroneteng@gmail.com>
> > Signed-off-by: Chen Bojun <bojun.cbj@alibaba-inc.com>
> > ---
> >     receive-pack: purge temporary data if no command is ready to run
>
> [...odd duplication of mostly the same commit message from GGG
> (presumably...]
>
> > -mk_empty () {
> > +mk_empty() {
>
> This patch includes a lot of line-re-wrapping, shell formatting changes
> etc. You should really submit this without any of those & just have the
> meaningful changes here.
>

Sorry, it was indeed a formatting issue, I'll roll back this part.

> > [...]
> > -for head in HEAD @
> > -do
> > +for head in HEAD @; do
>
> e.g. this, indentation changes earlier, and most of the changes here...
>
> >
> >       test_expect_success "push with $head" '
> >               mk_test testrepo heads/main &&
> > @@ -1020,7 +1011,7 @@ test_expect_success 'push into aliased refs (inco=
nsistent)' '
> >       )
> >  '
> >
> > -test_force_push_tag () {
> > +test_force_push_tag() {
> >       tag_type_description=3D$1
> >       tag_args=3D$2
> >
> > @@ -1066,7 +1057,7 @@ test_force_push_tag () {
> >  test_force_push_tag "lightweight tag" "-f"
> >  test_force_push_tag "annotated tag" "-f -a -m'tag message'"
> >
> > -test_force_fetch_tag () {
> > +test_force_fetch_tag() {
> >       tag_type_description=3D$1
> >       tag_args=3D$2
> >
> > @@ -1158,8 +1149,7 @@ test_expect_success 'push --prune refspec' '
> >       ! check_push_result testrepo $the_first_commit tmp/foo tmp/bar
> >  '
> >
> > -for configsection in transfer receive
> > -do
> > +for configsection in transfer receive; do
> >       test_expect_success "push to update a ref hidden by $configsectio=
n.hiderefs" '
> >               mk_test testrepo heads/main hidden/one hidden/two hidden/=
three &&
> >               (
> > @@ -1250,8 +1240,7 @@ test_expect_success 'fetch exact SHA1 in protocol=
 v2' '
> >       git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
> >  '
> >
> > -for configallowtipsha1inwant in true false
> > -do
> > +for configallowtipsha1inwant in true false; do
> >       test_expect_success "shallow fetch reachable SHA1 (but not a ref)=
, allowtipsha1inwant=3D$configallowtipsha1inwant" '
> >               mk_empty testrepo &&
> >               (
> > @@ -1809,4 +1798,12 @@ test_expect_success 'refuse fetch to current bra=
nch of bare repository worktree'
> >       git -C bare.git fetch -u .. HEAD:wt
> >  '
> >
> > +test_expect_success 'refuse to push a hidden ref, and make sure do not=
 pollute the repository' '
> > +     mk_empty testrepo &&
> > +     git -C testrepo config receive.hiderefs refs/hidden &&
> > +     git -C testrepo config receive.unpackLimit 1 &&
> > +     test_must_fail git push testrepo HEAD:refs/hidden/foo &&
> > +     test_dir_is_empty testrepo/.git/objects/pack
> > +'
> > +
> >  test_done
> >
> > base-commit: 297ca895a27a6bbdb7906371d533f72a12ad25b2
>
>
> ...until we get to this, this mostly OK, but maybe test the case for
> what the hook does here (depending on what we want to do).
>
> If the quarantine directory was not purged as before how does checking
> whether testrepo/.git/objects/pack is empty help? We place those in
> .git/objects/tmp_objdir-* don't we?

If we split the patch into two parts and put the test case before the patch
of receive-pack.c. Then in this test case, we will find that although the
user pushes hidden references will fail, the object files contained in thes=
e
references will still exist in the .git/objects/pack directory. A patch of
receive-pack.c fixes this use case. The reason not splitting into two
commits is to protect the changes I made in receive-pack.c.
