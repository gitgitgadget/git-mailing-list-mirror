Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED9C2D0EF
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378142073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jSHusq64";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2MxUK+o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgC3NqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:16 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54847 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728481AbgC3NqP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BEB1E6EA;
        Mon, 30 Mar 2020 09:46:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=k/rBZ/0iXPAvzT7Tz5GWzkrjZev
        Yk1JSOnBkDD/j0ok=; b=jSHusq64n1Qk6ElebsXC2bSotrMd5OiFrd1CNJmYcoi
        KUpVKZCTnw2wBoLhMymyHG/Lxt4+37koyNWsr+61TB6H2kh3omWMwdNdFMy7V4W8
        oxPMll+/TiTU9ZA9D+Jm7JIATl87vNxtM7EalFDBCq89hSAqLH/B0XT4l7cKyOa/
        RRjKve2e+0c8SUJW0GT6+hubQUEkTJuorbzSkzmU9SZx7EaGl4RzbqQs/NCpdCRM
        n5NxUlp6YCzdXB7zFNzasWkBZH1vY2ZPLowiF8MUh9IVZAqjmb5XeH1Id9lz8ddM
        mmMM4y5eqriaiehOq17zEZAo+6T6/nEeBzYdAj8a4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=k/rBZ/
        0iXPAvzT7Tz5GWzkrjZevYk1JSOnBkDD/j0ok=; b=2MxUK+o/qgTYJ9qdUNUQzU
        8nH5skz0Q+1f3dj8bM1bOeez8wNU6luDX92eXgkZ14t1ZzD+NtJDQokGwLy4brOm
        SzPNVE0kdFsx0NcLs0qxvh7tjR1JfKzWyGB8V3nzOAUiSadck2Px5B3Ifewm9hz/
        clS84+hHgBrdLAHuCcXQzfDESp7DZhAKZTdJrkw/C1E7CMIHh/IH8u1aZ+w9kmSr
        09fz3K3jzR4q0J8juivt/Im7Xd6CKwS2JdJ4z6ru/CmHQmGNFGFqdQXBMOD57xN4
        L+dgFAqrELApDGGnrCX4LJwDfSMiA6iFDQfvwRkdrBhY/NP5bbxXCTJy0BKjvhTw
        ==
X-ME-Sender: <xms:JfiBXoTqoqArysDHSOSV3lZOLRPNR6K7eaaSngpgRl_mg6A2hrGGJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JfiBXtbNmuGcpxIf4QEAqNhQwHKBFY9hdZwzw5sYsGnAYlsBU7pcIA>
    <xmx:JfiBXjfjiAfxLoKgNkwGefJ4qzjUAM-W9DpKkQnfxhsx-iJ8X2NOBg>
    <xmx:JfiBXmLmrO3RE-PYuHdoBkfi_zCqCGcn45AUAVDeR1-kseHOo8TSYw>
    <xmx:JfiBXlRONA6_lyzr6o_r3yXP9cTkVuJOUgaGRoX8CnWsGIrI1blK_A>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AF813280064;
        Mon, 30 Mar 2020 09:46:12 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 24c114f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:02 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] Support for transactions in `git-update-ref --stdin`
Message-ID: <cover.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of this patch series to introduce transaction
support in `git update-ref --stdin`. The goal is to make commands
available to the user of that command so that he can explicitly control
the given transaction by starting, preparing, and finally committing or
aborting the transaction.

The second version addresses the feedback of Junio:

    - Renamed the `commands` array to `command`.

    - Adds documentation to the `extra_lines` field to hopefully make
      its intent clearer.

    - Clarify why we ignore EOF when reading `extra_lines`.

    - When reading commands, the code now verifies that a line is not
      only a prefix to the command, but in fact the whole command. This
      allows implementation of multiple commands that have the same
      prefix, e.g. "option" and "options".

Thanks Junio for your review!

Patrick

Patrick Steinhardt (9):
  refs: fix segfault when aborting empty transaction
  git-update-ref.txt: add missing word
  strbuf: provide function to append whole lines
  update-ref: organize commands in an array
  update-ref: drop unused argument for `parse_refname`
  update-ref: pass end pointer instead of strbuf
  update-ref: move transaction handling into `update_refs_stdin()`
  update-ref: read commands in a line-wise fashion
  update-ref: implement interactive transaction handling

 Documentation/git-update-ref.txt |  28 +++-
 builtin/update-ref.c             | 274 +++++++++++++++++++++++--------
 refs/files-backend.c             |  20 ++-
 strbuf.c                         |  10 ++
 strbuf.h                         |   6 +
 t/t1400-update-ref.sh            | 131 +++++++++++++++
 6 files changed, 388 insertions(+), 81 deletions(-)

