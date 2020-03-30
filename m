Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD1C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FCA20776
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fUBYO4Wu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZId018z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgC3NrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:47:06 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54013 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbgC3NrG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:47:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 978FE5F0;
        Mon, 30 Mar 2020 09:47:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=T5d/+S884lJ7yhvxBsHOPa2uCqJ
        hDKLOuc6vDFh0dNM=; b=fUBYO4WuJksD3EpgPssCjndrzn58sou3Ykh7agHIFvE
        excTiTDOEJtsUhZ9y/8igZYCVYA7mS7RKv0rK3uBDypdCmE09Vu5SGMn7hobWIzy
        xqWbAc+tGycvNcJneLX02XJEgoUJyIzOoH6LYblbP+T8zvo48glSRhB6yOiqbf4L
        zioE5BIfylqihBUAX8IptW93BA5fGxTSnTw/WwDthr27C1S4jHcYZXyNYudq+0d/
        CrZQu59MPHMidQu6ZrdZRwm7fG4Pxc5+MQRt54uB0M8kMPP8WvvdgR0ozZteTg7o
        GuegSwKjzJw1WzHESIyJcR/kqlpye8+/4nt3WBceFYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=T5d/+S
        884lJ7yhvxBsHOPa2uCqJhDKLOuc6vDFh0dNM=; b=pZId018zo6K69E4Tuf8dto
        enA2O4KZSvQe3BbLPkiMwqLyedPopOoX0musJFx5WoQsUQa0KnUlu6K9+eMYisur
        JdVILe+juLDNd0oJTwwOlBsPfAsF+LuNF+biSW6/fA5TIfZJ98xMlZrUaVlm9hft
        oBPHFdh5kEB3gusILkzTAivRpDQnqpNTM67oyiWjlJwWDXQz3zRyCUFN+tl1kdXV
        reilcDQKqkAUk3NxwmOC262el9s9dJ0bJBx1C0tkXrzJGgvevbSOPV91yfUCoIDX
        uj2L+d+EPlEr8uIiFKbNpztzU5lsAkwLZ4UIqTtB+Fq6/YijssMq7yejkQrkmFJA
        ==
X-ME-Sender: <xms:WPiBXvABQ6qi0ho_6Mivm-Puf2JSrDUGKCcF_ueplsvP-cxLgMUTWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WPiBXphjGN4vKgT5RZl3MmXHfEZ-NR7Q-xWyL-nIl3CWU1bGhbGzCA>
    <xmx:WPiBXrMsre2taaTJfMEWVfndDIvtXnw0KlJJxEpA1O2C80CzY6g8ug>
    <xmx:WPiBXhoo7Mwfju_DXTR7lQw93sLfAf9jxcGpfzvRTLb1_-K01qKw4A>
    <xmx:WPiBXlGE1zJR55yYgRzG6a9PBllym1sDi2vXDxeYqslGVRrGiXf_Iw>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 861C83280069;
        Mon, 30 Mar 2020 09:47:03 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b949498d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:47:01 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:47:05 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] update-ref: implement interactive transaction handling
Message-ID: <c3fffdf9fa5bcf123aff2d6f9b904f5cac57972a.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-update-ref(1) command can only handle queueing transactions
right now via its "--stdin" parameter, but there is no way for users to
handle the transaction itself in a more explicit way. E.g. in a
replicated scenario, one may imagine a coordinator that spawns
git-update-ref(1) for multiple repositories and only if all agree that
an update is possible will the coordinator send a commit. Such a
transactional session could look like

    > start
    < start: ok
    > update refs/heads/master $OLD $NEW
    > prepare
    < prepare: ok
    # All nodes have returned "ok"
    > commit
    < commit: ok

or

    > start
    < start: ok
    > create refs/heads/master $OLD $NEW
    > prepare
    < fatal: cannot lock ref 'refs/heads/master': reference already exists
    # On all other nodes:
    > abort
    < abort: ok

