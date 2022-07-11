Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E810C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 15:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiGKPPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGKPPs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 11:15:48 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F2023BE2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657552544;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aBBlGfvShibpRAjqwfeLRX+sLa2TWSqmrFp+Lnt476Q=;
    b=Rrz0uhClxaaiGhwIhVVBOF1RsZVEny/L9RnDT8cic3oPvXLCQkW7AY1AX4HEji9Si6
    Ab0XfFBcmsmAi+OWN13IgS26pPNdap1IALbW8O+chBbFagRs9YZwPCI9GUAaxdeJngs6
    FXj4slsL1CUpZ7zcMRiUoNu4CniB0yS9fQEJ42wqVQye0K8R1FJHFPfdbOnjq2OAZPTk
    2T+ovRZ3DA+iMMHTRp9OVbnn0lfnrYRysiH3mgcfTBkdI0+LNfdp6JYAxZ6CRmd3d8F2
    BAWEzRL0hSmtWbChb0yOF2e4LnFke5gDMPQcHydqfuY+9FiiMfaIS3K9DTEzWq2A7nI2
    S8lg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuDsbSEit9KU5r3k6L5NRbajILDt10="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.46.4 AUTH)
    with ESMTPSA id k61132y6BFFi1Jb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Jul 2022 17:15:44 +0200 (CEST)
Date:   Mon, 11 Jul 2022 17:15:37 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git tag triggers out-of-memory killer
Message-ID: <20220711171537.19d058da.olaf@aepfle.de>
In-Reply-To: <YswuaPx6Mk7YkIim@coredump.intra.peff.net>
References: <20220711153135.35b1b135.olaf@aepfle.de>
        <YswuaPx6Mk7YkIim@coredump.intra.peff.net>
X-Mailer: Claws Mail 20220621T115632.b389e5f8 hat ein Softwareproblem, kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_0flMA7kux+E=Cg7+=82C3G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/_0flMA7kux+E=Cg7+=82C3G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 11 Jul 2022 10:06:32 -0400 Jeff King <peff@peff.net>:

> How did you measure?  Are you sure that each one is allocating a
> gigabyte itself, or might some of it be shared between the processes?
> Git will mmap the packfiles on disk, which will count against RSS
> (assuming the memory even gets faulted in). But multiple processes on
> the same repository will share those read-only pages.


I ran top(1), all the git processes were competing for memory.
There was most of the time no memory shared, according to top.

This tool to process a single repository exists since a few years.
In the past I ran it on a 12cpu/64GB machine. Today it was running the
first time on a 96cpu/64GB machine. There is a slim chance the issue did
not show up because the 12 processes always had access to enough memory.


I will try your suggestions.

Thanks.
Olaf

--Sig_/_0flMA7kux+E=Cg7+=82C3G
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmLMPpkACgkQ86SN7mm1
DoDCvxAAkpz6y5YkcaIkf3wRkczoIyN5S15YXw1XGGcYahgGB2wPDaQtqQA2flyb
htwoOeYQ0DQgKtC8L7sRTRzgemXfFy/kbkmNOvqDyVfyDicRPbp6d9ctZQN/Ztz6
vow5/0IPSF1+sIx42QaKEiInNnVI5474hEAe4QwIdnNIxIgZYwOEVhNfNotipbbL
XUK6G+Nwij4kmWKNF1QjooogoNLuaMcpo4WzcaPns1Oe9Wg40jYk3cY/UCDZhOqA
hVhZAIXIo6DNe9rBAJg4MnxoX0J7uFNnxSbYLXIV2y18A7fx71GsO9J8QyVjUDEl
UMpknAsb8ZYDb93UbhUFC5SwDigiBYsYcNwV6K+QTHGUyKDUtJSad8/7Ij/GdAqR
waMXR9Lm9oCY/3Kh5qPMwk6q7O8U9xrrhe8e3KR34Mm8ly2uqq5dRsvfrfOHgdCw
0xQOb+r10KEXRboSDHAK5xYLgF1LcKJTu/aVIN+OFaW0gd5BSJJVY95a2wBZFL7+
s9LJeF9yeV0zJ+0vpmJuYNOgCDsbkWxnZv6xjTIkKWuX23aDGqhi48GvMCXmwIEN
d4H+eX0qQgEC3ce6tn7ZzD8woPh0pCzR2n3n2vfUy5GWN6xo496fOL/+AIKkzVJK
E00HARnXK7V2yX3moFo5JgJk7oegFPlJZeH++FsKgztZsw6PNZI=
=Hdrp
-----END PGP SIGNATURE-----

--Sig_/_0flMA7kux+E=Cg7+=82C3G--
