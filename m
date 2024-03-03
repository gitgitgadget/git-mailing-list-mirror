Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12FC2FE
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709468404; cv=none; b=TiEMZ+fCQv/LzlRA/B+j25BsUQlfn1TQDxqX+v8/PDN9gxM6A9vlUiZs9ozZsYWGypZPAPdYwLDES9W1gl/lPezAAQdrx/X/SGB+1n72U3KHGt3vpzXQ+3vFvs3RrcOrz2wWOTFW7u46YdCOW8ZrGr7FTTFhK0nikROZIKTu+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709468404; c=relaxed/simple;
	bh=DWXSv1Oj582R4Wze3wpH416l7a/s8OuE9sb06gmmfaY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zte+lEtMrLjTIeZCVZCGJMiY+io/duz+YiWOnT1Qz1fzaA0adnEYmNzo9kLisW9RbraC7HaVPaHkqGc9Rrl0tLYigwrCj5YHHUfEh+I1hGQfRs3s5Y0W2JyFSqAsQtLXx8+Y/U8PL/w9DyY92I5KDYuUG3pFmD8RcskVVELFPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cinh0ZI8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cinh0ZI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709468393; x=1710073193; i=l.s.r@web.de;
	bh=DWXSv1Oj582R4Wze3wpH416l7a/s8OuE9sb06gmmfaY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=cinh0ZI8btqW9y75Wr2jEMkLoBRKOQsYM/osftJzmJp9ib7nGOIgi1XVqlIc0MoL
	 IJl9UFvXvfPgrXZm5rLogYk6tIFYGi3xR3wJWkJZ+yEUEaWC+5FYvlsc5SZlIRfUN
	 m92IpDHnxoASlHQdGtiLc1/A99RRMbh/ywC6vXjzDOZPZEWce/dfdTpMuBVi9ssxe
	 q6uUGgQVAvPxY4M9/tOruXfvS8Ydv5JrxaqPlTotVoIea05dF7DM5HZngSgt2fbd3
	 pQ/IfjpA0ynoEBhvFm0wYdv0Aud93+linNYs8lQ8oSB+naUnmcNlyAU4UEd/gF4Nq
	 ACrtYvv/WxURK6zKdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MLRYd-1rPuUU1Nat-00Ib1B for <git@vger.kernel.org>; Sun, 03 Mar 2024 13:19:53
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH v2 1/6] parse-options: recognize abbreviated negated option with arg
Date: Sun,  3 Mar 2024 13:19:38 +0100
Message-ID: <20240303121944.20627-2-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303121944.20627-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+FBaFes9b0SMA0fva+3H4nWvLv93R6+DpqcTEnYa8dkzTqXJ8CO
 X0a4ovcIGMtF+1vz9kAD4FcdB9fRB2XcliEfDBizz94ypM9+vS/vx6C01uIL5mqbKtKDbFF
 RHaM1e8f5gWT59YnWNEZdG6aLEqdYPVTfiszDCYTen8O3C0Lb0WJuHSPddwfytuH9Mj3url
 HLvvQdO5XNiW2bsPOmkVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IBjmkPtIcnA=;EwRl8nIh06vGLJvvDeH91MdDK6d
 U/p0+30wlhxzzxgUHgpsUDNUEtVcWkJOpxki/e4NT6+5MCvjbEilnFPTw5yQfmtrlR6xCMW9W
 j7C0TYTXWBOp82eZ8WIsT8byKuw8hxRCjbEIM+HRCPKSzQNPaWjfgpCAyFH9YJuCw/gqDQCET
 gKpNIru2TUTdtcB6G6usIl+95etnnaeXWxuyGdlf/1j9DGYYY6D69G32QKt0M46GMq/ZqHacn
 1coU7/9CJZ0xuethOTt7hjaSadCCtByQO1ayM7jv0f2decNzg0CUNdMRfvH04ZsWkHZXB6WsQ
 g5b0u/oA5wUWS6iPK+6FDY8Qq3Qni2WXFQIQ2pTWeZploqiEQJT1kTuj9FdoY1cAavvNeswys
 /41pHLlHlkdJJ79FLqAJ1HNNqse+KpBFK1lvwX4JlWkQZqfkc3U0uyn0PkFM6vqRAVSMBzrcl
 LGOu9BBzDwhpBANAlw6x29xlZi+bFWDOlfbWJYOZyokKCLcbDbkGzEmb1d+SpgP4oszvhnDmR
 DNKO3fTI8/6GcPx+L1j0/iym0/x7jlk+0R1mVq7rJ3PdEiPQwUU3Rj/fJ319I5bGv+txPg/Pv
 uUGtDh0J3yyXyRFawShDW9hf2nRdgQZOvCCX5yxkDERDq/C2hTPVIS3AJmg6HDTgKgmuZ2jjg
 bIW+ouCYwQcB59iXgs1HEjT+dYFOMWj4xc5/GrAInJc6ojhRl1b2Na+ROcq9karaDxhWlzh0x
 bw2yW4s144cF0MJrSwb7pIFLHgD3WhVx6QcnH0Xsdsx7/HqVkUTaiTVExH7LybS2Wl0gyodWX
 PwcyIxvAgfLv+aqI0PGoRDAeG8Xblo8QM1JNNQ62Mid5o=

