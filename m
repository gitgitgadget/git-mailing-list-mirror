Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8310423A77
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218606; cv=none; b=c/ZOM2sUomR0FsTfvYvUlS/hOBWDw+UICE2iRDBMXf+I8NQmlZ99ovUepondFgNv/GAR5xvFnwZW1QsfHpF6ZNoUjXmQdK43b4s16CHZ692/ybsO5M/MrTojxe+oObZd+kNhSqtZGIHrrv0qkM5X1GyyD6SBaMxMx2Vi+cyT1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218606; c=relaxed/simple;
	bh=ulOW63tYmvhBSS5vaNU1xn1Gwxs8FeI+HAeCMZjfAqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DPzqRYJY2woFqxFOkLfWiRrakg+Y5b5UDQVq7FFB4WVM0rykdU0NVdRQUN9m2/pEhVXpIigIguFSfNFle3iYB891KXo/DunhfHvu78//s6bom5XrKBljcRqimWxaBh5Oi9rtYx4Np20d5CjkRBzhUNwMPpGdFB88gv8KYBXbhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfK2milD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfK2milD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA79C4CEF7;
	Wed,  4 Feb 2026 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770218606;
	bh=ulOW63tYmvhBSS5vaNU1xn1Gwxs8FeI+HAeCMZjfAqA=;
	h=From:To:Cc:Subject:Date:From;
	b=mfK2milD/D8fGGJRU5Pdm0Ol6b7DljaTqV1xUUpvdOvXbxolrkv6U2EkGV5MK6dgX
	 Ja6tyeLEWF3vXMKtxjiZRVNrrLjma7ifH97geffhp94utnyICbmiRpu+tWTQjH1yYR
	 afkzyUth5Fko7TsGWrUqgydt/1KdNj1hZG4aGXwNk1bhmop7gpyl/RGST8vdi3r/Hs
	 5dPbpzPQ+lFNUX2WGv1up8JFAOWBj9401jMjc7xIyEAWbIQDhnv1yZdFZudpLICgBD
	 H+WHmIu1c+gKSDziLmbKRVFsB7LIh/4RjawdGa5YcbbzCnSguyzyRDaluC/6upMFKD
	 voN3yXQSNj6uQ==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: git@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Neal H. Walfield" <neal@walfield.org>
Subject: [PATCH v1] gpg-interface: Signatures by expired keys are fine
Date: Wed,  4 Feb 2026 16:23:06 +0100
Message-ID: <20260204152306.1767112-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711; i=ukleinek@kernel.org; h=from:subject; bh=ulOW63tYmvhBSS5vaNU1xn1Gwxs8FeI+HAeCMZjfAqA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpg2RaJjNsosOnRQBn7b5Fhqk4MOpX6sOlK6akx O03UiKdD56JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYNkWgAKCRCPgPtYfRL+ Tg+nCAC0da8jc54NHOIJvOb2pYMk8uoe8n/Xu8pcyLsSnDbDxqpPooSBILrKHwFuYdBRkyrT/Ou EeooIKZSg5ZXKSQFfuSPtrly61O+VmtZrAlTTD7euACwkHEV1Mtlro2WYgkRuZcOsm10JgjcUht xeUaG/caYbPzLB+DwvJt3WaI/63FOigow4hnJYF5dX33Ef3JhQHiiFmWWQRPoKAuab1m7qJWMJt R0qU0Kidjx60QVtx8JIgCG8hznCR2RvyghjCB2+ARNxb2Wa6vpCrq4FBvhNv47bK9MSMv2HrpuL +/TLXVYE45OagHtHul4mwVw8ms2DmNrS0KXGFgtW51CLakhG
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If a signature is done with a valid key and that key later expires, the
signature should still be considered good.

GnuPG exmits in this case something like:

	[GNUPG:] NEWSIG
	gpg: Signature made Wed 26 Nov 2014 05:56:50 AM CET
	gpg:                using RSA key FE3958F9067BC667
	[GNUPG:] KEYEXPIRED 1478449622
	[GNUPG:] KEY_CONSIDERED D783920D6D4F0C06AA4C25F3FE3958F9067BC667 0
	[GNUPG:] KEYEXPIRED 1478449622
	[GNUPG:] SIG_ID 8tAN3Fx6XB2NAoH5U8neoguQ9MI 2014-11-26 1416977810
	[GNUPG:] EXPKEYSIG FE3958F9067BC667 Jason Cooper <jason@lakedaemon.net>
	gpg: Good signature from "Jason Cooper <jason@lakedaemon.net>" [expired]
	[GNUPG:] VALIDSIG D783920D6D4F0C06AA4C25F3FE3958F9067BC667 2014-11-26 1416977810 0 4 0 1 2 00 D783920D6D4F0C06AA4C25F3FE3958F9067BC667
	gpg: Note: This key has expired!
	      D783920D6D4F0C06AA4C25F3FE3958F9067BC667

(signature and signed data in this example is taken from Linux commit
756f80cee766574ae282baa97fdcf9cc). So GnuPG is relaxed and the fact that
the key is expired is only worth a "Note" which is weaker than e.g.

	gpg: WARNING: The key's User ID is not certified with a trusted signature!
	gpg:          There is no indication that the signature belongs to the owner.

which git still considers ok.

So stop coloring the signature by an expired key red and handle it like
any other good signature.

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
Hello,

the motivation for this patch originates from a mail correspondence with Linus Torvalds,
see
https://lore.kernel.org/ksummit/CAHC9VhRwMpSCphW_FsHojX1r12D5MOMUBm6MAzpGYD_FDjEVtA@mail.gmail.com/T/#m6cc3cc4b599658cab6012326993a1261fd641046
for the details.

Best regards
Uwe

 gpg-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 47222bf31b6e..6635c6c8e16f 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -382,7 +382,7 @@ static int verify_gpg_signed_buffer(struct signature_check *sigc,
 
 	delete_tempfile(&temp);
 
-	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
+	ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ") && !strstr(gpg_stdout.buf, "\n[GNUPG:] EXPKEYSIG ");
 	sigc->output = strbuf_detach(&gpg_stderr, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_stdout, NULL);
 
@@ -680,7 +680,7 @@ int check_signature(struct signature_check *sigc,
 	if (status && !sigc->output)
 		return !!status;
 
-	status |= sigc->result != 'G';
+	status |= sigc->result != 'G' && sigc->result != 'Y';
 	status |= sigc->trust_level < configured_min_trust_level;
 
 	return !!status;

base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
-- 
2.47.3

