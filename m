Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070E332634
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052011; cv=none; b=s5XBZjd6wW0DyJXGpge7PX0mDxhCJEVTQU03WMXDZa2tbEP04W6IYN4WO5gDKL5OpdTxeQCRoAyXRHPIPsm8juRijjDIP06i51U6pRsYFtgtMJyS8mmtVfugYKPNuVYOfINQwis8cZFA/oYwfYTVi5F1SbDBg0TYqBhyPwIGqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052011; c=relaxed/simple;
	bh=RMfH+5wWlafCDRpoASUW9sHItYFnb/qqUg9LmbuoK0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofAaX4r1SZJBEzX0LgLoNftZ+l0B8V0760iPtMkJEkxqXz8tH4LR+77xZ7BZRS3x08tgke6XtVew1VF0f3KEZZ/KfVIvXJlS2D1fqsw+ZDD5oDLnD8yE/jcOuVelcN4apLKfddfyhujEkoa0waHYPP0fub2fsJ1udF3wgArz5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mwqXAr5u; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mwqXAr5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784052007; x=1784656807; i=l.s.r@web.de;
	bh=VOztkOwl79yqEm6adhw3f22su/n78jijCdh9DWt5gvE=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mwqXAr5u57CPAhTO7B9p/a2HsRdbshxNB0LTQd8u2J5UxSe4fxui8nWRPPpv37ik
	 Eg67Rz10xJyHjL18GmQ8qu08MiWb+iiXuP7Hfh4uLQs0dOELbS5alXszBhsbthS03
	 uQoOZeFkFmgU16P4VmzrhrQPp/c/VMxFpV6mJuh8rL9IsegaZGcNfy6fH0L1K8YYA
	 bHRh8ElPbGm73SsCREt/XN7Ralk8tonN2QbawoxLTtIv/iZR1PD0XyOlNvSqs9ew5
	 7urEd9tzIYnxxaoIcMkiLmTtFDfkn8qOck/y/9zeC28fYnwCg+cEwKkYihjdVlYD9
	 ikuZEKiZH/1021tCkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOV6-1wPG6H0B90-00PqlK for
 <git@vger.kernel.org>; Tue, 14 Jul 2026 20:00:07 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 2/5] refs/packed: use repo_create_tempfile()
Date: Tue, 14 Jul 2026 19:59:53 +0200
Message-ID: <20260714175956.54601-3-l.s.r@web.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714175956.54601-1-l.s.r@web.de>
References: <20260714175956.54601-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fzxthf97WxSw/SG0/EFijTFvxi0qrYddZEKeUN64chiz3Ec49ad
 mWi5vFWGe5Ti5EKUBrjsH7I0hs46ZD1sTc9Dz2gQ9o+ICZJuR6aEQMgoJ7FepF4HA0OhrTF
 86LDPUInqsxtcZFWqdkke75MkUS42H5A+a7/CJYa4/9KC0/drOhdjLFDYAmbiL5O1DLuz19
 dv7D/vlNA1LaMAA4qoI2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4dCEfBgRkvg=;mP0u/vFgE02QqAlag6789E9qBg7
 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
 9kHNxv017ioSSnZn5O16lAXEVbyu5A

Apply the config setting core.sharedRepository from the ref store base
repository at hand instead of from the_repository.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 refs/packed-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 499cb55dfa..7e65d9580e 100644
=2D-- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1393,7 +1393,7 @@ static enum ref_transaction_error write_with_updates=
(struct packed_ref_store *re
 	packed_refs_path =3D get_locked_file_path(&refs->lock);
 	strbuf_addf(&sb, "%s.new", packed_refs_path);
 	free(packed_refs_path);
-	refs->tempfile =3D create_tempfile(sb.buf);
+	refs->tempfile =3D repo_create_tempfile(refs->base.repo, sb.buf);
 	if (!refs->tempfile) {
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
=2D-=20
2.55.0

