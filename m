Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A655C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 06:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5709120885
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 06:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="suHGNx/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o5035bae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgFSGz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:55:59 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36309 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgFSGz7 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 02:55:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BACD475A;
        Fri, 19 Jun 2020 02:55:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Jun 2020 02:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=yKJUVb1T60f5M5fQyqkXEZcr6GU
        TUyLwytE1izRj/tY=; b=suHGNx/JmdzBKbZL1MEPMm7mFeNTkPngY9/JSliZ6SY
        WCGLTzqsCwnHGuvbrUQwAmhjMDF8VsmVBzO8E4m/6m7U5NQBcBOALDvoxsrZVyia
        uW8CNiUXNO7oKi55c8vuiajQ0AWmhFC+IamqxS7gRkcB5ty0FGk1rT1Ny61uIDNm
        piXC570uFG3Zt5JzAn0ObYswCDKstgPh11lDD8JbwJ5lhhnAzdrRIoBwW45742o/
        yFRMx2Bdl0/mvaayMBNvifY3doHmkxGCbGJcH6XDyR+6ATkt6gusbRUlRDuXjAYS
        YVBRm2PlHGXKQ/yFxe9cHNl9gJ58iD3Zct4qVRyRlnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yKJUVb
        1T60f5M5fQyqkXEZcr6GUTUyLwytE1izRj/tY=; b=o5035baeVITRqWqTw31k3G
        VrP0IIJ1NBrFTR8xlbHytgtat3hrShlMfeB2uQ1L0NhZaNozAlTHkViWzJnAGE4/
        VsvdPx4lanej92qKUMBjZ5p1mMly+NVyqyzi9M3LrsXCaM9QCebgtvoGikVIhTIJ
        X+gQWj1bEjXasJQSoUhM62W5vAdE3gf+MXZK8bukcMdpCwpOGpLNWEN3YgFnYfPD
        nNxYqlleVx4UsyAWZs9PzKSSUbPHzG6l5fkDBDJ4y8sM+Dxrc1eIyNI4sam0LImp
        a+fkYLeQFEWJtvVtBn1YrR+N+oq5dwOQGr4AvffrrjHwM4WQjMAhe/JVE3YgB2/A
        ==
X-ME-Sender: <xms:fGHsXoRxFfQd7nxW_lAoBt__bzhEZuqZRNvcZeJajd176H2XK5kA1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejhedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrkeehrdehleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:fGHsXlwJxJafs9KMGqVhdsb7sGGpGZ4vMR6I4pdy-yhzeMm5QFuyHQ>
    <xmx:fGHsXl38ELLpT4GPPuVqWqR4CvDhEZveJ0QnsUEJETzDFIUtJmsjRw>
    <xmx:fGHsXsBtlqRn_aKitfjVQcOT0WrNCRqtaJQpfIpjwW8QIRxb93AHwA>
    <xmx:fWHsXhJorOVFawFJLf6Bq4nkzEHkfDrMCprsjpKirNwW0CQKKQdWBg>
Received: from vm-mail.pks.im (x590c553b.dyn.telefonica.de [89.12.85.59])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD460328005A;
        Fri, 19 Jun 2020 02:55:55 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0f3993bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 19 Jun 2020 06:55:51 +0000 (UTC)
Date:   Fri, 19 Jun 2020 08:56:14 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4] refs: implement reference transaction hook
Message-ID: <55c58e9b09691dc11dea911f26424594fb3922c9.1592549570.git.ps@pks.im>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--17pEHd4RhPHOinZp
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

The only change was simplified error handling as proposed by Junio.
Thanks for your feedback, the result definitely looks easier to read to
me.

