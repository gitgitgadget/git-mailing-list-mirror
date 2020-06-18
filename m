Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547DC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761012166E
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r/yGyIkh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owQnmccA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgFRK1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:27:47 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49525 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729148AbgFRK1X (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Jun 2020 06:27:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 13FEA6BD;
        Thu, 18 Jun 2020 06:27:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 18 Jun 2020 06:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=tS/Lqd0kZ90Kc7iXtZXcOtKshVT
        5nX1RtAaK6Cgv7tk=; b=r/yGyIkh6+iOAskwkLFYw56JxiZTsUFK+av84hOsHTH
        VhzzkucRKUtcrPbjlnOohM8mMoup01Dp0HOJ2s5Eoho1VOhi/xMaStUWcjIfFDV4
        9Yev5oQFhoo5kQlpUJSYp87zYGmGA9E4kWlEKrIu8BEMFvCnmJ41YJrPqVFE7EW3
        QLbyrB6kmweLVLQJKxngWhaUNzkeTaueBi4G+hcDeB71i4pnXRK/yOsBy8CFBRez
        VoZgd+MFh0DujZC9p3oF2SEFCLBU9D0MvjDTgY7e3d/cJaEuejl37rIvT1yGJi0F
        B4rCb5as0p422b4EApHEbHINdaHL3swxydRO1mFR5TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tS/Lqd
        0kZ90Kc7iXtZXcOtKshVT5nX1RtAaK6Cgv7tk=; b=owQnmccADMzooT/4O/w2MI
        8tC2u5mA9vMep4VlhcR+H6XRMIHQM0XVTixTOZe+I5GaXuYdnW0hqWlEHLAk6XdF
        P8awJFZsmZzjZosJNpAH7DEd1kp9IDnlwzTNAZAFofrMNBAJzMnAalTfAIneLgpO
        7ZAKpnnhJnxXogv2g0IAT0UlK+U0lc8DYdHhabOXCKTHz+1hBgmaXGP9yMLT8td9
        /5bSzpr7C6a0300kIpjpNBn4daKe+eO7ORSsLvv5R4TmqxX8LrMALXwqi5gNZahW
        /D/h7O8406pAaE2ygVPrxP0L46c22Lu3khY7M2PC13CqNwDVof5WAAQcgRoR6WeQ
        ==
X-ME-Sender: <xms:gUHrXsfFxhpt8oEpYIFLR4cpSxklY5ddNKP--o1xLk7McOmYkP2uXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejgedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudefrddufedriedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:gUHrXuMbvSlbeoEtUiRYMKh02g6-G4I_lRt8gnR9tvm0NotKymz7qg>
    <xmx:gUHrXtgpNzOLkIKezPBlIndURqkNO4gVb5O2vWQu3_9Wq4VEA7rEDg>
    <xmx:gUHrXh9NGIZYGpRjX4bhBO5Vht7kGWRmsLh1cey5vBlqxzJGXivGRw>
    <xmx:gUHrXu2pnjnLkenlxOPMX6oOU5XSyBsoPEV5p3WnNhohlLSRCuO4QQ>
Received: from vm-mail.pks.im (x4d0d0d3e.dyn.telefonica.de [77.13.13.62])
        by mail.messagingengine.com (Postfix) with ESMTPA id 865B4328005A;
        Thu, 18 Jun 2020 06:27:12 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id cd0db994 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 18 Jun 2020 10:27:08 +0000 (UTC)
Date:   Thu, 18 Jun 2020 12:27:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3] refs: implement reference transaction hook
Message-ID: <1de96b96e3448c8f7e7974f7c082fd08d2d14e96.1592475610.git.ps@pks.im>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--T4sUOijqQbZv57TR
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
introduce two new performance tests for git-update-refs(1). Run against
an empty repository, it produces the following results:

  Test                         origin/master     HEAD
  --------------------------------------------------------------------
  1400.2: update-ref           2.70(2.10+0.71)   2.71(2.10+0.73) +0.4%
  1400.3: update-ref --stdin   0.21(0.09+0.11)   0.21(0.07+0.14) +0.0%

The performance test p1400.2 creates, updates and deletes a branch a
thousand times, thus averaging runtime of git-update-refs over 3000
invocations. p1400.3 instead calls `git-update-refs --stdin` three times
and queues a thousand creations, updates and deletes respectively.

As expected, p1400.3 consistently shows no noticeable impact, as for
each batch of updates there's a single call to access(3P) for the
negative hook lookup. On the other hand, for p1400.2, one can see an
impact caused by this patchset. But doing five runs of the performance
tests where each one was run with GIT_PERF_REPEAT_COUNT=3D10, the overhead
ranged from -1.5% to +1.1%. These inconsistent performance numbers can
be explained by the overhead of spawning 3000 processes. This shows that
the overhead of assembling the hook path and executing access(3P) once
to check if it's there is mostly outweighed by the operating system's
overhead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

