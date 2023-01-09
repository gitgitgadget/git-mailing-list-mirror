Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41767C54EBE
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 13:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjAIN04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 08:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjAIN0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 08:26:55 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C7BC0F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 05:26:53 -0800 (PST)
Received: (Authenticated sender: michael@platin.gs)
        by mail.gandi.net (Postfix) with ESMTPSA id 6CD96FF814
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=platin.gs; s=gm1;
        t=1673270812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wShidO/nWKdVsRvYQ4/PrjLR/x5bW5zV8xnTGONNGFY=;
        b=XGyA3sYIErugQNYQGDRKVy86gyfFLC7S1uUWVrt8t/zfpinhbOSVfg/wkuBM+dGhTXCMNg
        /rH686o7WK09D8Kt6a+GuXlO6LeQVSHnuAeA9a/eA0udwiZlxf8Mt6tt0nWmPuw79iVhkX
        4/Xe/JzqCZ15LJEFohf4g3bLlnesPAfIcgszTVeZFIG9srrVOprhguB8RycTmWcp+j1oCg
        BcgVRvOPQmevMITVCrQ7kOJZlRJqkRayc3C5zJUchO2kDGN26CYJUXORb/EUNShLXvbTJU
        opBsy2pRpy1Ic8jjLP1Z0s4aesxTp/z1h5/2hHCph//9Rp+lOjFQZJCVoYE0tA==
Received: by mail-lj1-f181.google.com with SMTP id s22so8850426ljp.5
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 05:26:52 -0800 (PST)
X-Gm-Message-State: AFqh2krInEvDox0sIPTX2iydgRRbhnRQWq8TJcXU+gv++ELuPbQh8i3q
        urIZxB8+TYDjriDHNppKXG9QQCH2vC2iC62NTXY=
X-Google-Smtp-Source: AMrXdXu2zXMEoXi5EVDRHlyJJjM+/OI2jgczxoaDxfwG8SJygqLJYKcFplYGcp7VGddxN2wY0HMbHxwNLsfzer58yJQ=
X-Received: by 2002:a2e:98c3:0:b0:27f:ea44:3efc with SMTP id
 s3-20020a2e98c3000000b0027fea443efcmr2607953ljj.272.1673270811497; Mon, 09
 Jan 2023 05:26:51 -0800 (PST)
MIME-Version: 1.0
References: <b1051e73-e663-82bf-bda6-015e64102248@trigofacile.com> <xmqq5ydgwcj9.fsf@gitster.g>
In-Reply-To: <xmqq5ydgwcj9.fsf@gitster.g>
From:   Michael Platings <michael@platin.gs>
Date:   Mon, 9 Jan 2023 13:26:41 +0000
X-Gmail-Original-Message-ID: <CAJDYR9RnWuO66i9aLdACox+GRSpidyWyZkS_2hHWH=1v2cfbtA@mail.gmail.com>
Message-ID: <CAJDYR9RnWuO66i9aLdACox+GRSpidyWyZkS_2hHWH=1v2cfbtA@mail.gmail.com>
Subject: Re: Ignored commits appearing in git blame
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?SnVsaWVuIMOJTElF?= <julien@trigofacile.com>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Resending. The anti-HTML filter gets me every time)
Thanks Junio for forwarding.
Hi Julien,
You're right, ideally 36944f2b16 should have disappeared from the
output at line 5. The way the ignoring algorithm works is that it
tries to find a line in the previous commit with similar content.
Since there's so little content to compare I guess the algorithm plays
it safe and gives up. On the one hand this is annoying because an
empty line or single curly brace should be trivial for the algorithm
to deal with. On the other hand "which change caused this empty line
to be here?" is not a very interesting question so hopefully won't be
too much of a problem for you in practice.
Thanks for bringing it to my attention. There are a couple of
annoyances with the feature I'd like to fix (the main being that
there's no way to enable it globally) and I'll add this to the list.
However I'm unlikely to get to it soon. I won't complain if you beat
me to fixing it :)
-Michael


On Mon, 9 Jan 2023 at 04:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Julien =C3=89LIE <julien@trigofacile.com> writes:
>
> [jc: redirecting to those who touched "blame-ignore" topic in the past]
>
> > Hi all,
> >
> > I'm facing an issue with the use of "git blame" which shows commits mar=
ked to be ignored.
> >
> > We have a .git-blame-ignore-revs file that can be retrievable at <https=
://github.com/InterNetNews/inn/blob/main/.git-blame-ignore-revs>.
> >
> > The Git command line I'm using is:
> >     git blame --ignore-revs-file .git-blame-ignore-revs radius.c
> >
> > Here is an extract where commit 36944f2b16 appears at line 59, though i=
t should be ignored (present in .git-blame-ignore-revs):
> >
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  50)     int r=
adport;
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  51)     char =
*lochost;
> > a9d899ddbe (Russ Allbery       1999-11-29 01:40:47 +0000  52)     int l=
ocport;
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  53)
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  54)     char =
*prefix, *suffix; /* futz with the username, if necessary */
> > 9f21a39f37 (Katsuhiro Kondou   1999-06-12 09:33:48 +0000  55)     int i=
gnore_source;
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  56)
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  57)     struc=
t _rad_config_t *next; /* point to any additional servers */
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  58) } rad_con=
fig_t;
> > 36944f2b16 (Julien =C3=89LIE        2021-10-31 10:04:59 +0100  59)
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  60) typedef s=
truct _sending_t {
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  61)     auth_=
req req;
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  62)     int r=
eqlen;
> >
> >
> > When running git blame without ignoring revisions, commit 36944f2b16 ap=
pears at lines 54, 57 and 59:
> >
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  50)     int r=
adport;
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  51)     char =
*lochost;
> > a9d899ddbe (Russ Allbery       1999-11-29 01:40:47 +0000  52)     int l=
ocport;
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  53)
> > 36944f2b16 (Julien =C3=89LIE        2021-10-31 10:04:59 +0100  54)     =
char *prefix, *suffix; /* futz with the username, if necessary */
> > 9f21a39f37 (Katsuhiro Kondou   1999-06-12 09:33:48 +0000  55)     int i=
gnore_source;
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  56)
> > 36944f2b16 (Julien =C3=89LIE        2021-10-31 10:04:59 +0100  57)     =
struct _rad_config_t *next; /* point to any additional servers */
> > 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  58) } rad_con=
fig_t;
> > 36944f2b16 (Julien =C3=89LIE        2021-10-31 10:04:59 +0100  59)
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  60) typedef s=
truct _sending_t {
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  61)     auth_=
req req;
> > d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  62)     int r=
eqlen;
> >
> >
> > Shouldn't 36944f2b16 have disappeared from the output at line 59?
> >
> > It should have been d65e228465 which already had that line, as it can b=
e seen in the commit (line 53 at that time):
> >   https://github.com/InterNetNews/inn/blob/d65e228465700ff044b75aecacb7=
062d2a1250f9/authprogs/radius.c
> >
> >
> > The result of that command is the same as the one GitHub shows; you can=
 therefore find the whole ouput here:
> >
> >     https://github.com/InterNetNews/inn/blame/main/authprogs/radius.c
> >
> > Commit 36944f2b16 is mentioned at lines 59, 129, 144, 293, etc. though =
present in .git-blame-ignore-revs.
> > Yet, that very commit is correctly ignored at other places of the same =
file.
> >
> > Other files and other commits in the project are also affected.  I can =
give more examples if needed.
> >
> >
> > Is it the expected behaviour of "git blame"?
> > Is there a reason for these commits to appear in some portions of the b=
lame output?
> >
> >
> > Thanks beforehand,
