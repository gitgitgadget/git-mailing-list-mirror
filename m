Received: from mail.cendio.se (mail.cendio.se [193.12.253.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E438FA3
	for <git@vger.kernel.org>; Fri,  9 May 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.12.253.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786847; cv=none; b=qFNfq1eK8iLOAmCdW5GAUVG95d9wDYYraXT0fSsb6MbPS0O322x5biu78n7KwZcj96Iql882lRhu8Ldk7juUNPhR22onoVgnmdtrRwCtVIGOH9ej+YmipA+8U0MEEQzJ2OEX/PD+N1u2662Zhi95PmvTDDbzvTJw5QQYtAPiIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786847; c=relaxed/simple;
	bh=ANOARxSdqe9vmZOo9YGDbYChtdKvhJvTSGrKpqF8p+0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sh8rS1Qn6nEt+rw4rZCanNJogxTJKQWyOommub0WR342rrYkAGcIPODdaM+qE/zsNjaqaA9qWFI+LWz0DU281S83NFhMHl+aFm3j9GACT61pAUACQSaPjtrkO0NzEm0d15Migjw8F/DCLCecIqI9EPRXl3Mb5v65iiB7Ai91s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se; spf=pass smtp.mailfrom=cendio.se; dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b=kW/tO5QZ; arc=none smtp.client-ip=193.12.253.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cendio.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cendio.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cendio.se header.i=@cendio.se header.b="kW/tO5QZ"
Received: from [IPV6:2a00:801:107:4700:e2be:3ff:fe9d:f27] (unknown [IPv6:2a00:801:107:4700:e2be:3ff:fe9d:f27])
	by mail.cendio.se (Postfix) with ESMTPSA id D379D1835BD2;
	Fri,  9 May 2025 12:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se D379D1835BD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
	s=20250112; t=1746786467;
	bh=JMVpQgeeAhmY/DjY0eEVssMM9G6YnszUsq04YFYMSnI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kW/tO5QZrheSiTJqZtDuMmPnBWTTVoeyFMRVUdr8LjEtEnlhWyoZ5pRhlq3Z7EXot
	 0wEQmksDEq0ZTRAYebDFfGVxUKR00Zjl5QFWKkf6ITtrH0hDjnEyNU6m14/t+P5t+P
	 rax16XacMRbEWAtEX8keo4ROMwCSJ/Jfthgn09rIQI4oTLG/0acKMjZT93Me28cC4x
	 qc2NEEHIOqIVIblGNcWpImmDziNYr9YVoCqH2xuCxtPUg94DxPfzrL7nXUkdD+KmpV
	 cViP712bSREB24dhIAKcLAUPm8eFbkKpvQ4btUtfxNB3Z80lP8OgZttGZ2rqMaVQb9
	 Vzm+GM845iIag==
Message-ID: <0f0a0dc6-2223-4d59-bc9e-5c8ebfbff09e@cendio.se>
Date: Fri, 9 May 2025 12:27:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] git keeps recreating packs, exploding backup
 increments
Content-Language: en-US
From: Pierre Ossman <ossman@cendio.se>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org
References: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
 <CAG1j3zGmA30w545+-6qFV6x+3HvM+fueYH-rv-_gaSTpZStMHg@mail.gmail.com>
 <ba212d4e-32c5-472a-8604-2a2653bde17c@cendio.se> <Z7g2aEpEboL5mvRa@pks.im>
 <b0b1007c-34a6-4e3f-9982-cfe617affe1a@cendio.se>
Organization: Cendio AB
In-Reply-To: <b0b1007c-34a6-4e3f-9982-cfe617affe1a@cendio.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Following up on this old thread.

I think the entire thing might be a false diagnostic on our part, and 
git's default behaviour is working just fine for us.

We initially starting looking at this because the backups exploded in 
size. But git is complex enough that we had a hard time examining things 
retroactively. Instead, we started monitoring things going forward to 
find likely causes.

What we did was to keep an eye on how new the files were in 
.git/objects/pack. And we kept seeing that the large packs were brand 
spanking new. Hence, the attempts at reconfiguring git, and the thread here.

But it seems we didn't look close enough. Although the timestamps 
suggest that the packs are constantly being modified, the names and 
contents actually stay the same.

I've been keeping a closer eye on a couple of active repositories, and 
we aren't actually seeing any excessive growth in size. But the largest 
pack files always have a very current modification time.

No idea what caused that initial spike in backup storage. We'll have to 
revisit that if it happens again.

Regards,
-- 
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Linköping        https://facebook.com/ThinLinc
Phone: +46-13-214600

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
