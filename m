Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6781C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80C21556
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cb+u2qCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfLLTQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:16:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:47651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfLLTQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576178198;
        bh=78hvCFM0wwbWV1CCVFsT12qhugb40ohA2c5zuvPMC8M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cb+u2qCqtPiXmSiXVGCsI58INBVNJhocadAhBR03tJL83FP1KQk0l2eiIqJjn2oGj
         m6uMMu07VAvuksspbPBg/oTFs/D4abBn8s5O4kezP5p28If3+pZhOJNV2GjU1ve0xD
         bjZt5vjaACMpL8r/RsGb5Jeep2w3TEFMgl3xJffg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1hhmjV1Ttj-012qgG; Thu, 12
 Dec 2019 20:16:38 +0100
Date:   Thu, 12 Dec 2019 20:16:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Miriam Rubio <mirucam@gmail.com>, git@vger.kernel.org,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-use
In-Reply-To: <xmqqh826pyh4.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912122015200.46@tvgsbejvaqbjf.bet>
References: <20191209103923.21659-1-mirucam@gmail.com> <xmqqo8wepyse.fsf@gitster-ct.c.googlers.com> <xmqqh826pyh4.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hg+z28Es12kWaAmmbd3CkttVHXub4y1YQdNQlZdRwSqYRieVSZ4
 HxQ8TXv/lpMsDQCpF5nN0T0yeZ8LrWEUmc1abHgmX2J+aIil3UfZaR338IoziUxUsmTWNid
 2/sFKceCs3RSyyCPv0XfmkIXs5CdmrCwsxfb52DHC3r5oa3/9c2TrPLW2EVg0hVWDqqyEer
 sWqRoqkE3z0YjvZmPD+IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NbD9JzDHh+o=:7kEy7pv8u9worqX5SZQRpf
 Y9+yec84+ViCdqYvL8GjlKAUzi6XPEv+FmLwc+RcatWRSbVsntyOb2vstGjdFGTjVR/KefI3A
 s01hNONlvN8hDjWW9muRkSZhrGGiC3l3HGK3T7dcPYyPy2o+x0+LUZMrsIF1zMYAn12TiBkr3
 3+QNBoyayt+llz0S2vJ1quw4N8NdeKX2+gUypbLn+/fBoK3Rd8i6kPCUq0J/8RCwadt5Be5uy
 rV/uFyj5TUvpWrKVEQYQMUyhpxCY7IG0pUU3Xq0SOqlr486CWiJVAM81YdtDYZfG/u7BENIDM
 edCDhmEyDCGifz1AKWwEySBJtR7VRxLfhxmO5uG316iDSzE6z1eLtpmXVaN8oAaSqgNTHr/o5
 Rb9hx9gIi1K7rrK6twDqm1GHcLa3ImRx8YATOkDvYSj+ZpEu78lj8Ln4UyQKgKBIMHVzZPo9m
 7Ve1oOGpze6o213ttcu2qeleN8xI7EV+9DwZZaHBjZ7gQZ3BIoolTZwvxTpggAUiYa8oGj4M1
 K9ZgzSlb50+ONwtKdwUY0OxfKGbFZAOhbnrEkaLhUvrCx+eqFToSMb2krJercK5g6ha9IF1j3
 bBImav5or27mM/oCMUJQGtLNhux0hXL0W/V+A5S4rlpUQpbM60AOQZVvwts5KIQoTTEh4JuNC
 n0qfILVxN9RtmFMRjGuPvOMaeoK7svurYkSespXCLjLyFM3V4Q5uxbozUOrBQnOZUzLLDhMbu
 n++ZXl7TjpZ6oPrcNjE0SBaa1VNaxSqcByleLPFtpn93szUjvazzRGu/ym7WVPIWEQAhzID2n
 +5wcDe/QJpZnry79gd6wFMAfwXwI5ANTlT5x5CSJigASg75KoXsKwjEhP852mZzLuhSiwKmuF
 R1k+L3y8hDAux9dowsWZK0RJyLAWWghNzGo6ohicUOXhcZ6VbkcKhirs9lNkyFpAObZZ4NBrP
 M9tFNxOtfiUXGocjvgJTjpxIuXTSS7OFpw9HgzEvyN9ucmik5GbBBRQ/uDLsx/rN7e2KAPBr2
 /OS4dBx3XQNCW8aAGgabkByEwLdgq2QRSy6ss+pXZMu82Sx9zqo3iCoUxRQ43lzJ8gKzsCdr6
 DQINYamv/6EGc5StwZeRxQPrVtZehkf5fwyVXza4Fk57aaH/A4cqB3cM8bpeIuZtZNSM72u3s
 llGtTvr2/L2LOhZeXdRZV7QKkKEKGBOrjkeLNpXJ9WEGucPui4FK+fCdqs+iHO+C1wGWyYexa
 aOYACJLZCtz3p5EmLr9zrvdCePiHCMjk+bDJaikKh+wBjxIXjBf7BMACGzB4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Dec 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Subject: Re: [Outreachy] [PATCH v2] bisect--helper: avoid free-after-u=
se
>
> It is surprising with multiple mentors, nobody noticed free-after-use
> is perfectly fine---it is use-after-free we would want to avoid.

Wow. It is totally my fault, and the only thing I can blame is the
mind-numbing work I did on those security fixes. So glad that's over.

Sorry for the mistake,
Dscho
