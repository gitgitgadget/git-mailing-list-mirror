Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F1C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiAGK4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 05:56:14 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35861 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237912AbiAGK4N (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 05:56:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 809565C01C7;
        Fri,  7 Jan 2022 05:56:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 07 Jan 2022 05:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0BIcQm7swH/D1hQJgDW7QUQJ8yN
        ROvDnL14CQ21FUMk=; b=QBSUTbQg2F9qCN6TgiRdim/CZvei107xUL+jijd888X
        uZFtv4p174xxmlhuABGApiEjGJKqtaaGkZR0lPSysESkyQ47I8rjL8NqpQYV+qyM
        dyBLP2Dj2LRBciunvkdee8rF8lfmmCxYWmJ3xE87ORFITEiRKJ9faD4FNVCxQMzw
        ftIPngejZlwlx/5WBb8jEyvlWyvUMQgag5bCqDq1GR86AO2zWc0W3eVnkkcTJmyw
        j7VGl4oLttmdu8jWBxw+BdM7v58t6ClxkDmveaF1azMpGw6H7yc7eVgh4AOxt3/W
        fGH7M7EfhRb7/ymZFQmKeIFDQXELEzye8mSbyjmEJaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0BIcQm
        7swH/D1hQJgDW7QUQJ8yNROvDnL14CQ21FUMk=; b=CtBvnkdT+9AY7fWZFBjUhD
        iSRlq2nWMAqHOanBxgDBTX+dDAyd0a5G8Q7drgCvp3qqkXuLZRx3uEvnDEXCbpdl
        xVVGBjEehDO64oA2YFQZznzuRL71g8qaHL/E53RaTNS2yS73xPeaRi3Qj5JKmEyw
        ParLdbRB+RQplt8qnYVEekK9T6J9M6hp0qATyCRGdLmFxfVKuxAo2ShIy2Fh2+jl
        u7JoGjOc4m883H6+84gpsf1PjZ6ENGIe6FBc27lQnHGzUdiwSIxPEavVkDDK0mPH
        7x7+prembuT+mC+tdEIv5Rr/7ZJlXxDTUsuV5JRmwk4JEHlXUHeAE5JFvuQsdDxA
        ==
X-ME-Sender: <xms:TRzYYXmy8fazTULPEXiIk9u0OCJN8Lbvj6itYtFn1YWMtO-FKx4y3w>
    <xme:TRzYYa3PwwgYxwID5SNXhqFdL0dq5pvLxfzfHtLh1ajAd4U77cbPS5HHJKo3fzDOk
    NpS7wmeHfwBsfS-ww>
X-ME-Received: <xmr:TRzYYdoy0Rj_Sm8YJj8OhAvZXLenPzgTNQMvKMO7iW_1P7_y3HAohG6unAb70UYsPH8Vt-8dX3w42UV2edqcgkL4VUUEaNaqnGGZrU2bQHU7rdy3GAVfXGFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeguddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TRzYYfnunbZNw0jeyyPjmAbHTGe-eYaeP1dxHRn-Q5UD9UY3nPV8Mw>
    <xmx:TRzYYV06wh0y8aidhFAzmZB_XX5JZUKLZ_BdxYOODplc6jCyGvKS-w>
    <xmx:TRzYYesDxSAkysU4OPIIjRMu_dJkMwijAgnl5ARZ7W6lRB3AgJQIyA>
    <xmx:TRzYYS8RXAntXE95jdcm0Di6pzNb8i2wnuZEjGPlLX0zRE_eqdA6TA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 05:56:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 583f2c7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 10:56:11 +0000 (UTC)
Date:   Fri, 7 Jan 2022 11:55:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     iwiedler@gitlab.com
Subject: [PATCH 1/1] fetch: fix deadlock when cleaning up lockfiles in async
 signals
Message-ID: <555ec6717ecab0fe6ef5660bcf0d61d59f84ef8b.1641552500.git.ps@pks.im>
References: <cover.1641552500.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JUZn/g7LYJLmgxJ3"
Content-Disposition: inline
In-Reply-To: <cover.1641552500.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JUZn/g7LYJLmgxJ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Resend with the correct In-Reply-To header set to fix threading]

