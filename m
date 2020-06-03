Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA7C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AEC20679
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 12:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lfaqAanX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2aUr1nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgFCM1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:27:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49409 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgFCM1K (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2020 08:27:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1563C5C0087;
        Wed,  3 Jun 2020 08:27:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Jun 2020 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=alkVcaIojR6J8IRNCTP23D3VBxr
        Znrxf2TUJi8tKZLY=; b=lfaqAanX7j1rECqafGupftpFAUWBsjHl/oiUE+amrIH
        wv29YQPk399R+LaAFj1b7T5EjsBG/67ayz7WAUVDonVNVG/1yrtgcVtc0ELQUg/r
        CEFv1GehFJEyxLkwS0kceFtgtQ/BJM4p4oWbiNfj1uqn9tJt/+82B6L8crPk9w7g
        vSWpqW7Wev5ckcBSwXKI6gUKba0+5ewqtHVpgQq+EGUrJs7Dp2rF33QW2FsPe58x
        AkfX/VKpCDaInHWNfmHA6TKmSfxM6SsntaOJT7BKD05C+CqZG+1Dz+lRvI0+VFZw
        uTP7hX6PRTsOziaKfdR51dF8hWmjwa+LowvQv2ofbiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=alkVca
        IojR6J8IRNCTP23D3VBxrZnrxf2TUJi8tKZLY=; b=H2aUr1nweZHe/tQF3qEQhR
        x7a38iUk5RggP9n+5hSiyRCQSJfKBE41D/FAcGyW1vBHa9D6so9m1lcYABBAYWpb
        Tn2BeDIVc8kK1Bhsa1+Np28pCb9eQvARSCtMZ5NFYLNOuYHzAFu/BrEton1SJMkc
        Oj3oQY5M0Cx+Tf9DuVtBwLXYCjw8NX6MOE0xaHVNzmg6JR5dMjBRGxBkUe5timgQ
        PRCjQmedxmehNH81CXRopTSYe9bGL9RhkFptQuWj69fWI8h6OF8EY7aOda9p+No9
        +WUNkc7CO22yuMPSWHRIewmd1x10Gv9XGUT2k8jlJatvCYdqnNKUtHvdIaZqvXog
        ==
X-ME-Sender: <xms:GJfXXlAGPLwrVuGDiYi0NQJ7udk5FAjW94PfyPadVkyBBO0lX7IrjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejjedrudefrddujeeirddujedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:GJfXXjis8IxEWOO4niPtolfHLKJ3zlvaA0dww2DudLxZn4FRcCtZhQ>
    <xmx:GJfXXgn8M4hxfyTgl3Fvr3uKokkNtGoflWqFWnP-0rktRD2Gv-b6_g>
    <xmx:GJfXXvzRwR0ZTf76ubNsUBU61_iYtaJuLEonC9gIDL-vNTrnODW_aQ>
    <xmx:GZfXXhMu2cELwnk9VpZIF3M8Z1XdiEOsEf2oM5uHF5nA0NoevtbXPg>
Received: from vm-mail.pks.im (x4d0db0ab.dyn.telefonica.de [77.13.176.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id EEEF73061DC5;
        Wed,  3 Jun 2020 08:27:03 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b7f7a29c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 Jun 2020 12:26:59 +0000 (UTC)
Date:   Wed, 3 Jun 2020 14:27:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] refs: implement reference transaction hook
Message-ID: <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
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

The above scenario is the motivation for the new "reference-transaction"
hook that reaches directly into Git's reference transaction mechanism.
The hook receives as parameter the current state the transaction was
moved to ("prepared", "committed" or "aborted") and gets via its
standard input all queued reference updates. While the exit code gets
ignored in the "committed" and "aborted" states, a non-zero exit code in
the "prepared" state will cause the transaction to be aborted
prematurely.

Given the usecase described above, a voting mechanism can now be
implemented via this hook: as soon as it gets called, it will take all
of stdin and use it to cast a vote to a central service. When all
replicas of the repository agree, the hook will exit with zero,
otherwise it will abort the transaction by returning non-zero. The most
important upside is that this will catch _all_ commands writing
references at once, allowing to implement strong consistency for
reference updates via a single mechanism.

In order to test the impact on the case where we don't have any
"reference-transaction" hook installed in the repository, this commit
introduces a new performance test for git-update-refs(1). Run against an
empty repository, it produces the following results:

  Test                                   HEAD~             HEAD
  -------------------------------------------------------------------------=
-----
  1400.2: update existing reference      2.05(1.58+0.54)   2.08(1.58+0.57) =
+1.5%
  1400.3: create and destroy reference   1.79(1.38+0.49)   1.82(1.39+0.51) =
+1.7%

So the overhead is around ~1.5%. Given that git-update-refs(1) is a
near-direct wrapper around reference transactions, there likely is no
other command that is impacted much worse than this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

The main adjustment in this second version is that I merged the
previously three hooks into a single one that gets the transaction state
as its first parameter, as proposed by G=E1bor. This is mainly to enable
atomic replacement of all three scripts, even though it could still be
that the hook gets replaced during a session. But I think it makes sense
regardless to merge these hooks into a single one.

I've also made changes based on Junio's feedback and added a benchmark
that exercises git-update-refs(1) as a proxy for this change. I guess
the ~1.5% penalty isn't too bad. It might be improved by caching hook
existence, but I don't think it necessary right now.

Thanks to both of you for your feedback!

Patrick

 Documentation/githooks.txt       |  29 ++++++++
 refs.c                           |  72 +++++++++++++++++++-
 t/perf/p1400-update-ref.sh       |  31 +++++++++
 t/t1416-ref-transaction-hooks.sh | 109 +++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100755 t/perf/p1400-update-ref.sh
 create mode 100755 t/t1416-ref-transaction-hooks.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 81f2a87e88..642471109f 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -404,6 +404,35 @@ Both standard output and standard error output are for=
warded to
 `git send-pack` on the other end, so you can simply `echo` messages
 for the user.
=20
+ref-transaction
+~~~~~~~~~~~~~~~
+
+This hook is invoked by any Git command that performs reference
+updates. It executes whenever a reference transaction is prepared,
+committed or aborted and may thus get called multiple times.
+
+The hook takes exactly one argument, which is the current state the
+given reference transaction is in:
+
+    - "prepared": All reference updates have been queued to the
+      transaction and references were locked on disk.
+
+    - "committed": The reference transaction was committed and all
+      references now have their respective new value.
+
+    - "aborted": The reference transaction was aborted, no changes
+      were performed and the locks have been released.
+
+For each reference update that was added to the transaction, the hook
+receives on standard input a line of the format:
+
+  <old-value> SP <new-value> SP <ref-name> LF
+
+The exit status of the hook is ignored for any state except for the
+"prepared" state. In the "prepared" state, a non-zero exit status will
+cause the transaction to be aborted. The hook will not be called with
+"aborted" state in that case.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
=20
diff --git a/refs.c b/refs.c
index 224ff66c7b..af752e1759 100644
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
@@ -1986,10 +1988,61 @@ int ref_update_reject_duplicates(struct string_list=
 *refnames,
 	return 0;
 }
=20
+static int run_transaction_hook(struct ref_transaction *transaction,
+				const char *state)
+{
+	struct child_process proc =3D CHILD_PROCESS_INIT;
+	struct strbuf buf =3D STRBUF_INIT;
+	int saved_errno =3D 0, ret, i;
+	const char *hook;
+
+	hook =3D find_hook("reference-transaction");
+	if (!hook)
+		return 0;
+
+	argv_array_pushl(&proc.args, hook, state, NULL);
+	proc.in =3D -1;
+	proc.stdout_to_stderr =3D 1;
+	proc.trace2_hook_name =3D hook;
+
+	ret =3D start_command(&proc);
+	if (ret)
+		return ret;
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
+		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
+			if (errno !=3D EPIPE)
+				saved_errno =3D errno;
+			break;
+		}
+	}
+
+	close(proc.in);
+	sigchain_pop(SIGPIPE);
+	strbuf_release(&buf);
+
+	ret =3D finish_command(&proc);
+	if (ret)
+		return ret;
+
+	return saved_errno;
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
@@ -2012,7 +2065,17 @@ int ref_transaction_prepare(struct ref_transaction *=
transaction,
 		return -1;
 	}
=20
-	return refs->be->transaction_prepare(refs, transaction, err);
+	ret =3D refs->be->transaction_prepare(refs, transaction, err);
+	if (ret)
+		return ret;
+
+	ret =3D run_transaction_hook(transaction, "prepared");
+	if (ret) {
+		ref_transaction_abort(transaction, err);
+		die(_("ref updates aborted by hook"));
+	}
+
+	return 0;
 }
