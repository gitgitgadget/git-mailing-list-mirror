Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F8C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B4A21D24
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBLwA6tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgIXM4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgIXM4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 08:56:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719FC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:56:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q4so3173833iop.5
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/YEnZ4cuis0fe4/UfxIGGPTzvHaotulnDui+YDwEr4E=;
        b=BBLwA6tXRlwLLHUrdTqJmWzBahyEeVQH/7F691DLDYCsdYRBbmpzOeVS+dgi2erIAU
         udBIBGuZKNYVZye+vz0RKzlRoOCS8fPVjHLCYhkC0gDo8ZnzO8MrzOXtxdLSeMjfYBt8
         3M2Ka26Tf9IX+fCzMGFhDbyCn4m0R9WMZjRkwQDeXEh9e5MK3QR5DqNFrxQjXv98hfyH
         Pw2KQJn4c3glZmUNMA4idLNASiXj9T1cyNGb4DbJ2NnQwudFC7NubPJaJ0rXk3oPd7jv
         2+e9USHYm/8JcmVGnzC//IxZZIPyIlnNNi7HNPc35/NfL7p7qoAV3bBP/tde3p2NSbd1
         osQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/YEnZ4cuis0fe4/UfxIGGPTzvHaotulnDui+YDwEr4E=;
        b=GsQSZqNlXt4i8/YRpnsNctzcbaDlE/1r2E8wgvuWZOhPc+UVf41VM3ukxrwn10WmEF
         ve8smby6sGXcXKukQwOJEbrvyztH0IZH9lx9xg8gAeREQzIhdrrdapiTaqlrUD9lLrWR
         XNA2ijreKfb92NYId50rhEDcsVtm8izPbPoGDwSiHtW6fR1ORNGg4Y6ZvFQ+sjj0y1aN
         d/3WijGzDUrhSpD4Ub/dy41fzG8zl/OPIQb4JrgeIqFSI6cSWS0B6dDxSe9heb5shVgP
         T97QOPyfPwn4lLC3tUSztqSku6FH11DCEOSXtmswmQDVu7xtbFvKQYIVMVcYQIHWPDOM
         Vvmw==
X-Gm-Message-State: AOAM530g7/izFbHU2OrV8DhLjkRwsdYC+ech1U9Dxk5rLCFcC5GAq1j1
        P/7KkH4FNMpCcYvlHFU2rzBsHOWfZdQMuNPsB/Y=
X-Google-Smtp-Source: ABdhPJwCBo9trIfDYtEGxpqU5Yg8K6QTTmpKui/lPwK+abm3OyjARM/mNCpfDqmMSFfnXdh4Xbl8de102pb7HRt4uSI=
X-Received: by 2002:a05:6602:2f8a:: with SMTP id u10mr3161577iow.72.1600952204492;
 Thu, 24 Sep 2020 05:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200831105043.97665-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2009031403510.56@tvgsbejvaqbjf.bet>
 <CAN7CjDDVp_i7dhpbAq5zrGW69nE6+SfivJQ-dembmu+WyqKiQQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2009231647370.5061@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2009232316570.5061@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 24 Sep 2020 14:56:33 +0200
Message-ID: <CAN7CjDBSn1FoTFEeqEaGJuSaiUAvjoWZHd6GkmOO5UW8p9ho_w@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] Finish converting git bisect to C part 2
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El mi=C3=A9., 23 sept. 2020 a las 23:23, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Wed, 23 Sep 2020, Johannes Schindelin wrote:
>
> > On Wed, 23 Sep 2020, Miriam R. wrote:
> >
> > > Applying some of your suggestions related to removing some 'eval' in
> > > git-bisect shell script, a bug has appeared. It seems it is related t=
o
> > > a previous code merged before my internship.
> >
> > Now you got me curious: what bug did you see?
>
> I found your fork and ran the test, and this is the first symptom:
>
> -- snip --
> [...]
> ++ git bisect skip
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [32a594a3fdac2d57cf6d02987e30eec68511498c] Add <4: Ciao for now> into <he=
llo>.
> ++ git bisect good
> ++ grep '3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit=
' my_bisect_log.txt
> 3082e11d3a0f2edca194c8ce1eb802256e38e75e is the first bad commit
> ++ git bisect log
> ++ git bisect reset
> Previous HEAD position was 32a594a Add <4: Ciao for now> into <hello>.
> Switched to branch 'other'
> ok 22 - bisect skip: add line and then a new test
>
> expecting success of 6030.23 'bisect skip and bisect replay':
>         git bisect replay log_to_replay.txt > my_bisect_log.txt &&
>         grep "$HASH5 is the first bad commit" my_bisect_log.txt &&
>         git bisect reset
>
> ++ git bisect replay log_to_replay.txt
> error: update_ref failed for ref 'refs/bisect/bad': cannot update ref 're=
fs/bisect/bad': trying to write ref 'refs/bisect/bad' with nonexistent obje=
ct 10006d020000000068986d020000000054f65f00
> error: last command exited with $?=3D1
> not ok 23 - bisect skip and bisect replay
> #
> #               git bisect replay log_to_replay.txt > my_bisect_log.txt &=
&
> #               grep "$HASH5 is the first bad commit" my_bisect_log.txt &=
&
> #               git bisect reset
> -- snap --
>
> So I dug a little bit further (and applied Christian's patch in the
> meantime), and it turns out that the `eval` has nothing to do with what I
> originally thought it would be required for: I thought that it wanted to
> prevent `exit` calls from actually exiting the script.
>
> Instead, those `eval` calls are required because the arguments are
> provided in quoted form. For example, during the execution of t6030.68,
> the `eval` would expand the call
>
>         eval "git bisect--helper --bisect-start $rev $tail"
>
> to
>
>         git bisect--helper --bisect-start '--term-old' 'term2' '--term-ne=
w' 'term1'
>
> Therefore, the `eval` really needs to stay in place (also the other `eval=
`
> I had originally suggested to remove, for the same reason).
Ok, I will recover your other suggestions too.
>
> I would still recommend appending `|| exit`, even if it just so happens
> that we will eventually abort when the `bisect--helper` command failed
> anyway, because the next command will then fail, and abort. But it's
> cleaner to abort already when this invocation failed rather than relying
> on that side effect.

Aha.Ok
Best,
Miriam
>
> Ciao,
> Dscho
>
