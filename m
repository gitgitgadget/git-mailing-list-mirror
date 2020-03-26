Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C44C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B85D20787
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 22:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCZWcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:32:04 -0400
Received: from sunset.tt-solutions.com ([82.240.17.225]:42701 "EHLO
        smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWcE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 18:32:04 -0400
Received: from [192.168.17.86] (helo=Twilight.zeitlins.org)
        by smtp.tt-solutions.com with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.92)
        (envelope-from <vz-git@zeitlins.org>)
        id 1jHb2f-0004m5-TH; Thu, 26 Mar 2020 23:32:01 +0100
Date:   Thu, 26 Mar 2020 23:32:01 +0100
From:   Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re[2]: [PATCH] fetch: allow running as different users in shared repositories
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     git@vger.kernel.org
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="4294967295-41-1585261921=:7932"
References: nycvar.QRO.7.76.6.2003252001560.46@tvgsbejvaqbjf.bet <E1jHGdD-00079b-06@smtp.tt-solutions.com> <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2003261538170.46@tvgsbejvaqbjf.bet>
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
Message-Id: <E1jHb2f-0004m5-TH@smtp.tt-solutions.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--4294967295-41-1585261921=:7932
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Thu, 26 Mar 2020 15:40:47 +0100 (CET) Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

JS> On Thu, 26 Mar 2020, Vadim Zeitlin wrote:
JS> 
JS> > On Wed, 25 Mar 2020 20:04:09 +0100 Johannes Schindelin wrote:
JS> >
JS> > JS> Hi Vadim,
JS> >
JS> >  Hello Johannes and thanks for your reply!
JS> >
JS> > JS> On Thu, 19 Mar 2020, Vadim Zeitlin wrote:
JS> > JS>
JS> > JS> > The function fopen_for_writing(), which was added in 79d7582e32 (commit:
JS> > JS> > allow editing the commit message even in shared repos, 2016-01-06) and
JS> > JS> > used for overwriting FETCH_HEAD since ea56518dfe (Handle more file
JS> > JS> > writes correctly in shared repos, 2016-01-11), didn't do it correctly in
JS> > JS> > shared repositories under Linux.
JS> > JS> >
JS> > JS> > This happened because in this situation the file FETCH_HEAD has mode 644
JS> > JS>
JS> > JS> I wonder why that is. In a shared repository, it should have mode 664, I
JS> > JS> thought.
JS> >
JS> >  This file is created using a simple fopen("w") and so is subject to umask.
JS> > With the usual default umask value (022) its mode would be 644, regardless
JS> > of the repository settings.
JS> 
JS> Maybe we should change that to an `open()` call with the explicit `0666`
JS> mode?

 Hello again,

 Sorry if I'm missing something, but AFAICS this wouldn't change anything,
open() mode argument is still combined with the (negated) umask, and 0666 &
!022 would still give 0644. The only ways to give this file the mode
of 664 that I know about are to either temporarily reset the "group" byte
of umask to 0 or to explicitly call [f]chmod() after creating it. I don't
know if this is really worthwhile to do...

JS> My take is that this was waiting for a review, and I provided it (*not*
JS> asking for any changes), and if there are no further reviews, the patch
JS> should make it into the `pu` branch, then `next` and eventually `master`,
JS> at which point it will be slated for the next official `.0` version.

 OK, thanks (both for the review and for the explanations)!

JS> It might make sense to ask for it to be trickled down into the `maint`
JS> branch, too, in case a `v2.26.1` is released. I would be in favor of that,
JS> but would not do the asking myself ;-)

 This is not really urgent to me, so I don't think I want to bother people
with backporting it to `maint` neither, even if I definitely wouldn't have
any objections to this. I'd just like this to work in some future version
of Git without the workaround we have to use right now (which basically
consists in running chmod manually) in the bright future when we upgrade to
it.

 Thanks again,
VZ
--4294967295-41-1585261921=:7932
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAl59LWEACgkQBupB3k9sHoa/ywCeI1bSmmLkXw22HxeILoR0m6yI
a4gAoKEsP7vBjpdTaZMHuJaPoLj3IAu0
=JRMp
-----END PGP SIGNATURE-----

--4294967295-41-1585261921=:7932--