Giving an argument to an option that doesn't take one causes Git to
report that error specifically:

   $ git rm --dry-run=3Dbogus
   error: option `dry-run' takes no value

The same is true when the option is negated or abbreviated:

   $ git rm --no-dry-run=3Dbogus
   error: option `no-dry-run' takes no value

   $ git rm --dry=3Dbogus
   error: option `dry-run' takes no value

Not so when doing both, though:

   $ git rm --no-dry=3Dbogus
   error: unknown option `no-dry=3Dbogus'
   usage: git rm [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]

(Rest of the usage message omitted.)

Improve consistency and usefulness of the error message by recognizing
abbreviated negated options even if they have a (most likely bogus)
argument.  With this patch we get:

   $ git rm --no-dry=3Dbogus
   error: option `no-dry-run' takes no value

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c          |  5 +++--
 t/t0040-parse-options.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 63a99dea6e..e4ce33ea48 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -391,7 +391,7 @@ static enum parse_opt_result parse_long_opt(
 					ambiguous_option =3D abbrev_option;
 					ambiguous_flags =3D abbrev_flags;
 				}
-				if (!(flags & OPT_UNSET) && *arg_end)
+				if (*arg_end)
 					p->opt =3D arg_end + 1;
 				abbrev_option =3D options;
 				abbrev_flags =3D flags ^ opt_flags;
@@ -412,7 +412,8 @@ static enum parse_opt_result parse_long_opt(
 			if (!skip_prefix(arg + 3, long_name, &rest)) {
 				/* abbreviated and negated? */
 				if (allow_abbrev &&
-				    starts_with(long_name, arg + 3))
+				    !strncmp(long_name, arg + 3,
+					     arg_end - arg - 3))
 					goto is_abbreviated;
 				else
 					continue;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ec974867e4..8bb2a8b453 100755
=2D-- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -210,6 +210,22 @@ test_expect_success 'superfluous value provided: bool=
ean' '
 	test_cmp expect actual
 '

+test_expect_success 'superfluous value provided: boolean, abbreviated' '
+	cat >expect <<-\EOF &&
+	error: option `yes'\'' takes no value
+	EOF
+	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfalse \
+	test-tool parse-options --ye=3Dhi 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	error: option `no-yes'\'' takes no value
+	EOF
+	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=3Dfalse \
+	test-tool parse-options --no-ye=3Dhi 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'superfluous value provided: cmdmode' '
 	cat >expect <<-\EOF &&
 	error: option `mode1'\'' takes no value
=2D-
2.44.0