Range-diff against v1:
 1:  3c7f8c47f3 =3D  1:  7a297db4da refs: fix segfault when aborting empty =
transaction
 2:  dd7798abb7 =3D  2:  15857e1b8c git-update-ref.txt: add missing word
 3:  4b0a963ea5 =3D  3:  b6546ae44e strbuf: provide function to append whol=
e lines
 4:  50ffc26329 !  4:  bd8c059fbc update-ref: organize commands in an array
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct str=
buf *input,
     +static const struct parse_cmd {
     +	const char *prefix;
     +	const char *(*fn)(struct ref_transaction *, struct strbuf *, const c=
har *);
    -+} commands[] =3D {
    ++} command[] =3D {
     +	{ "update", parse_cmd_update },
     +	{ "create", parse_cmd_create },
     +	{ "delete", parse_cmd_delete },
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct str=
buf *input,
     -			next =3D parse_cmd_option(&input, next);
     -		else
     +
    -+		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
    -+			if (!skip_prefix(next, commands[i].prefix , &next))
    ++		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
    ++			const char *prefix =3D command[i].prefix;
    ++
    ++			if (!skip_prefix(next, prefix, &next))
     +				continue;
    -+			cmd =3D &commands[i];
    ++
    ++			/*
    ++			 * Check that the command is terminated by an argument
    ++			 * or line terminator and not only a matching prefix.
    ++			 */
    ++			if (input.buf[strlen(prefix)] !=3D line_termination &&
    ++			    input.buf[strlen(prefix)] !=3D '\0' &&
    ++			    input.buf[strlen(prefix)] !=3D ' ')
    ++				continue;
    ++
    ++			cmd =3D &command[i];
     +			break;
     +		}
     +		if (!cmd)
      			die("unknown command: %s", next);
     =20
    -+		if (input.buf[strlen(cmd->prefix)] !=3D line_termination &&
    -+		    input.buf[strlen(cmd->prefix)] !=3D '\0' &&
    -+		    input.buf[strlen(cmd->prefix)] !=3D ' ')
    -+			die("%s: no separator after command", cmd->prefix);
    -+
     +		next =3D cmd->fn(transaction, &input, next);
      		next++;
      	}
 5:  a78043b188 =3D  5:  49a14d2046 update-ref: drop unused argument for `p=
arse_refname`
 6:  51ebb2f849 !  6:  cbe430029d update-ref: pass end pointer instead of s=
trbuf
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct ref=
_transaction
      	const char *prefix;
     -	const char *(*fn)(struct ref_transaction *, struct strbuf *, const c=
har *);
     +	const char *(*fn)(struct ref_transaction *, const char *, const char=
 *);
    - } commands[] =3D {
    + } command[] =3D {
      	{ "update", parse_cmd_update },
      	{ "create", parse_cmd_create },
     @@ builtin/update-ref.c: static void update_refs_stdin(struct ref_tran=
saction *transaction)
    - 		    input.buf[strlen(cmd->prefix)] !=3D ' ')
    - 			die("%s: no separator after command", cmd->prefix);
    + 		if (!cmd)
    + 			die("unknown command: %s", next);
     =20
     -		next =3D cmd->fn(transaction, &input, next);
     +		next =3D cmd->fn(transaction, next, input.buf + input.len);
 7:  bd92a649d7 =3D  7:  d2f68f59a7 update-ref: move transaction handling i=
nto `update_refs_stdin()`
 8:  1db63f97ec !  8:  f8786fdeb3 update-ref: read commands in a line-wise =
