Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E7C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 08:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC94206C3
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 08:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jwr8M/d8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x2vhZs08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgFBIY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:24:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55611 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgFBIY6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 2 Jun 2020 04:24:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 303035C00A9
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 04:24:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 02 Jun 2020 04:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=CBvkvbMJYc1o7V9yreARQPJi4NBTIAE++qUtdeqqpeE=; b=Jwr8M/d8nvna
        HJK2IUx6yqn0HJt2s9gmgzAKcDeO02yBjQE0NJu5Fxkj4i0Wn+QMKPdrNfBenIwL
        SORlZdt/iop8F2poOK6MxaUqvtKQeiVM1EL9XVa/TO/KpsAWUSLl1JBmQPbAEjq4
        1/wNELCa0DKMhKt4ieWVKheKh0tgTAO+34FwaJBCw8X7QTbDKlWDjqW/BPAUuP64
        1LtYlGHNeCXYhVBOxydJAQPktrlMQporSmynFZb7BPszpGhVvbMikNnQ4g07AnSF
        mrPOQ0yhTDVbe1OAZ/qiFQzzk86GusYjcTNic6OZQgDHYIIXV+U+H7kgF89sZZUV
        zW6Kzt5UlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=CBvkvbMJYc1o7V9yreARQPJi4NBTI
        AE++qUtdeqqpeE=; b=x2vhZs08w7cuFGm+OrjsHTiMKoOf4U5HibfPhzfYihRfF
        +42RLrc9Tk7HRlOJcvyDcYyXUY+Vw17TG3/kslBhcOhBpeY2HPGXYUvKKi/5Q8PC
        tdVgLD0VL4Wc3wUGmvBF1Pm1RS1QdcmxrhJai6Z/QEgupyH40Fu0s3DDZ4lz94Z2
        lwNVc4JI10ypySZtrBTJf1szCr88lCFD7Ii1LIEGXjfAUbUMkVPhjvkqzmS1J8rl
        QArSA6NNufIGwYcpCS/R+bek2GehvuwqOjSPLjPDl8HU9hmfHWyidaPcaC+4S7TM
        8p8tTYKxqmrIAysPtvTLt7dOJo4wq0+ahtCEdlfUA==
X-ME-Sender: <xms:2AzWXukGr6IH9SALjS3zHPpBPvx6MkMLDIs2xay8MuAHYPtIcXvaFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttddvne
    cuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhm
    qeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvdefud
    evffefveffhffgkeeiffenucfkphepjeekrdehhedruddtiedrhedunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2AzWXl1jfTnzuL5uBrH6RyRhQiH8hkaJY2uvNOXB5_VUDOL9-vjVXA>
    <xmx:2AzWXso0xViblu9LoQ50eBtR3x2zMnYeb-9nwLOcP6V6UsX_XMyiqQ>
    <xmx:2AzWXiligBTMcJZeZv5QY6qb4Ki8_HXpQ8g0tODMWa3245aTXXwdIQ>
    <xmx:2QzWXn1mLPr4KyNB0OkUueXTsqo4ERWKZBZ-yX2yswo1TKaGNsLGDg>
Received: from vm-mail.pks.im (x4e376a33.dyn.telefonica.de [78.55.106.51])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6BCB33280060
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 04:24:56 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ec42fb47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Tue, 2 Jun 2020 08:24:54 +0000 (UTC)
Date:   Tue, 2 Jun 2020 10:25:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] refs: implement reference transaction hooks
Message-ID: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The low-level reference transactions used to update references are
currently completely opaque to the user. While certainly desirable in
most usecases, there are some which might want to hook into the
transaction to observe all queued reference updates as well as observing
the abortion or commit of a prepared transaction.

One such usecase would be to have a set of replicas of a given Git
repository, where we perform Git operations on all of the repositories
at once and expect the outcome to be the same in all of them. While
there exist hooks already for a certain subset of Git commands that
could be used to implement a voting mechanism for this, many others
currently don't have any mechanism for this.

The above scenario is the motivation for a set of three new hooks that
reach directly into Git's reference transaction. Each of the following
new hooks (currently) doesn't accept any parameters and receives the set
of queued reference updates via stdin:

    - ref-transaction-prepared gets called when all reference updates
      have been queued. At this stage, the hook may decide to abort the
      transaction prematurely by returning a non-zero status code.

    - ref-transaction-committed gets called when a reference transaction
      was transmitted and all queued updates have been persisted.

    - ref-transaction-aborted gets called when a reference transaction
      was aborted and all queued updates have been rolled back.

Given the usecase described above, a voting mechanism can now be
implemented as a "ref-transaction-prepared" hook: as soon as it gets
called, it will take all of stdin and use it to cast a vote to a central
service. When all replicas of the repository agree, the hook will exit
with zero, otherwise it will abort the transaction by returning
non-zero. The most important upside is that this will catch _all_
commands writing references at once, allowing to implement strong
consistency for reference updates via a single mechanism.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/githooks.txt       | 51 ++++++++++++++++++
 refs.c                           | 67 +++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh | 88 ++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100755 t/t1416-ref-transaction-hooks.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 81f2a87e88..48f8446943 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -404,6 +404,57 @@ Both standard output and standard error output are for=
