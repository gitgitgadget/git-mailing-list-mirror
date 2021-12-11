Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7800EC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 14:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhLKOBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 09:01:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:49741 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhLKOBg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 09:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639231266;
        bh=RLAoRpZCPtIRyzduQSnw4pDhyHVXvR00QICHDJn5MSs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J+Kr4yDKGtUY+Y63jOsyeNvGq6wH2ylwgipSgw30zH3m1AuWq40KiJCsmTqr491Bs
         qyFsTkOM7G8QNMIqixrHGCnmmQ8A5pNXQynCIFvbAPt/EgMi/nzvrMjIilaS/8MzIh
         W0SyrMn7xbcQ/beGRoFn9sq4ZAO8DpSPzWq91KvM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1mpP5e01wO-00B5L2; Sat, 11
 Dec 2021 15:01:06 +0100
Date:   Sat, 11 Dec 2021 15:01:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
In-Reply-To: <211210.868rwscxcw.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112111453040.90@tvgsbejvaqbjf.bet>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com> <YbLL/YWbjc/sPRyH@coredump.intra.peff.net> <211210.86lf0sdah1.gmgdl@evledraar.gmail.com> <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet> <211210.868rwscxcw.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-679057599-1639231266=:90"
X-Provags-ID: V03:K1:q63k5E9Mf5B70U/iNZhAp/rA9sG6iADzXsUyGTxzKwuriKS57JS
 phVDFaMTVmk3/wE+5YfS6VCx0Q7lvIW//0bCAY0i52UDdef6wEg9Q2Rs8shpJ7VxAqrOU6W
 +z4QCk9SzuvuhjU5Pw6daxEcpFKIxp+4TXxqju+BCuO/NR1tN77N4JniLezbdVANhSdodm9
 y5Dj5jvNeM0waWF5Xt8sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MXzDS9p401o=:Cx4gR8XQxr14AQlm0waB9p
 Lsyq1VTKxBHJB4JeV/eKfI11rAoBM6Bmj2vb3D6+l0P5A72/MAJZ1kte2VnpH9OMaXNRTtNaY
 z4MrHFkhnZt9owZlhuFzY3Js+cJpl0eXdijQEr3rLAKQqpTL//9MC34mi44k3UB51QTesLCwG
 2nKE8iaSEQ44lmYzQZrgsz2PAytwkG44KP3Ge3DXvaZhdOW5AJtja++N/Hd9erS00NqNXC1rn
 vtMSzBUfNFoeL1zTiREBVPZ975IzRCfe4q1hMbH4RP5RKQ07/p7B0kPyrKrRj0yRvBjsKHnTa
 aUSF+7TNCU1A9hEI7bHmfojUPrk/zo930vhiO/J9iLpRDZQFcsmbwxkr8O3quRlWmuAtQ9JzK
 v1cPAi7HEj9jVFyxHSxBmHIh65AIYb8Q7AWYDy2TMPoR4UJ4pULDuUF/5NYerl7ql3i7kHg/2
 jYy3OueIapKQt5Ri2STbFWhBqaOtQpmOd9eplw107kVsxeKbO0FqND9MXeURNdsL4r4vy5gqA
 G72RcXpAfGxWD1DtQQ/G7JZtmC8CPL6iIFGS8q2GSn1obDGPE1A7zKXrrxaHl/9Q502JD0j9E
 OfYpV9dd4MRJKcBguue933noS+8ZKh/wi/8NbovwfjTuL4UFyAsJ+IPMH5qqFVaMHz73Bv5h4
 m3/ggR6aopVQdldvMkdyEeDtgLObtVdQTESabTanx+3gGPfcMj7DDVSsWabkND9cyETdEvajj
 d9Rftb8UEEP0dDbcnZepTiRHZ+BJpXnkpFUKDzPNrSGqa0YHhd0/xrgFb9UPv0GG8B0+NI6dS
 2I41QFa0UGHbirlrXSH1GnECCr7e8Ua9AjWoebQtQYNF34SV0qFRPZO3eXttZX/oaQSm6BrMG
 aSno04dEHF5WNiFtAesjEjA1RJouk3PLO72XnBR+Fmx4cenED9iDPVrwfJHkZkKjndGA+ZDOr
 JkQIvLjuL7BarBlo9/WUnG07+Mgn6Tx6ujyR4BpoU4dXKxFaUeDE2ZEXOAIxktcMryPlcR1OM
 mAzn/cJs6ysk5TBBrrrgSR2qvkGislw4ocXQ/vGbZb5qTaPRG1lYWlbuPnwKviFW3qnJ4qAw2
 Q+69TKZGBaavZE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-679057599-1639231266=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 10 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> But I'll happily admit ignorance on how the actual guts of range-diff
> work, I just wanted to fix a segfault I kept running into locally at
> some point, and figured I'd submit this RFC.

I understand that it is super tempting to avoid spending the time to
understand how range-diff works and simply make changes until the
segmentation fault is gone, and then shoot off several iterations of the
patch series in the hopes that it gets merged at some point, and that
maybe reviewers who do spend the time to become familiar with the logic
help avoid introduce new bugs.

However, as a reviewer I am totally unsympathetic of this approach. I do
not want to review patches that even go so far as renaming functions when
they claim to "just fix a segfault" and the author even admits that
they're unfamiliar with what the code is supposed to do, without any
indication that they're inclined to invest the effort to change that.

If all you want to do is to fix the segmentation fault, and want to skip
the due diligence of studying the business logic, then just fix that
segmentation fault (I strongly suspect that using `COST()` after modifying
it to use `st_*()` would accomplish that). No need to inflate that to 5
patches. Unless you're thinking of the commit-per-author count as some
sort of scoreboard where you want to win. In which case I am even less
interested in reviewing the patches.

Ciao,
Johannes

--8323328-679057599-1639231266=:90--
