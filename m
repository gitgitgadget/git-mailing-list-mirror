Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C92F2341
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658773; cv=none; b=pz1q0izRVqHTlysOfettuSrwaeUKjbEFgK9hMGQ0O3eyY8fyByHiuzBkzDnd2P58i6lrZo8gVTUUorxggiQenyk680LoA/6x5DmU+zRF1AU59coEyu59Nk4owC2deHNp95xYDnSwqIIs1VWKfXD5f6KDOty/P4XqFwVs0uG0tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658773; c=relaxed/simple;
	bh=sWZmQsfxKZpP0VuRiwiTpgokpTnQ3Byd2yUQQc5G8Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDZznMarlvJGTu38eKTqx4+cxgAsaL5tBxqT8WKTUxpaRcFLuwONVqwYieRa9jqhPqX4JhRyceXBhIUPgw8Mm4ypwIzxwaKquoWcKNrm91aYEey28WzEZEcHi1q2lsUNsgEp8FkRNRS25cdLB86j0viBt4RfPh0g+yfmjHfpcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Kr1iiEy9; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Kr1iiEy9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752658769; x=1753263569; i=l.s.r@web.de;
	bh=1kFMVhV+JbVPJ+e/WM1MKAmjd9yoquHysuTGCcKvgQw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Kr1iiEy9jNUwiIjlj576u3PPoZYAWd6gkTBPE0OjAT95Zsx6lO2ZgAN0xG1YWGQN
	 5O+of5jJkbbvbw7IDNoFhj+4ahTPqqY/VXQs6Va/igmyQMR7mCpASXv7rwOuuS+3O
	 w47PmPP7QiRtw5JYQ+B1qamF5Vq5RUyXUwOdbUMO6KjEh0KO2G/q4oN2qrsqLJHVu
	 kiAxMUpQE0/825hNvtrpuineKCGjl9Vzqq1rYjePsdSA0M5F1U6UnrZYAlIF5/lPI
	 2XVLeO7qZoEzIBGg4bIQJbHn610i/cTcGcwpZ0SFg0ywpygVl/a0es+BDPOw+vPu6
	 1J3ePKQMsAvc9zSG1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyaM-1uLxtb2olm-00V15C; Wed, 16
 Jul 2025 11:39:29 +0200
Message-ID: <3f24210a-cd96-4c2c-9d55-1f0ebd7bbff5@web.de>
Date: Wed, 16 Jul 2025 11:39:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Justin Tobler <jltobler@gmail.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <d2myew7nonfrelrwplpypexvcrktmjdlsccobjvx3dydvhnlar@bin5ol2vj3xs>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <d2myew7nonfrelrwplpypexvcrktmjdlsccobjvx3dydvhnlar@bin5ol2vj3xs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vxg09ZXt+UwHmVtRGCPg9xFSSsa2epimrkOz3/QTRURwujDYE/f
 JPgHAUVMvuIFbEtZZywrOj0rv4R9BmJ22f5GEp4lZHuIkZrEg7G5+tfsSOrs8tvOm6rBo+x
 6vOCaEdx4cmROmNaJOl8XfhnN3w+Y21TT7KjE72us7o3m+vMc7Ly7EI6ouhovuDpiHdljeR
 SG6FyGYs1+ZUqS8WhrSVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KizjMdUkPW0=;D6W4EiDhPGL950OKThR99JRn5ee
 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
 dUnHHjpfxme+YxDlnPNchMs=

On 7/15/25 10:47 PM, Justin Tobler wrote:
> On 25/07/15 04:51PM, Ren=C3=A9 Scharfe wrote:
>> pop_most_recent_commit() calls commit_list_insert_by_date(), which and
>=20
> Did you mean?
>=20
> s/which and/which/

Oh, yes.

>> is itself called in a loop, which can lead to quadratic complexity.
>> Replace the commit_list with a prio_queue to ensure logarithmic worst
>> case complexity and convert all three users.
>=20
> If I understand correctly, `pop_most_recent_commit()` removes the most
> recent commit from a list of commits sorted by date and then inserts
> each of the removed commit's parents into the list while maintaining
> date order. Iterating through `struct commit_list` every time to find
> where to insert each parent parent leads to quadratic complexity. For
> repositories with many merge commits, this could scale poorly.

Right.

>> Add a performance test that exercises one of them using a pathological
>> history that consists of 50% merges and 50% root commits to demonstrate
>> the speedup:
>>
>>    Test                          v2.50.1           HEAD
>>    --------------------------------------------------------------------=
=2D-
>>    1501.2: rev-parse ':/65535'   2.48(2.47+0.00)   0.20(0.19+0.00) -91.=
9%
>>
>> Alas, sane histories don't benefit from the conversion much, and
>> traversing Git's own history takes a 1% performance hit on my machine:
>=20
> As "normal" repositories don't benefit here, it might be nice to more
> explicitly mention the the types of repositories that do benefit.

Good idea.

>> diff --git a/commit.h b/commit.h
>> index 70c870dae4..9630c076d6 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -201,10 +201,10 @@ const char *repo_logmsg_reencode(struct repositor=
y *r,
>> =20
>>  const char *skip_blank_lines(const char *msg);
>> =20
>> -/** Removes the first commit from a list sorted by date, and adds all
>> - * of its parents.
>> - **/
>> -struct commit *pop_most_recent_commit(struct commit_list **list,
>> +struct prio_queue;
>> +
>> +/* Removes the first commit from a prio_queue and adds its parents. */
>> +struct commit *pop_most_recent_commit(struct prio_queue *queue,
>>  				      unsigned int mark);
>=20
> Previously, `pop_most_recent_commit()` would ensure commits inserted in
> the list were done it date order. Now this depends on how the caller has
> configured the `struct prio_queue`. This is fine though as previously
> the caller was required to ensure the list was sorted to begin with
> otherwise it wouldn't work properly.

Indeed.

Ren=C3=A9

