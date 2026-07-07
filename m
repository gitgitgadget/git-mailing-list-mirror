Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B32FF641
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424353; cv=none; b=TCgV0MXDKYzXDVkeTb3/ufmzNc1P/6zqYO9IV4DzEk69PTJOtq7R3R9EgPuBVDrGYA/Umz1uvK+08hnyoZ+gQrahDRAyM/s4njIm+4JHRueZEW6tDBcPakLF/3MLx/N4y4tLciqQCbMPhrPPVdyET5txyYFFUZZJGSwDSMSE2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424353; c=relaxed/simple;
	bh=DnwMUjioPV4ndF9GpV47YW9qL/to2HKs6/HETMyLT1Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RxaRuG6Kx+lUZjXc0xXxW9x7p9Yq5APC5rvDB1nPqJhxK7XASC6wrDkkPiYRuNk4radTtpd6oJPWAe5ZYOCLiUcwWDB6+oXs7Pb+yrF+pfpEu2qI5pBfgeLH9Bgsa+ytULHn4nuFFSmyDKI7Jy+Wo2tphEiXiWH6DGAA+BBtfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NpdtwTpv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NpdtwTpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783424348; x=1784029148;
	i=johannes.schindelin@gmx.de;
	bh=DnwMUjioPV4ndF9GpV47YW9qL/to2HKs6/HETMyLT1Q=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NpdtwTpvm2vL1Fl04Im5GENQHvmFHpg20SZPyR8XKWz8xipf0TtT91SKf3Odnhin
	 nPV5hgYcOu0B25za66TJaltDdCjCfn48NbjdKkETBSCcY1iBMzq6HN6JsaN82wwHg
	 LmaHd7+2Fzsy9e2jhwnTODdpVpAgdEsm5k2SXUUPQYBmrdbM+YHaOz5UjORYzG5BX
	 ZaWyhoeIHVxqQfnpWtS82a3rmWZI0hBY21TRnYG6EQATSZv6fokmrwq2xTrc/DK+w
	 zhDHUezSNIM1Obsv2/C+vGVePrHtB7kqLCNXb+/lEfypid9kBKKl7Sgb4eVR5zDng
	 Bv8vnjxSyXx3Vt/alQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1wXKh7119x-00V4Nc; Tue, 07
 Jul 2026 13:39:08 +0200
Date: Tue, 7 Jul 2026 13:39:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joerg Thalheim <joerg@thalheim.io>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <f449d0db-0434-f870-c69f-793f2b096816@gmx.de>
Message-ID: <10bb26f4-38e7-1bb8-d2d9-4d3e2ef52adc@gmx.de>
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de> <20260517132111.1014901-1-joerg@thalheim.io> <f449d0db-0434-f870-c69f-793f2b096816@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:96Vc7Ox+89b8zt0YLN8JDXxL2Zq6GBtCklFJsnfdDzCls1/z/iQ
 CeLJWiWrheyUh836yCUv6mcbH52uncdVaJSS/KlDOHEqVTTO1RCZzuKlb5aKR9qMkySLmUG
 qBc5RkRnJPNfaqKQ/9x7T1IV/TRJtLcg0JXFmEF66Kqp/jc4fbgw0jQHQRsMCVnAE/p8HMZ
 iT/i5dCYjXhFgLTQZVxhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V9x7RX05uoA=;K27zlR4qaqQQl2IghGYBsO5NjKy
 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
 LGu9BC2E0uPq8dJO/OUKbqGJ1bpJv+DzauzCLrW
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 28 May 2026, Johannes Schindelin wrote:

> On Sun, 17 May 2026, Joerg Thalheim wrote:
>=20
> > I matched the core.filesRefLockTimeout naming rather than reusing
> > microsoft/git's core.configWriteLockTimeoutMS, but can switch if the
> > downstream compat matters more.
>=20
> I see that there is quite a bit of precedent for naming a config setting
> `*Timeout` and implying that it specifies milliseconds, e.g.
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-corefil=
esRefLockTimeout
>=20
> In general, I am pretty wary of unit-less numbers [*1*], that's why I
> chose that "MS" suffix. However, the prior art in Git is clear, and I
> should not have missed it. Therefore, I have no objections against
> `core.configLockTimeout` as-is; I'll take care of providing a smooth
> upgrade path in Microsoft Git.

For the record: I meant this feedback as _supporting_ the patch. Now I see
it is stalled... I do not really see any reason for this to be blocked
from promoting to `next` and then `master`, though.

Ciao,
Johannes
