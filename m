Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD607C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CC820899
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lT5jnGDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFRKVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:21:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:47899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRKVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 06:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592475691;
        bh=7XuXOIS1SXMCDA0yLUMp/e4kCgki02Ud7nDHJEioLhY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lT5jnGDBwRbFxvk7JOBLf50ZSAl8xTm9UBrSTwLXMR2utixCUqpN4xQDknroupqbK
         37pFN6rLI5xT2aeRXEVJlfy+lWICJA80OFHMKtIHuj3i/cAuv256khm1nkTb5VFBhj
         2BDRfrACrrxQtXXOAq9YSBauZpIxb+4SXKTVNSes=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.215.12]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1iyjV21a9T-00wIB5; Thu, 18
 Jun 2020 12:21:31 +0200
Date:   Thu, 18 Jun 2020 12:21:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 2/9] remote: respect `core.defaultBranchName`
In-Reply-To: <20200616123559.GB666057@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2006181218270.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <06a2cea051c01ebee38c9910425171f112daf41a.1591823971.git.gitgitgadget@gmail.com> <20200616123559.GB666057@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:41hepS0OXiu5736eTMoiRdZ5WbLOyVFo5vE+lJsSpZmwebe7BDR
 cF8e/n2dpofW9PfvlZKrO3OvsTIxiCH1vHi53vC7VjWZjidplLBTknh0swbt7V0SlSz9as5
 N52P7F+TrS9HeMJGj0nnCSW4MXttFVCyFec1oV1L4vDBcOXdWiY95YtIcV5sZMtwhRC3DwE
 BeFKp/xQq0Zj0g8zspTlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5AsWBzM8A8o=:grR+qvxy6jvW5T625zRmi7
 WZtHBPDpOXv5k2O0tiTnMkxrA9gw5l9TqottaGA8pZx+j+SxMWHcdamDTbAxmIeyXCikxVklg
 eKSdU0MVhpO7eRpNThFPMEJ1RcVGjGLrifq0rq/exMSJTUiq+ZVm2lnt8PVc73c74Aas0V8v8
 eQ4rY7pnUtMOHOC03AqkwlQIkI4a/rIqUJDKmrKY1jlMaChLOgPyIH0KjSBZ/a3iXBe/A454D
 ZJXJKxkCj7Eh38bsH+is0CNpJWXjf8p78YxGpfCeZvb0BXfu+zMnOLYDHHRp33A8J6PAYmh27
 qbPPb/VE1boz335lfyV7tCFLTyPxwf9RVYJEAmd26d1uRe1Q9WrwLweZdf0s5EZps6TgZNirM
 fdxUzy3NC7pKnVZnORTOCd7bEpVneR6w+Srs3sQs7xCQEUKJo929AeZ5s9KhRArOLKjA9FPyC
 Q/0Fbu+hLvrJWVYdpQiY1ZGb7pQpsXCP6/rtD0s2KjJOTm+Rf6/g0DpYBHU1deWBBuvTvXAq/
 TTWb3NsiJ58f/gpLfvGVsPps82mz/47kN9We3G4wVpqMvp5supLr1LAQi1at7+FXXxX6j8DWh
 eFX20NnV8WTWjHsAM1ikjKZaX5sIcFFEwn2U3MitVB/0spkBjavW4WiUcvgh9mIYh45iAmA13
 rdvXJU1iVQXf15FKIJV6575sWQMcwWRbFf+inZ0tGgiUvas0y0Kw3cuV5O9616VHV4blXj5Sm
 QJWQeG1g/BY8tAmHx8wi0kjbxIKQRQM+Z5xokc6KNdPums+v38w2x2J0JObZwTKZC6nczDjWd
 sZEGaHA//YndBLZqP8Ei2LUmYjdHYKS5fxWfJFfe54mt/cfjqo0JhcQf0muKDvF6lhXte/e+h
 +ZO8MxPCanyGLe4yCo1/vMK+CfnPqkLnNHR43hIartYyU6L6pr6ywCwGa2fSDpAWX4bBx30cX
 6Iz0dkKvgNxv4gf/uPEsJKisIifnPsFmJZtZwUW6kETswZh9R0dThV4ANhcFmVYuhBj1NkGOz
 a2wUeKr5R89Y3+BwsTzHO2+lCFBbV29fWnPnGEMrZBugvlpnytfuPeV01xS1QYBicEZfiJpFA
 kIaRtccyFIFE+vZqG06sfzyTvL+0DpH3eZBESenMJXkwGN3A+IovEpx+BNIBSsdwk5fSAAUVM
 zR6g4qM86aE+FXlPe/qahe9Sql7NBHMFJub2XuEcAgUvbdQjWrGpz86TkjTQq+PGS0TeI8LQw
 s0KYQLHiQEkDy4GWx
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 16 Jun 2020, Jeff King wrote:

> On Wed, Jun 10, 2020 at 09:19:23PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > @@ -2099,7 +2100,10 @@ struct ref *guess_remote_head(const struct ref =
*head,
> >
> >  	/* If refs/heads/master could be right, it is. */
> >  	if (!all) {
> > -		r =3D find_ref_by_name(refs, "refs/heads/master");
> > +		char *name =3D git_default_branch_name(0);
> > +
> > +		r =3D find_ref_by_name(refs, name);
> > +		free(name);
> >  		if (r && oideq(&r->old_oid, &head->old_oid))
> >  			return copy_ref(r);
> >  	}
>
> You'd perhaps want to update the comment above, too.
>
> However, I think we should be a bit more lenient on the "reading" side
> default names. Just because "foo" is _my_ default branch name, does not
> mean it is the default on the remote side. We cannot know what the other
> side's default preference is, but in a world where we have 15 years of
> repos that may have been created with "master", it is probably still a
> good guess.
>
> I.e., I think this probably ought to check the preferred name, and then
> fall back to the existing behavior, like:
>
>   if (!all) {
> 	  char *name;
>
>           /* try the user's preferred default branch name */
> 	  name =3D git_default_branch_name(0);
> 	  r =3D find_ref_by_name(refs, name);
> 	  free(name);
> 	  if (r && oideq(&r->old_oid, &head->old_oid))
> 	          return copy_ref(r);
>
> 	  /* otherwise, try "master", which is the historical default */
> 	  r =3D find_ref_by_name(refs, "refs/heads/master");
> 	  if (r && oideq(&r->old_oid, &head->old_oid))
> 	          return copy_ref(r);
>   }
>
> That will help minimize fallout when git_default_branch_name() changes,
> either by user config or if we switch the baked-in default. In the
> latter case, we might also consider hard-coding that as a guess between
> the user's preferred name and the historical "master".
>
> Hopefully this would not matter _too_ much either way, as most servers
> would support the symref extension these days. But I still think we
> should do our best to minimize spots where the user may see a
> regression.

Sure, we could just leave this alone, or we can just ditch the
special-casing of `master` here.

As you say, this does not affect any modern Git version, and IIRC the code
after that special-casing tries to find any remote ref that matches the
remote `HEAD`.

So it's not like we _need_ this special-casing, anyway.

Ciao,
Dscho
