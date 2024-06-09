Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C318C3D
	for <git@vger.kernel.org>; Sun,  9 Jun 2024 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918722; cv=none; b=lmOK7EZSoWdwnwTim/G5A5dFETWC8/dfz9TeJVSOtFT2lb5ptpYmsxK4EZTSfmzKy1/mY4HWz/TsdM2Ofd2UC7JdqRvTcgg5jBnm4tOuJF4Zv3vxgc19xwAzEheSiL5EN+jmO/mpgJEkhN/MEc0xxG6N+mEz924FX2SV2aJRmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918722; c=relaxed/simple;
	bh=0STcVmAPNNsn85GMwJVIiF216J3lKtbRFlSMLJ2cNu8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i7OTQ/A+wZI5sl19I8x7dbgRTzSn2Eizgusm+n9i4JBEujJHBLUT6LNpu14iXtByLQHsL3rCrzwiuOdLmOrPd3p8fM0zmDJfI5NtI0zYa6XKvLEebNZpgyFyfaWSlxjE7Udsn88Rz45bKHe1QVl/S7f0OXf8vKP4JhwBFvPsZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=m+rQYuZV; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="m+rQYuZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717918705; x=1718523505; i=l.s.r@web.de;
	bh=Bqt9Rg7hPRbBAzr4LAsNgx/ralLwMDpofq4Rnpicyy4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m+rQYuZVOg09aVjRtC5/t/XNvl7a/Xik/IC0tXNDC4w7obArxzGD5ePNi4ZEKy55
	 maN4Hwp5XEAihY0Lw99K/y+JbmbjYUu+w4/h1AxlAMrLIaVlKoIZ/1wFC8EX52NVO
	 RwwSmYgXR6gliX0pLiIbIJcVmWzy7YhKsu48kaVBuxnFoVh5hx9Gou2UyTYJVR6iq
	 GtXHe3VsJt2MzARy9TGzM1lQ9meoT+GbVTSXyXugfB5hzHa6WmcRr/fbxDLzC7bUJ
	 x1zZdQFK8598ATxLS8fOw9Ije899ejWBy0MMY6pCIOCOVLbkqmoYCkdnM+l/jTNDT
	 QBUVXCHCa++a4T7OPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnrh-1s0ST21oQz-00Qy1k; Sun, 09
 Jun 2024 09:38:25 +0200
Message-ID: <79a951f8-cf35-4159-a90e-f95d69773413@web.de>
Date: Sun, 9 Jun 2024 09:38:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/3] t4020: test exit code with external diffs
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Language: en-US
In-Reply-To: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j7JNx8eqHtolTuYE5hlPELhEc75L8vhlJyMmKuFwU/YcR4RBt35
 MF7TLiIkiUgduncNIjYLPTf7/PCvYVkgKoN92Hj4fxQbjoc3u9IqNZVG4U9AzOtj/GdVBSY
 iZoct3uto95nld9qDskDXNnEXla2R6NjTcbCEB6J/TNNFlCzS9p/YY41VSTuL8GgVwomZaZ
 3cWyFUe0bB2Pw2F0ba4pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Mmr9sZm+58=;HVgamukdEZXd4Sr1YRULz4vTYW/
 vxOetxIshsEMJnwfBca7ViiyU4BTZNf4Yo1PZFO+hafLC565GOkvkwyQ7egmIjrnqaDjhrnLZ
 Vc3ARbknYLg+ZI0qgxzuW6znGUIAyDNNhcmW8hieqjt80/dMhLgKuI5zfwVQSeFNFmX45Vu4q
 3QLTDo8vUZ5JHZdgiBdW6Mss8aUv9oQS6PEYradn1jRmZob7/0Kyz13VKoVSaORthZUTmsMBJ
 wdAIVpetdXCRbZcjJioarSaMPXkH8r1DXohVetou2iotptqYGnt1QImEpvM4RlTqruD3KslC1
 2kaebyPRog9CD57+mLoXvLQVTg0p2R6PdV5qYEKrLJ/i0rjdP/vfpGPL4iTd85NQLhqtNUo9r
 j5+M38grku+IIRtn+2XMH2x3iY2mycDm5WwNgyLM76j0kO3yduzL0BfpdM0YwzNK5ZD1VjqXe
 mCiTXBc5QtV7/l/lO8szoxa7GrQ4+QYV772pBJ3eHULRVx+wSGEm1W4xLdqpvqH5ZqlyBAQRH
 ou0iMBq0+gXZOMKBLbOLvcz2dOzgvEuWpG81WH29N8jIx9WKlRa+wjmWausaOyyxWpqlEl4sL
 +T41ps26JSFKycthiiVnPeL0tRkuFqCKaUK8HzN8g3hEG6BVdOFlMmYBzSIk56Cbe5/b0QkVi
 Q4/DM3eJL/38I+CEtXmetiZl3H2jDVHXQY6v1+HqIGlG1MbajcYNeJ/CoB5q+67YODnaqHmBv
 cNiFLTwTaxlSIHo8VU/op+gjZtJ+QQGLusivmrchFTvNrSA82QKuvX0cz7CWbCka4WX1aZ1qz
 g6T08OWW6BYradj31rpyWpbaPW/TJ5if56e0rjEMpxu4g=