warded to
 `git send-pack` on the other end, so you can simply `echo` messages
 for the user.
=20
+ref-transaction-prepared
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by any Git command that performs reference
+updates. It executes as soon as all reference updates were queued to
+the transaction and locked on disk. This hook executes for every
+reference transaction that is being prepared and may thus get called
+multiple times.
+
+It takes no arguments, but for each ref to be updated it receives on
+standard input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> LF
+
+If the hook exits with a non-zero status, the transaction is aborted
+and the command exits immediately. The
+<<ref-transaction-aborted,'ref-transaction-aborted'>> hook is not
+executed in that case.
+
+[[ref-transaction-aborted]]
+ref-transaction-aborted
+~~~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by any Git command that performs reference
+updates. It executes as soon as a reference transaction is aborted and
+after all reference locks were released and any changes made to
+references were rolled back. The hook may get called multiple times or
+never in case no transaction was aborted.
+
+The hook takes no arguments, but for each ref to be updated it
+receives on standard input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> LF
+
+The hook's exit code is discarded by Git.
+
+ref-transaction-committed
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by any Git command that performs reference
+updates. It executes as soon as a reference transaction is committed,
+persisting all changes to disk and releasing any locks. The hook may
+get called multiple times or never in case no transaction was aborted.
+
+The hook takes no arguments, but for each ref to be updated it
+receives on standard input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> LF
+
+The hook's exit code is discarded by Git.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
=20
diff --git a/refs.c b/refs.c
index 224ff66c7b..e41fa7ea55 100644
--- a/refs.c
+++ b/refs.c
@@ -9,6 +9,7 @@
 #include "iterator.h"
 #include "refs.h"
 #include "refs/refs-internal.h"
+#include "run-command.h"
 #include "object-store.h"
 #include "object.h"
 #include "tag.h"
@@ -16,6 +17,7 @@
 #include "worktree.h"
 #include "argv-array.h"
 #include "repository.h"
