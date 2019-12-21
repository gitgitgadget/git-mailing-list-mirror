Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FEDC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256EA206C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ubu33J1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLUV1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:27:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:48777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfLUV1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576963630;
        bh=/uvdWt34nST0AeCKNzwMT2raYUce6aUibFOjEkclorA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ubu33J1XI2hf89uaZWYW8JaOahHnoC0Ei9RILcj8Bq2dMowPRnWec1DvHs+fnzIl1
         DCGJW2e2bSCdmA+fesnjwkthV/fb72PpodAMbTFA4tl0Ayaw3ijxSxNZHi/pOi7XZw
         6+hR9F9jUq2889dWD6GV4vtFc8B0dRwT2LRa6g0w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1i9APV2QPT-00aHKv; Sat, 21
 Dec 2019 22:27:10 +0100
Date:   Sat, 21 Dec 2019 22:26:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/7] built-in stash: use the built-in `git add -p` if so
 configured
In-Reply-To: <xmqqr212g0xp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912212224180.46@tvgsbejvaqbjf.bet>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>        <40c00302f67ed927317fb5955e13690328e2f4e8.1576579264.git.gitgitgadget@gmail.com> <xmqqr212g0xp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wXs6EMgJO9teBfShBVRuqTIfZVCS4U4gDqQY64RJk8tTC98ycGY
 CBCQ/yejKLOTr7fh0RRQ+y1SY/QX9cRlk72ypEwnjAa0BLIUud7mhkxQJU/uzbtNIDCnlAX
 fNv3JzXPrKbqLBiWWDNiNuKofW13692B33Y4Nn2H02oucFJrbwzT6hodqYx7SqFwIyRuejU
 ELcjUa7OFJgalhnFT+KYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zf8GQLky0e0=:LiBokE+eXz0vlpquN3Akt2
 U9hwq02l0nxEy2jwlUb0/XZHMl1cpfRM5GpTWVYPX7BTP7qrfHlQ0Phe0AIcAp2OOHn2IKpXf
 XXDNtOlJQHfb+nrPm8mOekgmGXVbewf9m7h/Qt1IFm5BKDmimUrNZpb0V/xnK+v+yll72I2ln
 u7xB9NcXw02NPhdT2qubO4edsXnRkGlwsjZSodq40bQwb8dCcycQ2kKINBTfYlRi8rFd+c+nt
 velW6SjMJ2ot0myH8HozibRhRegEbEVcW0kGB6t1cz9rOTwgE0igfiNPGuoroD3NhD/ktX+UW
 HZrxUVHrNt92c9QgNF1GwxnhdVewI+Idtp8NnyjH2o75aNi3pb6BfUs4z8hgtbVhcB96x1BoO
 XaRwrbnE5KwMRTWdXdBrWzE2dAvl0siFf17TsBKq+MMrR+UnGoxK/0L4EZixkqjAdl7A4xWhg
 rGiAW4tshk4VtN82VJvkefXbFtNHsjmj1e4PO1oiu89+UKvkqu2qKgKnFj7Hl3NhwxHoxNHVT
 bd+icpgtfw3IK3hXiE5sN+rH7QaptQIEg7eUltC+KRlZWTDwElYMw8ZZn1fLkp56H3oQZRN/S
 0wU2DGpikAXvOZoUeRBn/NAgPo22NhJpopHSPzWIvSZsrVcPVh8BPxW15Xc1qmpoXmtpNT7eA
 5ZyYC8CeIX1ByF3Nu21r4+XRa95kjZ6KLhLdFQoBF/L7ywhjN6lYhGu8ftSP41uv6f7ULiDWW
 OQGTw4D3CFs7RKA2S+wJf1yZ+e0CmSTxhlsQ5Bzp5tELSiXNkzMysFNicoJlkDA3FRTakPg7J
 Ge/j50WkZGfX1DNhjHbNXRLPJsbdcMoI5yq30/bjCHjJkHkOP3UzcAoADYgmV4w5KVinhw7hG
 WYZwu7ErPmRV95JwZ3nJkweusvZZoqkvFjWH1e0F7A6v30FCFUFPxpBBcbsqFTqX0PLlWPXIt
 CiHC3Nm+ERbaEDmGs98XpIacWjNoQ7VF3Y+5Dl3E1Y6VNv3bPdrPaA7YxCGLm5A93vwlM+tyO
 3ZC3HVMgtO5fJZPUnhESm4USm2J49CPsVPN8/9MKjHCv0Kv5dt/chpKVosn2KqeEj+5we+hNO
 lHNN3GtePh3Cftb7SByQVvMgICfeyXt4iNl9X+5ahOXjjP1hMaE7aPwXshKrUcuJfCF+9f12Y
 RB11vUSUAMgCU5yi1Us3PBcAZmjfHbQXcZBh+XJ7gS/GE+wd3LK20F6h/USmJbdv5/mcUdW4R
 gaC2Yu+/5via6+kFEG2E+b016EgMnJmHsHqlmlp4fi6v/HCPcn8OWaeYJ9vc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Dec 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 4e806176b0..2dafd97766 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -999,9 +999,9 @@ static int stash_patch(struct stash_info *info, co=
nst struct pathspec *ps,
> >  {
> >  	int ret =3D 0;
> >  	struct child_process cp_read_tree =3D CHILD_PROCESS_INIT;
> > -	struct child_process cp_add_i =3D CHILD_PROCESS_INIT;
> >  	struct child_process cp_diff_tree =3D CHILD_PROCESS_INIT;
> >  	struct index_state istate =3D { NULL };
> > +	char *old_index_env =3D NULL, *old_repo_index_file;
> >
> >  	remove_path(stash_index_path.buf);
> >
>
> Together with the previous step, it makes sense.  Earlier we always
> spawned the scripted version.  Now we first give control to the C
> code and allow it to punt to the scripted version unless it is told
> to take control with USE_BUILTIN.
>
> > @@ -1015,16 +1015,19 @@ static int stash_patch(struct stash_info *info=
, const struct pathspec *ps,
> >  	}
> >
> >  	/* Find out what the user wants. */
> > -	cp_add_i.git_cmd =3D 1;
> > -	argv_array_pushl(&cp_add_i.args, "add--interactive", "--patch=3Dstas=
h",
> > -			 "--", NULL);
> > -	add_pathspecs(&cp_add_i.args, ps);
> > -	argv_array_pushf(&cp_add_i.env_array, "GIT_INDEX_FILE=3D%s",
> > -			 stash_index_path.buf);
> > -	if (run_command(&cp_add_i)) {
> > -		ret =3D -1;
> > -		goto done;
> > -	}
> > +	old_repo_index_file =3D the_repository->index_file;
> > +	the_repository->index_file =3D stash_index_path.buf;
> > +	old_index_env =3D xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
> > +	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
> > +
> > +	ret =3D run_add_interactive(NULL, "--patch=3Dstash", ps);
> > +
> > +	the_repository->index_file =3D old_repo_index_file;
> > +	if (old_index_env && *old_index_env)
> > +		setenv(INDEX_ENVIRONMENT, old_index_env, 1);
> > +	else
> > +		unsetenv(INDEX_ENVIRONMENT);
> > +	FREE_AND_NULL(old_index_env);
>
> OK.  I suspect that, as we move more stuff that used to be an
> external call with one-shot environment assignments like this to an
> internall call, we'd see patterns of "save away the state of this
> and that environment variables, then replace them with these values"
> paired with "now restore the state of those environment variables".
>
> We might eventually want to add a helper for doing so easily, which
> may make the caller look like
>
> 	extern void save_environment(struct saved_env *, ...);
>
> 	struct saved_env env;
> 	save_environment(&env,
> 			INDEX_ENVIRONMENT, the_repository->index_file,
> 			NULL /* end of "VAR, val" tuples */);
>
> 	ret =3D run_add_interactive(NULL, "--patch=3Dstash", ps);
>
>         restore_environment(&env);
>
> It might (or might not) be premature to introduce such a helper at
> this stage in the series, though.

To be honest, I would rather have this at a different layer: I'd like
`run_add_interactive()` to take an optional path to the index, to be able
to override the default `<gitdir>/index`.

But that requires either quite a lot of changes to the Perl script, or it
needs to wait until the built-in version of `git add -p` stabilized enough
to allow retiring the Perl script.

I kinda aimed for the latter solution.

Ciao,
Dscho