Range-diff against v3:
1:  1de96b96e3 ! 1:  55c58e9b09 refs: implement reference transaction hook
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refname=
s,
     +{
     +	struct child_process proc =3D CHILD_PROCESS_INIT;
     +	struct strbuf buf =3D STRBUF_INIT;
    -+	int saved_errno =3D 0, ret, i;
    ++	int ret =3D 0, i;
     +
     +	if (hook =3D=3D &hook_not_found)
    -+		return 0;
    ++		return ret;
     +	if (!hook)
     +		hook =3D find_hook("reference-transaction");
     +	if (!hook) {
     +		hook =3D &hook_not_found;
    -+		return 0;
    ++		return ret;
     +	}
     +
     +	argv_array_pushl(&proc.args, hook, state, NULL);
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refname=
s,
     +
     +		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
     +			if (errno !=3D EPIPE)
    -+				saved_errno =3D errno;
    ++				ret =3D -1;
     +			break;
     +		}
     +	}
    @@ refs.c: int ref_update_reject_duplicates(struct string_list *refname=
s,
     +	sigchain_pop(SIGPIPE);
     +	strbuf_release(&buf);
     +
    -+	ret =3D finish_command(&proc);
    -+	if (ret)
    -+		return ret;
    -+
    -+	return saved_errno;
    ++	ret |=3D finish_command(&proc);
    ++	return ret;
     +}
     +
      int ref_transaction_prepare(struct ref_transaction *transaction,

 Documentation/githooks.txt       |  29 ++++++++
 refs.c                           |  76 ++++++++++++++++++++-
 t/perf/p1400-update-ref.sh       |  32 +++++++++
 t/t1416-ref-transaction-hooks.sh | 109 +++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 2 deletions(-)
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
index 224ff66c7b..f05295f503 100644
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
@@ -1986,10 +1988,65 @@ int ref_update_reject_duplicates(struct string_list=
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
+	int ret =3D 0, i;
+
+	if (hook =3D=3D &hook_not_found)
+		return ret;
+	if (!hook)
+		hook =3D find_hook("reference-transaction");
+	if (!hook) {
+		hook =3D &hook_not_found;
+		return ret;
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
+				ret =3D -1;
+			break;
+		}
+	}
+
+	close(proc.in);
+	sigchain_pop(SIGPIPE);
+	strbuf_release(&buf);
+
+	ret |=3D finish_command(&proc);
+	return ret;
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
@@ -2012,7 +2069,17 @@ int ref_transaction_prepare(struct ref_transaction *=
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
@@ -2036,6 +2103,8 @@ int ref_transaction_abort(struct ref_transaction *tra=
nsaction,
 		break;
 	}
=20
+	run_transaction_hook(transaction, "aborted");
+
 	ref_transaction_free(transaction);
 	return ret;
 }
@@ -2064,7 +2133,10 @@ int ref_transaction_commit(struct ref_transaction *t=
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


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7sYY0ACgkQVbJhu7ck
PpQk9g//ZRT7DSzDtEtrBG//LhDuWgaDGPF+kqT3w5FVaAU98Tm9bDUzAIY9K0NT
tiRD0shuY74C8fDgFPgLK9zWMvkxvXh4a4FQg+cofrsZmnF5FnW82d2fBA+Uw1y/
PmcMrhid2uDMvuUV1VX/gytTfppRBVCEGvq4V26Ryg70wS2O02ysgvSAwYnM5C41
oLODUiDodYiG7akntRLEFY7kF0ap9i17ql2q5OEaV9UHutPYdObJX8of94tCaFwm
ZTTbR1kW/W+lSvzm0bIczSLaRF5sb+LcBSHIwnuA/8e8xs/ScL0DkcREjqw5N1//
VaiXVrMkXXkvuFQuH2EZ8cgUX+60bYaGHlJvTTlLfnQym6PbRiMqCnpLT47z6c3x
6ozGTGJmvo25zGWtc1brqmVQSWOa5U7oiBiJq05kDD5n7ALyy0gjDLSfMBMpJhtE
bFpDZ0F4EHzdvoa/D3zrC82XdqABFMqPFfyqfyeaq4hFr4nx0rrzK2fKe9OnlCAz
KeFTDMEPxax/MGyXDgDmpp2LvZjXnqB8u7PP9DrwFEHBluTGcRAc8mVOB0862qRn
rqGZHl2ORUrg4q1JlShBoTQFWa5GUD8BWSbJUFc56BXADhLCXmiU0MVhORH5q+dE
cFhw/nsT0ZHwXcD0bZlkVh1p0KHNwk4b6jgBoRSzMCvKT0URY9U=
=G/Gt
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