In order to allow for such transactional sessions, this commit
introduces four new commands for git-update-ref(1), which matches those
we have internally already with the exception of "start":

    - start: start a new transaction

    - prepare: prepare the transaction, that is try to lock all
               references and verify their current value matches the
               expected one

    - commit: explicitly commit a session, that is update references to
              match their new expected state

    - abort: abort a session and roll back all changes

By design, git-update-ref(1) will commit as soon as standard input is
being closed. While fine in a non-transactional world, it is definitely
unexpected in a transactional world. Because of this, as soon as any of
the new transactional commands is used, the default will change to
aborting without an explicit "commit". To avoid a race between queueing
updates and the first "prepare" that starts a transaction, the "start"
command has been added to start an explicit transaction.

Add some tests to exercise this new functionality.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-update-ref.txt |  26 ++++++
 builtin/update-ref.c             | 106 +++++++++++++++++++++++--
 t/t1400-update-ref.sh            | 131 +++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-re=
f.txt
index 9bd039ce08..3e737c2360 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -66,6 +66,10 @@ performs all modifications together.  Specify commands o=
f the form:
 	delete SP <ref> [SP <oldvalue>] LF
 	verify SP <ref> [SP <oldvalue>] LF
 	option SP <opt> LF
+	start LF
+	prepare LF
+	commit LF
+	abort LF
=20
 With `--create-reflog`, update-ref will create a reflog for each ref
 even if one would not ordinarily be created.
@@ -83,6 +87,10 @@ quoting:
 	delete SP <ref> NUL [<oldvalue>] NUL
 	verify SP <ref> NUL [<oldvalue>] NUL
 	option SP <opt> NUL
+	start NUL
+	prepare NUL
+	commit NUL
+	abort NUL
=20
 In this format, use 40 "0" to specify a zero value, and use the empty
 string to specify a missing value.
@@ -114,6 +122,24 @@ option::
 	The only valid option is `no-deref` to avoid dereferencing
 	a symbolic ref.
=20
+start::
+	Start a transaction. In contrast to a non-transactional session, a
+	transaction will automatically abort if the session ends without an
+	explicit commit.
+
+prepare::
+	Prepare to commit the transaction. This will create lock files for all
+	queued reference updates. If one reference could not be locked, the
+	transaction will be aborted.
+
+commit::
+	Commit all reference updates queued for the transaction, ending the
+	transaction.
+
+abort::
+	Abort the transaction, releasing all locks if the transaction is in
+	prepared state.
+
 If all <ref>s can be locked with matching <oldvalue>s
 simultaneously, all modifications are performed.  Otherwise, no
 modifications are performed.  Note that while each individual
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 77cd235dfc..120c0a5fc0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -326,6 +326,59 @@ static void parse_cmd_option(struct ref_transaction *t=
ransaction,
 		die("option unknown: %s", next);
 }
