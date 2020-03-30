Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0BC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5160C2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 08:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OEpIj/x+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3s0AgEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgC3IF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:05:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40247 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729546AbgC3IF4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 04:05:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 28DF75C00E9;
        Mon, 30 Mar 2020 04:05:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3kvm+ehuGb8pu1Wfd4tooQ5wJSa
        EG3xm1920oyT3Q6Y=; b=OEpIj/x+utSYHl7ADcKMiKuVBc9gvPDiWMOv8L+WW4R
        maw7KX0rMMkfURq75N0LMCARCfQjP24Fyet95Aj/dITS7qFxbdS0GwZfM80gvIUn
        il9iqaCZGb50YF1gDMN3fwcfPYcTkoP56y3xH4XAyBhnNVR0gS5ts55iyLuZtHLJ
        pdFA3RcZPLq03kaRRc0r05NTQ240MVzFG0stIiF+5g1gSEMJIGu1zkpGzwHFIX9w
        le+qCrallSqNdt7JmvetZzYByeVBuQpGVN/H6mdD6ud/zAnRL5pZN7qUXEbW1X2O
        +4hhLmDDKgHMv8V0Xu7Sc1g+zW1tG5QFcIKV8wSF6eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3kvm+e
        huGb8pu1Wfd4tooQ5wJSaEG3xm1920oyT3Q6Y=; b=C3s0AgEXguS7go+K2RWWgS
        VrL4n9TM/QGE39XtLaWsCL9pdACbecSAc9HTCQ/o8Hwm92J7JPXPloh1m2eESg2p
        P1B22Pp5mtK4+JWGKKgJ9k7FLGOu2112LVL5s3UUOqKasilDuGgUygqkcJFQA2hQ
        LBK0XbSBYKXB6QJz2Ckl0v7LQLnyg402u0Vu6XJ2uA/HVGRTCyEdModLxk/D34O4
        yvUG0Mtk2y3v2GfCsjgzpYNuYz4y3+zx/m6zzLm44Rxmxy7i1r8u9MeFPWXIiWw9
        HfnpjDhraiRC6cg6ezdbkUmX7isO88L4m1qpTT+Qxt3/vqeVs0KYIioKcjxEJY5g
        ==
X-ME-Sender: <xms:YaiBXjXt5XeyEM88RNmBZRLtvz_kn0B_Mic6n6pusxqxpqq9D4033w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecukfhppeejkedrheegrddvvd
    dtrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:YaiBXh7mSNYz0XDbrWhpdsCG8Qwhl95NnYjcWleMP1S1iQh8DDCC8g>
    <xmx:YaiBXlZk_dTkHP8cnXc_YRSSgFbHzF9gGHELFED1ff4C6WHVc4vSWg>
    <xmx:YaiBXrqdTcqLoFe9f5VPJ-baeFFkQ268URn3PUmiA6TA37E2wY2qeg>
    <xmx:YqiBXuqfeX3pOQNikhmwjpHrW5Frxi9Z-dz8jlO9iNN-I34CVxKonw>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 316083280067;
        Mon, 30 Mar 2020 04:05:53 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fbc09716 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 08:05:47 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:05:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 4/9] update-ref: organize commands in an array
