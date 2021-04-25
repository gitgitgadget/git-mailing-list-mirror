Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E90AC433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB721613AA
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 08:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhDYIzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYIzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 04:55:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44388C061574
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 01:54:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o16so13748026plg.5
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zunwD5etLcIHlYjHUk82dAx9UcyxU83HhVQ8G5w2fXc=;
        b=jNYARUutS9qPyywZygQFtxqndCUtASBVEy08DjTBnsUuk/cn8yuMdrfrFH/smtkHRO
         X95kVsewf+Qg7xFNLyHuFO6IERF+O2dXYp5OAdqohLsRCnheIUatmYXgmBcLYsGRH4Qr
         BvKhoZYeGyWGpiw3aGnGZIgzUmsPIV40BKrGMouRF1lCDIsNmmgQzRc7ToYxPB4ujiPP
         YVYZXGFOGoC7JM0Kv+vkz1PSNhOg9V15YOhW7xXJyIhT0En+YitsDqzh8pXEDkF01wp5
         n1Aj375sfDuRNT68kdwG++crQZ54f4TulbVZB8t9PUgiQLzWAwVZZR3cfozAsNQYyq8l
         O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zunwD5etLcIHlYjHUk82dAx9UcyxU83HhVQ8G5w2fXc=;
        b=Z2JPYQ4ra5EK1fznUn0i6GwPe8DdJ9uCoKnHeo3aTPe9w7VaZcdOjbfCX2TcbyitNE
         QK5wZV6Ol7m2GCL9YSaQNaM1jY3x9hDdVIA/pUK82Aq9USQo+LCpYubmqeIiQsFhMx0v
         4WDfw0MbjEs+LZLXRCtxfcIVRiSc53I0+JYcr/ubscAN817xWl4C/rFvOWAY2sciu1AF
         2h6FZ9kf4JT/NqXpx6HHmQAoPPXL7j66Gzvto6DKr+1Zz28xy5g5rSyAyHGo9IKFSqoO
         E1RwMErXm31gOPIi1AgyxSpO8CM5RsRk5AoMNVHomCkaYL902zYl1S2YnX8MHrFTQAwr
         y5UQ==
X-Gm-Message-State: AOAM531pdzVXqxZkCozmBWyVDUXlgj5s7EJNhKvURgKgQwBx21KJpLpv
        wANAjKsii6aHrZrySOHEwZcTmQEEne0plw==
X-Google-Smtp-Source: ABdhPJwlMlGRTceXwav41P40Ptk35azERmJey8ov9LnMVIbt6R9WveHZ7SvDLUEDQJhcg63Zn7gbsw==
X-Received: by 2002:a17:902:b687:b029:eb:6491:b3f7 with SMTP id c7-20020a170902b687b02900eb6491b3f7mr12551372pls.38.1619340876691;
        Sun, 25 Apr 2021 01:54:36 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.112])
        by smtp.gmail.com with ESMTPSA id x38sm8471654pfu.22.2021.04.25.01.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 01:54:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: git diff word diff bug??
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
Date:   Sun, 25 Apr 2021 14:24:33 +0530
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3787BA48-785B-4375-95A0-715D97D0C523@gmail.com>
References: <215a2703-7a16-5ebd-41b5-de0830a1cf63@gmail.com>
To:     Count of San Francisco <countofsanfrancisco@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20-Apr-2021, at 22:08, Count of San Francisco =
<countofsanfrancisco@gmail.com> wrote:
>=20
> Hi All,
>=20
> Here is my "git bugreport":
>=20
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your =
issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your =
issue)
>   git diff --word-diff=3Dporcelain file0.txt file1.txt
>     or
>   git diff --word-diff file0.txt file1.txt
>=20
> What did you expect to happen? (Expected behavior)
>=20
>   I expected the diff for porcelain or default word-diff to be clear =
on which lines got removed and which changes belong to which line. I =
explain more in details below.
>=20
> What happened instead? (Actual behavior)
>=20
>   The diff was not clear.
>=20
> What's different between what you expected and what actually happened?
>=20
>   The diff made it looked like all the removed text were on one line =
and a later change in a line look like it was meant for a different =
line. When in fact, the later changes were for the same line (i.e. the =
first line). More details below.
>=20
> Anything else you want to add:
>=20
> Here are the details to reproduce and more details on how I =
interpreted the diff. If I am writing a script to highlight changes or =
to do extra processing for my specific use case, my script would get =
confused as to what really changed.
>=20
> file0.txt content:
> *** Begin Content *** --> this line is not in the actual file but just =
a marker here for clarity.
> The fox jumped over the wall.
> Blah1e32
> q432423
> qe23234
>  233
> 253
> 345235
>=20
> 53243
> afsfffas
> *** End Content ****
>=20
> file1.txt content:
> *** Begin Content ***
> The fox jumped over the river.
>   He made it over.
> *** End Content ****
>=20
> git diff --word-diff file0.txt file1.txt produced this:
> diff --git a/file0.txt b/file1.txt
> index c8756ba..3413f10 100644
> --- a/file0.txt
> +++ b/file1.txt
> @@ -1,11 +1,2 @@
> The fox jumped over the [-wall.-]
> [-Blah1e32-]
> [-q432423-]
> [-qe23234-]
> [- 233-]
> [-253-]
> [-345235-]
>=20
> [-53243-]
> [-afsfffas-]{+river.+}
> {+  He made it over.+}

