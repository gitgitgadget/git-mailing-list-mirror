Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D0C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855D920936
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OYRLkTb1";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lT+1tABz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKMIMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:12:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47013 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMIMj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 03:12:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5026C5C0066;
        Fri, 13 Nov 2020 03:12:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 03:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7ftYd8gP8yK3m6DhyMqVT9rg3Hb
        +/65oeem+Q6qwMGk=; b=OYRLkTb1lP8X+6ZP3uyImU4cvmGrqpV5OziLQkp9del
        ZDmJ8JOkkITM9T++jYQAusrlK8CUVx0/5cu0j+DZcjBif3UV7Er9GE0NkqI3NGgr
        69iAbFwtsVX4XoEaGtACAbxdq0P+3vgy2o4D16bKhqVN2whXC7kWgzO7NV+2/maz
        5EJKXxETwcHvPgFkIny+MeOJ+5iUrn4IAmAeF8lsbw1l7OAUi3OoqOM1y0WKC9mX
        QP/g9a7cGkyjY8NSQK6l8DNE15k4G3k31qJFKip4h9KGl/dBUinrkaH3bcxcHrOo
        pL42bwt4+y4JmsF4FtWDuSmosWfrG+6Ij3aHt+vDM+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7ftYd8
        gP8yK3m6DhyMqVT9rg3Hb+/65oeem+Q6qwMGk=; b=lT+1tABzGJazOXNAyYhqhx
        xxQCYckIUzDN3HnK3VKqAUcawd1Sk5RILyrgVjZde76yA6oBlOIpY7y23FZm6blP
        oIIxxcI0xDcvWdZfG7+GDgvxOalVV8QYiFAXB1C3i+0G77QfxnEwsh5vDYPHs5FD
        eAVQxQY+qv5RRhciFlZqblR27ZWyEmwESPs/nPbAFp/szLwRYNp2zV95BEGlwpz3
        xftJ104Z2yn1Y9bTkcfsTRctTaZIv/4ejUK07lIEqOKPbx+c2tfjKVudoYGwj01P
        YSOpi2WGQowssQ4K08NjVdmwDBga2zLFdWiV5TFRzPV8xBp5QBIRNV86QH+2MS4A
        ==
X-ME-Sender: <xms:9j-uX0CuCwUj8uN82On2LHAgfOU2NQrOS3DWPFmQG6CR2CBpB73XmA>
    <xme:9j-uX2jNfA_apuJ2hnGDnHmO5OxIIoigV9106FgUBof_jGIM0kABbi8tRAb8dp7QN
    tG3YincqkIGm5CMDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfedurddvfeehnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:9j-uX3k97zvRgOfpyW2Jm1-al6KcUhUiHlL74_oSa9e_SY5CFPIhKQ>
    <xmx:9j-uX6xOh1TbF6s4ohs3JYlqTaEFN2h6G4KMlRBuzyV0ZX9XwxfgRg>
    <xmx:9j-uX5TLHnk4jR-SqD4K1iCriee10mMWuGPwasu2AvxPHoc3qqH2CQ>
    <xmx:9j-uX4IDgT1MoxMtdw76tqNBw_P1wYLo2qtrOrtsoMQkUYRP3TEcnw>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 583E23064AAE;
        Fri, 13 Nov 2020 03:12:37 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 39847dd1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 13 Nov 2020 08:12:36 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:12:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 2/4] update-ref: allow creation of multiple transactions
Message-ID: <8a05b48223f2829f536ea1f95f58c017efb8cf3d.1605254957.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/b2Kd92yo+rYeX9I"
Content-Disposition: inline
In-Reply-To: <cover.1605254957.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/b2Kd92yo+rYeX9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While git-update-ref has recently grown commands which allow interactive
control of transactions in e48cf33b61 (update-ref: implement interactive
transaction handling, 2020-04-02), it is not yet possible to create
multiple transactions in a single session. To do so, one currently still
needs to invoke the executable multiple times.

