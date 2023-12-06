Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Oy6Qxg0+"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB782695
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863536; x=1702468336; i=l.s.r@web.de;
	bh=MgY8AnrtULKrhNi/5xQfrcBwgq4tGWjiO4zFtcsRquI=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=Oy6Qxg0+IeA8+NWLjW8i2M21eyQiRApV1SF27UQwloR3wU+snwrg68RtQkR3nC7m
	 PHIVsvl5fpbr5XwJ0vZqlUVJ+jCtWiEa8uiqnRMLaNjXpEsZ0n64N7iFIRGKo2Pxc
	 e/7JZjETk8CPeai7H0vlNiSUSIVWFzkI2NuOGgCngULRGGqemQOKlvO3mMlWhNkl8
	 2SZ2DWL9vsZs5KKDQgFf7cgJXWPwXq3giphOVakErgcF4m42aF2wu4bQbRYJ0f7ln
	 gGuv8DSzOAboHgDTyPVFIng0Hqg7nOZ2kK7YN/4CBTQr7G4Bsx7EPMr8Lnq9OqQ8Z
	 5ehJRtAPaWCE8JJbXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1Ml4B4-1reex22I60-00lTiP for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:16
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 2/7] repack: use die_for_incompatible_opt3() for -A/-k/--cruft
Date: Wed,  6 Dec 2023 12:51:56 +0100
Message-ID: <20231206115215.94467-3-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H6FEy+PKOlySeQPAbkO01xQ1OZzLUijXUY2dVl9krw9fa7rrrPV
 54XkG/RSY0gSd07kDdKnRsRc38+chBiqK4I3Tdj90SmdSinQDf7BpnrBWXqmvVoo8r+j5XW
 GIDabja3GLTi9CVkrSxxT+5KziJo5E8OdFBQpGpGeOoopM9O0K2USD+7UkxyZNfO09Qe14s
 yBNkfdrS6O6XWRsqo72gw==
UI-OutboundReport: notjunk:1;M01:P0:OE0HOpX42rc=;E1+UuiKpkXqoKki98yp7w0KnjGT
 enOERYAO5gH0SdwDQydIvoMNJT0J8JUezRtr4YFmv2ofopqLUXpnYNNWR1Idnwyioeqz3uQnp
 cH/c5cgijgYoap/0YOWestyuouDnMr+8JzOz6fDFTOexaJ5qrzZPGxTja5/KEcyAP3dEq0zJp
 /FtnTdV5OWdefrWm+hpZ+9Jz6XfXMG0tYY3Xj5AHMei4Vfz8N1JqEE8Z6HHweutux3yhtckna
 XtrxBKNwI9nKm+xTUVuNlCPGwHchxmoldDB0t5m756oUFxn7u4sBeDavDIHc57htWjIzwj5++
 pxO8JaajzYi7/pTaE7OC0dvJmqO+BUqfslRjB1ShmSYqe/izesxW1DSsS1ejzvGwp2i4OH599
 4XMR1UW24av15a2IrXzr31DUhSlnFt0eZwW7YmNg/o47rqds7qcFMg9RRcWyUk3Xb3/p7TCHx
 o5SJiGJHsRm64YHl+3v52+dR+i49T6XmPv45nwPlIumcbljb/FD27wFX/2MLRyJo7DYQDD8T9
 +An0EmECNo9IIw4zuY8S3BcnOZBRBMKkxMdFts98fttccPD0sTCNPuJ1jv/Sc9VR0ufSm9EHp
 8Pj07a7w2gE5+P8ChtfjQWRwg1kzPRodxomtzedlXTtPFIX56fjvnoQqHhOKrOn9bK+Q0x7Tc
 A36NebTo5tvsZNG83ntMwbYGty8Amk4CNhtWusSRzPVNmbR+tnUHyvbtsFGD6MbPbNQjvM9Gp
 6SmShJUykC8j6fA/mgUWs0yKCBVvH6hN7DWfiSPEv6jHxt3NYB2mVnGZhm2kJwtVlf/d9rRMn
 VbZTtg9XBZnrNl4WAicC+0kyD9gujd0/kXCwy7FKoWXGpeh9TgLpECGKPbixVkqomcZTU8PyO
 8HtnZD6IqlL6i4GfavbHBjkVqCuGKTy9wxFIYmnkEY5jymGwMclkihLZHbXyleO9dSnvrpSFX
 yVbQcQ==

The repack option --keep-unreachable is incompatible with -A, --cruft is
incompatible with -A and -k, and -k is short for --keep-unreachable.  So
they are all incompatible with each other.

Use the function for checking three mutually incompatible options,
die_for_incompatible_opt3(), to perform this check in one place and
without repetition.  This is shorter and clearer.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/repack.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index edaee4dbec..c54777bbe5 100644
=2D-- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1203,19 +1203,13 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
 	if (delete_redundant && repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));

-	if (keep_unreachable &&
-	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
-		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreach=
able", "-A");
+	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSE=
N_UNREACHABLE), "-A",
+				  keep_unreachable, "-k/--keep-unreachable",
+				  pack_everything & PACK_CRUFT, "--cruft");

-	if (pack_everything & PACK_CRUFT) {
+	if (pack_everything & PACK_CRUFT)
 		pack_everything |=3D ALL_INTO_ONE;

-		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
-			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-A=
");
-		if (keep_unreachable)
-			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k=
");
-	}
-
 	if (write_bitmaps < 0) {
 		if (!write_midx &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
=2D-
2.43.0