fashion
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct ref=
_transaction
      	const char *prefix;
     -	const char *(*fn)(struct ref_transaction *, const char *, const char=
 *);
     +	void (*fn)(struct ref_transaction *, const char *, const char *);
    ++	/*
    ++	 * If using NUL-terminated format, only the first argument will be
    ++	 * available in the first line. In case a command expects more than =
one
    ++	 * argument, we thus have to fetch an additional `extra_lines` number
    ++	 * of lines.
    ++	 */
     +	unsigned extra_lines;
    - } commands[] =3D {
    + } command[] =3D {
     -	{ "update", parse_cmd_update },
     -	{ "create", parse_cmd_create },
     -	{ "delete", parse_cmd_delete },
    @@ builtin/update-ref.c: static const char *parse_cmd_option(struct ref=
_transaction
     +		else if (isspace(*input.buf))
     +			die("whitespace before command: %s", input.buf);
     =20
    - 		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
    --			if (!skip_prefix(next, commands[i].prefix , &next))
    -+			if (!starts_with(input.buf, commands[i].prefix))
    + 		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
    + 			const char *prefix =3D command[i].prefix;
    +=20
    +-			if (!skip_prefix(next, prefix, &next))
    ++			if (!starts_with(input.buf, prefix))
      				continue;
    - 			cmd =3D &commands[i];
    +=20
    + 			/*
    +@@ builtin/update-ref.c: static void update_refs_stdin(void)
      			break;
      		}
      		if (!cmd)
     -			die("unknown command: %s", next);
     +			die("unknown command: %s", input.buf);
     =20
    - 		if (input.buf[strlen(cmd->prefix)] !=3D line_termination &&
    - 		    input.buf[strlen(cmd->prefix)] !=3D '\0' &&
    - 		    input.buf[strlen(cmd->prefix)] !=3D ' ')
    - 			die("%s: no separator after command", cmd->prefix);
    -=20
     -		next =3D cmd->fn(transaction, next, input.buf + input.len);
     -		next++;
    -+		/* Read extra lines if NUL-terminated */
    ++		/*
    ++		 * Read extra lines if NUL-terminated. Do not raise an error in
    ++		 * case there is an early EOF to let the command handle missing
    ++		 * arguments with a proper error message.
    ++		 */
     +		for (j =3D 0; line_termination =3D=3D '\0' && j < cmd->extra_lines;=
 j++)
     +			if (strbuf_appendwholeline(&input, stdin, line_termination))
     +				break;
 9:  88c0089bb5 !  9:  c3fffdf9fa update-ref: implement interactive transac=
tion handling
    @@ builtin/update-ref.c: static void parse_cmd_option(struct ref_transa=
ction *trans
      static const struct parse_cmd {
      	const char *prefix;
      	void (*fn)(struct ref_transaction *, const char *, const char *);
    +@@ builtin/update-ref.c: static const struct parse_cmd {
    + 	 * of lines.
    + 	 */
      	unsigned extra_lines;
     +	enum update_refs_state state;
    - } commands[] =3D {
    + } command[] =3D {
     -	{ "update", parse_cmd_update, 2 },
     -	{ "create", parse_cmd_create, 1 },
     -	{ "delete", parse_cmd_delete, 1 },
    @@ builtin/update-ref.c: static void parse_cmd_option(struct ref_transa=
ction *trans
      	int i, j;
     =20
     @@ builtin/update-ref.c: static void update_refs_stdin(void)
    - 		    input.buf[strlen(cmd->prefix)] !=3D ' ')
    - 			die("%s: no separator after command", cmd->prefix);
    -=20
    --		/* Read extra lines if NUL-terminated */
    -+		/* Read extra lines if NUL-terminated, but let commands handle miss=
ing ones. */
    - 		for (j =3D 0; line_termination =3D=3D '\0' && j < cmd->extra_lines;=
 j++)
      			if (strbuf_appendwholeline(&input, stdin, line_termination))
      				break;
     =20
--=20
2.26.0


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+BwACgkQVbJhu7ck
PpQdQA/9GtEgAhsYno/1cRDrydoAkD3vr5m9+QCJdE7azyezk06ANDAQLmwIQcmi
p2FriinfD9p3obDlafXK5nrjbPyS+FCzdjVepPRTPucY0j4hiuYLGnAd72QtgIQ0
f8HYm/KVeL2gV1Lt+jrhDEDGwunLGL4jXToj+xKqOuFcL61zJAXvyFuYlUtTAQZg
k36glBu3TNvd6QgcrXGnLYwL0tTaeUR59tKylevXUJnVzV66c1DObG1rQwhlPRjh
+aRQU6UVAhbMxpU6AUWAZAOdpNUCULxPUa7IcTJHV9WaUcyfxB9kQjCMUcqlI/Wm
wEbsQdraKRjGixuG++pa/JIs4NsL4A6X0cZvtAh+5RoEH0Tw/bI49/6P83rwhvnI
C1NWNIMeajVWVpY5AzrKLhz+dd5WswPbLUILpAV5Xs+dlm71CZC0G657ctKYTh83
+dPQhv+bW0VOrbrN2+EGX1hzuh08Ab7+PXA4MkCrLWA77wlVV3/f+nqXP6LUYyht
TnAxTJ7XIdahnfSSk5RGawm7trSoWyrMFOGwJ4+f4x716/cQ8EfGJvoVewm5ypOq
DiBFfoja/dqGhL4nW4XmJgBtreOQwQ79Z3aBxkTh7hM4tqs0Ks/DYYFQ4TJYxz1C
OksBAsaaHiyM16eb8OFHa3Wy/G2SKVgiGO9wnZEE1TPT/zSp2gA=
=i+Mn
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
