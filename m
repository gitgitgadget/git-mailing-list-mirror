Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDD13C9A2
	for <git@vger.kernel.org>; Tue,  7 May 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071488; cv=none; b=iKmlojDwjbAhKVqoTx15TgkoknQbkMSvEUJipCJlBFGA5A4/HR4Q/2dj8E+4Yt9vRshacyUZuHB2g1fAPQaTnhYi76g9B2NcnnVUHXydxKrzphPgWuJJMpUbNoM/E8Qe5iNV1wXQY5Msk6ozsBPaTJydcqG3idXmvajd47VTgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071488; c=relaxed/simple;
	bh=itfteu97l2W9n7adGdZi3t/clHwO4IsL+6wECPQR7yM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHABu8XweE7wWbf1fP62EVmXErhMRUSu5gLl3xgd9WDoyn21Hpc02pqyjO/B32qTIO8UQn3ZfTgJE3eZKNDjtYPFO76yI9Eo9PR0VsBwBSybOJ8+3Ya/52wvjf/xgH6i0gCtRhe/Ex0RPK7lAapTvua9vkiixnP2rUDxSkJsYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=c4ZD/XnR; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="c4ZD/XnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715071471; x=1715676271; i=tboegi@web.de;
	bh=djAfIiMfIg6st+3j9m2+iiTkcmUFm9ki8K/6xTv8eGY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c4ZD/XnR1ZrY71a3eVPCHnbZIEwVTkqiVYxb3+8Z3BeGod9XHkKDJqtzJ8h0hPRs
	 /1/0mfeHoZG9+cOxunU5DpD6yxXPWrssG/tba5h48lNAhcQ2z8kdpv4R2URvO1LYN
	 60ETc2LF0r7BXe40/dKzMcsRVkNJrPfOCBDa5x+9NVz1pykny87to8qqF2qVUkCxK
	 IuvyC8+PzGLuixlSxxTEYzyTze1McPcjmh60KG8ME2+RcyvanfkXXlVysk+Cl7quk
	 QSCnMcG7j3vgPLuZxdiKKFDlSSMsUACCaY7htkRXrb+mKcomwDeZg4+F+nWQiHAjm
	 /0hA8l6kcIDq0gAp0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([213.65.201.17]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MYclj-1s8qz62GHb-00Vraf; Tue, 07 May 2024 10:44:31 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	takimoto-j@kba.biglobe.ne.jp
Subject: [PATCH v1 1/2] t0050: ls-files path fails if path of workdir is NFD
Date: Tue,  7 May 2024 10:44:29 +0200
Message-ID: <20240507084429.19781-1-tboegi@web.de>
X-Mailer: git-send-email 2.41.0.394.ge43f4fd0bd
In-Reply-To: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
References: <20240430032717281.IXLP.121462.mail.biglobe.ne.jp@biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDn3uBPap0W8bE+KOZ3mtP/MR9GJlfEfywC50VpWqHXRYEjjkhM
 0LUSMUXrT7MKLEMy9v0TJNWWQv1XW2uF/zUx10+OvEOlg7G1Pw4fkLTpqwgvJ7m2FtojW3L
 /p5EbpdzDwsoBACtw1jxP9AExxczcOfzTIFe+jlnIO/642mRj5GY1gilMopRvQQYpTVfuMJ
 /0Tay7GfPkZcyzovWiTfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qc7/DTtcYI0=;718VuhF7KkxXquhUFon9jW4AsyV
 xzNTcXzoj19bUHd1NCLEk4iEanFaFvwQXRxjMetWwI90ATjtHpXIlLSOjMgDERzyKa86me9wm
 J4mlfNRlDUJAgWlXZorzUW020s4Wio/Y3UcqRH74DcQD/sdurWtBWd3o1Au4oPcNJ6Xq5085U
 UouVNaF5Y8xdomWTP5NIiUcGyy1lp+NYGw96KL19oUKJhb5afW+V+Dnxh3EUHZ3qspaIAREmL
 WVXSG7RsylihgiajuLcyhMtuRnhhnnydPrN3Ks0fSJfItNv9jbQu1kRS/d8FFfv+X5lxMm4BH
 YNKOWuGt9gJxKZj79A4IOiUd0vOuqnuNCZua34Ofl+DM4fvtLLzMJQt/jFg05JyV6zlyGK/jm
 zLd9RwbPe+NN1YuAhp73PiTz8Th96Oj6ANyENrHOIWngd6PMdUfDG6u0Wl/MdSmHH7Pha+dn5
 O2FM3Rn4PuWMZSk83EZI+cjMVFTNghp9ijQ37/tV3zq7uK352MVHS7hfkbt2wqP9b7QLeChhQ
 awOONBO6O2JwwPpJ518ONvxwSBj5gAupNBEUiYEZlxAKIEyz0sYWfMPg+GR8KYryJGE/Mqiof
 GRbLzcbkS6wcOpRiAEmIl+2n3bw+ziEKAEjIfb2pvXRJ7hR1dajkY3jnbpmSHzRHDdpbMP4XQ
 V6onddDe5NdrYhXwdD55bus56dc29WVqiDZWlAQgjO/n/raQR4xqCfI4/LhPovcHQXKbCs6iU
 BSZ1pGlAOmoSaZp0Y6/Wk07Xa+9Ik0YCJ2y3F2o22oGdBfin9azpFn3heVEKGNYTK2ju1VlmH
 XjGPlOGY0pjDqagRu14tzseZnwHvBA+Huwm7Wgf4xz+Eg=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Add a test case for this bug report, slightly edited and shortened:

ls-files path' fails if absolute path of workdir contains NFD (macOS)
On macOS, 'git ls-files path' does not work (gives an error)
if the absolute 'path' contains characters in NFD (decomposed).
I guess this is a (minor) bug of git.

$ cd /somewhere         # some safe place, /tmp or ~/tmp etc.
$ mkdir $'u\xcc\x88'    # =C3=BC in NFD
$ cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
$ git init
$ git ls-files $'/somewhere/u\xcc\x88'   # NFD
  fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository at '=
/somewhere/=C3=BC'
$ git ls-files $'/somewhere/\xc3\xbc'    # NFC
(the same error as above)

In the 'fatal:' error message, there are three =C3=BC;
the 1st and 2nd are in NFC, the 3rd is in NFD.

The added test case here follows the error description,
with the exception that the '=C3=BC' is replaced by an '=C3=A4',
which we already have as NFD and NFC in t0050.
A fix will be done in the next commit.

Reported-by: Jun T <takimoto-j@kba.biglobe.ne.jp>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 t/t0050-filesystem.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 325eb1c3cd..bb85ec38cb 100755
=2D-- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -156,4 +156,16 @@ test_expect_success CASE_INSENSITIVE_FS 'checkout wit=
h no pathspec and a case in
 	)
 '

+test_expect_success 'git ls-files under NFD' '
+	(
+		mkdir somewhere &&
+		mkdir somewhere/$aumlcdiar &&
+		mypwd=3D$PWD &&
+		cd somewhere/$aumlcdiar &&
+		git init &&
+		git ls-files "$mypwd/somewhere/$aumlcdiar"  2>err &&
+		>expected &&
+		test_cmp expected err
+	)
+'
 test_done
=2D-
2.41.0.394.ge43f4fd0bd