=46rom my experience, git diff prefers to bundle up a series of
deletions or additions into a group if they all have the same
word delimiter. The way I would interpret this diff is the steps
needed to be taken when moving left to right in file0 to get to
the state of file1, while minimising the number of times file1
has to be consulted to know what needs to be done next.

Here it would be:
"Delete all the words from 'wall' upto 'afsfffas', and then add
'river.' and ' He made it over'".

> The diff above does not make it clear that the "{+river+}" is really =
to be appended (or related) to the first line.
> I expected the first diff line to look like this:
> The fox jumped over the [-wall.-]{+river+} and the rest of the lines =
are delete lines.
>=20
> git diff --word-diff=3Dporcelain file0.txt file1.txt produced this:
> diff --git a/file0.txt b/file1.txt
> index c8756ba..3413f10 100644
> --- a/file0.txt
> +++ b/file1.txt
> @@ -1,11 +1,2 @@
>  The fox jumped over the
> -wall.
> ~
> -Blah1e32
> ~
> -q432423
> ~
> -qe23234
> ~
> - 233
> ~
> -253
> ~
> -345235
> ~
> ~
> -53243
> ~
> -afsfffas
> +river.
> ~
> +  He made it over.
> ~
>=20
> This is more non-discernable. The git diff --help documentation says =
that "Newlines in the input are represented by a tilde ~ on a line of =
its own". So a script would see the '~' character and interpret that as =
a new line. The script would have mistaken the "+river" for a different =
line. The git diff --help documentation does not explain what to do in =
this scenario.
>=20
> I expected this:
>  The fox jumped over the
> -wall.
> +river.
> ~

This is also consistent with the behaviour I mentioned above.
A script would need to interpret this as:
delete "wall"        (this starts the streak of deletions)
go to next line
delete "Blah1e32"
...

and as soon as it sees a '+', that is, an addition, it knows
the series of deletions are done with, so it will add "river"
to the last line that was common to both, that is,
"the fox jumped over the".

> Is this a bug? If not, how do I make the distinction that the =
{+river+} (in the first case) and the +river (in the 2nd case) is really =
for the first line?

I do not think this is a bug, because it does not really
deviate from any specified behaviour. But I do see the source
of confusion.

I hope I could explain that well enough.

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>=20
>=20
> [System Info]
> git version:
> git version 2.30.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Darwin 20.3.0 Darwin Kernel Version 20.3.0: Thu Jan 21 00:07:06 =
PST 2021; root:xnu-7195.81.3~1/RELEASE_X86_64 x86_64
> compiler info: clang: 12.0.0 (clang-1200.0.32.28)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /usr/local/bin/bash
>=20
>=20
> [Enabled Hooks]
> not run from a git repository - no hooks to show
>=20

--
Atharva Raykar

