Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39F6520179
	for <e@80x24.org>; Mon, 20 Jun 2016 06:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbcFTG0o (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 02:26:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:60572 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665AbcFTG0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 02:26:43 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MHXXo-1bFy3L1vbw-003Oj1; Mon, 20 Jun 2016 08:26:03
 +0200
Date:	Mon, 20 Jun 2016 08:26:01 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Sunshine <sunshine@sunshineco.com>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
In-Reply-To: <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606200814510.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de> <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+T75A0EDo4V3Xz38QHwvCsQOy0tzUbsOYdhMZEBNN2+BKouAvmI
 pZQ1hhmxo3+Q99aZUbSPLAb9o9PsSqphzgBiqY1+SH+IpqZJJ8TWwHWyzdZmDEybaxyR4fM
 OOl2SLkHBlHDs/CI68SuPjFe3vHL0e+NHLw7qVxaEbSNAIaiaXbrGVV6fdzmqrcosK7SNGV
 iPn5wSPehmoDtUk7I/Z4A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3MNwFpzmA1Y=:AWRE97TXODUYR/076CUxxE
 TFEw1YcBqh1eT4JMkKml694XEK7t7/CFYoLdDQRL98UztwMbYX3hIZCSCXgZd8WS43Wfg+46t
 4lkzzySv5ACOyKr0kgnt50GAWjzWOnQCjQtHGTKKHg9CkLPlBJgOvNdIjluU1BGGpKvv+mEEC
 MR1LzuhQ61TPGKf3hCkb0nd4badRJB5GcmPmNrIanDw2blIhyOx984Xe/UuRIOcA0hab536X6
 VrF8hHayR+5kEGZx66WUSZfVeGYa+9+BBGcDzG8ZnjgmhEcY+tIS8sF0CVOOhNeDdIENnfgQv
 D/P97AY/MEvNmkb2RxDP+97c1PqN1AUiem6hTIJeHBOmb0d00k8O7HbTkYXRrJUNt1lFW5rnc
 bjqAhI1gaB+ApYYWVs5NfiAD5uzWxdjUFEsbxqd0H2TGjaKfZOimma/e+bNMKk1HTyBnKdsik
 MiHBLSGCHLGi0AqjebL38ftQ7YsNTQZkJv5Nv3edn99JSrVBldDaIDVxunbfiFS3d816xEKj8
 q2dJOaCjjtRPG9Fd7iCOcg/q4oLPv97F1ij124kFOkfWsm6cbqwHIRr5ZuM14746XQOGac7Xm
 6zgAceXRoJCk7rWTRvsAsUgHoNG0Pa4g7gP/VPSKDWYfkRJktYaI+GqubvksyuGVWnebBiNHc
 GzFK48DKAfKaEWwxlVewbceSRC9pjbeHaoGG3/+FVn+uJuC6xZETJPIb0bawAM2zKns94boJn
 ROYnBk/Z6QEyKHI9L2R04uoBLpQoEGyAwVxWD5puJ84UuY5mfm4WCAF1N+FxTHXfXnB0eZ9eV
 1LiBght
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Sun, 19 Jun 2016, Eric Sunshine wrote:

> On Sat, Jun 18, 2016 at 6:04 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > We just taught the relevant functions to respect the diffopt.file field,
> > to allow writing somewhere else than stdout. Let's make use of it.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1569,6 +1570,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >                 setup_pager();
> >
> >         if (output_directory) {
> > +               rev.diffopt.use_color = 0;
> 
> What is this change about? It doesn't seem to be related to anything
> else in the patch.

Good point, I completely forgot to mention this is the commit message.

When format-patch calls the diff machinery, want_color() is used to
determine whether to use ANSI color sequences or not. If use_color is not
set explicitly, isatty(1) is used to determine whether or not the user
wants color. When stdout was freopen()ed, this isatty(1) call naturally
looked at the file descriptor that was reopened, and determined correctly
that no color was desired.

With the freopen() call gone, stdout may very well be the terminal. But we
still do not want color because the output is intended to go to a file (at
least if output_directory is set).

So how about this commit message (I inserted the "Note: ..." paragraph)?

-- snipsnap --
format-patch: avoid freopen()

We just taught the relevant functions to respect the diffopt.file field,
to allow writing somewhere else than stdout. Let's make use of it.

Technically, we do not need to avoid that call in a builtin: we assume
that builtins (as opposed to library functions) are stand-alone programs
that may do with their (global) state. Yet, we want to be able to reuse
that code in properly lib-ified code, e.g. when converting scripts into
builtins.

Note: we now have to set use_color = 0 explicitly when writing to files,
as the auto-detection whether to colorify the output *still* looks at
stdout (which is no longer freopen()ed, and therefore might still be
printing to the terminal).

Further, while we did not *have* to touch the cmd_show() and cmd_cherry()
code paths (because they do not want to write anywhere but stdout as of
yet), it just makes sense to be consistent, making it easier and safer to
move the code later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

