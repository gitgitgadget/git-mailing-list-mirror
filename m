Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8332C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 09:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C5320663
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 09:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T7EnBFnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ks/2cSd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgFCJpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:45:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56843 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgFCJpe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2020 05:45:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EB9B75C00E8;
        Wed,  3 Jun 2020 05:45:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Jun 2020 05:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=kvQ3GU6bhVhqPuGvGKdFFJaqSTM
        EV8wPQ9JBb2G8dV4=; b=T7EnBFnYYUhaNurNwGohNia99UlDvrAczcIekkPwNOS
        e922JsR1PqJI8N2Qxcwc3Ib10q0pXJCqkJ7A96Xwc646OHomuIvAo/iiTvKnidys
        tEQijNAhrLpvkL+fIDKZdcrdIi4245/5wQPyAgsNaAaKaA9hUcLE2uBSzqxGmWLM
        jr8ullKRLIzV1DtomBDDGYPAx0KZ4Ey8hDfSwRGU1kv0spi6eKmn/udAzStnkFpo
        icpEEONMvWpUm9zxV5IWwcGIqB8DjkDuireyhrVf9mII8gADG4i+Pl59pAYMTzZN
        sgR1Q5JerLiFP4xNKTlp6tSAz8zi2etdhqhKv5tO9KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kvQ3GU
        6bhVhqPuGvGKdFFJaqSTMEV8wPQ9JBb2G8dV4=; b=Ks/2cSd1vp3IEZ9/emnnLk
        oW89QgCa3IeHb/eLxH2caqkxzSI3Jf8bPEyUm+0IaNJ57Bu3f2C5rjCeifV+a4+9
        8W65ZGRqiIWMARvERxj/K/PI7Z6scTeUE6LeHOw3mPv1hs6ZS6Y57sn0FbQTDHRk
        vxHl57CijQ0QWhvfbZNWKX9PTB0u/LTDeiXUnLXAtnOGMBODzwYGf0r8ENtwET3I
        JaWKdGw3ZIOT1AAD48+SGaCxWVs6fZULXxTfYyzdC0tSdBFfvucYf6gjqNTfJEvn
        61xTAhv+IumjdFH+Eid3DLmukD2Ga+KOfblh2EJ8F1LR9MXN9GaRxtqp037q6zcA
        ==
X-ME-Sender: <xms:PHHXXmTcHNwaz9VzKMk9OmJHG7c044AutKKH8lwUTQ0ysWP6pgpopw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejjedrudefrddujeeirddujedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:PHHXXrzKcdKsUVrfQNrCAxVimG2cCiB3GXYRAXHjq8HZ5YmYINMDVw>
    <xmx:PHHXXj2SSLtyEeXv1z-QC1ezwgmOxnGZkpiscuiUttDCzEIoKkbvRg>
    <xmx:PHHXXiB-aOyQ6Y-1CitzNAVe2c70tT-gnq9kSht8yRgierX6F1NU5A>
    <xmx:PHHXXqvvXs8Wm4IN0GheH951mMRUGo6e5Aoah6DBZTYPsGwoC8I9lw>
