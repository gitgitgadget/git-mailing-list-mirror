Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E91946C7
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576534; cv=none; b=MV5q8s/gTT4kxgYS2p51zgITES0aP2Hfk62OINsdRwL0vv1VBp4lGIdGBqz9DmkOLG7RP0xwuTZNWAuoLTwM9lzo/taYUpnLNUIWmsJMro6sjz/kgjlS2dANUIdDdGM3AvcyTIjQsZ9YGYmKRLyPpGJo563ENKRFYvtuPBCZjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576534; c=relaxed/simple;
	bh=dsyN5fCxqGE9go73srEyefJqwbYPDZLxtundaBJxgLo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UqsSQ+aS1flwF901t5DTOSmsGrEDG4w2YfatMYarQO1ipv8MkXZmHOdVQHJKPqJ2/k4AgtRo3Tbhc5F+3esv5im0O9+aaviZmUc5v+00gjj/qc0wLfoLbUle5DCerggC93NelA7f/b85Bz9fkcd/pMqmUnaokhZwyyZJv97ql34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XU7E2HCB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XU7E2HCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717576524; x=1718181324; i=l.s.r@web.de;
	bh=Y7gbaiAH7UJlV+PURwqCIRBWzErcVOnUGltLLVfsIGI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XU7E2HCBZZiRjYpCLl2BrolcCXvgvXv/H82EblEUQ/e6ymLWqTwOlF5cXwyykrIS
	 ZQeymVwZyo6x46JsD3t3HGMoFHRHYavFcTLK1wc71uIjTQq2eS7dkVUfYj8eSAxof
	 OVxo7+R/akmqFNzsANHaBGjFb7icsKZZBPzslEDihyw+5SGF5Y7+/U3tOEf57rQEc
	 RfYG3H9dL48XnYMRWAWcdETd4PT/PldR2ab/3zyP58fE/6rpKD/RamK7YJYdniHLI
	 pB9Ya92vTUt8O05gUDRym0k8ze0NMFdkhSS4CBH6WV5kHW1HBM9paNjrjQSp/Swgg
	 /K8A2IrKQhWMU+9ubw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1ruknr32ZD-00WpPj; Wed, 05
 Jun 2024 10:35:24 +0200
Message-ID: <2a5167fc-871b-4968-bacb-eaff4d7a2630@web.de>
Date: Wed, 5 Jun 2024 10:35:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] t4020: test exit code with external diffs
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Content-Language: en-US
In-Reply-To: <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZDFvw8cw+zVRKV5Bx2+A8MlR25Y/vEuC3hcPv2dn7CzsCFcjLFy
 40QG08wG1KIv8MmQxYSI4KMmw7RrGMiSbFueP9DGl6oKZMXOZyNBgR7m2uWfzrBEMFv54HY
 wAvsO/D6YaIyzcZU8jBxllA4oZijUOZE2dNCkwc2MBBIJMGPfM23U7n9BRr0Fco+H/pjHyj
 gC4bRZosQ+ORuHwDr5sVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sUhjQOCR0kY=;CQ7DLwEIQOGdAdBGxfffpcUy+pi
 F2fiRyzMWLyfz5O311EoQiyKAwlkbPe3/G4FmLf9LsxX6N4oLnh7OZrA1OodJ2BDCiJxyBU2u
 ALBjRNrda4O2MXmM5tTK0adrC23QCYwH5xmB1E62h+XNMof/GbAkRkHkQOvd8QJYnE/b79i+g
 er4xxYUQK+5wd3NfgqqrR6OQV0Bpzxv1OFOgBf9TocsQLrfcb4PljOSiTtCml3w2Wljzz3EAr
 jIMa+FjJfTSy35MAwd7N9Vv/+19UcFvkYNsWuI05JGQVQHuhTFwy7tZ1DtgjF1mwgxobNufdG
 st+vXDM9oiATu+8IJaSlkdCjqzJkFnlu5+OP3p3V+fIVMVWCy2h9CtbhIvd3/fs6COFIbCHOR
 MMXzpbxt1goCwvQACUyCXd36lLMgwix77rSkMPvoaaO0oD6QmBGxRUABmmZeY9LNfBNrkWnil
 rXmoQ9G6MFUymBf1kRyK6DkJS3t7ZTBUzXXizXWnh8h3Oy7AbyEyfFEYcgV0F7xjmUDz2fBOA
 N3hoOVfg0g1G3bzQdXexC3A86EFkZP+J2e6ne5SlwBgVhKVXPs/zyqr5QDdURtq3BG66azpTd
 nXY4Mu7mG6Z/lK0Je5X6sAEDize+qs49aMeXG5kl/+/9tHMJpO6WPPcNkwH4tbbld/IC7HsPt
 FEM+M2VSfQ/BNwT/z+g35DCHOMlV2qzgDoqAIwlZSo7INXpBQk7nvF6Hz1fwu+oLSF9Zcjqtz
 TiqiN8W1tuD2YNc8hQVkDSNpl9zevmdYwK3LZxMuUQWtzOLctbD4pOAMJyZZnKfUQiKhTr0Jl
 EGansV4HjP971tPMPoB1Sx5hqb98z7VbvSyvFeh5saUdw=

Add tests to check the exit code of git diff with its options --quiet
and --exit-code when using an external diff program.  Currently we
cannot tell whether it found significant changes or not.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4020-diff-external.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index fdd865f7c3..bed640b2b1 100755
=2D-- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -172,6 +172,39 @@ test_expect_success 'no diff with -diff' '
 	grep Binary out
 '

+check_external_exit_code () {
+	expect_code=3D$1
+	command_code=3D$2
+	option=3D$3
+
+	command=3D"exit $command_code;"
+	desc=3D"external diff '$command'"
+
+	test_expect_success "$desc via attribute with $option" "
+		test_config diff.foo.command \"$command\" &&
+		echo \"file diff=3Dfoo\" >.gitattributes &&
+		test_expect_code $expect_code git diff $option
+	"
+
+	test_expect_success "$desc via diff.external with $option" "
+		test_config diff.external \"$command\" &&
+		>.gitattributes &&
+		test_expect_code $expect_code git diff $option
+	"
+
+	test_expect_success "$desc via GIT_EXTERNAL_DIFF with $option" "
+		>.gitattributes &&
+		test_expect_code $expect_code env \
+			GIT_EXTERNAL_DIFF=3D\"$command\" \
+			git diff $option
+	"
+}
+
+check_external_exit_code   1 0 --exit-code
+check_external_exit_code   1 0 --quiet
+check_external_exit_code 128 1 --exit-code
+check_external_exit_code   1 1 --quiet # we don't even call the program
+
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file

 test_expect_success 'force diff with "diff"' '
=2D-
2.45.2
