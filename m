Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A713AA3E
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540000; cv=none; b=EUc9dKWGjB8j4EEw97SGlc3HxpQchwgfalYaBt/IuhdH4VtwZn1c28Ul8E9Xw80aEkCQ0YDguerHTYVAF3woJLy4ZUkbOwg2hJI6ibH9d8Av6q+EOe48CGWulKwxnK/7Uc/RDejMnxRvqPow1eYGELAFbtS4HEw3pf9CsmZq4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540000; c=relaxed/simple;
	bh=GWJzC2Zmomd0kuO0o6WzJJwzYsb++WjLJT1bChK31pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZKmpI1Ye0rhs13Fijfn1CvcAlbHu71+NT3ojQuZh4pcKIEL9jJF6lYmAeOFIDngTdq2umGfDo5V9q1aLkaMRtFmx+K3LR+AEWxnGCc+gk6W0EzwlI5r/OcIyg48NS+td+iO4aTsu5mlXMRMDCEQvASqCqn62qvdm0YDD3PM1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=rs3qsEdl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="rs3qsEdl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723539992; x=1724144792;
	i=oswald.buddenhagen@gmx.de;
	bh=9yyP2BMYo0HoMp6T5XV0pxm8WGy60+EU5crmHaCtNe0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rs3qsEdlyGSXN6W97tsKgsO5sSaN1FhC14ZYoLIt9qeAa6Sq9rDdH7gGM0JrQABS
	 Ape8HhTfyqHFp7ZJy/Rnqn8z4OW5BTo7zU3SrteTzZVVwh4UPB8/wbv6wxJ0fNYzm
	 BbFhUXYfmZgx1HRuiDhQVRATc8A4vmLkWUZH7jTYmFuBCOHcZGuloO5N/pdHzMtPD
	 uAQMxp+oLFeP3LcuCAhs/E25c9JyQxRyE0yDHKmJ1+CnWdnbPlpMsXoWyNipzfjyU
	 CitfspmVbXUqSlHynWJYdfDzzeh6fBUd6RVX851byuW3K7r/PqIA72PM3K8KagI6X
	 R52srvLRsnE/DVnRfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1sVnH83jZF-00Cikt; Tue, 13
 Aug 2024 11:06:31 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1sdnU7-klK-00; Tue, 13 Aug 2024 11:06:31 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Brian Lyles <brianmlyles@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Sean Allred <allred.sean@gmail.com>
Subject: [PATCH 2/2] git-gui: strip commit messages less aggressively
Date: Tue, 13 Aug 2024 11:06:31 +0200
Message-ID: <20240813090631.1133049-3-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.46.0.180.gb23db42a00
In-Reply-To: <20240813090631.1133049-1-oswald.buddenhagen@gmx.de>
References: <20240813090631.1133049-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MfD6jc0iy/WUyXmNgEJFSs5vUHWXdBBFpii32duq9Ewvy9OOuZk
 HMoU4klLp+ZDl0BOL/BR1TPStWztUnTNfdCM1tc8DkDeRUJ2X40z+n9ybnQtExwECeA9vRL
 qinQCGzfeVWJ/shrhjHqgG3N85wnVD2FLN4h/PKzWWqNbp5ytsRevTEVI3IrjKjBcdAaHDd
 Lz6nuF9OoKMK1MCP1GEkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EmPMlE1uKas=;XV4mvGLNMPsgmWKH9o4f71aeqbv
 yRKEM60xZUOqtoScYVLlm+HdTtB6Ertka91zUJs6hL8DpUso1wu/3t1Z/M+tq0zU7LkvBcila
 T5Lp3yXi0ZtQBZ9fccaglhkJ8wKMDxF38uOPfvN8hKBYGSqYKEWZTYtAnKPdcUFCOso9oL/is
 QTxsBlpfjGIw5hNDb5+c68kZfh4oB4D0wIQK1b/AcnCRyZzgo7bD5i+7nFp4UwYK7v973pFcd
 c58zs89ABfDL13G44wkM+Pn1PiMNmigc1x9kxIjVgGl5W9Rh8KRPs79k6Lsa96YYwNwyaHMto
 FvChDHNhZlqMCH2XCKokVwNuFYKA6MAI5WcFO7kc+FXhLCT2Ilddcyaf6CJTGtUuLLrdE1HNA
 kg/FaY9/9Jz4nqfmNd241zBY7zIN9o5LxdNGZSeXfdh12hIj951w6zt0SzBPeSRp5mmVeQ2Y+
 AGA/yzBtuyxYPrU8l4/6S5cgZAIeCvqaRFLLHtzdAnWcuv9b43wAVqpEnmUGmc4JlPHbi3TYo
 Nwh/wLPrQDWzVyk1uvzanwZwDJm2jjRZ4QE4DxOi0gZkwwSFx0Du1/w5GpuNCqY8UWrDEpBSe
 Vw7kreJOumhRarl16bm8JGVEAzDvn5GfvEekBkzMCDcwCIU1fblOZ7rZdLJ7xORlDZ/DXXxAp
 XZJF35s2tMCsgTMDjraGT3sGBENCJw9fgzC6g8K+wV2OgJXFZOZafLrRsNGPQxFiOcPTSO7gU
 I7oqHInyEtM6r5Dd3uW75Eddj9N/gljVNFv1cJNQrAIDHhIjkhmkM2NQBPlYN/5AfSmfSBUS6
 eqccIEHoqiHnNJJshErhzpALXhahngUsT6MDnQXT523BI=

We would strip all leading and trailing whitespace, which git commit
does not. Let's be consistent here.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---

Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Brian Lyles <brianmlyles@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sean Allred <allred.sean@gmail.com>
---
 git-gui/lib/commit.tcl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index f00a634624..208dc2817c 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -207,12 +207,17 @@ You must stage at least 1 file before you can commit.
=20
 	# -- A message is required.
 	#
-	set msg [string trim [$ui_comm get 1.0 end]]
+	set msg [$ui_comm get 1.0 end]
+	# Strip trailing whitespace
 	regsub -all -line {[ \t\r]+$} $msg {} msg
 	# Strip comment lines
 	regsub -all {(^|\n)#[^\n]*} $msg {\1} msg
+	# Strip leading empty lines
+	regsub {^\n*} $msg {} msg
 	# Compress consecutive empty lines
 	regsub -all {\n{3,}} $msg "\n\n" msg
+	# Strip trailing empty line
+	regsub {\n\n$} $msg "\n" msg
 	if {$msg eq {}} {
 		error_popup [mc "Please supply a commit message.
=20
--=20
2.46.0.180.gb23db42a00