There's two changes compared to v2:

    1. I've added lookup cache for the hook that both caches the
       positive as well as the negative lookup of this hook. It's
       specific to the reference-transaction hook, only, and will simply
       store the path to the found hook or a sentinel value in case it
       wasn't found. Like this, we avoid one of the two calls to
       access(3P) when executing git-update-ref(1). This improved
       performance into the range where variance between runs drowns out
       the impact of the single access(3P) call.

    2. I've amend a second benchmark to p1400, where one tests single
       invocations of git-update-ref and the second one uses batched
       invocations via its --stdin switch. The latter doesn't show any
       impact, while the former one ranged from an overhead of -1.5% to
       +1.1%.

I did have a look at integrating this work with Emily's work, but I
don't really think it necessary given that benchmarks show that the
overhead of the access(3P) call is drowned out by the OS anyway. If you
feel differently, I may revisit it and perform some benchmarks on top of
her work.

Patrick

 Documentation/githooks.txt       |  29 ++++++++
 refs.c                           |  79 +++++++++++++++++++++-
 t/perf/p1400-update-ref.sh       |  32 +++++++++
 t/t1416-ref-transaction-hooks.sh | 109 +++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+), 2 deletions(-)
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
index 224ff66c7b..c4961f4ad9 100644
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
@@ -1986,10 +1988,68 @@ int ref_update_reject_duplicates(struct string_list=
 *refnames,
 	return 0;
 }
=20
+static const char hook_not_found;
+static const char *hook;
+
+static int run_transaction_hook(struct ref_transaction *transaction,
+				const char *state)
+{
+	struct child_process proc =3D CHILD_PROCESS_INIT;
+	struct strbuf buf =3D STRBUF_INIT;
+	int saved_errno =3D 0, ret, i;
+
+	if (hook =3D=3D &hook_not_found)
+		return 0;
+	if (!hook)
+		hook =3D find_hook("reference-transaction");
+	if (!hook) {
+		hook =3D &hook_not_found;
+		return 0;
+	}
+
+	argv_array_pushl(&proc.args, hook, state, NULL);
+	proc.in =3D -1;
+	proc.stdout_to_stderr =3D 1;
+	proc.trace2_hook_name =3D "reference-transaction";
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
@@ -2012,7 +2072,17 @@ int ref_transaction_prepare(struct ref_transaction *=
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
@@ -2036,6 +2106,8 @@ int ref_transaction_abort(struct ref_transaction *tra=
nsaction,
 		break;
 	}
=20
+	run_transaction_hook(transaction, "aborted");
+
 	ref_transaction_free(transaction);
 	return ret;
 }
@@ -2064,7 +2136,10 @@ int ref_transaction_commit(struct ref_transaction *t=
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
index 0000000000..d275a81248
--- /dev/null
+++ b/t/perf/p1400-update-ref.sh
@@ -0,0 +1,32 @@
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
+	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
+	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
+	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete
+'
+
+test_perf "update-ref" '
+	for i in $(test_seq 1000)
+	do
+		git update-ref refs/heads/branch PRE &&
+		git update-ref refs/heads/branch POST PRE &&
+		git update-ref -d refs/heads/branch
+	done
+'
+
+test_perf "update-ref --stdin" '
+	git update-ref --stdin <create &&
+	git update-ref --stdin <update &&
+	git update-ref --stdin <delete
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


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7rQZ4ACgkQVbJhu7ck
PpT+KQ/8DfZ0tzSf6Wx9Sc+ua1Lo/c9yBU5Pk7be7yvW/DM49YdPozs6nHZqO3uj
F2VZEfb0137GzqTSpVwQgJMSNyRFtutuaSZnKu8F3MyOma7tOzl8/FBBGUCaY2mo
4qF29nw7k8BwucTpc04viXH+hf5ms23I9H620In/4d+6mLcYFdvo6VSGQh69N64r
K1lOOTyd6xjopNYUzatbVnJL+3hDtuOg5GiIKrT/ya8IxedfDdEUQ5utBnNCGu/H
uYTaSeOORymA2dcYJcgN6JXPdy22FZS8U1rnsX0hR1H6pOBIk+98L9zUOoPRfw1F
ttY2wCpWACR/4nPFUk7Cu4q3pqSeyFYGHpN9RPv3EIVKFKjhF/D26RDjFWV3Z4bZ
ljMzemb3eV0JhBqrqhHZwamC5iJr2DdBXobAsLE4NQlTTlKJcMDfpQgbufcsYS1/
9Hcb3t9Mc6e49NQB4jaYnvuq85crRi+BwWUxJbu7VPKcSRb5xA652TqlJp/15o9e
oeaets+0ch6ypzKBgFFFvSoqJithLJ0Qd8a85JcA5+WgPwiSg2JyEZLxwzei5mus
CUbwzMZxn+ZefekVPI2w95Cq9ll9udW/piV7RFBFWxzd/qpzNAW6p1+y2sQVVnKO
pJY0f7zDlf26NZXLCymApPgv2xLHH3cLnsOPUcfeIhPwab3/cm8=
=IsVJ
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
