Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824E61DFE5
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810288; cv=none; b=EgRLgiuvVRKXzkpT3Yuo+pjUqJctI+yF2pCCvN2/REBDUA0tU6fhEY44hp4lUIW4myzCvTOuo1GHsp+RInI6kWAPx/2lSLY6153g4dD7/4eLtDR+5UlgYLDCzlK7FbB1Sit93jmTmozZALvnfwOEbI2gRJDdjqcIDLk0WZOj2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810288; c=relaxed/simple;
	bh=tTi9OiaCdyb7jGOMfHR8PP9g/cVdTA2z5CpKid3x+68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c14FWpUu6QQEIKua0IIbD4kujmthXpE4LBCmxtcMJJ7bps0R6vvX/W0x+uRrtYSQS/eOzycLZY8/wzXqrDMVzX+NVxb5W0Fa1+Avtae9ot/FKp546DOYGIB1OVIOIr5y7Y/yi7BJEZiRREseVMGy3VvvRC9XNUbc1e4ixaYNt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=FPDO73UZ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="FPDO73UZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708810277; x=1709415077; i=l.s.r@web.de;
	bh=tTi9OiaCdyb7jGOMfHR8PP9g/cVdTA2z5CpKid3x+68=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=FPDO73UZJKNSoWvShuQcHvL2Wt6r6/2IGC4Bs7yHXVmjWn1iVIVybXVb2Joefoca
	 gfcydbbC4/UahmWxVBj0Y7orKZSNhm6sPp5ciQQzFCjfXyfjOs3CeESbtm1mg4UoX
	 tyj34QXeZsxGz5BSYcW3cLD2VpXd1dgx/LS9pdVpci/zcFk7XCusdUkOrmh1WtPIB
	 2D8NyXTrE4RMwwJZUB7nNnILxuj/8WAw/cnHc0BIxVHuVQS9hZQUQTGqF8FyaqKaR
	 eWfV8bAm54N5wNjijlNFZy+n3YiErhENtVru0Fp0dOKs2Xn8CYJhFlNWQedBG+MB5
	 5V+Z5TE86dOCaB2I6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.19.211]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MHmq2-1rivp50kAI-00EuCC for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:31:17
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 1/6] parse-options: recognize abbreviated negated option with arg
Date: Sat, 24 Feb 2024 22:29:48 +0100
Message-ID: <20240224212953.44026-2-l.s.r@web.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224212953.44026-1-l.s.r@web.de>
References: <20240224212953.44026-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0xNsPr0SfdfzTVIzT6aS2YLXIS5VdTK3YZqEMNDsIwFINKE/O1C
 l93ngNspKv9fiVtL9KEyCtY7wBf7DRYdC5mrju81jEhZcNK0lE7oa9/+8zG6WxljY/cQR3u
 Ju1T3pgwIHt3YuneEcnQ4/FZUYBgABXab9AsA9iP8kLvjegfgRV940uhG39v7/gmLTADodd
 WdG830z2UV8ewxa7+CWjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HeFCa/JL7mg=;WQAnXHJ/aLUCwt0QlP2oO65O32e
 Ny2ZcO8kHXAADMUe2WqCC/KveOGWPx0yRAs/aKUeV1Ew0zozWvXM7jknC77znCpVnudJ/oE4j
 vRi77uWAiosJusmAcF5vaz+Hz/UPMjTWpzsoLVNdNXHHRJDiv0da11Pct9C6LNONhzeTTYczD
 HB9FISX12FSvFrXlrPEdfsEMYfWx6UHvq2WhNgNH7PEEc3uobQlPo2mYj0MLbMSC4PPNxiGMw
 9toQpErIwl2vId2phbPQzYnRM11yXqJtfR/qYfli180IyOS/FsHWrMmQx5tR3++FPIINUxLco
 L8FsyGhEsnqJvzLVS7ZH6Vsoz/T0ToOg+f/cFAF+vgmSjbI9Kk9o5Vu6x3XITSdGl8+fWyYfV
 BOotKcTzVlWC+Y1wTM1UsOSVLtplfuToctV5m3+EW28ENmMSbcNkQ4OxVejLUCEkrVPoJ7hlj
 OnX8Vz0Tbp6VeOHa+7pZtStTWNT3yAseKyS65jJhgIVL44R6REFcZwfE/P6SJQh3u99AU/Dlk
 Jh6PbHjDuTsyJoyRI3x1rtCKMeRD0Zynw0x+I3AmyXFz63bLpuauuGsi3z6L08GJ33AvzTa4Y
 AqtCV9mx7Rsyyys3Sk+yToqnE6ykWbXeybcbdAXJIElgMAJ83xvUu41K1P8i8UyY2N0anlzWn
 ScQ7zGwlqui411Y+xNvOogZxstfWAiH7BmIa8VEmyROI/Dvmk14//zHTdict/XxCiLo1e1cZj
 SkO+QqHmXkm6OfJdXT+adjE5+tmW2OkjEP2AzuRGDB9iUIDbcgohBcrr6QvWUEB8+Q+CiqQUG
 GqrRX4oESZdOr8JVYSDNFmyzeYt7sJ4166uDtXhdOOmqw=

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

