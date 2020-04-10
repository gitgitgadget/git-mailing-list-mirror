Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C851C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7129A20CC7
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 14:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BKRAYr6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJOBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:01:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:36713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDJOBa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 10:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586527284;
        bh=cKRqzFAOBBvW99BrioRsNL/lJd5hLaORA/J+k62NKdA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BKRAYr6orybUiM/pXxf+eRAr58+7+IbTd/hkgR6ieej1vvWx67BJckmbZHpbFu1hA
         L5IHXyb37U2YyDJrFIw2ISZ7mSUcMIEiOfK2MBzrN0F2Y21KgQ2yVXTRFqsyw7/NaQ
         thKw03XCQZXoYr/L3J035+rIoUqB+z4ORbP6F0ew=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5wPh-1jLVZn0Um3-007YZi; Fri, 10 Apr 2020 16:01:24 +0200
Date:   Fri, 10 Apr 2020 16:01:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] Refactor code asking the user for input
 interactively
In-Reply-To: <cf6bdc4c-bacf-5de0-b0b3-255e66c7bc18@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004101559540.46@tvgsbejvaqbjf.bet>
References: <pull.755.git.git.1586374380709.gitgitgadget@gmail.com> <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com> <9d2ee78a9e414c0b6aacbc9c878ab08eb70703d5.1586518072.git.gitgitgadget@gmail.com> <cf6bdc4c-bacf-5de0-b0b3-255e66c7bc18@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:53PlRJh7RkSRetKgplKCLzua/SZ3X36kvwyv2uB5/8y3L/Vg1A0
 74S9+jZZg1NuFgIfMDhl6QsnWA9wsMH/SkQ5E+HMEN2jH9lskdlz78LBaUPc5NT0s0Tw2dl
 lLFwSvboiA3mKv7gAyJbnSCF0R5ZAl5jKKtPJxIYjjPm61bXaD02yhGTKRA4SOxpiNy0LWR
 y5GdsvJn58807N8hJPaow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8iE//m+2Pbk=:GVa0wD/Wj6VRMDwKMx8Q8O
 ey63pkvXWp5a7m0Oe5tKfUp58HF/zsfGdYmU04n+NWWrj1yop8YqqORso4LNbp0CghAhBtJLG
 YKds4Llox7eigtAFZQuaurETbn8g5UR0QQI0aVfLi78XX8M3ALvdZrHW8je9wVbTtgtx7aWxF
 +cDF2zM8VOKMLbQtqICAI24GVk5tmuNZUE9p295wN1haxOSwsZfz23lJ9VnbUQof3YNDNPKI/
 tvRYAsrWF4bFAQMBbeRrB6B5sC5d9mlPOwLpg8Z06KCmilZ4iY6woFXeVTntQJbpQlMbUAV1p
 iRwECh0dBjYFQmhqHfLZpKYxX8og02PZ10V2/4zRcKjX0OaznBIV1tNfLhCnuCGu2jDEEu4XU
 Oaoke7zHcgSZYSN/u0aG09igoyMUZst/kWW6j7cvcDjQ2hRcc9wIc45RlInCb9SudmotEOBZd
 5j3awJab+7MdiN3VNybtWOUgb1/ugHBztiup+G8OJuImK+y+Ube1LO0i2i4uT5L5hO/5TVe+Q
 1Lxx1Wemv0Y45wu4b9sS8TzCeEbPA9MAVkWgarUszZmI5U//YZZqtOeduKh1WQQAyaWVZG3RX
 yNcELdDe2RFIgPHXKRg7haFjC8QKBVQEN1xipwppWJsTm47wWrXIUQy8xCq73I/+cx2N/bg/R
 T1ceJdzD3nFSGKOIMfzt6OdFk3sU+OAf+en/pg0Fg5IgQU4L2Mf59BPfrAgFC6+YGrP4LD2eR
 Ui9jb0ncPEzm0Dwm4/5NcmYG0a5Ys6Lq8eoYtbAwSQyij5TpcdCWUwsEeVM7x6iWGVGDEe619
 sLZ9AJUzqdfz/3FPTe+7o1Z4y1sdzKZSX/74fSqmYz20Up9J4rpIAgBoQRMi06iEB3MMTZaaR
 ja/Nz3fYjvnylhIifYyuLYwmAQBQNNnbHGF7NNf4nsUlhEcjbZ1DvvbwGXNYV5LQatolNKD9O
 AQ5tSe1suQTLLywYIE8QyX4hgVwJURwxRSE2aXm+acc+6DwDArBq1nyuEg3JM4COOjvoElG+9
 GllGJ9c1C69WkmBMZ6Cp/yjs5RxHvhvyQJ4dhGZ/yBokv4v+KWfdcD98jf1BLD++JWSEf8Ru2
 zgwDKQ77SL0hkBT5aK/kM0U0UIBlMRDCebMtWUSTWfZiC/x78Tn+/c9pJ7HkKjo+SfzknebLg
 wg+qU+3+L17mMLGS/umzpfI7OibxpEiRwXjGIc0QR5WjLajvcn58IYRfRg7Efbni/JlIwoeN7
 WnFbBQvsFFVnISJc3
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dr Stolee,

On Fri, 10 Apr 2020, Derrick Stolee wrote:

> On 4/10/2020 7:27 AM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > There are quite a few code locations (e.g. `git clean --interactive`)
> > where Git asks the user for an answer. In preparation for fixing a bug
> > shared by all of them, and also to DRY up the code, let's refactor it.
> >
> > Please note that most of these callers trimmed white-space both at the
> > beginning and at the end of the answer, instead of trimming only the
> > end (as the caller in `add-patch.c` does).
>
> add-patch also only trims the newline! This is still a good change.
>
> > THerefore, technically speaking, we change behavior in this patch. At
>
> Strange capitalization here.

I fixed it and force-pushed, waiting a little with submitting it in case
there are more things reviewers point out.

> > the same time, it can be argued that this is actually a bug fix.
> >
>
> > @@ -1158,9 +1159,8 @@ static int read_single_character(struct add_p_st=
ate *s)
> >  		return res;
> >  	}
> >
> > -	if (strbuf_getline(&s->answer, stdin) =3D=3D EOF)
> > +	if (git_read_line_interactively(&s->answer) =3D=3D EOF)
> >  		return EOF;
> > -	strbuf_trim_trailing_newline(&s->answer);
>
> (Pointing out the trailing newline trim here.)
>
> > +
> > +int git_read_line_interactively(struct strbuf *line)
> > +{
> > +	int ret =3D strbuf_getline_lf(line, stdin);
> > +
> > +	if (ret !=3D EOF)
> > +		strbuf_trim_trailing_newline(line);
> > +
> > +	return ret;
> > +}
>
> This looks good. Do we need a trailing newline or something?
> The way the diff ends abruptly after the "}" line made me
> think so.

No, this file ends in that line, therefore it ends abruptly ;-)

If I add another newline, `git diff` shows a red `+` at the end, i.e. we
consider it a white-space problem.

Thank you for your review!
Dscho

>
> Thanks,
> -Stolee
>
>
