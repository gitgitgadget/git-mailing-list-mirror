Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF5C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6142080C
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tEs1Uglx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWCs/Hft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgDBHJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34753 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgDBHJ7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AD5D15C028F;
        Thu,  2 Apr 2020 03:09:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=gHKhqEzfzf+pJT3EE9SPXsIspcI
        0LdiWVpadawE2gD4=; b=tEs1Uglx7uBG23fvkanhrl04uLFPanzsL/WUfvpcfK3
        g2UIgnvHtqvZ7aqrgKCChaYm2+9mDMnwsi7nGUOhYy59KHaJ6Rp5ttvdUZC5Plun
        dy1hxaFFYwR7Ckq3GZzBZ1vDYrb6fwvfK7g89AvTS4+d7WoNOgY9t+4EICuI2uvQ
        QewgD6bZcyeWTPPUNyUMuCZWBN9l7S/VYCEZPszudfnC6XvW2yZKfqcFFd9ZTwfC
        JmpDLyLdOsgoU5tzqPjifV2YedMcQLmKnbEMUCca75Ef9xCr3J0U3UbLGuM93okV
        LghEvqGwUNHJLhUk2GRbj8W4NoggUBtbsdTl2xmpUXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gHKhqE
        zfzf+pJT3EE9SPXsIspcI0LdiWVpadawE2gD4=; b=gWCs/HftM6YVx6FforCMmU
        Ix1vzsQdKtzVzGYir1XOc0c2xbijnwS36PjO8AzcDhzpESuYPn/Tg5aMJj2bTk3S
        /hCXMAw6ojvgywTswQowX3IjpCQPOzt5f3gTGONBbAFwB5TjOlIHsCFgYZvQj8sD
        hRKpZ9Y4B9X8S0hPKkvKT+Qyt6iL5+64fHbWQEpGh5bQiBsB/qCyaIkvbBeCSVMZ
        /RFenC8aoG/vdPQo9uEDoYOnLdOkRZEluypgjJTxVHaeRO6M/DbWRLR0eGX8ON+/
        hZyi0+WuHJTgOLi5D86+X7KgCd2PRy9Y1Bn00UpErDZSjwVlTh8M3HUaZQwrfhMA
        ==
X-ME-Sender: <xms:xY-FXiiJC6HJOcbUyBGXmSL49RPZUcNVkm4Iqe3IzHLoxUZmbwgX1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xY-FXiDkk0yrUQVg2VrcEmz20Bf0ZlnYhVIWA7qehnrP9c9Ub56w9A>
    <xmx:xY-FXkeQ1Vc1enceqE-zJjCROhYIMsdWHMNBImDJ3ILXRUhGLgmuDQ>
    <xmx:xY-FXj1uVDzyeZ1ZlzqUz-ZZDiWDMtZgqHGGgJcNMRkHvHLi784WFg>
    <xmx:xY-FXtWnrq0mKuT5Qxo-5EZm_tovneJEEk8TvkQptbZfd-1QURwq4w>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0137F306CDA9;
        Thu,  2 Apr 2020 03:09:56 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 91e464ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:55 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:10:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 9/9] update-ref: implement interactive transaction handling
Message-ID: <5670bea2b15bafbd93d7d507b35e54980ad06fb9.1585811014.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CE+1k2dSO48ffgeK
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
index 348407b896..b74dd9a69d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -312,21 +312,80 @@ static void parse_cmd_option(struct ref_transaction *=
transaction,
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
 	unsigned args;
+	enum update_refs_state state;
 } command[] =3D {
-	{ "update", parse_cmd_update, 3 },
-	{ "create", parse_cmd_create, 2 },
-	{ "delete", parse_cmd_delete, 2 },
-	{ "verify", parse_cmd_verify, 2 },
-	{ "option", parse_cmd_option, 1 },
+	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
+	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
+	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
+	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
+	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
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
@@ -374,14 +433,45 @@ static void update_refs_stdin(void)
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
 		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
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


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj8kACgkQVbJhu7ck
PpQn1BAAgdwOgtUO9fgnLvjQKZNeZu/a1Lle/5vwic7UbaIwfQCOoKsloAQHE4tq
7sBA+PJXjKkfrLFq4tvo+WHLpqi8SXlmedt06rQuolrTxydE54bEG+d3Sbmq7G2e
SmUupaRu5fJnPHBV755QpWKzEb8dlTt3GLzMBj2X6yY+FZ0bIReM+k17/fIicb2X
BYSZDwHur1kBt4WBHtQyrl+1em23TKnmNFqagoMp64m/t9GCNRV6MR8mQW2BtJIY
xs0LK6DKQJNu0KF/MDyH8PAcM14w5M8n1FFCWdebmJHk55YKsL9/JOdNJwxJTN3F
TS/1i+7Cki7vyVPDJkHe7tMqaN/o4sCmHBtsjwzzw9hAYZoTYpwQfeSlqL9o5n3O
hEFzpInEPH3mcvJrsIqa/DtU+guWnuUhen7w75k9X+B/vtXrIKoXegyiOlnLg4E9
idK997Pmg3U8ArpUk/MikB9KF3cwa1s1iEIRJ3HmRyZVK4ULb0MK3zaiIg48AnaO
A5WehWN+UjnxFpwXPYzRgfUk1UGKsSZPJjwrmTzjdM328YZNdFeylgMLYIi1F6B4
N84TlrEOXYOODDatp06UbK7EPL/pa5b1cBl5myeR9QRZDQyu/L36XQX3Zf9QTdIC
CL4kFVnNhNXslQRtVJN2zSFoHV3PQWf8xJbu2smP0fwYHG3+pdQ=
=ZBjF
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
