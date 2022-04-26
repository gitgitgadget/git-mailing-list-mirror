Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C7C4332F
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 17:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiDZRM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353822AbiDZRLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 13:11:07 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235F340E2
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 10:07:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id w124so9410217vsb.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jYW1xZy/WER5Ei1UNSHn7vZdbgh6YSo98xJr9oexcY=;
        b=RaryjUok7e1g3eO58zdqVagc1wxfoiPNHjfFtCw5flf7R9JGDSxxkPu5FIupP0brL3
         FrJoiadpyoTjeR2LoICZmNJ0HfkT0C+bewAftxAbiwCfxdj5Lzvtq5Mco0CZKwh1a1sr
         GFC41osFXvT6rd8qVVUyBl8YVM2IawpA8nXSrSE1VkNYFRNbYx6u1vSSyhY2lOKjsb9Q
         4JK7JpgJuGJR1AIUI9SHJ4ULFeitrSkerLQ61HtG3g6On1O+MLQ9+WQQiDiWMMgir/S5
         cMVaMobqe4zMf5Mnc71QSiSgx0EB/iodj3OCdoWGA6obgEI0B+ac7MltMpQqtfoLVRbx
         sbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jYW1xZy/WER5Ei1UNSHn7vZdbgh6YSo98xJr9oexcY=;
        b=59OvORkCXoJYjn5FDdE6FJzofuh4Bd3mRV2AwgeFMQTn+qIQSt3PMjNUfimvltZDg8
         U3pVRGTWThvmJVGHXR17Uq5vMKQ/dGHLAicEhS9ASdjaNiOVlzyfIi7hnpnqxN7XHvVb
         pvo2Q9G8SqryiWi+ezDl6OgBpHFwgdNZ3jxFNhCH2jF2allrMbm8SGl/6Wf35VkHT43v
         eRG4m/JTAfa0IhRptxA8/5uC7GMCXpnjv86LbzSvHy/VFiqfqNbSd3nInzvenm0z7Fxw
         8OU55BoyKAExcCGy+7TZra1AQ0R0jun9kpUWeEDtkbY2N7sKYxA2MPvZG4vbTz21ZPSd
         N+2g==
X-Gm-Message-State: AOAM530HzaCujVClM/rB+TdTVX8IlPtsmx9SpIIcvuonKTd1NTKH8Mh/
        6GvCKi7jG98RXlU2ozSgImLLDrfVHOnmhOkXdaM=
X-Google-Smtp-Source: ABdhPJz6NpRFd7DHNkp3VkEYlaQ52sT/1T6lBY7dFkDXiDqSmi9IL1IZDROPaU/Dbq7M6u5aopyiRurXSrZi4pCmHkE=
X-Received: by 2002:a05:6102:ed4:b0:32c:ea17:c6b5 with SMTP id
 m20-20020a0561020ed400b0032cea17c6b5mr944133vst.52.1650992850472; Tue, 26 Apr
 2022 10:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013911.7646-1-carenas@gmail.com> <20220423142559.32507-1-carenas@gmail.com>
 <20220423142559.32507-3-carenas@gmail.com> <nycvar.QRO.7.76.6.2204261747530.355@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2204261747530.355@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 26 Apr 2022 10:07:18 -0700
Message-ID: <CAPUEspgBNWPtiriYTVWdnJtdy6jZBBov3zTnwZZGA8gXwMiooA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ci: avoid brew for installing perforce
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 8:55 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Sat, 23 Apr 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 41e9290fbdd..9da03350d09 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -37,13 +37,14 @@ macos-latest)
> >       test -z "$BREW_INSTALL_PACKAGES" ||
> >       brew install $BREW_INSTALL_PACKAGES
> >       brew link --force gettext
> > -     brew install --cask --no-quarantine perforce || {
> > -             # Update the definitions and try again
> > -             cask_repo=3D"$(brew --repository)"/Library/Taps/homebrew/=
homebrew-cask &&
> > -             git -C "$cask_repo" pull --no-stat --ff-only &&
> > -             brew install --cask --no-quarantine perforce
> > -     } ||
> > -     brew install homebrew/cask/perforce
> > +     mkdir -p $HOME/bin
> > +     (
> > +             cd $HOME/bin
> > +             wget -q "https://cdist2.perforce.com/perforce/r21.2/bin.m=
acosx1015x86_64/helix-core-server.tgz" &&
>
> I vaguely recall that G=C3=A1bor Szeder attempted something similar, but =
I
> _think_ that ultimately there were too many moving parts in that URL that
> we did not want to hardcode.

I can see that, and indeed that is also why those series still keep
perforce installation as optional so it wouldn't block CI when it does.

BTW most of the reasons why those values are hardcoded here
is just to avoid conflicts with on the fly changes, and making it smarter
and avoiding the hardcoding would be done as a prerequisite to making
it mandatory again (if that is what is preferred)

> While I don't think that we can solve this fully, I would prefer to keep
> the existing `brew install` calls but fall back to downloading from a
> hard-coded URL.

Considering that the expectation from brew maintainers (as documented[1])
is that those mismatches would happen and should be solved manually
and that perforce releases just do inplace binary pushes I still stand by m=
y
suggestion to avoid brew, but it might be useful as a fallback of the wget
approach if that helps with your concerns above.

> For the record, the recent problems stem from the fact that the package
> was cached on GitHub's build agents (I guess to avoid many identical
> downloads), and the cached package did not match what was recorded in the
> updated package definition. Which means that those `brew` errors are only
> transient, until a new VM image is built that caches the then-current
> perforce package.

FWIW as I updated the brew cask[2], I realized that livecheck pointed to an=
 even
newer release, so if we are adding brew back it might be worth adding
yet another
workaround to delete the cached file and try without a SHA as =C3=86var sug=
gested.

Carlo

[1] https://docs.brew.sh/Common-Issues#cask---checksum-does-not-match
[2] https://github.com/Homebrew/homebrew-cask/pull/122347
