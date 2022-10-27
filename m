Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792BAECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiJ0QfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiJ0QfU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:35:20 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737220356
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888503; bh=hUPIERufh2YPKYUYEFtjKEriqayeFlciFf3o4OX2rFY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=bmfjlte0CqG7bS41BGFIrw966KnPtoGqdXsNFwqhwmiNSa2OI6aDF3WFFKaL8UQXA
         o4aLiq86HtfrDqkGiAVx/dcAbcKDbBjWnj6oXv0CDsSLp0a1LwOwxxAhGs3od5G7cU
         /bwL2H4YCQOxYpbaEE/va/jyvSvVsOijQ1x9G8mixlRKpWkJ+aVtuJ4OWnwPZQleFD
         ByCxeMREXvRjcWuXwWxvfRRJ5wrpIZdxi/s5PY45pawRBzmMQlra+u6HAWaEnAA9Qa
         SgBqtS2bhkKrBVkqUcn25awrZuEsoGQjf/xCmX86tDAso3aAoSmqcUXdy3ZEkgFFXE
         biqxaulnN7Fkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1pX1V50w32-00jIOk; Thu, 27
 Oct 2022 18:35:03 +0200
Message-ID: <0cae80c0-2576-8be7-48f7-06a0a135961f@web.de>
Date:   Thu, 27 Oct 2022 18:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 1/8] merge: remove always-the-same "verbose" arguments
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:czNccu2pYPC9z9jMaMsxf9cE8wqZFFKj30Y9zigKufZyqM3vRnb
 FNk8il+LbHcHnGrBkHr4Br3bZfIih8mNumSxe+VdIw9Co0+P7//p0XDYcRkBHYXUH1n6mYI
 h5+kNdUS49gSyx6BGjd98ZhAYH/Xnf5g0qBzasreRKBsS7rGO1cCfH7ofJq9u0J4oujzo7D
 tp9BzryZTbUThhcUhrGVQ==
UI-OutboundReport: notjunk:1;M01:P0:6sgb3lW/tO4=;KmUKXCtaZDFyJ6ohgXpp/Gs+XEG
 9sdCVfQjqndBrv8fXrAFIMpvU6URbAWmPI0wRa68j30PETOsqMnyrwl/XHgEgIDK8dz6B+bsf
 QJ4X3Qp+dBHf6wCsKCBfcNgPhP1e01dSRTV7oeQKtsgDDLFHKp8xyAtfwM86QGJLJcKgm+eaz
 dmVE+XxZOUF78K9FkYG+j1p3x5zmi6ZDccp2gFkylYCgFU4EzmHWttruAPNfkr0c2TqGRiNvv
 h2rsiVcRSZwPA11O+gKT7bSqAkAkGuSpI5tFdn0LPgpAg8jB1wUEzCGqUAKRz7h1Cju74Z8rx
 C47nW8Yodb5E1hiFTRZGSbneAHABoZX0alOe+jsjZulgSPgvpf7qpp5l92pjG2GQgdFk9aMC4
 UBpCSjWyq90L0jBeVa4RuSBL8PldXfUYSVaF6UgBXQ5pq08mo1zQ1dIeADNKEUEgBQ9JO+gq+
 eR5nzaDUd7dF4NKKWEZc2DPdhzakgYS/PTto8LwVzTFExPie01BaNrQqQM0ieNXTKGHE+yzfk
 DZheALM/gDzjr5V6vfhsmsmEmADjpibNzw2uK0sEBHw707P7mo+71PXyiwqta3pOZSjCYilQn
 7AWpZHaC7MmRK4fNkb9tZjkC/LQ1UYZ3EWtj3Xt4cTjn5G1GMhz6YMo4Cvtvp8Jz+fVQkqIKk
 fH79K5NHIgNidHyOsfu23YfkJn8qBd4f3pApZAkvPG6uY+xgLiR2XCrP2zS4GWCyGfCCJQRHs
 EsKfTFkRPF+edOvvpnSJSbRx1FD4gCxZItMUTsJuQ/mrx6MbkvIMPHQGLGOdgXBLSMPdNukHd
 7w5qQJu4Q2mWMz0cXhSATwtC2w526vUWH//w5hh6f//AgyTxZp302T5F5UOmzaRaE0z5uW1ic
 uQhlnQz8zfy0oGIe4SzV9OrXxJxvGhi+43J2dPX7rlm8WX20yuzRr5GhI82YHLfZAznXmRQH0
 HVW3Fg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Simplify the code that builds the arguments for the "read-tree"
invocation in reset_hard() and read_empty() to remove the "verbose"
parameter.

Before 172b6428d06 (do not overwrite untracked during merge from
unborn branch, 2010-11-14) there was a "reset_hard()" function that
would be called in two places, one of those passed a "verbose=3D1", the
other a "verbose=3D0".

After 172b6428d06 when read_empty() was split off from reset_hard()
both of these functions only had one caller. The "verbose" in
read_empty() would always be false, and the one in reset_hard() would
always be true.

There was never a good reason for the code to act this way, it
happened because the read_empty() function was a copy/pasted and
adjusted version of reset_hard().

Since we're no longer conditionally adding the "-v" parameter
here (and we'd only add it for "reset_hard()" we'll be able to move to
a simpler and safer run-command API in the subsequent commit.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/merge.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729..3bb49d805b 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -345,14 +345,12 @@ static int save_state(struct object_id *stash)
 	return rc;
 }

-static void read_empty(const struct object_id *oid, int verbose)
+static void read_empty(const struct object_id *oid)
 {
 	int i =3D 0;
 	const char *args[7];

 	args[i++] =3D "read-tree";
-	if (verbose)
-		args[i++] =3D "-v";
 	args[i++] =3D "-m";
 	args[i++] =3D "-u";
 	args[i++] =3D empty_tree_oid_hex();
@@ -363,14 +361,13 @@ static void read_empty(const struct object_id *oid, =
int verbose)
 		die(_("read-tree failed"));
 }

-static void reset_hard(const struct object_id *oid, int verbose)
+static void reset_hard(const struct object_id *oid)
 {
 	int i =3D 0;
 	const char *args[6];

 	args[i++] =3D "read-tree";
-	if (verbose)
-		args[i++] =3D "-v";
+	args[i++] =3D "-v";
 	args[i++] =3D "--reset";
 	args[i++] =3D "-u";
 	args[i++] =3D oid_to_hex(oid);
@@ -385,7 +382,7 @@ static void restore_state(const struct object_id *head=
,
 {
 	struct strvec args =3D STRVEC_INIT;

-	reset_hard(head, 1);
+	reset_hard(head);

 	if (is_null_oid(stash))
 		goto refresh_cache;
@@ -1470,7 +1467,7 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 					       check_trust_level);

 		remote_head_oid =3D &remoteheads->item->object.oid;
-		read_empty(remote_head_oid, 0);
+		read_empty(remote_head_oid);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
=2D-
2.38.1