This commit addresses this shortcoming by allowing the "start" command
to create a new transaction if the current transaction has already been
either committed or aborted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-update-ref.txt |  3 +-
 builtin/update-ref.c             | 13 ++++++++-
 t/t1400-update-ref.sh            | 50 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-re=
f.txt
index d401234b03..48b6683071 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -125,7 +125,8 @@ option::
 start::
 	Start a transaction. In contrast to a non-transactional session, a
 	transaction will automatically abort if the session ends without an
-	explicit commit.
+	explicit commit. This command may create a new empty transaction when
+	the current one has been committed or aborted already.
=20
 prepare::
 	Prepare to commit the transaction. This will create lock files for all
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 8a2df4459c..bb65129012 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -446,7 +446,18 @@ static void update_refs_stdin(void)
 			state =3D cmd->state;
 			break;
 		case UPDATE_REFS_CLOSED:
-			die("transaction is closed");
+			if (cmd->state !=3D UPDATE_REFS_STARTED)
+				die("transaction is closed");
+
+			/*
+			 * Open a new transaction if we're currently closed and
+			 * get a "start".
+			 */
+			state =3D cmd->state;
+			transaction =3D ref_transaction_begin(&err);
+			if (!transaction)
+				die("%s", err.buf);
+
 			break;
 		}
=20
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b782dafff5..3144e98b31 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1533,4 +1533,54 @@ test_expect_success 'transaction with prepare aborts=
 by default' '
 	test_must_fail git show-ref --verify -q $b
 '
=20
+test_expect_success 'transaction can commit multiple times' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/branch-1 $A
+	commit
+	start
+	create refs/heads/branch-2 $B
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit start commit >expect &&
+	test_cmp expect actual &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/branch-1 >actual &&
+	test_cmp expect actual &&
+	echo "$B" >expect &&
+	git rev-parse refs/heads/branch-2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction can create and delete' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/create-and-delete $A
+	commit
+	start
+	delete refs/heads/create-and-delete $A
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit start commit >expect &&
+	test_must_fail git show-ref --verify refs/heads/create-and-delete
+'
+
+test_expect_success 'transaction can commit after abort' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/abort $A
+	abort
+	start
+	create refs/heads/abort $A
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start abort start commit >expect &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/abort >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.29.2


--/b2Kd92yo+rYeX9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+uP/MACgkQVbJhu7ck
PpS93Q//WKqC81/NQhCjr60/C3xMARFQOpLPcl5gtMfScM0wdPNuDCDh8TvHCVCH
XdomJl12yZt/S78oYUxBrJLmeZb87NW7i3BIF45Y5Ya0gFYNtp8MZG/r6IuIAHst
hzYn9eN9aYjVvfB9Vjw07OK8flA1D4o6sVg/ljIVCUrzfiZ2l+lpvQpGgbst/GYS
FOGtStV5FdHMi9Dujrro8Y3eD6XPawuH2HEJq+33emG43WBTGisFP1p57T7rFYUi
/tUGI3nzk4nNrchy1NZbosRO00AudmKcLtVaVeutvwfu0Q1TKio7eXnOYlE8vpGI
zEkauuIj7M3CF83MAqVfZcjc9d9ewGFYdVPipkykETmdCe97ZDPUR/Uni2adLcHU
jErKzF8Ho7jvNxOLnTOu7pQjNyJ8m/3m73NqwsJh3o09W0Kql2FG5OEqdePuKgDZ
X+WXnT9wAVoW8WeX/YOSuuDjmhx/Jkdf3argD+yGRZVwJz9QetUhj7rzxyrlXybA
0Z2WerJ8cVPTLRsAOYWuBCJV/a3IFv2Bhqje+sIsRyv+RSjsDp5jjFGPGq2qSibd
2uPw2EHGcvgTYVARffPnMq1RaebhnlLI90A9rn25oQhHs6TY77QlmtNfG3wgEGIW
jWc1pYAUc3WaqzrZbBpdJt4TW1WJTVkO+hJqxSsVf65aLz5CQ9E=
=x/rm
-----END PGP SIGNATURE-----

--/b2Kd92yo+rYeX9I--
