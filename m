Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01BEC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93976610FC
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhEFOCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 10:02:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:42793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234303AbhEFOCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 10:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620309660;
        bh=W9jweIF8V/wAT/JtThiyWTcIOYnBBxG3XW+p/MkxlNw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PvnZV/01GZvJ+QuXJ6MCnzFQVLoAHp7QpWm8ED60Q00heQ6RlwxyJdWXDM4jhNm8i
         0Ao/gCXttzzUVDhCgAEu8pBN28P+bNMMaAkTbJSGidHuKUoGHr12HhfFSt/pW4Clw0
         rPcdrfra9dQyrJCQONQcf2S3LlsF/8WKKulKphPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1ldpLb2Ypn-000qsa; Thu, 06
 May 2021 16:01:00 +0200
Date:   Thu, 6 May 2021 16:00:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Andrzej Hunt <andrzej@ahunt.org>
cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH] builtin/init-db: preemptively clear repo_fmt to avoid
 leaks
In-Reply-To: <79cd3791-bf6e-df3e-1045-c51801406905@ahunt.org>
Message-ID: <nycvar.QRO.7.76.6.2105061551360.50@tvgsbejvaqbjf.bet>
References: <pull.1018.git.git.1620240022594.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2105052125452.50@tvgsbejvaqbjf.bet> <79cd3791-bf6e-df3e-1045-c51801406905@ahunt.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dx1zFUNWc+PAiZ8BUmcHFJ4xIHi2gAzUwvmInbpcEHCp3Zkk59y
 hFaWI7Zzoj0cGJgkDjocNRQHoJvv4lk3aaTQ4vYAFd9Reg1dFf8DHCiik0wHH82K3Iff8jN
 NDCK2bCIFceYOpSfa8LjqYm9EiAViPYnI+mXEbhbF7crCm3HxdCAwMx8rCRkUGf4t1qfRXB
 6CxkJ7LMRttKUuhD9T5JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kohk0Vsvrqg=:wURvaJ4WACcPNVlKsjPEfh
 wTDiP7qonzb2yrlRfBf48Zj68dS6ynd6waaGolsPBfRiB1oeC/vC4NAObNC3EF4LwkfLpJpdo
 dTdCmvDKCuglgyUS8Ap9t3ikhOaqA2CbnoZtgUGSl1UJXDYtY+d/6pTsxgvDXkhAjhPC/qhce
 UB22DxtwNx9pbjBvFwvsWs4wi17lYZbha2VChJLSeko77iU49rZ3wZi4nAL5tkYHhDe9n8ryP
 xdXuz1BOL3FBXHMwMsmqFHj9u5+3nwb/+HQH7e8RKS5Rjm41eQkO8VVTb0uqW3XmANeOZvWpW
 uCKIiA1rSNyEnEaMue4xb5oAzGHai6KGZTs+UisCfv+D6BZkLIOcXM6YnOBalDuUjQ4YHVmYe
 2+OdjqtS+lqhhyXTPYv0pwmDBtNKKhoFMkDJ3DzOdG+VWOgjSRkWvJ3AFaLKNHihVMPxZvAlz
 +QM7cl6Szj+3j+rCOwrwV8HpdIS3jtdqwDIwiU9m93bSbSM0KgvbwxW/tVUTlxl1bzbmWOSHR
 pvmAqmCghtJsyH8DKhvCOVNZj3QBJLSrPROlrZd+jpCG4be4mlRWGmkTkrFWK4YDy5IpMreex
 3XFx21C1hnflQu3Oj6hd4vXnbFeIPSPltbuHyZyVCtJj1U7ii6LxU5BNeTszuK58809ZU6Md6
 OvQR3EQafraA9onFaKXeA3g8Wdxa6ahQyhum7tFj+jch8JOYXp4BrMxXTYprA4lPb27ihwago
 xbn0mjbegsZ3dWbkKAWrgjrCOhCudzTMIEF4zAdHN5tR5uUZRd9DVU67uwLQvsBN9kRHaIQqM
 s+Gf1KkJxHrUQrvisX7j11Mb/4iJwXkXUIuGzRzATWfJg6Le20YyZ3wUDeHsaFlr1BYsFdQ2H
 D4lgWoVL+QTkVH17bJIQajDVxJ1Gx46FQGdrg102avVDTjCXACLwNTnwy99Xad1d9sucARUSN
 9PHfTdXFeVjmIZLKnsNrot++Ck0GIs1tW8BnmMekMKYzVxWoPJQOvOlgc9jqNcGyR181hx2yM
 V4o/kTzMH2QqjDFH0DtMbsXg16IPCOdzR0Lf2n3/FNRonSgA5KgdRhefFIYcaE1XwAK0IAWcW
 1OBZ7/ycmLZaodUOEluJERVUSRNayEx3+Pmj37OSkdj7IAGeorjCAy7NF8BTstJnoueKzwtAu
 dIXrm7BHF+J3VtGRPsAui0VQh3W7u2oMUPKMXWXETkDNf0ZrsZYJO0ZqphzqdJ2szlO3Rbb6F
 ZbWKhDDypjJSRSpAO
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrzej,

