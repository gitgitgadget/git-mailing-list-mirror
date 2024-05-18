Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4B2900
	for <git@vger.kernel.org>; Sat, 18 May 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715997959; cv=none; b=N64HNSPbxVEK3z5jHCSITKu8OzC/dHMGCpgkHGcPVc42t0texhvNRfKC3ZzDFcJ+J0Q0fDFiXAKZvSK5vLy3euyXJiFjjGa8FBS4gJXWbAblf2BYuN0iZzkAzjRQ7TXCe65XFs+faholMF6iGROlJLy6rNoAAfX9jH+a0tjAH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715997959; c=relaxed/simple;
	bh=VRGdnpUb9ZczRkssuIU9wG7TW+91VS1W83xKsN+GxP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJn/sCTc4GxheUVzCEtc+2ZBCM7HJxMK138mJIHktPj/zCg1Sgx8pPgbXPy/PUflthGWN1bHsMAuimPSfnU6+eb02z0GEucsTUbTY8FcSydRjXlMwCpnbYcGST5TlHKhHQxiOFXms8dpwVad9XO9YKgb90I6oBkvYDcHZczVNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fw1kXBMG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fw1kXBMG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8157B3273D;
	Fri, 17 May 2024 22:05:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VRGdnpUb9ZczRkssuIU9wG7TW+91VS1W83xKsN
	+GxP8=; b=fw1kXBMGyzY3hnRU18OxUGV3y/7hEGcxWVpLjt2mzr8jN70dKxUza7
	MWpyZfQx2dlgsGCUHi9dxvRE5mK0Yt4qOtb0YYe7I2Wc4C47XqoGAmK6Jvdd90X3
	ZdoN5pidscF3GeFSLKW9WS/LGoVlLXf7LL8rxdCR8oodix9DRv0eM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 794853273C;
	Fri, 17 May 2024 22:05:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E291D3273B;
	Fri, 17 May 2024 22:05:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Nathan Faulkner <natedogith1@gmail.com>
Cc: Ed Avis <ed.avis@qmaw.com>,  Philip Oakley <philipoakley@iee.email>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Re*: git log --name-only improvement: show old file name in rename
In-Reply-To: <02d147ce-78d1-4fd9-b9b4-14b0662188c6@gmail.com> (Nathan
	Faulkner's message of "Fri, 17 May 2024 20:24:20 -0400")
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
	<xmqqsgf1i46l.fsf@gitster.c.googlers.com>
	<25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>
	<xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
	<BL0PR11MB34608AE271344D508676D17A9D9C0@BL0PR11MB3460.namprd11.prod.outlook.com>
	<c239ab15-4d48-4328-8bd5-8e2d77163e03@gmail.com>
	<xmqqv83cl97m.fsf_-_@gitster.g>
	<02d147ce-78d1-4fd9-b9b4-14b0662188c6@gmail.com>
Date: Fri, 17 May 2024 19:05:54 -0700
Message-ID: <xmqqo793dgcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 297FF424-14BB-11EF-BE6A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Nathan Faulkner <natedogith1@gmail.com> writes:

> That description sounds to me like it only shows files that existed in
> the from-commit, not any files that were created in the to-commit.

Sorry, this was a typo/thinko.  An updated version was posted on the
list after the message you are responding to.