When fetching packfiles, we write a bunch of lockfiles for the packfiles
we're writing into the repository. In order to not leave behind any
cruft in case we exit or receive a signal, we register both an exit
handler as well as signal handlers for common signals like SIGINT. These
handlers will then unlink the locks and free the data structure tracking
them. We have observed a deadlock in this logic though:

    (gdb) bt
    #0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/low=
levellock.S:95
    #1  0x00007f4932bea2cd in _int_free (av=3D0x7f4932f2eb20 <main_arena>, =
p=3D0x3e3e4200, have_lock=3D0) at malloc.c:3969
    #2  0x00007f4932bee58c in __GI___libc_free (mem=3D<optimized out>) at m=
alloc.c:2975
    #3  0x0000000000662ab1 in string_list_clear ()
    #4  0x000000000044f5bc in unlock_pack_on_signal ()
    #5  <signal handler called>
    #6  _int_free (av=3D0x7f4932f2eb20 <main_arena>, p=3D<optimized out>, h=
ave_lock=3D0) at malloc.c:4024
    #7  0x00007f4932bee58c in __GI___libc_free (mem=3D<optimized out>) at m=
alloc.c:2975
    #8  0x000000000065afd5 in strbuf_release ()
    #9  0x000000000066ddb9 in delete_tempfile ()
    #10 0x0000000000610d0b in files_transaction_cleanup.isra ()
    #11 0x0000000000611718 in files_transaction_abort ()
    #12 0x000000000060d2ef in ref_transaction_abort ()
    #13 0x000000000060d441 in ref_transaction_prepare ()
    #14 0x000000000060e0b5 in ref_transaction_commit ()
    #15 0x00000000004511c2 in fetch_and_consume_refs ()
    #16 0x000000000045279a in cmd_fetch ()
    #17 0x0000000000407c48 in handle_builtin ()
    #18 0x0000000000408df2 in cmd_main ()
    #19 0x00000000004078b5 in main ()

The process was killed with a signal, which caused the signal handler to
kick in and try free the data structures after we have unlinked the
locks. It then deadlocks while calling free(3P).

The root cause of this is that it is not allowed to call certain
functions in async-signal handlers, as specified by signal-safety(7).
Next to most I/O functions, this list of disallowed functions also
includes memory-handling functions like malloc(3P) and free(3P) because
they may not be reentrant. As a result, if we execute such functions in
the signal handler, then they may operate on inconistent state and fail
in unexpected ways.

Fix this bug by not calling non-async-signal-safe functions when running
in the signal handler. We're about to re-raise the signal anyway and
will thus exit, so it's not much of a problem to keep the string list of
lockfiles untouched. Note that it's fine though to call unlink(2), so
we'll still clean up the lockfiles correctly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  2 +-
 builtin/fetch.c | 17 +++++++++++------
 transport.c     | 11 ++++++++---
 transport.h     | 14 +++++++++++++-
 4 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5bed37f8b5..585eef9b9a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1290,7 +1290,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	 */
 	submodule_progress =3D transport->progress;
=20
-	transport_unlock_pack(transport);
+	transport_unlock_pack(transport, 0);
 	transport_disconnect(transport);
=20
 	if (option_dissociate) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f1fe73a3e0..4bc04522ed 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -223,17 +223,22 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_END()
 };
=20
-static void unlock_pack(void)
+static void unlock_pack(unsigned int flags)
 {
 	if (gtransport)
-		transport_unlock_pack(gtransport);
+		transport_unlock_pack(gtransport, flags);
 	if (gsecondary)
-		transport_unlock_pack(gsecondary);
+		transport_unlock_pack(gsecondary, flags);
+}
+
+static void unlock_pack_atexit(void)
+{
+	unlock_pack(0);
 }
=20
 static void unlock_pack_on_signal(int signo)
 {
-	unlock_pack();
+	unlock_pack(TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
 	sigchain_pop(signo);
 	raise(signo);
 }
@@ -1329,7 +1334,7 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
 	trace2_region_leave("fetch", "consume_refs", the_repository);
=20
 out:
-	transport_unlock_pack(transport);
+	transport_unlock_pack(transport, 0);
 	return ret;
 }
