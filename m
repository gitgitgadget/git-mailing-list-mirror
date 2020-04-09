Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A407C2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 00:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657E72084D
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 00:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rmdsXoC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgDIA2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:28:09 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13785 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDIA2J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 20:28:09 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200409002807epoutp022aa11458e4a98cc0850e6e564d2942e3~D-zK-FMzO1587515875epoutp02W
        for <git@vger.kernel.org>; Thu,  9 Apr 2020 00:28:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200409002807epoutp022aa11458e4a98cc0850e6e564d2942e3~D-zK-FMzO1587515875epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586392087;
        bh=oLgxRp27awtUHYWWxGoVPpmdntaSzJea1Rsx1g2IsTI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rmdsXoC6DjO7/fEE667UshkiFss3sOvyDw6e7DGVD/OM/CU84Rn7LJr0qaWRh1lfK
         bX1pTKN4MayeojZywZnLGn1MNhVRzzysJ8iRCGFE0nhCLayx5PwzRUq98pHbHfzfMX
         mEQkVrS/wbxWjIG+mtBcc4Dwh79VsyyvWztS6lD0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20200409002806epcas2p300af536f2a52ae2ea649ef7670fce47b~D-zKwePqg0161301613epcas2p3n;
        Thu,  9 Apr 2020 00:28:06 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48yMS46TKQzMqYkV; Thu,  9 Apr
        2020 00:28:04 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.C3.04598.31C6E8E5; Thu,  9 Apr 2020 09:28:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20200409002803epcas2p2c52166fe019a78d6d1a24f45187f1c26~D-zHsE-5V0319103191epcas2p24;
        Thu,  9 Apr 2020 00:28:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200409002803epsmtrp2d02bfe704375582f5bba82e15ab5cbfa~D-zHrWseL0134701347epsmtrp2T;
        Thu,  9 Apr 2020 00:28:03 +0000 (GMT)
