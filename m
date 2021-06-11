Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE2BC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 10:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38862613E7
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 10:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhFKKiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:38:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:37631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231315AbhFKKh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 06:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623407756;
        bh=Le+CFbRBwDYcRDDckbdMYDa/5X2Xggy0TKmqYCYFFWY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=luu1araqmD3mkeawI6wTFFOmlUg3AH18F7zJFsCVt1WRFXW+O0GacUd8ip/osOKul
         SGj70p0xLhvtUFjGE7i0dttiSyiRTDB+bWgO6VmskFAUEayggD23VHE5ho5C8KrYfP
         Upf6iGckeaz+e60AQ2GOkmyCbjvfj9MaFKR05KF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1lUdyS1uJw-00lWD2; Fri, 11
 Jun 2021 12:35:56 +0200
Date:   Fri, 11 Jun 2021 12:35:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Shumaker <lukeshu@lukeshu.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 2/2] subtree: fix assumption about the directory
 separator
In-Reply-To: <878s3h6wo8.wl-lukeshu@lukeshu.com>
Message-ID: <nycvar.QRO.7.76.6.2106111235110.57@tvgsbejvaqbjf.bet>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com> <4e1a569c9fa494fa9bb1bfde14d77ac9751d9049.1623316412.git.gitgitgadget@gmail.com> <878s3h6wo8.wl-lukeshu@lukeshu.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kWUUS/Oq7opxKva1UWIcHMUfFNMTv5djaE/6IueM+VOaO6vvOhW
 MSH9DJP2HZhLw38yTVeZ7DNdGRQiS7idDHlLlW1EuBBbkxtnY55kv4D3wpgvS6/mWgRJ8Gb
 WIB3KmUnSRrva7zZvs4S4Uc5b/I/rgPcwwKuU35fEicwC9SN3fPPXLYU1x5MfydkaQVTyFm
 uR9yeTixRp8tnaQOKA/FA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/twFv7+3Lks=:yGe61/ot6mSv6QTVCWyYlv
 ALsAGOlNfCWaEfiE1Dv8n+vNpjvLax246T+WR4/rpHucXWaQejGV5CYhzPQ/5t/3hvq5brQhS
 1cJvW58vWGGLIvd5orzfjcGvoxlI6Scs+shslOkBnACNMdeU0ZdjZaOmD7og5bcqG9r3d4NfR
 9PBywoAnO4ggTlxq6PJN5ATDyMvZHR3N6taStQTihqg4vSoESqMveLzJGySBZZ6U6K2YtvJph
 wG/Torhzn8kcIt4tNVec6GPNZoH2KcSRQKMVNLTmVDZRr0EFhOD/anJsDAgwnCGxBBvefF5/B
 1cDTLfTDu4ycuf61xHfl1A8JmeJ5N7HQAYG/mf00uu90PdRYACkvrFtW3qiY59iXVUnQkZvHm
 az0pI9znWBSi9hnFtm48Aaxf7aP8W839VxOyINFnHDJwJEzRNOnqJTqq9euMXr/j4+ULDcPa2
 a8MvogNcYw4ka13koZ7B0bEHgK5p0rzoAx41YuiRKYnhQFMmJcggdc4QrYr9cBGFgL9a8WOGd
 r37pqa3lnK6YfXY3WrqzSgLaFV4uW/0NsWbl82CBGxGbtSR+PklU5yYka4zR7jqBnp7rM9Lh2
 orbJUIhlachTG3IhkL+ASEkmOay5PsOG25EPG0b8Gkyym3eYfdEGSXz+DatwkrNPdjysEo4/t
 knjxRUZlE+LDAvwXrq//viYCY2tXCJ24fuUHwZIWaD9+wph2npQyi2+OaHCzvoklfNoK1z+c2
 ilNcQDxhOiklkU+5/eJLO72a0JA1WwlHkjsn1PriyQFFRW6SyqMJoMC50q2F7fPgAMqdnJEK+
 g/rSBlYn4OLnfMg4jJWxqNR0d/7WQVjsWkyYez9KkgLTuF5hqLXpjtN/JYsdIX9lEsfMD9MOt
 BiEOvARXWw7aXUuHSzGhgessG/+7sXTv3K2cljc6Nij9flBt8DYzNYefgrkv8db5chQ743PuL
 VVnn1Y+cnTAx4jLtNrcBewDpwlvGFf3Wgj0jDuz37XfpthprC3sa87pYAMR6E0bTg2b+orfSZ
 iJsr/QkqUanzuPO8sT0BMTluPyQvZ09ov8tNFwecAhLDh8mVz0R9+R07KM1tShgjiMJW3OQwA
 FxYYkkwW+s9NverUwkjlk2ftbHxzptvEHogr8BOzBS4zVNCMWB4+Z4p7A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Thu, 10 Jun 2021, Luke Shumaker wrote:

> On Thu, 10 Jun 2021 03:13:31 -0600,
> Johannes Schindelin via GitGitGadget wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, both forward and backslash are valid separators. In
> > 22d550749361 (subtree: don't fuss with PATH, 2021-04-27), however, we
> > added code that assumes that it can only be the forward slash.
> >
> > Let's fix that.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/subtree/git-subtree.sh | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subt=
ree.sh
> > index 6bd689a6bb92..d11ac56f9eb8 100755
> > --- a/contrib/subtree/git-subtree.sh
> > +++ b/contrib/subtree/git-subtree.sh
> > @@ -13,6 +13,8 @@ if test -z "$GIT_EXEC_PATH" || {
> >  	}
> >  } || ! test -f "$GIT_EXEC_PATH/git-sh-setup"
> >  then
> > +	base=3D${0##*/}
> > +	base=3D${base##*\\}
>
> This might be more clearly written as
>
>     base=3D${0##*[/\\]}
>
> ?

True. For some reason, this did not work in my tests (probably because I
confused `#` with `%` or put the wildcard on the wrong side, or
something).

Will fix.

> (And then maybe it doesn't need a separate variable, and can still be
> written in-line?)

I am not in favor of inlining here. Three times. It is too complicated a
construct for a casual contributor. At least giving it a name (where
"basename" would make even more sense than "base", I just realized)
alleviates this problem _somewhat_.

Ciao,
Dscho