Received: from vm-mail.pks.im (x4d0db0ab.dyn.telefonica.de [77.13.176.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B448328005E;
        Wed,  3 Jun 2020 05:45:32 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f1b7a639 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 Jun 2020 09:45:27 +0000 (UTC)
Date:   Wed, 3 Jun 2020 11:46:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: implement reference transaction hooks
Message-ID: <20200603094618.GA4194@tanuki.pks.im>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <20200602180900.GA11344@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200602180900.GA11344@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 08:09:00PM +0200, SZEDER G=E1bor wrote:
> On Tue, Jun 02, 2020 at 10:25:44AM +0200, Patrick Steinhardt wrote:
> > The low-level reference transactions used to update references are
> > currently completely opaque to the user. While certainly desirable in
> > most usecases, there are some which might want to hook into the
> > transaction to observe all queued reference updates as well as observing
> > the abortion or commit of a prepared transaction.
> >=20
> > One such usecase would be to have a set of replicas of a given Git
> > repository, where we perform Git operations on all of the repositories
> > at once and expect the outcome to be the same in all of them. While
> > there exist hooks already for a certain subset of Git commands that
> > could be used to implement a voting mechanism for this, many others
> > currently don't have any mechanism for this.
> >=20
> > The above scenario is the motivation for a set of three new hooks that
> > reach directly into Git's reference transaction. Each of the following
> > new hooks (currently) doesn't accept any parameters and receives the set
> > of queued reference updates via stdin:
> >=20
> >     - ref-transaction-prepared gets called when all reference updates
> >       have been queued. At this stage, the hook may decide to abort the
> >       transaction prematurely by returning a non-zero status code.
> >=20
> >     - ref-transaction-committed gets called when a reference transaction
> >       was transmitted and all queued updates have been persisted.
> >=20
> >     - ref-transaction-aborted gets called when a reference transaction
> >       was aborted and all queued updates have been rolled back.
>=20
> The point of reference transactions is that they are atomic, and these
> hooks must work together to ensure that.  This raises the question how
> these hooks can be updated in an actively used repository.
>=20
> Having multiple hooks means that they can't be updated atomically, and
> git might invoke the new abort hook after the transaction was prepared
> with the old hook.  Now, if there were a single 'ref-transaction' hook
> (which gets the phase of the transaction ('prepared', 'committed' or
> 'aborted') as a parameter), then it could be updated atomically by
> mv-ing it to place, but even that update can happen in between git
> invokes 'ref-transaction prepared' and 'ref-transaction aborted'.
>=20
> I suppose this issue could be addressed by a single hook which runs
> during the whole transaction and some back-and-forth communication
> through stdin/out between git and the hook.  However, this would, I'm
> afraid, complicate both Git's handling of this hook and the hook as
> well, so let's take a step back first: is this something we should
> worry about in the first place?

Very good point about which I didn't previously think, thanks a lot for
raising it!

I agree that using a single long-lived hook would complicate the logic
by quite a bit. Given that the ref-transaction mechanism is such a
central piece to Git, I'd be wary of introducing such complexity. But
merging the current three hooks into a single hook accepting a parameter
sounds like a fair compromise to me that would at least allow users to
replace them atomically, even though it doesn't mean all stages were run
with the same version of the hook.

If we want to go further and also ensure the same script's run across
all hook invocations, we could also open the hook's file descriptor on
first invocation and then use `fexecve` on all subsequent invocations.
As long as the user doesn't do inline rewrites of the file, we'd thus
always use the same file. I'm not sure how portable that syscall is,
though, but it's at least part of POSIX-2008.

> > Given the usecase described above, a voting mechanism can now be
> > implemented as a "ref-transaction-prepared" hook: as soon as it gets
> > called, it will take all of stdin and use it to cast a vote to a central
> > service. When all replicas of the repository agree, the hook will exit
> > with zero, otherwise it will abort the transaction by returning
> > non-zero. The most important upside is that this will catch _all_
> > commands writing references at once, allowing to implement strong
> > consistency for reference updates via a single mechanism.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/githooks.txt       | 51 ++++++++++++++++++
> >  refs.c                           | 67 +++++++++++++++++++++++-
> >  t/t1416-ref-transaction-hooks.sh | 88 ++++++++++++++++++++++++++++++++
> >  3 files changed, 204 insertions(+), 2 deletions(-)
> >  create mode 100755 t/t1416-ref-transaction-hooks.sh
> >=20
> > diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> > index 81f2a87e88..48f8446943 100644
> > --- a/Documentation/githooks.txt
> > +++ b/Documentation/githooks.txt
> > @@ -404,6 +404,57 @@ Both standard output and standard error output are=
 forwarded to
> >  `git send-pack` on the other end, so you can simply `echo` messages
> >  for the user.
> > =20
> > +ref-transaction-prepared
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +This hook is invoked by any Git command that performs reference
> > +updates. It executes as soon as all reference updates were queued to
> > +the transaction and locked on disk. This hook executes for every
> > +reference transaction that is being prepared and may thus get called
> > +multiple times.
> > +
> > +It takes no arguments, but for each ref to be updated it receives on
> > +standard input a line of the format:
> > +
> > +  <old-value> SP <new-value> SP <ref-name> LF
> > +
> > +If the hook exits with a non-zero status, the transaction is aborted
> > +and the command exits immediately. The
> > +<<ref-transaction-aborted,'ref-transaction-aborted'>> hook is not
> > +executed in that case.
> > +
> > +[[ref-transaction-aborted]]
> > +ref-transaction-aborted
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +This hook is invoked by any Git command that performs reference
> > +updates. It executes as soon as a reference transaction is aborted and
> > +after all reference locks were released and any changes made to
> > +references were rolled back. The hook may get called multiple times or
> > +never in case no transaction was aborted.
> > +
> > +The hook takes no arguments, but for each ref to be updated it
>=20
> Nit: I found it a bit surprising to read about refs "to be updated" in
> the description of the 'aborted' hook, because by the time this hook
> is called the update has already been refused.  The same applies to
> the 'committed' hook below as well.

Fair. This should rather read "that would have been updated" and "that
were updated", respectively.

Patrick

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7XcWkACgkQVbJhu7ck
PpS4tw//eNA2uTLVizvbG4FAvWzm6Zh4Bg1ToZeGpniVnrNoOxmpzTNRHlgdK0Ir
sIBdNHFtpMPq+XtV1tJ3TTTwoELRfEIY4NkoPRUjU9XNWjG0Yofq0yczpoGbRoN/
MnDOf7trtlHgpWlKIJFYin/qspc4fveKXyjWHd+lr9TFqlj6ZO0tdoY89VLx374L
WlAEu4R4cjDQrYNRreItHqr1M+Y+10g94UNA76kvNlL83SE+xU/friV6Xa9q4rYk
OgPs97KkMECg74QvLIwgp/HgtkwV/smD/cyPSzoikljbAASRtUtkWp7DdTPShz1+
t7xU9mzAY10+mUubp/GOAoSgTZJDmUOIb8IljSMQXtCCu4yxxTQR/jW73DP0NZnk
u4Qksz/qmOW90JSm/lyqWAEOphgyNFXqsQopNpsnindrvGZjAXb4jTIQSEvu9I0r
MdeeWoMmRJy/R74bt8TFmbadOQP2CTM/Ifa8MDm+b7Kn21kwTmhQi3/+IAsiJgr9
JDH5shFry0Wr308zdKmvE1innrBDPGPLaC/CRvLm2SKMN33K7Pb3UhrEQOaa9Vai
0xyblAbfU4+UwfEr7ZRrncmdPmiE65SxENkz87bJpRiXdRF3c7R8jKTUIzrmjewY
7+7+W2KLNrnenNZjrnVu13sWFelZGso4iHe5nJavJYqLZiapruU=
=skJn
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