+#include "sigchain.h"
=20
 /*
  * List of all available backends
@@ -1986,10 +1988,56 @@ int ref_update_reject_duplicates(struct string_list=
 *refnames,
 	return 0;
 }
=20
+static int run_transaction_hook(struct ref_transaction *transaction,
+				const char *hook_name)
+{
+	struct child_process proc =3D CHILD_PROCESS_INIT;
+	struct strbuf buf =3D STRBUF_INIT;
+	const char *argv[2];
+	int code, i;
+
+	argv[0] =3D find_hook(hook_name);
+	if (!argv[0])
+		return 0;
+
+	argv[1] =3D NULL;
+
+	proc.argv =3D argv;
+	proc.in =3D -1;
+	proc.stdout_to_stderr =3D 1;
+	proc.trace2_hook_name =3D hook_name;
+
+	code =3D start_command(&proc);
+	if (code)
+		return code;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	for (i =3D 0; i < transaction->nr; i++) {
+		struct ref_update *update =3D transaction->updates[i];
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s %s %s\n",
+			    oid_to_hex(&update->old_oid),
+			    oid_to_hex(&update->new_oid),
+			    update->refname);
+
+		if (write_in_full(proc.in, buf.buf, buf.len) < 0)
+			break;
+	}
+
+	close(proc.in);
+	sigchain_pop(SIGPIPE);
+
+	strbuf_release(&buf);
+	return finish_command(&proc);
+}
+
 int ref_transaction_prepare(struct ref_transaction *transaction,
 			    struct strbuf *err)
 {
 	struct ref_store *refs =3D transaction->ref_store;
+	int ret;
=20
 	switch (transaction->state) {
 	case REF_TRANSACTION_OPEN:
@@ -2012,7 +2060,17 @@ int ref_transaction_prepare(struct ref_transaction *=
transaction,
 		return -1;
 	}
=20
-	return refs->be->transaction_prepare(refs, transaction, err);
+	ret =3D refs->be->transaction_prepare(refs, transaction, err);
+	if (ret)
+		return ret;
+
+	ret =3D run_transaction_hook(transaction, "ref-transaction-prepared");
+	if (ret) {
+		ref_transaction_abort(transaction, err);
+		die(_("ref updates aborted by hook"));
+	}
+
+	return 0;
 }
=20
 int ref_transaction_abort(struct ref_transaction *transaction,
@@ -2036,6 +2094,8 @@ int ref_transaction_abort(struct ref_transaction *tra=
nsaction,
 		break;
 	}
=20
+	run_transaction_hook(transaction, "ref-transaction-aborted");
+
 	ref_transaction_free(transaction);
 	return ret;
 }
@@ -2064,7 +2124,10 @@ int ref_transaction_commit(struct ref_transaction *t=
ransaction,
 		break;
 	}
=20
-	return refs->be->transaction_finish(refs, transaction, err);
+	ret =3D refs->be->transaction_finish(refs, transaction, err);
+	if (!ret)
+		run_transaction_hook(transaction, "ref-transaction-committed");
+	return ret;
 }
=20
 int refs_verify_refname_available(struct ref_store *refs,
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
new file mode 100755
index 0000000000..b6df5fc883
--- /dev/null
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description=3D'reference transaction hooks'
+
+. ./test-lib.sh
+
+create_commit ()
+{
+	test_tick &&
+	T=3D$(git write-tree) &&
+	sha1=3D$(echo message | git commit-tree $T) &&
+	echo $sha1
+}
+
+test_expect_success setup '
+	mkdir -p .git/hooks
+'
+
+test_expect_success 'prepared hook allows updating ref' '
+	test_when_finished "rm .git/hooks/ref-transaction-prepared" &&
+	write_script .git/hooks/ref-transaction-prepared <<-\EOF &&
+		exit 0
+	EOF
+	C=3D$(create_commit) &&
+	git update-ref HEAD $C
+'
+
+test_expect_success 'prepared hook aborts updating ref' '
+	test_when_finished "rm .git/hooks/ref-transaction-prepared" &&
+	write_script .git/hooks/ref-transaction-prepared <<-\EOF &&
+		exit 1
+	EOF
+	C=3D$(create_commit) &&
+	test_must_fail git update-ref HEAD $C 2>err &&
+	grep "ref updates aborted by hook" err
+'
+
+test_expect_success 'prepared hook gets all queued updates' '
+	test_when_finished "rm .git/hooks/ref-transaction-prepared actual" &&
+	write_script .git/hooks/ref-transaction-prepared <<-\EOF &&
+		while read -r line; do printf "%s\n" "$line"; done >actual
+	EOF
+	C=3D$(create_commit) &&
+	cat >expect <<-EOF &&
+		$ZERO_OID $C HEAD
+		$ZERO_OID $C refs/heads/master
+	EOF
+	git update-ref HEAD $C <<-EOF &&
+		update HEAD $ZERO_OID $C
+		update refs/heads/master $ZERO_OID $C
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'committed hook gets all queued updates' '
+	test_when_finished "rm .git/hooks/ref-transaction-committed actual" &&
+	write_script .git/hooks/ref-transaction-committed <<-\EOF &&
+		while read -r line; do printf "%s\n" "$line"; done >actual
+	EOF
+	C=3D$(create_commit) &&
+	cat >expect <<-EOF &&
+		$ZERO_OID $C HEAD
+		$ZERO_OID $C refs/heads/master
+	EOF
+	git update-ref HEAD $C &&
+	test_cmp expect actual
+'
+
+test_expect_success 'aborted hook gets all queued updates' '
+	test_when_finished "rm .git/hooks/ref-transaction-aborted actual" &&
+	write_script .git/hooks/ref-transaction-aborted <<-\EOF &&
+		while read -r line; do printf "%s\n" "$line"; done >actual
+	EOF
+	C=3D$(create_commit) &&
+	cat >expect <<-EOF &&
+		$ZERO_OID $C HEAD
+		$ZERO_OID $C refs/heads/master
+	EOF
+	git update-ref --stdin <<-EOF &&
+		start
+		update HEAD $C $ZERO_OID
+		update refs/heads/master $C $ZERO_OID
+		abort
+	EOF
+	test_cmp expect actual
+'
+
+test_done
--=20
2.26.2


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7WDQcACgkQVbJhu7ck
PpRUCQ//Ys9XoqKAC7wet/mhZvF0jmnS/KyT4k5sLmyljm5BYH9bYhr2i2O/kiQb
fTyOTtP1nKIyPWby3/FxumcX4HNM7dBJ6HJN35AbnAKslYlTa8/VYEeB9yQj/udA
fs+R5NMWPUiLawuvhloULHjofdY2fB+a66j1x6NQiKVbTLsRYp+TCIxxz3eVhG3Z
YyUN/Sl/ihUTh10A0Jos+Ws1LkOIGrToKtT/GeiJbqSfn1NPWVuQrqVD/aMxWPM/
q0m9dlQ1Nv7zcohtDW9k98jnaeI3WvhtjgJuHdtd8x22FGSc/feFa+iye/XlsFpQ
D14rmK76lRDcU0nCxuasAJjht/snnk1aU6CqpBUtIPHztqvuiDmqwdodteT0BQcQ
bj82RNHj8KRXGBKYCo9NbwS8IhygCTwtYspoCgT+ptLcfQBmtDInfLPhZ5xdKk35
VxwJObjEoxLXsH7ieUX4DV41QPy4OsxOibIsP9OqfebCMjTAMbD4WkM878dSlDRO
0J19SFf54rvb8HDLbNYOBKavqpBy1cc44EWAGPX9BKa6Ls7+uopYRRIEEjiIMdIt
fJlrfvvhwKbxV2bsj8OBSTvX+dfYaHHd2rj9+dzHYyYF0xdb0gyZaAOvgakzL431
fmgBiwPomUEJsj2pIWIxW5pjPlMUH/n6ZdaNHdCRMTjXpIrKkok=
=SZUC
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
