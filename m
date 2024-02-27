Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D216423
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043071; cv=none; b=I9u742Y7PFY1ejE4jcwLkNa83AhmVxqnP65iJMB++p+RHjZrsrQpKDAq9rKL86PQiQivD1BHi64ClAILAjFQoS1Hr9NWa/yR8AqXotQdTpHsF31PfxTpHTteIs3kpGPhIrZecEF0XSKwTNLwOprosxOWICowGwfSt1xm0Fs4qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043071; c=relaxed/simple;
	bh=krZ2fROC+0fIyv9Z7gPpkoJcjyrFbhWFMULNfXv8Xak=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z6vtk5vxSIWtez9EXRpACUPdGXLzlRsaWyVUFnaA5usdAt2zycUa/S/M/cGC0mxNt8FpEbqRMUW1vzfiglCJnJWNJ3KT0/ZD6q7JpFXT005AweFgOwuWJs3IigVZ6JOyy0D9CAgpdGDl/OjY9HXkpzIGUp5Jk6vku7JcLwmn4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41REB0Y22354871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 14:11:01 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>, <phillip.wood@dunelm.org.uk>
Cc: "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>,
        <git@vger.kernel.org>
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com> <01be01da681e$0c349090$249db1b0$@nexbridge.com> <20240225191954.GA28646@tb-raspi4> <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com> <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com> <Zd2hMmIzHKQ7JE45@tanuki>
In-Reply-To: <Zd2hMmIzHKQ7JE45@tanuki>
Subject: RE: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Date: Tue, 27 Feb 2024 09:10:55 -0500
Organization: Nexbridge Inc.
Message-ID: <02c501da6986$cb7c5c30$62751490$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH6KeHXK3ktIx6cNmAt1sL267+NoQLej1jbAXwNbRICuPECnQG1wVidALQjrBCwks2s8A==

On Tuesday, February 27, 2024 3:46 AM, Patrick Steinhardt wrote:
>On Mon, Feb 26, 2024 at 03:32:14PM +0000, Phillip Wood wrote:
>> Hi Randal
>>
>> [cc'ing Patrick for the reftable writer]
>>
>> > The question is which call is bad? The cruft stuff is relatively new
>> > and I don't know the code.
>> >
>> > > > reftable/writer.c:              int n = w->write(w->write_arg,
zeroed,
>> > > > w->pending_padding);
>> > > > reftable/writer.c:      n = w->write(w->write_arg, data, len);
>>
>> Neither of these appear to check for short writes and
>> reftable_fd_write() is a thin wrapper around write(). Maybe
>> reftable_fd_write() should be using write_in_full()?
>
>It already does starting with 85a8c899ce (reftable: handle interrupted
writes, 2023-12-11):
>
>```
>static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz) {
>	int *fdp = (int *)arg;
>	return write_in_full(*fdp, data, sz);
>}

Unfortunately, this fix is included in what I am testing but does not impact
the issue I am seeing one way or another, but thank you. 

