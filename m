Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A84D9FB
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290125; cv=none; b=MOSAxLkCmCt70rfIBGHZDyEZH8gfSU8oVdnb3cpFIlsl5+gimwalBspRkg1E06bo0OHyXN4nI2p1W2An2gaINFcclDC4rdBqZ6srrwUY4gISvBh8qmE/VGEIiA/L1pfTzvzY5kuapSXOnG+9N11XLqRRTu76Zcw0RMH8g9vppJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290125; c=relaxed/simple;
	bh=rl/AaPt0uqxTDJGB7s4d87dSSK7j4FkfP8sbsoYSJjA=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=DfNKSPi4L4n9egTk30ZhA6OwFkn2CkfyLwnUEb8dvmAd3sLVj3K2SWuXznt/nUbpffecLGPSR82xpPNJUz3k4fUcgQebn5tPVM5/z5FTwNQzVYibia0BdDKUi5KEpFztq/PqLh3X1KLl+43BPSO8hFC9yvqRVM0a0VJNQDeNV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=e2HUpmwU; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="e2HUpmwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail; t=1733290112; x=1733549312;
	bh=rl/AaPt0uqxTDJGB7s4d87dSSK7j4FkfP8sbsoYSJjA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=e2HUpmwU137wTAQ/cDqZvvS1f3wE4DyE74ULcEApTi5Tpabjr//TT5v34nxMGLssX
	 NQkzE/kna0/+6/50FAz80KCoXIw/BZm1aFE9a7pN+bIfQf3MHK/1rAJ0ymRzC9tiqx
	 scq/cMHq0IhFHwNa08fJbSh8jKg7LYbahnGhVEGA7iRAR+rJAOxPUeE57nV4d0vy8n
	 oezoJRKd6jUcbEJp77gKjxNkHooxsk0+B/LVmJvIxwSEUtLjfsGqEL1Em+trHOc2kS
	 mSNjurFY8pFgBQdtNTv/wnJcqrF3/2/plR/cHCY/N/S4JxCgIbbouxHOW36lfAKcJt
	 mX9/KT1UagU7Q==
Date: Wed, 04 Dec 2024 05:28:27 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: Some feedback on 'git clone create'
Message-ID: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: c511d67ed8a1bac911fdbcb8ce94bfb345b15e5b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, I hope this email finds you well.

I think Git bundles/packfiles are an exceptional compression format, but I =
find there are some rough edges with the tool to create them:

1. There is no way to specify that you want a shallow bundle, instead you a=
re only able to a) pack the entire tree at a given head or b) pack new/upda=
ted objects in a specified range. Anecdotally, this could store data in ~67=
% of the size of an equivalent .zip file.

2. It seems that when specifiying a commit hash, it raises an error:
$ git bundle create repo.bundle $(git rev-list HEAD | head -n 1)
> fatal: Refusing to create empty bundle.
This confuses me slightly because I thought a commit hash should also be a =
valid head _pointer_. 'git rev-list' also seems to agree with me on this.

--=C2=A0Sainan
