Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4DD27E
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994226; cv=none; b=JMLhOZg/uPGiW11nZsUn4n5qf6wBiAlKFH7md4zXSvw35+zPyBJv/LPFNwGtsSxEwbIRvQfPnFJo6xGRf9b8u/UoAVzNJhlvrif9+ANH2h40EyVrdexR4LNqhPqyRZO/Is28ZiynBe50NBv7XezUkUKGeLj61D21OEGplgGc09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994226; c=relaxed/simple;
	bh=tDR9JFim0LClpZsZxMCCthAfKMhELCinZ/M/wMjfr7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPKRquKTAUKHxFl8XNwzmYYymGHDgLFeAS5LcAwiOT/6aWnf3jyRUGK436k6Ax5XAYs/EzEbxwvd49OFoWI/ASkIiN8ECM3Cf6u6J24mHKEs39PEFKJarIRanBfituq21Qsp+xYwiq/hRJJVPWekRJhsr5orIpwsXs7KoJTL7KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=i6fRYGUE; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="i6fRYGUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767994222; x=1768599022; i=l.s.r@web.de;
	bh=msAE8uIcIEYBW0bFbTJmwvAaycsNFXo44Ehx/jQjcx0=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i6fRYGUE8nomE33WFuXn3TIrniEBBcQlz2r1rlyhdjJkd/KEZ54aGLom30MyW5vQ
	 YSPY6X1/hByB7OhJ8W4JXiNgT5ncLF98hx9kUq714kwC0P0lhF5c3suo4BTYQg1k/
	 AMjUejRqxHf4vKV+pNvKcd4XqXwmrEogXHJbxISaOZ8p7RCkD9gy6q+sMvYs7lsnb
	 QJ7XZRjrN0lGc9UZtrS2IG611fJJdZlott4FANH4yq7I4hY51+Wnmc8eBrS2SNAWf
	 AtlWvVDIFe9J3nUk7UMXT6A+EdxZ6aN89WcEMH6DwlKdi9A0hk6kyOQkDcym5wJ37
	 WkeEFy/9zRclNRTGpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.19.215]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MSqXM-1vHgIK1nyg-00JxCQ for <git@vger.kernel.org>; Fri, 09 Jan 2026 22:30:22
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 03/10] add-interactive: use repo_parse_tree_indirect()
Date: Fri,  9 Jan 2026 22:30:14 +0100
Message-ID: <20260109213021.2546-4-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109213021.2546-1-l.s.r@web.de>
References: <20260109213021.2546-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GtLwbRiAVmo48dQ+w5HYseo/F95iUt9QXiKTjUOzD19HS9Nr76G
 AvckRIr1E/d0Fy1ser8a7VAc2Ar/xLNqLlQ9rTIlFqUjA3l5yl9GWFGIoXIQw6dCmSuZ1cG
 dfZmZEIct9ppVtCd7oJfNZIUVp3N22bNyWB+13O/LO059aWkgRt/LVwluwaTfAmf+7NtTbv
 SD87CvA3cq5Q/LGm3jsvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o6+F7lz8fEg=;eQlwbLg/vqMkdgNdn9yvvmDmeJd
 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

1b374ad71f (add-interactive: stop using `the_repository`, 2024-12-17)
replaced explicit uses of the_repository.  parse_tree_indirect() uses it
internally, though, so call repo_parse_tree_indirect() instead and hand
it the correct repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 68fc09547dd..95ec5a89f8c 100644
=2D-- a/add-interactive.c
+++ b/add-interactive.c
@@ -840,7 +840,7 @@ static int run_revert(struct add_i_state *s, const str=
uct pathspec *ps,
 	if (is_initial)
 		oidcpy(&oid, s->r->hash_algo->empty_tree);
 	else {
-		tree =3D parse_tree_indirect(&oid);
+		tree =3D repo_parse_tree_indirect(s->r, &oid);
 		if (!tree) {
 			res =3D error(_("Could not parse HEAD^{tree}"));
 			goto finish_revert;
=2D-=20
2.52.0