Add tests to check the exit code of git diff with its options --quiet
and --exit-code when using an external diff program.  Currently we
cannot tell whether it found significant changes or not.

While at it, document briefly that --quiet turns off execution of
external diff programs because that behavior surprised me for a moment
while writing the tests.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/diff-options.txt |  1 +
 t/t4020-diff-external.sh       | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.t=
xt
index c7df20e571..6b73daf540 100644
=2D-- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -820,6 +820,7 @@ ifndef::git-log[]

 --quiet::
 	Disable all output of the program. Implies `--exit-code`.
+	Disables execution of external diff helpers.
 endif::git-log[]
 endif::git-format-patch[]

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index fdd865f7c3..4070523cdb 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -172,6 +172,59 @@ test_expect_success 'no diff with -diff' '
 	grep Binary out
 '

+check_external_diff () {
+	expect_code=3D$1
+	expect_out=3D$2
+	expect_err=3D$3
+	command_code=3D$4
+	shift 4
+	options=3D"$@"
+
+	command=3D"echo output; exit $command_code;"
+	desc=3D"external diff '$command'"
+	with_options=3D"${options:+ with }$options"
+
+	test_expect_success "$desc via attribute$with_options" "
+		test_config diff.foo.command \"$command\" &&
+		echo \"file diff=3Dfoo\" >.gitattributes &&
+		test_expect_code $expect_code git diff $options >out 2>err &&
+		test_cmp $expect_out out &&
+		test_cmp $expect_err err
+	"
+
+	test_expect_success "$desc via diff.external$with_options" "
+		test_config diff.external \"$command\" &&
+		>.gitattributes &&
+		test_expect_code $expect_code git diff $options >out 2>err &&
+		test_cmp $expect_out out &&
+		test_cmp $expect_err err
+	"
+
+	test_expect_success "$desc via GIT_EXTERNAL_DIFF$with_options" "
+		>.gitattributes &&
+		test_expect_code $expect_code env \
+			GIT_EXTERNAL_DIFF=3D\"$command\" \
+			git diff $options >out 2>err &&
+		test_cmp $expect_out out &&
+		test_cmp $expect_err err
+	"
+}
+
+test_expect_success 'setup output files' '
+	: >empty &&
+	echo output >output &&
+	echo "fatal: external diff died, stopping at file" >error
+'
+
+check_external_diff   0 output empty 0
+check_external_diff 128 output error 1
+
+check_external_diff   1 output empty 0 --exit-code
+check_external_diff 128 output error 1 --exit-code
+
+check_external_diff   1 empty  empty 0 --quiet
+check_external_diff   1 empty  empty 1 --quiet # we don't even call the p=
rogram
+
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file

 test_expect_success 'force diff with "diff"' '
=2D-
2.45.2
