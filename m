Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BE3F4DDC
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374782; cv=none; b=ry3M0FdvzoC6Th0kNtBVnr44v0IsFS0z0CTl38TmM5pIb1bMyw8fnZkCmxL8SPKxguqjCoqIR9ChE2j7xIdAvRPypomRtOP0Kv47hwn5WfRPCrG5Yd7EXbPqtYV6PZ4SR1g+gEkylcgoyin9PEkj9ws3nqLv29j0MBtrYdL8UuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374782; c=relaxed/simple;
	bh=ChToPgC6akC1TpikI6dKOMIo/n5JcRJgjCO/Dth+1Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keTpuA79r926q2ntU1gCWpLHsIMRzxQV5YT2nD27FA51cSu3VbFZCrW+W1LTxR+Iaq/lVZlWBIoRkeO1+uIx17GJCRVWxIUk7fW9I9TbQ787p1i5FhBaQbhts/SxaHZBWibrr93VqC05VOZ6kYZ5riE4vejq5vOOnE+5PdsBXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=V46NYt0U; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="V46NYt0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202608070029; t=1786374776;
	bh=ChToPgC6akC1TpikI6dKOMIo/n5JcRJgjCO/Dth+1Dg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=V46NYt0Um8j54wmpmz1OLIsmUmskqskVqDXEAFgmsnzjGkcyn636+kbEC5MHHvqPR
	 wl9yhPKKVwjUv2lp82qSgK9PbxqSYy3KA4ZQXnonL1y+IJZbn3BH+iIFvVWKlyumvb
	 eBbHsGG4fg0EZdQ5octEiG88CEoH7KVAE7ygV76ymkqdn3ziyk4qj+iYpyw6F87IQD
	 /UqYx7S8ixRtJAIArrH781+9NAWymofBhA6K8btMnBT4k/hQDNPPDrV4nU3ketX4Xr
	 BBzw5fm5SJD0iRgdZrchkxqhwKmC4CGh+VvqzXDe7uoNKNdK5BJ3MCGhcBR/bLtvgR
	 1TIcn160Mi6Aw==
Received: from [192.168.42.64] (66-97-142-46.pool.kielnet.net [46.142.97.66])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 5F73C3C2B73;
	Mon, 10 Aug 2026 17:12:56 +0200 (CEST)
Message-ID: <7fbda96f-a16e-43f4-91c1-00c08d956775@haller-berlin.de>
Date: Mon, 10 Aug 2026 17:12:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
 <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
 <anlfk0P7UillhlUd@pks.im>
 <801031d7-f219-4410-a863-7410cff7952f@haller-berlin.de>
 <anmNX-WVohAyjEcc@pks.im>
 <4f6a96ac-d993-4872-b3c4-30d899f61ca9@haller-berlin.de>
 <annYNOWrEx1PwjQw@pks.im>
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <annYNOWrEx1PwjQw@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 10.08.26 15:55, Patrick Steinhardt wrote:

> Does the issue go away if you set `maintenance.geometric-repack.auto=6700`?
> If yes, I'd propose to simply change that default to be in line with
> what git-gc(1) uses.
I'm afraid it would take me too long to find out; the issue occurred
sporadically on CI, so I'm not sure how many CI runs I'd have to trigger
on a branch to be reasonably sure it doesn't reoccur with that setting.
(And I'd prefer not to make that change on main, I'm quite happy with my
current solution that's guaranteed stable.)

Stefan
