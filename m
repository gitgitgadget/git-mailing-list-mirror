Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA3C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 10:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2059B206B2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 10:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dpWcX7HR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgINKa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 06:30:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:48819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgINKa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 06:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600079452;
        bh=l1cvAd4lFVEtoBHEMLviOifBNFtlSza4CyM+v9VgwBQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dpWcX7HRixMBjiANvp9QW1OeqUCDMmuHdhNxKzPvU9en5weQiXczi49UkjIu3PEK7
         E2m0ojUYx2oYWTEyaNPhI87RqhnasNhkx9rpa2NtfxvV/+3p7NwoFhfIWZJ00Ik7z1
         TzYzU8iifvGwX8eGQF1aQWvp4nXJHd/5PZIwbK24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([89.1.213.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1k9XU53I3q-008NoJ; Mon, 14
 Sep 2020 12:30:51 +0200
Date:   Sat, 12 Sep 2020 00:17:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <xmqqsgbpr8oc.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009120016310.56@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com> <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet> <xmqqr1rcxdsu.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
 <xmqqsgbpr8oc.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:40Skmrkw0Tcjlv8btZ9Sx6Lo9L673rjQJv+TDq8H6xGabVvZxJ+
 8eIJp/Gdja9nVJofOVNT78R9PGYc+/q8hWF8VWomGu54FS7wkUb/md25uUzm0ICWYYVaTVw
 MKKOiayweRqCNPmG6XgHF5n2WNa9ejcieVlEHpgF71KF3XwMoTAdNci8+m69pOXQC++R0PI
 pRTOGgC0O2gTdtZdlzZOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZyCOk+G1M2I=:tQcV0irKgYNZHBFxSyQAxI
 L5QFdFiH1ErywEMSCMJJPt9SRbaOdvV6TekxXnKPO3BIv+WMrtdIKrS2HOosCAsmlq2H6Ngqp
 9QuFlZNvbP2dMWv65fYzP20zJQgsFXKenAuc/jVBtkcvFDyhJev1tJEumCdvRnEwy8wToTyJ7
 Cv+WNAvWji83nBtM/QZ+PNb0a1V9ilxkD7eAzrC7CYnJusFOEflFESsAwzPkCGdhQIhE7DjRl
 jnrMLYC2xR91NxSlfXlH3bVjqnt9BILt724va/cGTjn8ofEQnzWylAVtF9Lq0feKhnd09HM0z
 txZ6UKn17DiDUiHGn5djIKXsMT3vcJFBsSI5KyVE+f0IWm/1dSdTYJsgJXp0EMZwwim/DPb7c
 tFW0um7yGkUxxCYAQCpk1uZKLVX05eKL4Bc371OoPijuvhOMaCDd6IxstEU2PVKvt6g0TrnzJ
 7lsxK5pRRHpcvWjV2cD8OJ6rRzxKo0NazkrGRSWK1PJ1Qj0nznzw6e3xpiA3OT2yedH0WMKBY
 ZjIy+j4szCEbrZzJTiTi/2XvDxnbcnCzGdmTq4nSLpRgPpmMDQ5LmhGUrJ4sVdfZEsOEl4isC
 DDCDFPbR7+MP8NISnYMDkif2LGOxL3Xn++TyZ0lBmO+h0hqZ4FYP7TkRs/WVEvdbvI0mJLSfJ
 AVPOQYw+IdcsvUcdQlJgGAu5SlS0s1ebqzY1e2LvlTU8vX+UKiPcQHlA9E/QRaVr7ja1W1TiZ
 oLJ1W/NrKgonJk7UKwqpAs55pPWKhQUfzBphOWVV3aECp9a7H6qsCXHdExR02HqgbyB2rP2wj
 /9ExM5FtADQPlTKXAbjw5FRo4bHxwgiO1OGZTeNbF3hU5JfXKL4FxMKiD0QZqnAbhXGuM4fqr
 anbw+p5mAQMGA9B9fKkqA6QVRIzFLg02yYiWxzH5h/xzAVdeU2ZimFy9odD+qJAO6lDw5tKWx
 4fDnhJB7cyQpoQaN7WNEbAo2YplIYlhBTDZDQBshnzv252OxZyUWEI1LQsPgGVqwRbmrZOcgj
 ty2mP4QkH8KXn94T8h/sCNvS+SNoQUma9LnVuALP4ZyupvN+HYzACMEA+yZLg4i6SKtMYY8Pt
 xqJD5V+MUHm22O9c1Q7lPLYHtqcO+r1aqqJ/iY1x+n3yszDLT2OBAtGQEdQ0L2XfRBj8Hw++z
 i/ENmLjKK+cS3uB26J7clg0Dny9HrMRuTvnQa9eb0An7pVj1SyEFSHn4miUmp1Jx3hyKlwrX+
 knpZC1KG9fA2xlPu1SX3kQFU6VNIYzXeO49GUMg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 10 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> In contrast, when you want to make sure that you _actually_ incorpora=
ted
> >> the revision that is currently the remote tip, e.g. via `git pull
> >> --rebase` with a possible additional rebase on top that makes this _n=
ot_ a
> >> fast-forward, you totally have to force the push, otherwise it won't =
work.
> >
> > Maybe `--force-if-incorporated`? Originally, I had in mind to call it
> > `--safe-force`, but that might be too vague.
>
> Yup.  "safe force" indeed feels like a misnomer.  The assumption of
> safety relies heavily on the workflow.
>
> I might even say --force-if-merged even if the way the to-be-lost
> changes have become part of what you are pushing out is not
> technically a merge, but there may be shorter and sweeter way to
> express it than 'merge' and 'incorporate'.

You're right, `--force-if-merged` is a much better way to put it.

Thanks,
Dscho
