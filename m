Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D0EC43217
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiDEVoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572908AbiDERSf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 13:18:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB1F25DA
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 10:16:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l26so11789830ejx.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/GMEjH0GVtzBbwHl/Tkc+hryrCWuQ9VmxbasnAeeyLM=;
        b=cHmXFe9E0P8ll/+n2eLnf+mu+XqUBpK1tYgCNff08qEDlHh1y1qV+6gdLYw6JBvYSk
         yqBM6lNQlsNczNEXSq/U6FcPs0TeefwsgYbyTjUvLWP2c/6/PM5pw+gfahlmIAUWTg0l
         g1+HQd5wLfvvcfInUufAkgQ69KSNCKlSJsXOyxv9WHRRx/OQ7iAwa9BPuIl1l//3y/8M
         ANdJkJU1xeQwWWNaDOmxu0KwHzlXZHEGoNp0xBFnWmjmPKcR3K2j4oOhmh0YTlwotKip
         48mEE4EtDtbXA4Fic9VxlZlDYCGfEzN0CmbATPqgRYFeHilXyzt0+SSDL456Cr9u5VhT
         3tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/GMEjH0GVtzBbwHl/Tkc+hryrCWuQ9VmxbasnAeeyLM=;
        b=v270Vfnr5/4SQ913uPGGona5GYPjUTXaeD9SjPSLr6qZHjQzhcHslT6bmakDq0Bapb
         yJl6hR7Zl5UEx2x2QOm1nSeSh+vncPPzZv/BCQPaUTqGSoa4j0h8ctHNB7GpjEj/5B6s
         vW0DKQjvsb/M39pJ+guFQhWgSFW6NWyYg4IetDaweyEtB6k7kBows5TcVZw4io/k27YJ
         CFtF7+/Hdgn5wKDZ8vI3JWq2lggI7UhP4b3OeUU2uCiG66DSapD1hvZeNUSe+DYYy6BJ
         rdoxI6WZLtkYpghLpZeEER6J2z1yOs9TwTmxLS2MwoMmKFzkFwK3ltrEtpaOrp3H/dlZ
         nDzw==
X-Gm-Message-State: AOAM530T9RzgN+Yj33b39hXGYV/7Qc8CXIuUNXsV/wR9L9a1M5Z+fjIk
        v7P/QFhwuIxrXQM5ZF3ELnqR7LEiMUe3Iu1QjfFx/w==
X-Google-Smtp-Source: ABdhPJy8YH0bQc1wfYHO8TobIQWpmwzOX6EB6Sbzycx9Yd8MFpnqObanCGmrTLTD1/tTTMEM9HzIs565AAmxY7HNFQY=
X-Received: by 2002:a17:907:94d5:b0:6e0:2924:bd54 with SMTP id
 dn21-20020a17090794d500b006e02924bd54mr4477500ejc.170.1649178995015; Tue, 05
 Apr 2022 10:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
 <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
 <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
 <CAPMMpoggSvPox5tM3B_NZ0GwLzg7LtHkXGhby1mZqpkehZ1G0Q@mail.gmail.com>
 <CAPMMpohm74nVbi-dR=YOLoT+CbPiHGuVo35EoufKGKHP9Urexg@mail.gmail.com> <BL0PR12MB4849BAE614E63BBB0B77EC29C8E49@BL0PR12MB4849.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB4849BAE614E63BBB0B77EC29C8E49@BL0PR12MB4849.namprd12.prod.outlook.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 5 Apr 2022 19:16:23 +0200
Message-ID: <CAPMMpojFrDL9v=fWfyBx-Ko7fdZkd0yroC058n0+KAvL8SPiYA@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] git-p4: Various code tidy-ups
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 5, 2022 at 2:04 PM Joel Holdsworth <jholdsworth@nvidia.com> wro=
te:
>
> > So, an initial test suggests that a recent version of git-p4 at least d=
oesn't fail in
> > the same way under python3, in the face of at least some of these encod=
ing
> > issues. I don't know yet whether failures will occur in other places, n=
or
> > whether the not-failing behavior is better, worse or the same as I had =
under
> > python2, but it seems plausible that I won't be filing any test_expect_=
failure
> > tests after all, and will instead say "yay, python3 ftw!"
>
> That would be fabulous.
>

Indeed, but completely untrue in the end. I had simply lost my
"python3" override in the update (and failed to notice). It works just
like before, unfortunately, so I'm back on track to try to reproduce
under controlled conditions, and propose fixes.

> I myself have a repository that has a variety of such issues. A common ca=
se is CP-1252 Smart Quote characters produced on Windows which are incompat=
ible with UTF-8, without explicit conversion.
>

I was perplexed as to how you could still have these issues, if they
had magically cleared up for me. Now I know - they had not.