Message-ID: <20200330080551.GA186019@ncase.pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <50ffc263293571f8af71fd1d253ac238c6909229.1585129842.git.ps@pks.im>
 <xmqqh7y9fq29.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <xmqqh7y9fq29.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 02:25:34PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +static const struct parse_cmd {
> > +	const char *prefix;
> > +	const char *(*fn)(struct ref_transaction *, struct strbuf *, const ch=
ar *);
> > +} commands[] =3D {
>=20
> Do not call an array the represents a set of THINGs "type things[]";
> instead call it "type thing[]", so that the 0th thing can be
> referred to as thing[0], not things[0].
>=20
> One exception is when the set as a whole is referred to more often
> than individual element of an array, in which case "things" (without
> the [index]) becomes a sensible way to refer to the set.
>=20
> > +	{ "update", parse_cmd_update },
> > +	{ "create", parse_cmd_create },
> > +	{ "delete", parse_cmd_delete },
> > +	{ "verify", parse_cmd_verify },
> > +	{ "option", parse_cmd_option },
> > +};
> > +
> >  static void update_refs_stdin(struct ref_transaction *transaction)
> >  {
> >  	struct strbuf input =3D STRBUF_INIT;
> >  	const char *next;
> > +	int i;
> > =20
> >  	if (strbuf_read(&input, 0, 1000) < 0)
> >  		die_errno("could not read from stdin");
> >  	next =3D input.buf;
> >  	/* Read each line dispatch its command */
> >  	while (next < input.buf + input.len) {
> > +		const struct parse_cmd *cmd =3D NULL;
> > +
> >  		if (*next =3D=3D line_termination)
> >  			die("empty command in input");
> >  		else if (isspace(*next))
> >  			die("whitespace before command: %s", next);
> > -		else if (skip_prefix(next, "update ", &next))
> > -			next =3D parse_cmd_update(transaction, &input, next);
> > -		else if (skip_prefix(next, "create ", &next))
> > -			next =3D parse_cmd_create(transaction, &input, next);
> > -		else if (skip_prefix(next, "delete ", &next))
> > -			next =3D parse_cmd_delete(transaction, &input, next);
> > -		else if (skip_prefix(next, "verify ", &next))
> > -			next =3D parse_cmd_verify(transaction, &input, next);
> > -		else if (skip_prefix(next, "option ", &next))
> > -			next =3D parse_cmd_option(&input, next);
> > -		else
> > +
> > +		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> > +			if (!skip_prefix(next, commands[i].prefix , &next))
> > +				continue;
> > +			cmd =3D &commands[i];
> > +			break;
> > +		}
>=20
> The only reason why you had to sprinkle
>=20
> 	if (!skip_prefix(next, " ", &next))
> 		die(_("%s: missing space after command"), cmd);
>=20
> all over the place is because the table lacks the trailing SP (which
> makes sense---after all, you are making a table of commands).  In
> other words, it's not like some command called from this dispatcher
> would require " " after the command name and some others would not.

> So why not avoid touching the parse_cmd_<cmd>() at all (except for
> the "option" thing that now needs to take the transaction object for
> uniformity), and then verify the presence of " " here, perhaps like
> this:
>=20
> 	for (i =3D 0; i < ARRAY_SIZE(command); i++) {
> 		const char *eoc;
> 		if (!skip_prefix(next, commands[i].prefix, &eoc) ||
> 		    *eoc !=3D ' ')
> 			continue;
> 		cmd =3D &command[i];
>                 next =3D eoc;
> 		break;
> 	}

The reason why I moved those `skip_prefix` calls into each of the
respective commands is that this patch series introduces calls that do
not accept a trailing space at all. Thus we cannot handle the space
generically here, as that would was soon as we introduce the set of new
commands.

Initially I just had a trailing " " in the `command` array as you hint
at, but it felt a bit magical to me and might make readers wonder why
some commands are spelt "update " and why some are spelt "commit",
without a trailing space.

> Note that you cannot reuse &next here to future-proof the code;
> otherwise, you wouldn't be able to add a new command, e.g. "options",
> that sits next to the existing command "option", in the future.
>=20
> > +		if (!cmd)
> >  			die("unknown command: %s", next);
> > =20
> > +		if (input.buf[strlen(cmd->prefix)] !=3D line_termination &&
> > +		    input.buf[strlen(cmd->prefix)] !=3D '\0' &&
> > +		    input.buf[strlen(cmd->prefix)] !=3D ' ')
> > +			die("%s: no separator after command", cmd->prefix);
>=20
> This part of your version does not make sense to me.  If the input
> line began with "update" with some separator that is not a SP, the
> original would not have matched.  But with this code, "update\0"
> would pass this code and cause cmd->fn() to be called, only to get
> the input rejected, because next is not pointing to SP.  So why do
> you even need this if statement?

I hope this makes more sense with the above background of commands
without trailing space. It would probably make sense to move this into
the command-matching loop though to be able to discern "option" and a
potentially new "options" command in the future. Instead of dying, we'd
then have to `continue` the loop and check whether any of the remaining
commands matches.

Patrick

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6BqF0ACgkQVbJhu7ck
PpTDzw//Rtj5/3KwG1Cgl6cUGMhZ2hnQOltX/NQQXEc0eqEX4la0fo5YFC6Ow9Tr
3k289aT3zOdCOqLPyqYNNOeoo34A+xe3FgWYqELVuu6WY3hdc/UlMV6bB/M1ncM5
tOh1tAc5S8QJuB/XfhZhZehBQa88vqsn1FgNLiMant6xcYLJNxA0661AK0Y2iDwJ
zBUhNYhylMhY7F/NDHkCHv+NPskhxOuAiL1mAiDK4S0EL0VtzlB94wj3bziiNrH8
2B/rcB9R9YVSE3GQoYvthPFsKmOiJGNBWqC+pW7dW1ChD6bYbju2ZeI2YKO4GfU+
jIxyqCHVXTFMvrjeS1Rtn+UuVCvgeiH80UlUvu0zieboRn7RGqfWq7ZANTK5gTcJ
bQgYEU58Je/rHbR7ZJ+YXnXqpM/lOJjU/mRVFsPrveR7+q8YryTF76n5O+tLTprB
9NWVFZo8hJ+exYgvpVlcKGGVnfXKOLdao+D4xTh5XR/tsMLNJjH/o4wl40k/n0Zy
FpxPPwvvMl5cNB1z9XyEaMP2BqeRlHIG9XrPKx0Z4waVReZAUA6gbZFwaM8i/2GY
QhE+HXCIcKeNuPllizQ4bZ4PaqCKY7QW17LIw3sfy2o/E38l9fmywjG6psm1V0Oq
UIOPrL9d9QtYTRUG4O5QkUIgMPRAXf0J7nd/pwRDjzbeF+Ocl5E=
=/YBe
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
