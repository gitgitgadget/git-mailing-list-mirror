Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0BCC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9BB61107
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhKJNHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 08:07:31 -0500
Received: from mout.gmx.net ([212.227.17.20]:60675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231679AbhKJNH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 08:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636549479;
        bh=plg/4kvd/YHtMUnrdCKuCXXa8YfhhSknNJ3+1wFm4zk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jKgjlqMliw1xkfnQPIlDVFf6RpuZ82yjBKQRDx8Lfo1DlU/Xo1kjWAotSGF71cZ5m
         EaDj/LYI2vj3j5TebmKIpbFzAxtpENr1OWed4cMWn0s5XTC3j6PrhzS5A3W/cFeFvc
         vPLjSkPM463zZHG1d2YyNptDokKw+jI5w0ENJHF8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1n39TW1OOT-00J1g6; Wed, 10
 Nov 2021 14:04:39 +0100
Date:   Wed, 10 Nov 2021 14:04:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: jc/fix-pull-ff-only-when-already-up-to-date, was Re: What's cooking
 in git.git (Nov 2021, #03; Tue, 9)
In-Reply-To: <xmqqy25wygek.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111101402240.21127@tvgsbejvaqbjf.bet>
References: <xmqqy25wygek.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lMeoDbnysCh3xjROwomak9AyIW/pcGblYbaLLsn1I/PYrl/JGiv
 7Svcgbfn+Y7rfIMJimwwb3igM6fYbpRV1cxmWWLsJgN5ChfGOU4+claGNjERSr4Jna3YMKw
 HwSBFcKrweDUE+3htx+wkPqNhunYTUJvTHweLC9W7w7Voa+Y1E9SKXb8BlytlBSgwhODHf4
 WWMKvzwzDDpICyrx4rwbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XNt7VTda1so=:Y2a0zL8E2438myGPKrulyl
 LsYInD5+0VCuHpXpy9VRVRZdgccx1mo85o2FXRwfe6oV+ccu24o8uGptDoJ6u4KQ6rCNPdc36
 f21WrT1s0bCGRoIfKckwE5kYCK4Jj4AEMOyqpMuCaVmufOXPKZMbSXuCS/9n3hnoBJCIaM3Ce
 RUp1ybCfg3cs1CDPXkcNYJfXTaQms9TDImq+s6H7f2KFrqnRgMOkZ+q6cpCapRnt6YjZjc73a
 86xis+ms8UAO+BvPxOlKwkHMqhc3bEE/oYOOITvqUa62msETh3DNCh66nYCTXInfGHCwtna2c
 YPeIicP7Ocw5VcTvePe7hfJazUr4/KvKbS1dy3xgsy/SyrAwC9gMA10XhRAkZtnnycA7PLD1F
 kEw3+twMIjjVc8lNivEwbRo1qvieply3cv9ulPQIPfGcpG5bq7qgCBuVeEnYKwee5UriYIP4D
 OnrIShcLiINbNwvlteBm2VapsYZJnRUO5Iq6JfZ3h5mqGgutqVKwvqW45Sg1wLFypp0sgWdTY
 dAfKrAGEfXshmjdhwPr+l6Rp6uATgPrMIfoUrWpxkkhEtsuqchJBb3QMqNVl7Kmf8CLcC/Sic
 BR8/t1aVcRIzXIcWSsdApBXUL0rYBj01F43zQJK9LpDQhjSrjI5ZV8znwRTyEtZlMfzt7MiCE
 7BjkIQknjl8+eg4fSc6NDv+KmmOC1vbE0Ir9WE3bW7Z1tzNZbxf89iTwOaJee66gZG3u92G4D
 4j/XMPKkgnu9holNELRJhYvxlJO/YBS88MTR2wg/4OOkg+mjQKg1i9v6rgDkmee9XZB+EyYz7
 xuDFQAPKkBOBg6aHGZRkesL4BqNO2dxoJyvKrMI9myXR2y0pCrulyMJlNimGb5CX+VdvdyFBT
 Mqk2uURxftZF2RgPpcq1sNM2WvXaKVEmGUfsx+MWjs1Y3z3oIZUewxoKOn9wzpQsPRqX0jzKJ
 2KOO3xe7SsgywbPtq5sOU5VWuz0jbvsAR/f92HlTOAtNfAOhSNx5vqZ+yGd/1gIZ1wzIO1mjI
 dav7WTqwV9gAgCUpjTJxNP2K7zBYybiHkBXF1iMvIBfCfhSxS7rW5OO0VF0BZTNGWOkOdaLIv
 mHtFEjg+zIQNLM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 9 Nov 2021, Junio C Hamano wrote:

> * jc/fix-pull-ff-only-when-already-up-to-date (2021-10-29) 1 commit
>   (merged to 'next' on 2021-10-29 at ad4753e668)
>  + pull: --ff-only should make it a noop when already-up-to-date
>
>  "git pull --ff-only" and "git pull --rebase --ff-only" should make
>  it a no-op to attempt pulling from a remote that is behind us, but
>  instead the command errored out by saying it was impossible to
>  fast-forward, which may technically be true, but not a useful thing
>  to diagnose as an error.  This has been corrected.
>
>  Will cook in 'next'.

I would like to register a vote for advancing this into v2.34.0, still. It
is not only technically a regression, it bit me in Git for Windows'
automation. If my experience is any indication, that change of behavior
would not be welcome among Git users, and it would be preferable to
publish v2.34.0 without this regression.

Ciao,
Dscho