=20
+static void parse_cmd_start(struct ref_transaction *transaction,
+			    const char *next, const char *end)
+{
+	if (*next !=3D line_termination)
+		die("start: extra input: %s", next);
+	puts("start: ok");
+}
+
+static void parse_cmd_prepare(struct ref_transaction *transaction,
+			      const char *next, const char *end)
+{
+	struct strbuf error =3D STRBUF_INIT;
+	if (*next !=3D line_termination)
+		die("prepare: extra input: %s", next);
+	if (ref_transaction_prepare(transaction, &error))
+		die("prepare: %s", error.buf);
+	puts("prepare: ok");
+}
+
+static void parse_cmd_abort(struct ref_transaction *transaction,
+			    const char *next, const char *end)
+{
+	struct strbuf error =3D STRBUF_INIT;
+	if (*next !=3D line_termination)
+		die("abort: extra input: %s", next);
+	if (ref_transaction_abort(transaction, &error))
+		die("abort: %s", error.buf);
+	puts("abort: ok");
+}
+
+static void parse_cmd_commit(struct ref_transaction *transaction,
+			     const char *next, const char *end)
+{
+	struct strbuf error =3D STRBUF_INIT;
+	if (*next !=3D line_termination)
+		die("commit: extra input: %s", next);
+	if (ref_transaction_commit(transaction, &error))
+		die("commit: %s", error.buf);
+	puts("commit: ok");
+	ref_transaction_free(transaction);
+}
+
+enum update_refs_state {
+	/* Non-transactional state open for updates. */
+	UPDATE_REFS_OPEN,
+	/* A transaction has been started. */
+	UPDATE_REFS_STARTED,
+	/* References are locked and ready for commit */
+	UPDATE_REFS_PREPARED,
+	/* Transaction has been committed or closed. */
+	UPDATE_REFS_CLOSED,
+};
+
 static const struct parse_cmd {
 	const char *prefix;
 	void (*fn)(struct ref_transaction *, const char *, const char *);
@@ -336,17 +389,23 @@ static const struct parse_cmd {
 	 * of lines.
 	 */
 	unsigned extra_lines;
+	enum update_refs_state state;
 } command[] =3D {
-	{ "update", parse_cmd_update, 2 },
-	{ "create", parse_cmd_create, 1 },
-	{ "delete", parse_cmd_delete, 1 },
-	{ "verify", parse_cmd_verify, 1 },
-	{ "option", parse_cmd_option, 0 },
+	{ "update",  parse_cmd_update,  2, UPDATE_REFS_OPEN },
+	{ "create",  parse_cmd_create,  1, UPDATE_REFS_OPEN },
+	{ "delete",  parse_cmd_delete,  1, UPDATE_REFS_OPEN },
+	{ "verify",  parse_cmd_verify,  1, UPDATE_REFS_OPEN },
+	{ "option",  parse_cmd_option,  0, UPDATE_REFS_OPEN },
+	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
+	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
+	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
+	{ "commit",  parse_cmd_commit,  0, UPDATE_REFS_CLOSED },
 };
=20
 static void update_refs_stdin(void)
 {
 	struct strbuf input =3D STRBUF_INIT, err =3D STRBUF_INIT;
+	enum update_refs_state state =3D UPDATE_REFS_OPEN;
 	struct ref_transaction *transaction;
 	int i, j;
=20
@@ -393,14 +452,45 @@ static void update_refs_stdin(void)
 			if (strbuf_appendwholeline(&input, stdin, line_termination))
 				break;
=20
+		switch (state) {
+		case UPDATE_REFS_OPEN:
+		case UPDATE_REFS_STARTED:
+			/* Do not downgrade a transaction to a non-transaction. */
+			if (cmd->state >=3D state)
+				state =3D cmd->state;
+			break;
+		case UPDATE_REFS_PREPARED:
+			if (cmd->state !=3D UPDATE_REFS_CLOSED)
+				die("prepared transactions can only be closed");
+			state =3D cmd->state;
+			break;
+		case UPDATE_REFS_CLOSED:
+			die("transaction is closed");
+			break;
+		}
+
 		cmd->fn(transaction, input.buf + strlen(cmd->prefix),
 			input.buf + input.len);
 	}
=20
-	if (ref_transaction_commit(transaction, &err))
-		die("%s", err.buf);
+	switch (state) {
+	case UPDATE_REFS_OPEN:
+		/* Commit by default if no transaction was requested. */
+		if (ref_transaction_commit(transaction, &err))
+			die("%s", err.buf);
+		ref_transaction_free(transaction);
+		break;
+	case UPDATE_REFS_STARTED:
+	case UPDATE_REFS_PREPARED:
+		/* If using a transaction, we want to abort it. */
+		if (ref_transaction_abort(transaction, &err))
+			die("%s", err.buf);
+		break;
+	case UPDATE_REFS_CLOSED:
+		/* Otherwise no need to do anything, the transaction was closed already.=
 */
+		break;
+	}
=20
-	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	strbuf_release(&input);
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index a6224ef65f..48d0d42afd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1404,4 +1404,135 @@ test_expect_success 'handle per-worktree refs in re=
fs/bisect' '
 	! test_cmp main-head worktree-head
 '
=20
+test_expect_success 'transaction handles empty commit' '
+	cat >stdin <<-EOF &&
+	start
+	prepare
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start prepare commit >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction handles empty commit with missing prepare=
' '
+	cat >stdin <<-EOF &&
+	start
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction handles sole commit' '
+	cat >stdin <<-EOF &&
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" commit >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction handles empty abort' '
+	cat >stdin <<-EOF &&
+	start
+	prepare
+	abort
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start prepare abort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction exits on multiple aborts' '
+	cat >stdin <<-EOF &&
+	abort
+	abort
+	EOF
+	test_must_fail git update-ref --stdin <stdin >actual 2>err &&
+	printf "%s: ok\n" abort >expect &&
+	test_cmp expect actual &&
+	grep "fatal: transaction is closed" err
+'
+
+test_expect_success 'transaction exits on start after prepare' '
+	cat >stdin <<-EOF &&
+	prepare
+	start
+	EOF
+	test_must_fail git update-ref --stdin <stdin 2>err >actual &&
+	printf "%s: ok\n" prepare >expect &&
+	test_cmp expect actual &&
+	grep "fatal: prepared transactions can only be closed" err
+'
+
+test_expect_success 'transaction handles empty abort with missing prepare'=
 '
+	cat >stdin <<-EOF &&
+	start
+	abort
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start abort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction handles sole abort' '
+	cat >stdin <<-EOF &&
+	abort
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" abort >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction can handle commit' '
+	cat >stdin <<-EOF &&
+	start
+	create $a HEAD
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit >expect &&
+	test_cmp expect actual &&
+	git rev-parse HEAD >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction can handle abort' '
+	cat >stdin <<-EOF &&
+	start
+	create $b HEAD
+	abort
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start abort >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing .git/$b
+'
+
+test_expect_success 'transaction aborts by default' '
+	cat >stdin <<-EOF &&
+	start
+	create $b HEAD
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing .git/$b
+'
+
+test_expect_success 'transaction with prepare aborts by default' '
+	cat >stdin <<-EOF &&
+	start
+	create $b HEAD
+	prepare
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start prepare >expect &&
+	test_cmp expect actual &&
+	test_path_is_missing .git/$b
+'
+
 test_done
--=20
2.26.0


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+FcACgkQVbJhu7ck
PpS7zBAAo2l9x8mtn/tPBYH+Ea3XDSTvuYsnhPDyKhuEdQU8GhLTzI5RgROxH14C
wTHw605jTCJXQ5ZezL8PEu77I87g0eT5AETL1fjGQN4Wtv9YT6Xi0q0EvblNETVm
MZk5GBooATqrbh4GdkO++vw5W6XewB5D/fMymbn3eASiE8RXFkiAQIeXI4xDL1xN
KTO3Zr8Pt9E0VKOH2HYlQmAp+1eyXOzilcrKA7yC1AjwNBjxv4Wi5881wvZxs2gX
duyZun+bP7wgxVL8FfycAlg6mtpwbZyjdgmyIhZro8RBV4U6VSavdeP7WhstBOTo
6b216vt+ZKXNNWHzm/llRT2NrHZXGaDeCB2B/EoQSFs+lvKLhjcs1jpIN1Q1ug/5
j1koV1tSRD2yymLlMQt//1OOVnEizrO0cUimYq/N8sbHDBwbmPaEMRZADWrIRZ30
EJSjW/jITMmD57I2Zh1K4ZiRVv/1CQCT09vnCPyTsnDqMaXjWQ7DFr08t71pa32P
Vv/bFwbipxwWX4RoFfM9r3iWR6UDFn+KtSWZib08k1gpTzM53fc4sBhooddZplWI
zi0IWHGOjfcGMtG90Zdzd0fQPn4e/VodJyTtkJW0mHWGT4SmAqeaqut3ljR3c+CY
WM61l1HeObLltZVZ/NTPDkZNA8L8rOICRHvNlf2OY79zmMVi/Ls=
=dlWJ
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