On Thu, 6 May 2021, Andrzej Hunt wrote:

> On 05/05/2021 21:28, Johannes Schindelin wrote:
>
> > On Wed, 5 May 2021, Andrzej Hunt via GitGitGadget wrote:
> >
> > > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > > index 31b718259a64..b25147ebaf59 100644
> > > --- a/builtin/init-db.c
> > > +++ b/builtin/init-db.c
> > > @@ -512,6 +512,7 @@ int init_db(const char *git_dir, const char
> > > *real_git_dir,
> > >    		       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
> > >    }
> > >
> > > +	clear_repository_format(&repo_fmt);
> >
> > I am afraid that this might not be correct, as t0410.27 experienced a
> > segmentation fault (see
> > https://github.com/git/git/pull/1018/checks?check_run_id=3D2511749719#=
step:5:2845
> > for the full details):
>
>
> Thanks for spotting that. On further investigation this looks like a
> preexisting issue on seen (my github PR was based on seen - in hindsight=
 that
> was probably not a good idea) - here's a CI run from seen this morning
> exhibiting the same failure:
>   https://github.com/git/git/runs/2515095446?check_suite_focus=3Dtrue
>
> To gain more confidence, I've rebased my patch onto next, and I no longe=
r hit
> any CI failures:
>   https://github.com/ahunt/git/runs/2515309312?check_suite_focus=3Dtrue
> (I ran this on my fork because changing the base branch appears to have
> confused the PR's CI configuration.)

Oh, I'm sorry! But it is great news that this is not _your_ patch's
problem (I had a brief look over it and wondered why it would cause this
segfault).

> Nevertheless, I was still curious about what might be causing the failur=
e in
> the first place: it appears to only happen in CI with gcc on Linux, and =
I was
> not able to repro on my machine using (tested with gcc-7.5 and gcc-10, w=
ith
> seen from this morning):
>   make CC=3Dgcc-10 T=3Dt0410-partial-clone.sh test

There are more settings used in the CI run, indeed. So yeah, it would be
good to debug this in an environment where it does fail.

> I'm guessing that understanding this failure might require the help of s=
omeone
> with an Ubuntu install to debug (unless there's some easy way of using
> Github's Actions to run a bisect)?

As a matter of fact, there is a neat way in GitHub Actions to debug this:
the `action-tmate` Action. It installs and starts a `tmate` instance,
which is a `tmux` inside kind of a proxied SSH server.

This is what I usually do when I have time to track down such problems: I
edit `.github/workflows/main.yml` and push it into a branch in my fork.
The edits are essentially:

- I delete the `ci-config` job (because I know that I want to run this
  workflow and don't want to wait for that job to be queued and run)

- Obviously, this requires all the `needs: ci-config` and
  `if: needs.ci-config.outputs.enabled =3D=3D 'yes'` lines to be deleted, =
too.

- I also delete the jobs, tasks, and matrix elements that are not
  necessary for my debugging session (in your case, that would be e.g. the
  `dockerized` job as well as the vectors in `regular` that are not
  `linux-gcc`).

- Then comes the most important part: after the
  `ci/print-test-failures.sh` task, I insert this task:

    - name: action-tmate
      if: failure()
      uses: mxschmitt/action-tmate@v3
      with:
        limit-access-to-actor: true

The `limit-access-to-actor` thing only applies if you uploaded your public
SSH key to your GitHub profile. Otherwise, anybody who monitors the run
could see the command-line to connect to your debugging instance and
interfere with you.

For details, see https://mxschmitt.github.io/action-tmate/

Thanks,
Dscho
