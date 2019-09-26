Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB4F1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 20:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfIZUOm (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 16:14:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:39085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfIZUOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 16:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569528872;
        bh=57awZ4waCr93ivoLmD6GsXywNKLKRZDpfXQnRrgZIEM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CcJxZVMOVuy33sAZFpogRVtdaebK3Uh3ZOcL6gPZsumi03W/hq07NEY/RshVInhRZ
         PSwowPfFQRXY2OCoxBpCZrWiUAGWU7Yb03u6W9IMcufIHX+OrTJBmmw6FOHNDnM7vu
         yHEVTqPGsl+4kfXyJcr0hqGMBnDUFuNoaKPGkZas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1hfs2R2DQl-00hvtQ; Thu, 26
 Sep 2019 22:14:32 +0200
Date:   Thu, 26 Sep 2019 22:14:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, davvid@gmail.com
Subject: Re: [PATCH 3/3] wrapper: use a loop instead of repetitive
 statements
In-Reply-To: <03e509db-942e-4538-4729-4e345df82a7e@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909262155020.15067@tvgsbejvaqbjf.bet>
References: <20190925020158.751492-1-alexhenrie24@gmail.com> <20190925020158.751492-4-alexhenrie24@gmail.com> <03e509db-942e-4538-4729-4e345df82a7e@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t0OgOKd3MZdry6vQlUp6VNSZO2paRj0I37HTIWz0xEpr3HJShoq
 9OOkhaZR9Yq1EmokuxgEAL7dyretfgsyoLQRcJQnUPiZu853slxo9ruJiVdBheMNyuxTrF6
 o14WHk8pjZO4SZAuHmD4j/r0ZaUUuXgRUbBe4OcbPjLlYsnbbWdlR2UpQCYKxiCs0FKyFfO
 7Dhl+LorFk3SxiygaetUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A3fqDs6Ba1c=:HGUVzPrSVfbPpBpGz3yt9n
 2T7K5ks3u0QVYEpNg9c26Ntvi4PmUkbv1vTMFkSGZ6r4eh5m70piDcIfj8cJ0AXQ0YjY5VK8m
 RnP7RKnsAGvseVau7zeLEHxxjzRb28NiGuFOwGg62c9vjYvhTMVUerrNds9753Kt1EAibFN77
 j6vaitsHa+2B9wHpaykzuXVQCoj6o9+3r5eySEXMpr4M5yF33uZRVjXnzg43Q6lKf2udJErVB
 91VCibR+S/ucM2SYEyRnoodbB8JexkDYf3046MmW1KnbGcDdBir3gqOElDMeBU1IXb6Jd9TUf
 bT4/t62PN9H9Ntqx2Hjyq0vF2k335YKnjDs6+wlsAYn314y5Kzg9nEA+lX+sKkmyT7Pvx/I3L
 9fYJ0aOLjIjz5vwIdWbO1l4vSis7AZfeGJCF34TUq4nTvUc4Q1ITbGHCRgsUWP7BXjbpH7FCW
 B9FnWYqzJYyuaKRkzT//UOR3Okna+cYxMp8iDe1t9c3Xd60OP4Y9gQq5PZSHiGQwotHDH/P2U
 BiMZZ8YX+e/a7LkjbgEv5mFqbg3UuSMwMhr3WoNiK1cTAq4YRt0ZOfL9VJLvKnSGMLWUJix+o
 nKnXsaszo/9Z1woQekcpmsHXa8ki5VZfKGMIhJc3+WSG+n8m9s9Zii6/xYyucVVMKVRybHlq/
 VbNC2M6I/fNC6wscfS0zHQ67fnk2H/mx528Wsv+bRaUh00b/An3StC29vEsXp1C/P/y7RRMZa
 gqdZSq40DlPNuAlrc7QeV+2JSlKxZlUAA+SlZwm7J6KwftSDoo0nfeY/PquC9sxLqS1pyb0su
 E6N6Vj8aMVPmMGCRLAiF16eMgtquEcncBeU7yLcId8B1gW9cV6WD4BAPVjmwmkPH3HgvbGQni
 qIgFzJB4Wf75eUYKaNUjXB/aTJB17dtpi4peNWSze+WQioK0q42I/zinpS8lvik9InCx6F6rq
 EbYSgtVUwoXRC7fkSMY38yXMzWB2eNK/IFjDtmx6azsnc9sFZHFOpANfbk9N9Ncw0/obuR7l0
 wEsZL0/FQrHaCssnG2HGM3IfeApvCVWFzBpDWcpdSXLrbczvAtPS+WI1886js8uCOYAKVIyyg
 o8unUv6hO0V29L/xSNclbRBymPBVRMd0cptYBj32gCnecjt4b1nJHtjhSrQDyp8Uq6IsNeCgm
 Q0INJ2i4iO45vT/v1IexvQpHcUzTBOIKrgQUffSqESF0UD5s9na88Rn2e3jTMNPJEwj6xj/O7
 TLnxqUtYf98csI04tORzn2Vn0w3QU7Tc2syArGGp9DWrs3x/4aOm+LQRttWM=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 26 Sep 2019, Derrick Stolee wrote:

> On 9/24/2019 10:01 PM, Alex Henrie wrote:
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > ---
> >  wrapper.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/wrapper.c b/wrapper.c
> > index c55d7722d7..c23ac6adcd 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_=
len, int mode)
> >  	filename_template =3D &pattern[len - 6 - suffix_len];
> >  	for (count =3D 0; count < TMP_MAX; ++count) {
> >  		uint64_t v =3D value;
> > +		int i;
> >  		/* Fill in the random bits. */
> > -		filename_template[0] =3D letters[v % num_letters]; v /=3D num_lette=
rs;
> > -		filename_template[1] =3D letters[v % num_letters]; v /=3D num_lette=
rs;
> > -		filename_template[2] =3D letters[v % num_letters]; v /=3D num_lette=
rs;
> > -		filename_template[3] =3D letters[v % num_letters]; v /=3D num_lette=
rs;
> > -		filename_template[4] =3D letters[v % num_letters]; v /=3D num_lette=
rs;
> > -		filename_template[5] =3D letters[v % num_letters]; v /=3D num_lette=
rs;
> > +		for (i =3D 0; i < 6; i++) {
> > +			filename_template[i] =3D letters[v % num_letters];
> > +			v /=3D num_letters;
> > +		}
> >
> >  		fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> >  		if (fd >=3D 0)
> >
>
> This change is clear.

Not so fast.

This looks like it was intended to help compilers that cannot unroll
loops all that easily, and just because current clang can does not mean
that we should put people at a deliberate disadvantage when they are
stuck with a C compiler that cannot optimize the post-image of this
diff.

Let's first see whether my gut feeling has any merit.

This part of the code entered Git's tree in 0620b39b3b7 (compat: add a
mkstemps() compatibility function, 2009-05-31), and it was clearly
copy-edited from libiberty.

It entered libiberty in
https://github.com/gcc-mirror/gcc/commit/119735e34916. That commit
claims that it was copy-edited from glibc, and edited it was, as it
inlined the `__gen_tempname()` function.

Sadly, the commit message of the patch that introduced this pattern into
glibc is pretty much not helpful at all here:
https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3Da7ab2023fcdd5=
c90c9f664cbaed8ef90dd38e818
(it only talks about using a random-name generator that is already used
elsewhere.)

In short: sadly, this history excursion did not reveal anything to back
up my intuition that your change would revert a change that might be
crucial on older platforms.

However, I think that this patch should at least be accompanied by a
commit message that suggests that some thought was put into it, and that
concerns like mine were considered carefully.

I mean, if there is _any_ performance-critical code path hitting this
unrolled loop, we may want to keep it unrolled.

Ciao,
Johannes