=20
 int ref_transaction_abort(struct ref_transaction *transaction,
@@ -2036,6 +2099,8 @@ int ref_transaction_abort(struct ref_transaction *tra=
nsaction,
 		break;
 	}
=20
+	run_transaction_hook(transaction, "aborted");
+
 	ref_transaction_free(transaction);
 	return ret;
 }
@@ -2064,7 +2129,10 @@ int ref_transaction_commit(struct ref_transaction *t=
ransaction,
 		break;
 	}
=20
-	return refs->be->transaction_finish(refs, transaction, err);
+	ret =3D refs->be->transaction_finish(refs, transaction, err);
+	if (!ret)
+		run_transaction_hook(transaction, "committed");
+	return ret;
 }
=20
 int refs_verify_refname_available(struct ref_store *refs,
diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
new file mode 100755
index 0000000000..4f4519529e
--- /dev/null
+++ b/t/perf/p1400-update-ref.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D"Tests performance of update-ref"
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+test_expect_success "setup" '
+	test_commit PRE &&
+	test_commit POST &&
+	git branch update-branch
+'
+
+test_perf "update existing reference" '
+	for i in $(test_seq 1000)
+	do
+		git update-ref refs/heads/update-branch PRE POST &&
+		git update-ref refs/heads/update-branch POST PRE
+	done
+'
+
+test_perf "create and destroy reference" '
+	for i in $(test_seq 1000)
+	do
+		git update-ref refs/heads/new POST
+		git update-ref -d refs/heads/new
+	done
+'
+
+test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
new file mode 100755
index 0000000000..da58d867a5
--- /dev/null
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description=3D'reference transaction hooks'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir -p .git/hooks &&
+	test_commit PRE &&
+	test_commit POST &&
+	POST_OID=3D$(git rev-parse POST)
+'
+
+test_expect_success 'hook allows updating ref if successful' '
+	test_when_finished "rm .git/hooks/reference-transaction" &&
+	git reset --hard PRE &&
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+	EOF
+	cat >expect <<-EOF &&
+		prepared
+		committed
+	EOF
+	git update-ref HEAD POST &&
+	test_cmp expect actual
+'
+
+test_expect_success 'hook aborts updating ref in prepared state' '
+	test_when_finished "rm .git/hooks/reference-transaction" &&
+	git reset --hard PRE &&
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		if test "$1" =3D prepared
+		then
+			exit 1
+		fi
+	EOF
+	test_must_fail git update-ref HEAD POST 2>err &&
+	test_i18ngrep "ref updates aborted by hook" err
+'
+
+test_expect_success 'hook gets all queued updates in prepared state' '
+	test_when_finished "rm .git/hooks/reference-transaction actual" &&
+	git reset --hard PRE &&
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		if test "$1" =3D prepared
+		then
+			while read -r line
+			do
+				printf "%s\n" "$line"
+			done >actual
+		fi
+	EOF
+	cat >expect <<-EOF &&
+		$ZERO_OID $POST_OID HEAD
+		$ZERO_OID $POST_OID refs/heads/master
+	EOF
+	git update-ref HEAD POST <<-EOF &&
+		update HEAD $ZERO_OID $POST_OID
+		update refs/heads/master $ZERO_OID $POST_OID
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'hook gets all queued updates in committed state' '
+	test_when_finished "rm .git/hooks/reference-transaction actual" &&
+	git reset --hard PRE &&
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		if test "$1" =3D committed
+		then
+			while read -r line
+			do
+				printf "%s\n" "$line"
+			done >actual
+		fi
+	EOF
+	cat >expect <<-EOF &&
+		$ZERO_OID $POST_OID HEAD
+		$ZERO_OID $POST_OID refs/heads/master
+	EOF
+	git update-ref HEAD POST &&
+	test_cmp expect actual
+'
+
+test_expect_success 'hook gets all queued updates in aborted state' '
+	test_when_finished "rm .git/hooks/reference-transaction actual" &&
+	git reset --hard PRE &&
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		if test "$1" =3D aborted
+		then
+			while read -r line
+			do
+				printf "%s\n" "$line"
+			done >actual
+		fi
+	EOF
+	cat >expect <<-EOF &&
+		$ZERO_OID $POST_OID HEAD
+		$ZERO_OID $POST_OID refs/heads/master
+	EOF
+	git update-ref --stdin <<-EOF &&
+		start
+		update HEAD POST $ZERO_OID
+		update refs/heads/master POST $ZERO_OID
+		abort
+	EOF
+	test_cmp expect actual
+'
+
+test_done
--=20
2.27.0


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7Xl0YACgkQVbJhu7ck
PpQIgA//eDFyUp6ukLhRZVqyCT66iW/hfde/BTrvSgdNHPuf+zyZCjVuF+oNR5b9
kDda/wl/QyDGwD95O0pnH4+raXB1LO3DiB39QGE/kBdQ9GVJjBZJ6kIrMWkIs//m
QZEfFzSVyAubQNXsKqmVJ5zEmkFmBkOJzqDe52zkR8CeoEaP4K72J8c2Y9N4RgbJ
b7fybxYyWK1YrZFxAs2Pqr5DHEcolewFhpWRiW04IRhiUn5Uy3n48MJOARDH0SFA
m9vpJeWsU7dyaOpWGzSyOxugsS20A+8mFbiSSfS+KOMIlXDXZXxP53ISr0HogKJq
zLpqVv1pCfqwIRZHTLl5B3nKOgUzQGP53WCLv7u2UEyaCgCZIStzZiZUhYJ9crjK
fStq7HCMs0JxdXzmnwQ7H3HkGWuHwNMCI8KWQXiPOtR6AMCBbhfw7VDmLuTTmwxM
Xqer3IfFB98olA+fQqlsdte+NqbsxIrgi/4WHWBuqQn1m1uJPWsmVmGUC5PL+Ha7
xdWQ8Kb51Xjsv97AEL8+6hpjX3clT+dLJfDZkk9MhRobN9qrlhGluvufgKw39LHl
vM8UvcAljgjS5LUQ/7Xa+bnVSAraYxImljzjpm6DbLLIzjYyGJh1zRVo2Q2ijG6V
kmC3OP83cKwLX2NoMe0+kEsdyOQpi31kyWo5uVK8bZO0qF+KZ6A=
=o0KI
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