=20
@@ -1978,7 +1983,7 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 		gtransport->server_options =3D &server_options;
=20
 	sigchain_push_common(unlock_pack_on_signal);
-	atexit(unlock_pack);
+	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
 	exit_code =3D do_fetch(gtransport, &rs);
 	sigchain_pop(SIGPIPE);
diff --git a/transport.c b/transport.c
index 92ab9a3fa6..2a3e324154 100644
--- a/transport.c
+++ b/transport.c
@@ -1456,13 +1456,18 @@ int transport_fetch_refs(struct transport *transpor=
t, struct ref *refs)
 	return rc;
 }
=20
-void transport_unlock_pack(struct transport *transport)
+void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
+	int in_signal_handler =3D !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HAND=
LER);
 	int i;
=20
 	for (i =3D 0; i < transport->pack_lockfiles.nr; i++)
-		unlink_or_warn(transport->pack_lockfiles.items[i].string);
-	string_list_clear(&transport->pack_lockfiles, 0);
+		if (in_signal_handler)
+			unlink(transport->pack_lockfiles.items[i].string);
+		else
+			unlink_or_warn(transport->pack_lockfiles.items[i].string);
+	if (!in_signal_handler)
+		string_list_clear(&transport->pack_lockfiles, 0);
 }
=20
 int transport_connect(struct transport *transport, const char *name,
diff --git a/transport.h b/transport.h
index 8bb4c8bbc8..3f16e50c19 100644
--- a/transport.h
+++ b/transport.h
@@ -279,7 +279,19 @@ const struct ref *transport_get_remote_refs(struct tra=
nsport *transport,
  */
 const struct git_hash_algo *transport_get_hash_algo(struct transport *tran=
sport);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
-void transport_unlock_pack(struct transport *transport);
+
+/*
+ * If this flag is set, unlocking will avoid to call non-async-signal-safe
+ * functions. This will necessarily leave behind some data structures which
+ * cannot be cleaned up.
+ */
+#define TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER (1 << 0)
+
+/*
+ * Unlock all packfiles locked by the transport.
+ */
+void transport_unlock_pack(struct transport *transport, unsigned int flags=
);
+
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
--=20
2.34.1


--JUZn/g7LYJLmgxJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYHDIACgkQVbJhu7ck
PpT0qg/+OysY3+cxM4oOs8CGrZ9aVhLSjQRkbFMCCMxTa7+I7tDU937NnrsF4FRz
/088YKmUwDdtJ8OwudLjivo6wXOY3/IdIVFuCdJt+aEkCb2uMpmMBe/UweBpx1DQ
RZLXnLSBZR9MRVlYlKVZGHbzOBaF5Ww0POQRaABVG2YHiFRpx9izCEJFvLU48/9J
UKf24V15CczaQimfBeK9NXAMV7PUOMxYiY234NsoqFVVJdS/97HjdXWonIxO1LvA
5CLEyPceif/Tx1YJhvtPpD0/IB2LGL6j+LbFB6HBJOA7BK1RwK4L2p+0pYuOQoCv
cj4TsfkfUhS5crfTWDwr5swrLLO2nteynOfTYlGUsQRTi7hnZiuWz6d8ZfFmElqo
Eswgdvn1tbUQYVCvsYhOobqqwmNLGCWFiqRvjnkrniN3Xv/qZPUTXXck4lRKTLGG
Dluyo8SUp2AhLk4BOE10n9u6HAYQ5Qum7PTg1Jc0K32OmVjGSM8H2DxoMvW7d8Fy
+GRUazhpPs9xQK3ZDYYLVVRqfDuqi2TKHP1X+Bkd/k43RD/SnvYVr4DqWtjyTkOR
D5RGvrDC3rIRzSif2vw8yHI5k2hIWMc5rMnCa24eBqUc+oBiru6W1DKpMgH78SsX
U50g8DTZlfsswbIDO17Bz1xP14DUGsEioiDYoJ3dchburNUIE98=
=KG0g
-----END PGP SIGNATURE-----

--JUZn/g7LYJLmgxJ3--
