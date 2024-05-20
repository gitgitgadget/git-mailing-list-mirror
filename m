Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873F1D531
	for <git@vger.kernel.org>; Mon, 20 May 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239060; cv=none; b=AS1uA1n6F48sxzH2ve+eVyRzjpuRxoQeKA79jOJ85dMySbV+QUZJJN+cPay+xMnQs0yww3+U/1kaJCjl2WIeoZnYeVUBwIYxKrffec1l8jm8tqC6pexKadsjipEg1O4boqVLQVA9WMCgClisLvs5jFtl21XLoVG91TXhCJrv3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239060; c=relaxed/simple;
	bh=VyqCcf8+2UraMFY0ih3PNbm8lQawEKSR5Zt+sOZyoD8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dyewHFNl10ZDWVt/6o6R3IuP7AT/SFpp9llDg4/g6NrO3aJoH7SeSZqi7/00Kr2No6XvDUhyODkfegc1dxb3HBls/GZYbXcqnAICmhucaCVcv8roB5xgZiOWkV0hOYr8u+JjHYqA40im86S+g5n+Y+/SsNyoiYkotUcwzCdY210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fM4XlJKx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fM4XlJKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716239041; x=1716843841;
	i=johannes.schindelin@gmx.de;
	bh=VyqCcf8+2UraMFY0ih3PNbm8lQawEKSR5Zt+sOZyoD8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fM4XlJKx/u7k4MKGLsK/wKtDrSFuLBC7sTm7EFSYj626+KppenWPDrI7RpFVhe3G
	 XvaUzgC4WIppVvHBgAQlgyTVpsem0pXRR3P2/H8OrOZmbAFV63zUzsV+SY6ZgR90I
	 81JraL53bT5yZItPUiSqCawfA7aaGOQmvf6yjotqDpviYn38s7qI/cd4NbZpfYeyP
	 H1pwx5sGiMu6SpEMea8I994vRZzf2vmzc50R4+9csttqFS9/iN4vR/Cq009kkPTcL
	 6CjISyLzyowRjTcgDJkZZNr9gv0zepaCWDl+GN1L3MGpvzpW/o9+FAxmkceZTXGDg
	 +XUhv6UEebYQhRk9tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1rqFqe2Q3x-00HhwD; Mon, 20
 May 2024 23:04:01 +0200
Date: Mon, 20 May 2024 23:03:59 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <736b43a1-a371-4d6f-7739-b5b64e060585@gmx.de>
Message-ID: <4f7cb327-2ccd-deee-8727-ae0302e36e45@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com> <20240518181432.GA1570600@coredump.intra.peff.net>
 <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de> <20240518194724.GB1573807@coredump.intra.peff.net> <86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de> <20240518211224.GA1574761@coredump.intra.peff.net> <xmqqed9yob4v.fsf@gitster.g> <5e0d660a-b1ee-2202-752c-d46d3b0c8a19@gmx.de>
 <xmqqzfskfiu3.fsf@gitster.g> <736b43a1-a371-4d6f-7739-b5b64e060585@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GeH+O46GzYsQYBGCGkZ2/gNW0NwwnD4HaqLwb0xHywsrsBxfhRB
 spsowXnDqeHLVParWq4eaT3nm6vBxFWupZjCl+AWAKrHDow0jGPrjAk+QjBd6Lx5GT/qKV2
 uKH1zpdjwzoLqO6IO2nmJYduiLelEiNlLS0FVXdt8N7orG/KMoJAhrQYEQCXU9zkNEcWrAx
 PWgLBzHnqEAkgwVhdtLuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TQFCyckditA=;zmDi53M+9UN7Xpj7hG64eJysdgU
 n4yPdctR7Bf+FK1C/ThUsO9ZovDQLg7jpDwc+34Ibd0IQr9vXikJeCRfkrIAtr9Z00GADmuQE
 9+xV6ww1+d/+vd1r92IsSeV1UaZRq5qht1V24fcHtaFg5GRARnaOpQUcgqMxzZHD9MCbe0BDe
 puWKHqL2W2oYrZYOw96UNGUl0KAjoUDRSdqPJh8PUFUh404Win43K8tuqm6nSYwORgpN/ZvI8
 FiBLLBHmFOshky2aG+RS+SOnkYiqmrO2YZS/58g642fAnK+6UUXZSDjnjd4tFxszonlIRQSiF
 PpZfpNlrrk0aeBe6lZVveckEyBE/1E6AGHJQNA9d2+zOQdWs5aur8VVF06/m8x3xi7fdyw20S
 t3Cy49CLyK0FKrWBt8WB6U5o9++UaUXaaRqkY9XhPev6fDmWb+6wnysz4u6XMw9RTlOqjBL9p
 sP51yy83++ol/l5jmB17rdtO8rX4nql3jinn0IdG8LQoqqhuQt62NWz7JmoaR/S0r0NEReV4B
 q5USAJMCIFNgLlxJTx44byCmuzFG92nVWFvyA/RyO/67yzFn7Hx/oPyFUxTADdUL7mv0yuF0+
 V3vjVKwQNC0Zv0veFj1VEjUpmvXYjr2VzRDmGqQvbAraXtYgWGx7n/8rL2A3orHO1d5/VN72f
 iadx6I2bSbAtXPTJdGTTigCfoZhCEW9Un6jSurNks19xaq9q5HtGHjiSVdsVm5JHhhIrfzIy2
 I5knzFxgQuTTsOyuosgM00pC09OAGlblQuCAf70OVGSLvHmYjvRBgHtL7R0wdjB46rX2ACDB5
 sUC1po8ON9UIW+zG3IBNuIwondIAhv+nOEO7AeoAo+o6Q=

Hi,

On Mon, 20 May 2024, Johannes Schindelin wrote:

> Let me quickly iterate on this here patch series (as well as the
> `tentative/maint-*` branches) so that we can accelerate toward a fixed
> version again

v3 is on the list. The `tentative/maint-*` branches have been pushed to
https://github.com/dscho/git, with these commit OIDs:

b9a96c4e5dc4e04258214ab772972a0e1eefd3c5 refs/heads/tentative/maint-2.39
4bf5d57da62f91db9b74d490d5dae69e65cbdc73 refs/heads/tentative/maint-2.40
5215e4e36879d1ee0ad5da7790f4598c3314ed45 refs/heads/tentative/maint-2.41
33efa2ad1a6c14fc5d8bc5cdf38ba13b25926b42 refs/heads/tentative/maint-2.42
0aeca2f80b17fcfdd9186c585ce84004ed43f46a refs/heads/tentative/maint-2.43
9953011fcdd895fd3ff4e2f2e5ff266eaf8b0b49 refs/heads/tentative/maint-2.44
aeddcb02756259e4b221f37a60e4ee1ece3889f1 refs/heads/tentative/maint-2.45

Ciao,
Johannes
