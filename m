Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A941C69D
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951785; cv=none; b=YRhDNKcN3mfrB94E+LxOdFL9X2lbdvDxxccEOWF6saa0LFBxxJZGL4eeWCpbGm0/gzxq2FeWa8WJEyzfMU/3i/hKuqCdG6vaLxwZTUi2FoOrkHC1RGlg4DJz/tTehzhzQfBim3ZuYrfkzWyUWkfdJV8mwk5JukkSunpcAa/Z17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951785; c=relaxed/simple;
	bh=LmFbrSQe02S7tOgk6gJIlQAMYqcra2C3JI6xuNCg7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXl64xAUwwHZ1a/fMVC1YrrsG7g4fqwe45c2XjXMDScJQACgNm9+P2ufFq5EFb9whj5I5tWyffrAa+kwO8iGwLTuWztRnwNx+5A0TMsmgfL/eZHFVvRcUvT+YYSjB+2ZUKzddYZQYn9fOiy0dj62wfY/YctmhtHEGF4NdEKWO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=fHzH2p5n; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="fHzH2p5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783951775; x=1784556575;
	i=oswald.buddenhagen@gmx.de;
	bh=LmFbrSQe02S7tOgk6gJIlQAMYqcra2C3JI6xuNCg7Ls=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fHzH2p5nTneyLx0eeqH2VQh5ZACU5suPHyLlN+yHwIk5qNeunpPzMh9AXE9xbe2Y
	 vna9/e1SY0nodxNswMQRZjee7zivj5bdugsZi64lcd+H6u29pVXmeZNUsGRoDc2ld
	 2EZgFfjG63Fdb2hgigG9THmFp425I/v24151g/AkP0N/NCJDnbsYoRyUIg0AS9sB/
	 NBpqED7dS0QyEUCttZLRhhe6r4Spj+ZaOd+u4cESTj1ktpZPiXc/5gy5FR97AbWpa
	 Z3xjvyjfnvvpybBljNj31m3r6Po37iUVVs7Dd6rdhBorkRL23okufAbiuUzsRvWyP
	 ghqzlGXfhQ42sOAMhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1xOcqW2IMp-00kmcQ; Mon, 13
 Jul 2026 16:09:35 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wjHLj-W4e-00; Mon, 13 Jul 2026 16:09:35 +0200
Date: Mon, 13 Jul 2026 16:09:35 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [PATCH v2 06/10] sequencer: simplify handing of fixup with
 conflicts
Message-ID: <alTxn7MmX3aH_7gp@ugly.lan>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1783948637.git.phillip.wood@dunelm.org.uk>
 <26dc48951cea663080bacf7d8d4760528125cbf5.1783948637.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <26dc48951cea663080bacf7d8d4760528125cbf5.1783948637.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:uOhNgJYZ34Pyz/xx1gN3Lu27DUUB9D34REHafTl64YpMaTdOxde
 TdNoqaw52dlBv2euQ2kL0NOrsrHIXJp95B1abT00s48OFTTFxzx/I5yBBBBt9tp1rdPttPO
 NQFZurNBUEHyrguK7/7Dctg3H/OeyHy528RfrgL8psyeXAj5FZ+kQbHT2JTiKd/b9R7cl2c
 m3crHP6bjgW/2E7lUYb1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j0Sva3yXAdw=;7u7XRnwM8xc4ZJM1atshCr6+LOj
 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
 lI1elfmmiKUUUezrfo4Bor7I12U=
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 02:17:23PM +0100, Phillip Wood wrote:
>Commit e032abd5a0 (rebase: fix rewritten list for failed pick,
>2023-09-06) introduced an early return when res =3D=3D -1, so if we enter
>this conditional block then res is positive. After the last couple
>of commits the only possible positive value is 1 so we can simplify
>the code by removing the conditional call to intend_to_amend() and

>call it error_with_patch() instead.
>
that part makes no sense, subverting the argumentation.
(as-is, i actually can't follow the logic, but i suppose it would be=20
clear with (much) more diff context. i'm not sure whether the commit=20
message is supposed to substitute for that, or the reviewer is supposed=20
to deal with that on their end.)

