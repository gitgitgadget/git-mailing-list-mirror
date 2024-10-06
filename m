Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9A15445E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728190796; cv=none; b=uUlaOwzi7mEV3Uct5Eq3mDRs45vKY3mYek1jZ5bpPKszgVzvNMpTfNmo2xfahZ79fzK3zhZQ5b3o33k4ZBnhjI05DXlRTP0T8xjj50k5+wHaIGCmYkqGlU5zHmrPPVITebsE2l8Kpdjr1/usfb74yIHL0Udgl8baOKSxo16YaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728190796; c=relaxed/simple;
	bh=6Jkn26ug4PZcwLl20rUSpHW4YQvWFjt0D5m5E05KBNA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsknLtjmRAiPowHaErzzXAaPqK20sMWpWDVEbNJy1vremxKbFwZkLsVtHJ2Zz5Mh05Kshg5yo6m0WVkI972m69paNqPQMkKzUOH7q0YZWUAms1XywuU285REjrm/vi7DcHhurk4AdvBerfdwqk/mPZS6rNtuPlwX5/gHTHQavOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qucwIajd; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qucwIajd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728190792; x=1728449992;
	bh=VO3cE1mQtj7EIcy0XaY67UddJ5EYYmLKdrKvx+59c+o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qucwIajdRumjHjFJtDOwD+F7+63u6xL6TaYe+VUtKrqW0ahJwLNTNrbUy6qbKyMDm
	 X5bnzyY5ipg7430USQ33KLMs0NK75zplySXmnIwyYvcmT3trnnQP28Bv5BYqdlcoD4
	 AUv5YiooVvrHEP+XDntdbOis0e6FJ1+42SH6zKUSHlL6SmJ0ikSn+u+XkMeBsMp5uS
	 xrfmtFhfScEGFWotzxhJ5XbbB6KUUCMNe8T0w5bQ1MjUO1GGP3fJ6/U8ZBszCLPqys
	 zPpNSnfXwVmIwzW8hegxmvAL/hTUuvI+KhmULzMJNgCSmaAuwDWpfyj7hJjZShVcrE
	 fbu6YUHRX5dHQ==
Date: Sun, 06 Oct 2024 04:59:46 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 4/4] worktree: prevent null pointer dereference
Message-ID: <20241006045847.159937-5-cdwhite3@pm.me>
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
References: <20241006045847.159937-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4eacb72576bdc8722ec7f22093b04281aedc0ef6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------5cd6a39075b722c0fbd5325f6bf847d952433d0c49c2128ef2a601d6d7894a87"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5cd6a39075b722c0fbd5325f6bf847d952433d0c49c2128ef2a601d6d7894a87
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 4/4] worktree: prevent null pointer dereference
Date: Sat,  5 Oct 2024 23:58:42 -0500
Message-ID: <20241006045847.159937-5-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
References: <20241006045847.159937-1-cdwhite3@pm.me>
MIME-Version: 1.0

If worktrees is NULL, free_worktrees() should return immediately to
prevent a null pointer dereference.

Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 worktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index b08ecce..1cf15b0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -28,8 +28,9 @@ void free_worktree(struct worktree *worktree)
 
 void free_worktrees(struct worktree **worktrees)
 {
-	int i = 0;
-	for (i = 0; worktrees[i]; i++)
+	if  (!worktrees)
+		return;
+	for (int i = 0; worktrees[i]; i++)
 		free_worktree(worktrees[i]);
 	free (worktrees);
 }
-- 
2.46.2


--------5cd6a39075b722c0fbd5325f6bf847d952433d0c49c2128ef2a601d6d7894a87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAhlACRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAAbYQf+PbHjC7WfOHPWbmBQYN3EAGxdeeH+/DTVixzY7VxmN/M2G1hr
DyKyGNQl5+fX7idJqy7nXZDYmaAbYQcq7G2VkR2kwGTCbn/NsOkbiFT7A3Xm
VNVFs/317cxXN/xm25cOrhymeOPP8BT/5meKEtba1JGSqgHIbZcGTAboFBoq
EGEotGQD/Uaircs7q46Yml6eWJP2bGreOt83ONvQa5xvTFXAY993abYrgtL3
SzIz3kONzd08hNydvel6hOV7Xzu6k25j5GMwr6rIRF2FoA3zEXxXUi++44MZ
DbwSMN2vr4TNsddPHKYB99cmk+wnI2ISPx+D6lFXtJi8/1HuxhDnJA==
=ho3k
-----END PGP SIGNATURE-----


--------5cd6a39075b722c0fbd5325f6bf847d952433d0c49c2128ef2a601d6d7894a87--

