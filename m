Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030562D7DCE
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951290; cv=none; b=LF8gZSEuQ8qkU1Lfb662iGzOc1/soFqIuR6wt5/wtoSPplj/uEk5Z0BLB3CautqC+pPd83w03qz3ZI7WPRByfMDdXaTim8lJSfFEPRWQiljWEfdCjgLpVqQe2q7Brm1SnmJOZNu82xxptE73v1yxTi4gv+uYSskV3c9mCfbQ+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951290; c=relaxed/simple;
	bh=GwU3edAah2jj9PMAbtsmGjILU9ygJ+WECGws+vl/AHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqznrm14Vo7XqjMeFI6b7Mfdd89YDtc0VuEJCsWuPLJHVdv5XPdg2ZOxA0gfnMx7AOru2Pn7rYzlYunjAehRDdUk30QxI02X+euK8HpH2mo0e+FyC5S+C2Zuhr/8cX1EVNgjVBgYHPL19drB5YzTfiU0+F3DzK3DNVirhSCpSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=aZPZls6s; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="aZPZls6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783951285; x=1784556085;
	i=oswald.buddenhagen@gmx.de;
	bh=GwU3edAah2jj9PMAbtsmGjILU9ygJ+WECGws+vl/AHc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aZPZls6sBWoVXmD90QWyYz0p8vkFrdOOkvzfrF9iBJTQnBOZtTj6G07oz/ey4bUt
	 CIUB9itbGdddjta65tb+qONjkJhN8CHruHswoY1hJ1/RNAl2NaJj+mj35rOvMR46Q
	 BkefyFQKsBeTE89xYdDbVOVDRS2ARvykrlSJasJs4GYDEfD7zQkFEWH50QJytz+sX
	 2MJ/qWzgEHUCJkF8xc1H12DTFEflVmyK/euW3Du1uccTuTcZ9Tphq5ESM0xe3w+RC
	 yi5xbXtmqJ/7vAs5IlIjz+UiamQCfAIpQ5C3D3XwVQy3kvjLkEWlmfG9/q90gKtvB
	 kYquYCb6Qhr3vMYTwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1wSyE549sr-00OQH8; Mon, 13
 Jul 2026 16:01:25 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wjHDo-VxW-00; Mon, 13 Jul 2026 16:01:24 +0200
Date: Mon, 13 Jul 2026 16:01:24 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [PATCH v2 03/10] sequencer: be more careful with external merge
Message-ID: <alTvtOc39bLR4ocx@ugly.lan>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1783948637.git.phillip.wood@dunelm.org.uk>
 <3d79362332c1208eed1fb7f8b0d431ee92fe45c5.1783948637.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3d79362332c1208eed1fb7f8b0d431ee92fe45c5.1783948637.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:ZcML8k7kuNH+oX88ei3BtbeAfAGuImlpzoiozvRCwMkZ2fyyOlB
 KlqtcNgC4eclJTFMoINy+8fRzKyKKofFaL9MDlML/J2JCL06aoqEkzvptNC4uOZWqr7qjZ5
 9kwjLnaWGMh21MP/tPOICm7lX7eidnPka+gmSRmvmtjPHeFrPt9oaJK9bNGHVAu5qgqtFZo
 hvE0iNPno/Ez5KUFOLaCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lWPiGH93JBI=;8bGXrNpSx3IQi5+E7JTWtlaBRHa
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 02:17:20PM +0100, Phillip Wood wrote:
>If an external merge strategy cannot merge (for example because it
>would overwrite an untracked file) it exits with a non-zero exit
>code other than 1. This should be treated differently to a merge
>
s/to/from/, i think?

>with conflicts

>which is signalled by an exit code of 1
>
parenthesize, and add comma?

>because as
>the merge failed
>
(maybe add comma? here it becomes muddy ...)

>we need to reschedule the last pick. The caller
>expects us to return -1 in this case. Also reschedule without trying
>to merge if the commit message cannot be written
>
add comma?

>as that prevents us
>from successfully picking the commit.

i know that most commas (and parens (or em-dashes)) are optional in=20
english, but they _really_ help parsing complex sentences, because they=20
reduce the amount of "read-ahead" required.
i'm stopping at this commit, but subsequent ones could also use the=20
treatment. i trust that you don't actually need detailed suggestions.
