Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F02882A7
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348376; cv=none; b=oDo5tsoXpW//LHyzPsZStAVCKgXQcN3Gp/qX7ORj0vbIXAVZGDyRCXr3qJd6HbDMKWQVq3VaEXKOgtKpRVCOirx0HGYnmn/bQqDf45UrsobPRhBfd2a3/n7J/jx1V9M/mw931eSdNPicajmIOP+m54qdAQgGXmrENO50lGGgPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348376; c=relaxed/simple;
	bh=Fau4RJMlsAAFYR8smfZoliUQLEgzzaWS6+zkqQ+nfbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmxfS4V60eUJPr8Z7nzVrokOkZHlKVuV1VsglXn7FPdZoVlRBCO13lDeC7qhA4zPWN69Zefg3vwiG6q0fONL/WytY5YRQh8MsO1Q2FpeVkjvnGuKgAp9mYpvBlPlLo8L7VTR4JhC4aywugO8m+LYRD1kt9uyq4fcvG5TGJIy5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qE5Hg3bq; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qE5Hg3bq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764348371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1Bs9iefr4fQRsealfvA9be1K5TpLAQPdeK+MbxjvfQ=;
	b=qE5Hg3bqbsq9xzS2ZfB3p4lzRBbEFHFYxCfEhM0JD1L/zBmlyTQBXjYruppqZk/2m3upxW
	2iBCH36Z2i+mAkDSyNrdkfKXQgAL5mEmMn82LjInFOmMfVDcEk4nm2Ck6iC4rjrK3R7EMR
	BHRBt0eiv3S9v3sA3vFtaklh0svbBrY=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, Anders Kaseorg <andersk@mit.edu>
Cc: rsbecker@nexbridge.com, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Subject: Re: t8020-last-modified.sh failure on s390x (Re: [PATCH v4]
 last-modified: implement faster algorithm)
In-Reply-To: <20251120081611.GC1283645@coredump.intra.peff.net>
References: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com>
 <4dc4c8cd-c0cc-4784-8fcf-defa3a051087@mit.edu>
 <3b24b6a3-61cc-4b9a-a823-f1e58fd9919b@app.fastmail.com>
 <ceacc47b-9d29-4e32-9d83-6bd68279c83c@mit.edu>
 <20251120081611.GC1283645@coredump.intra.peff.net>
Date: Fri, 28 Nov 2025 17:45:57 +0100
Message-ID: <87y0nq14xm.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> On Wed, Nov 19, 2025 at 12:06:35PM -0800, Anders Kaseorg wrote:
>
>> The failures in subtests 16 and 19 come with these diffs:
>>=20
>> --- expect=C2=A0 =C2=A0 2025-11-19 11:28:57.966106204 +0000
>> +++ actual=C2=A0 =C2=A0 2025-11-19 11:28:58.110112543 +0000
>> @@ -1,2 +1,2 @@
>> +ac29b6e974b49803f1c6ec5a705d1bf7dbfa7d2f m1.t
>> =C2=A0m2 m2.t
>> -m1 m1.t
>>=20
>> [=E2=80=A6]
>>=20
>> --- expect=C2=A0 =C2=A0 2025-11-19 11:29:03.492349022 +0000
>> +++ actual=C2=A0 =C2=A0 2025-11-19 11:29:03.648355864 +0000
>> @@ -1,2 +1,2 @@
>> -b5 file2
>> -b2 file
>> +da1857e0652b6f264c0038d684ddecddc273e506 file2
>> +da1857e0652b6f264c0038d684ddecddc273e506 file

Kristoffer, thank you for reporting this bug. It seems there was a real
bug in git-last-modified, which was uncovered by these tests running on
s390x.

> Interestingly, the commits it returns are merges. E.g., here is the
> state after test 16:
>
>   $ git log --oneline --graph
>   *   ac29b6e (HEAD) Merge tag 'm1' into HEAD
>   |\
>   | * 53e7187 (tag: m1) m1
>   * | 9b81a41 (tag: m2) m2
>   |/
>   * 08525b6 (master) remove a
>   * 664d121 (tag: 3) 3
>   * a732b0c (tag: 2) 2
>   * 1edf6f6 (tag: 1) 1
>
> Though it is also the first commit we start traversing from. The same is
> true after test 19 (da1857e is the tip of HEAD there). So I am not sure
> if the bug is "we are not passing down blame from the merge", or just
> "we are not passing down blame at all".
>
> I can't help but notice that this same failure is seen on s390x and HP
> NonStop[1], both of which are (I think) big-endian. And not on any of
> our usual little-endian platforms.

Peff, thanks for the pointer. It costed me more time than I'd like to
admit, but I've reproduced and debugged the issue to find and fix the
root cause. The problem is bigger than on big-endian only, bug it was
uncovered by this test running on a big-endian system.

Both, I've submitted a bug fix at:
https://lore.kernel.org/git/20251128-toon-big-endian-ci-v1-1-80da0f629c1e@i=
otcl.com/

--=20
Cheers,
Toon
