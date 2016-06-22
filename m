Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792AC1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 07:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbcFVHZJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 03:25:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:52330 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbcFVHZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 03:25:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LqV4f-1btc1w3A6D-00e91I; Wed, 22 Jun 2016 09:24:09
 +0200
Date:	Wed, 22 Jun 2016 09:24:07 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: avoid freopen()
In-Reply-To: <xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606220849480.10382@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <de218a6cc529b3f5c33dc4b8282f16fd8a5329a8.1466244194.git.johannes.schindelin@gmx.de> <CAPig+cTiexRhzS3MwMEntGYxKms-XQvtoc7HOnUGJvDaBSK7JA@mail.gmail.com> <alpine.DEB.2.20.1606200814510.22630@virtualbox>
 <xmqq4m8nvodo.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606210906190.22630@virtualbox> <xmqqvb12qyeu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YCE/Dy7dORD3CN8marQnAIrunhGOJwdbyA5qqSNmY5pArBebeA2
 Ujonp4/p2IQxCTl46XtPDQ0i99enGShW+w36C1DAd5HCwY9zPVbadOder8mlOXqslK2gRZO
 CnDjtUaMTkIt+wBnqFus7pRpFis356hlmh2n/C9gvA8bZQW/s7dj7KraBSWf/HjRFZ2JDz3
 CBDgDLjME+8pc4WUJe/Ug==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0Ylzvg7Bmxc=:H+leOtJi/8wZ6FeRtCam+3
 xyEb4ZNc/cniC02ii8byffnOXNDaHLk1lE8Xkr/UJ77igJZ88R/kJ6BDJDY5I+SwtjKXnja/4
 y0A23dUDhOg9V2tVUbvAAAfAAr8DWK4l28oLQme69ttbG1KwUM3f1gJI4DOGYvYIRBKBcMdAY
 14V4lr88jFnYbpLsBA0Cgu8rAVyJxIkZBd/YgJfI+4Hlq8KgJCwKPWHvqwGr0BrjGhN0DhUO8
 pEK3CwtCgXqAy/4RkCbjVkFDh5r8/d2YCW6GQ3HJo+SUBw1eim9iVClT9azLGc5r1ST0s0rCG
 k/O5D8d6YpsRxLWKM6wTdu1h5RmiyfHXUjfajjGpPu0C3DX1yOrgDs7d29zX0WmKeXw5/GjL1
 F3//NchsdKM7CcIfrTPG9B4b2AZlfxeF2Hxuj/MoYcdLfbSFJ3QfrJXy4l1r6TSN/57zkdkEd
 cnhGl1Yk4VWVgq5N+51wkACMCbBLQfwY8WGS7879gX+5zPapyxnY8li7uHIiqAPEpzGWdqsLX
 BgXDqHGtU/ICYeTGGd8AE/lgKii047E8fYmWVghl0qNIm64O7FYBW6HgD+6m6wtt3ufQKxR32
 1eIlX/xK4UH/mtsbGI/MipIG95kJ6AMwbrQ3SeRPGESwfwBORmERzoeq9GnTH/oCT3q5WpGA7
 0ArURLPasVdUE73NU/wBx113V48/FsIjWxhTLa7IUu19LXN3ucT/lQhrRBqE2fkchi9ym47yj
 1g5LjuGg1D/wfEBt8fBqkxTk7jgnK/DBF3FrwWRDvRolFKX0P+sztzaNdLreOetB9ZNMHcRA8
 nWDCAG4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 21 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > That is a very convincing argument. So convincing that I wanted to change
> > the patch to guard behind `diff_use_color_default == GIT_COLOR_AUTO`.
> 
> I actually was expecting, instead of your:
> 
>  	if (output_directory) {
> +		rev.diffopt.use_color = 0;
>  		if (use_stdout)
>  			die(_("standard output, or directory, which one?"));
> 
> an update would say
> 
>  	if (output_directory) {
> 		if (rev.diffopt.use_color == GIT_COLOR_AUTO)
>                 	rev.diffopt.use_color = 0;
>  		if (use_stdout)
>  			die(_("standard output, or directory, which one?"));
> 
> I didn't expect you to check diff_use_color_default exactly for the
> reason why you say "But that is the wrong variable".

In diff_setup() (which is called by init_revisions() which in turn is
called by format-patch's cmd_format_patch()), the use_color field is
initialized with the value of diff_use_color_default, though:

	https://github.com/git/git/blob/v2.9.0/diff.c#L3283

Please note that diff_use_color_default is initialized to -1:

	https://github.com/git/git/blob/v2.9.0/diff.c#L32

and set to a different value here:

	https://github.com/git/git/blob/v2.9.0/diff.c#L180

when parsing the diff.color or color.diff config settings, which
however are *not* parsed in format-patch, thanks to:

	https://github.com/git/git/blob/v2.9.0/builtin/log.c#L740-L743

Therefore, use_color is initialized to -1, and in format-patch's case it
remains like this. I was a bit surprised to see that GIT_COLOR_AUTO's
numerical value is *not* -1 (which I would have chosen for the "undecided"
case, but I guess that -1 was assumed to mean the "unspecified" case), but
the numerical value of 2 instead:

	https://github.com/git/git/blob/v2.9.0/color.h#L59

Hence " rev.diffopt.use_color == GIT_COLOR_AUTO" would
evaluate to "-1 == 2" in this context.

Further, I think that the commit message of 7787570c (format-patch: ignore
ui.color, 2011-09-13) makes a pretty eloquent case that we *want* to
switch off color when letting format-patch write to files.

But there's a rub... If you specify --color *explicitly*, use_color is set
to GIT_COLOR_ALWAYS and the file indeed contains ANSI sequences (i.e. my
analysis above left out the command-line part).

In short, I think you're right, I have to guard the assignment, with the
minor adjustment to test use_color != GIT_COLOR_ALWAYS.

Will reroll.

Ciao,
Dscho