> However, a lot of these problems can be avoided by simply avoiding conver=
sion to text in the first place. In many cases the incoming data doesn't ne=
ed to be converted and can be passed around as binary.

That's certainly the behavior in git-p4 under python2, but I'm pretty
sure it's not "right". Git has a formal and coherent strategy for
encoding - commit (meta)data is interpreted as utf-8 unless an
"encoding" header is present in the commit. Git's output is utf-8
(with on-the-fly re-encoding if commits do have a different encoding
specified), unless you explicitly ask it to output in a different
encoding. These processes are "forgiving", in that a set of bytes that
cannot be interpreted as utf-8, in a commit that does not explicitly
specify an encoding, will be output as-is rather than being rejected
or warned about... But there is a "right way" to store data. When
CP-1252 (high-range) bytes are simply "passed through" into the git
data by python2, the resulting git commits cannot be displayed
correctly by most or any git clients - they expect utf-8.

On the other hand, in Perforce that does not appear to be the case at
all: as far as I can tell, p4v in windows is simply using windows's
active "legacy codepage", and reading or writing bytes accordingly
(CP1252 in my case); in windows cmd, same thing by default; in linux,
where utf8 is the norm nowadays, I get "unprintable character" output
when something was submitted from a CP-1252 environment (same as I do
for the python2-imported git commits, on any platform). If I switch a
windows cmd terminal to utf8 ("chcp 65001"), it behaves the same. If I
create a pending changelist with non-ANSI characters in Linux they get
submitted as utf8-encoded, and when I view the same pending changelist
in windows (from the command-line in its default legacy codepage, or
in p4v which also seems to use the legacy codepage), I see the classic
utf8-interpreted-as-CP1252 artifact "=C3=83=E2=80=A0" instead of "=C3=86".

I don't see any sort of "codepage selection" configuration either in
the perforce clients, or in the connection / server relationship.
Perforce tooling seems to simply assume that the Operating Systems of
all users will be configured with the same codepage - the bytes are
the bytes, clients encode and decode them however they will, and there
is simply no encoding metadata. US/western Windows clients, modern
linux clients, older mac clients, and cyrillic-configured clients, etc
will all have produced mutually-unintelligible content in the same
repo over the years.

In *my* environment, a majority of users have been using Windows over
the years to write commit messages, and most will have had CP-1252
configured, so I believe the most reasonable behavior would be "try
interpreting the bytes as utf-8, and if that fails then fall back to
interpreting as CP-1252, and either way, store the result in git as
utf-8" - but I don't know whether that is the right strategy for a
majority of environments. This strategy makes sense for me because
it's very rare for something that *can* be correctly read as utf-8 to,
in fact, not be intended to be utf-8; that was kind of the point in
the standard's development - so starting by *trying* to interpret as
utf-8 is a safe bet, and has value if *any* of your clients are likely
to have used it. In my environment there are linux users, and in fact
p4 user management happens in linux, so user names/descriptions are
also utf-8.

For other environments I suspect the "fallback codepage" should be
configurable (I don't know how codepage identifiers work
cross-platform in python, that sounds like it might be fun). You could
imagine having an "auto-detect" fallback option, but for the reasons
identified above this would need to operate on a per-string basis to
have high value, and I think CL descriptions (and user names) are
simply too short for autodetection to be a viable option.

Another reasonable strategy (less optimal for my environment) would be
to follow the "python2" approach of writing the bytes into git as they
were read from p4, but also additionally *telling* git what the
encoding is expected to be, by setting the "encoding" header
accordingly in the fast-import data. In my case that wouldn't work
well because, again, author names are utf-8, but commit messages are
more commonly CP-1252. Git expects all the strings in the commit to
use the same encoding (unless I've missed something).


> I'm slowly working toward this goal, and once this patch-set it merged I =
have a couple of other decoding patches in the pipeline. If you have any ot=
her failure cases, please do submit them as test cases, or bug reports at l=
east.
>

I'd love to know what approach you're looking at!

I only use git-p4 for mirroring p4 activity into git, and not the
other way around, so my perspective on this whole topic might be a bit
skewed or short-sighted. For example, if we do end up storing the data
in git as utf-8, as git expects, then when someone comes to create and
submit p4 changelists from git activity, they might presumably want
that stuff to be output-encoded as CP-1252, if that is the more common
convention on their Perforce server...?

> I would prefer the script to discard Python 2 support, but even if the co=
nsensus is to retain it, Python 3 forces us to address these issues which i=
s a great step in the right direction.
>

Right - discontinuing python 2 forces the elaboration of *some* sort
of strategy, besides the python2 default of "oh, just import
effectively-corrupt bytestreams into the git repo". That sounds like a
good thing :)