X-AuditID: b6c32a45-ea1ff700000011f6-d4-5e8e6c137b40
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.EF.04158.31C6E8E5; Thu,  9 Apr 2020 09:28:03 +0900 (KST)
Received: from KORDO039863 (unknown [10.229.42.93]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200409002803epsmtip2807bb2cd5b22f694e8db2a1bd8a3d570~D-zHkgrIm2566725667epsmtip23;
        Thu,  9 Apr 2020 00:28:03 +0000 (GMT)
From:   "Jordan" <jordan.az@samsung.com>
To:     "'Pratyush Yadav'" <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
In-Reply-To: <20200408180753.j4sa7iahszp3kljn@yadavpratyush.com>
Subject: RE: Installing git questions I can't find an answer to.
Date:   Thu, 9 Apr 2020 09:28:03 +0900
Message-ID: <001501d60e05$bb5f2b10$321d8130$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJccoFW6kOGscjhCBGGV83rPtpPfgGjhdmKAkrxk5+nQ7FFAA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRT23e7m9WNym5bHETVupRhs7a72YWSJWQhKDPxVhHZxt21298Hu
        lCwQswizMrUo00AjKIsomFFSTpdWIw3BLKOoxqTAiV+4kkzMNu8i/z3n4XnOOc/7HlwoXRLJ
        cIvNxThtNEuK47HH/Zk6RQpbX6w6dU6gr3t3XqD/4p0S5AjyQ+4N+T0PWIPgELvLzNBGxiln
        bKV2o8VmyiYLikr2lmi0KkpBZel1pNxGW5lsMq/QoNhvYcPdSXkFzZaHKQPNceS23buc9nIX
        IzfbOVc2yTiMrIOiHEqOtnLlNpOy1G7dSalUak1YeYQ1T1zzYY75pOMNsyNYNfqRUIficCB2
        wOWZJXEdiselRBeCpZoREV/MIRg540F8MY/g86v22H+WgcBw1OJB8Ohup4AvxhH89nrFEZWY
        SAf/1+EVRwqhgKapwRVeSKTBaOAKiuA4IgfOf5wN8zieHMaX2vIiNEZshvdXn6/IJUQWVD+r
        QTxeA6+vf8P4NhvhydQNIb+QHBa+3xbxo3Lhsf9WVJMKwZcvYiO7AXFfDMFb49EEedDbGhDx
        OBkmfI+ivAxC0x4xb7iMwDcfEvLFBQSTTW1iXrUdBs58xyJbC4lMePh0WwQCsQlefIoOToLa
        /qVYnpZA7Vkpb9wE3p8diMdp8GsugBoQ2bIqWsuqaC2rIrT8n9WOsHtoHePgrCaGUzuo1b/t
        Riunt3VfF2oeKuxDBI7IRIm3+2KxVERXcJXWPgS4kEyRFNSEKYmRrjzBOO0lznKW4fqQJvzy
        jULZ2lJ7+JBtrhJKo9ZqVVkavUar1pOpks6Ej4elhIl2MccYxsE4//kEeJysGnWnLjR2n6bL
        1GNvagdk69urMpRrF5XJavvYdNXNTOZzmiojSfUFjeYW+xNnBy/s8RuGlw8kbTBQY1cPNsZQ
        CW9lJxPn6nUVe3QmT1d6wxZJoGPvzERea5mj1jIUbA0tT+beWeztUfZX6bKMvtk/9e07j5aN
        Bj8sXItpLsLcbhLjzDS1Vejk6L89GZ77kAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvK5wTl+cwa+dKhZdV7qZLO4eeMvk
        wOTxeZOcx751OQFMUVw2Kak5mWWpRfp2CVwZr6YfZyn4xlcx4cNllgbGL9xdjJwcEgImEqce
        XmTrYuTiEBLYzSix4UYLE0RCUqJl3g4WCFtY4n7LEVaIomeMEhPWfwVLsAmoSdy/d5EdxBYR
        0JWY9PY0G4jNDNR87eEURhBbSGA/o8TsZeEgNqeAg0T3zQ9ANRwcwkB2/3wXkDCLgIrE1WkH
        wVp5BSwlGnY3MULYghInZz5hASlnFtCTaNvICDFdXmL72znMEKcpSPx8uowV4gIniW33F7NA
        1IhLvDx6hH0Co/AsJJNmIUyahWTSLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBIe9ltYOxhMn4g8xCnAwKvHwSuzvjRNiTSwrrsw9xCjBwawkwuvdBBTiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TBKdXA2Ho9tu2O9dNCg8dth5jPRCfq
        Vai/EpHZnX94wfRop2nzAoODjyQzfPFpmn/UPPiLTUmf0AXhUxEa2xl/H/ooYXZfZ+9U1ZY9
        /ft+3j0xsTc6W93pffeD538ZH+opeuv71Dj8yNgTnCQgIdDwTSB01imndPMzkfcCj7WychlM
        u8vadfT4ahZ2JZbijERDLeai4kQAgYb5JXcCAAA=
X-CMS-MailID: 20200409002803epcas2p2c52166fe019a78d6d1a24f45187f1c26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1
References: <CGME20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1@epcas2p1.samsung.com>
        <000001d60d31$f1b41d80$d51c5880$@samsung.com>
        <20200408180753.j4sa7iahszp3kljn@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Pratyush,
Thanks for the reply. I was able to build it from a tarball, but it was
certainly not straightforward. After a failed attempt and more research I
came to the following that works. 
$ tar -zxf git-2.9.4.tar.gz
$ cd git-2.9.4
$ make configure
$ ./configure --prefix=/ <my directory>
$ make && make install

Regards,
Jordan

-----Original Message-----
From: Pratyush Yadav <me@yadavpratyush.com> 
Sent: Thursday, April 9, 2020 3:08 AM
To: Jordan <jordan.az@samsung.com>
Cc: git@vger.kernel.org
Subject: Re: Installing git questions I can't find an answer to.

On 08/04/20 08:12AM, Jordan wrote:
> Hello,
> I have searched the internet and can find no answer to my dilemma. I 
> am trying to install a local copy of git on a Linux machine that is 
> not connected to the internet and I don't have root privileges on. I 
> can download and transfer things to this machine, but that is it. I 
> think this should be possible, but have had no luck with the things I have
tried.
> Thanks you for any advice.

Are you able to build Git from source? Do you have all the dependencies
already installed? If so, I have sometimes used the Git binary in the build
folder when testing a new feature I was working on because I didn't want to
install an unstable version on my system. It worked fine for the most part,
though I admit I didn't really use a whole lot of things other than commit
and some worktree commands. Maybe something like that would work for you?
You can download a tarball from kernel.org [0].

If you can't, maybe you can try building Git on a machine you _do_ have
internet and root access on, and then copy over the binaries? Again, I
haven't played around a whole lot with something like this so I can't say if
it'll work. Something to try I guess.

[0] https://mirrors.edge.kernel.org/pub/software/scm/git/

--
Regards,
Pratyush Yadav

