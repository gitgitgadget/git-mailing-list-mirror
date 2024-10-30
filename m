Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2C125DF
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 04:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261807; cv=none; b=uO9ZnoLInPru7j2ZBbMATAzIsZR4HKTC6BD9ks/w4cpj7NU7FpkTF1AAX4H2vqWj3M5TxSMR3+DCgp0eHSXcQZcxWNjS9Ik8/JlANSLP2qJAWCotPcu3Kg9mQVlT+t7BEWEnFKKpYDes6BF1uEjQwraWdW8ZlzwnLYMbUP35hlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261807; c=relaxed/simple;
	bh=6Kn6fGU+anTDhMmN3VzREi5KJM7kA1pLZUXE/gseknQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tl8IFQCEHODKp1LWO3pGvijPhVzmWwoYHN8Ti/ZvD2WjfH2NhyfWnzvcMwTAFHy3yH/qwPAZ3F1yg1gLERygMsjjd788MGzQsrZ0mVZTvF13s8icoF3FMVGHp+2A9e8oezn7fnhE7wAz3fOybAeq5ojqGoMQ/sXOK/lIi3UCPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NGEtsUmG; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NGEtsUmG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730261802; x=1730521002;
	bh=rqF/da0dUcvCRqzMMnuwev91piIx5+9JrdDY6mXRE9I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NGEtsUmGtSnf5cha11ftyB5kmwUECNxi5uzkABTPDZrbaFKzGlhlF1Iu9XBkU/8/p
	 R+6d9bn43p44ELnd/+2szA2CBHvy7PwEX7lhpXVwhvwbG/+ouVQCN/wztRMbESVOSt
	 5UiH2yzpA1I18NfsqwViMtGIHrlkiIv9t6X9j/L1bT6uEwSg293UQT/KJCYK08m8tP
	 vVsmsm02P9k9plGXNQCZypu6FT0YK38RwJwuciqFKBQRuJ9bGqm2oSG2xSjeF05axY
	 7JyQjYKF189QJOfJ9MvOZuuJDsAoPd8UbLqu5X5zs7jdh4uwNlD3vlWBrjKxyD9vWz
	 gE3+kS+e3PreA==
Date: Wed, 30 Oct 2024 04:16:36 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] worktree: add tests for worktrees with relative paths
Message-ID: <D58UM62S8YX0.17RAKH4H6XJSR@pm.me>
In-Reply-To: <ZyFo+e5Vj2TpXNyo@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me> <ZyFo+e5Vj2TpXNyo@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 600af4190f011b4a8680d1d9161b028d2147a780
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 6:00 PM CDT, Taylor Blau wrote:
>> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..e21b9aa5e7f4599af8b20165=
b50896c9a49ba7ea 100755
>> --- a/t/t0001-init.sh
>> +++ b/t/t0001-init.sh
>> @@ -435,6 +435,7 @@ sep_git_dir_worktree ()  {
>>  =09test_when_finished "rm -rf mainwt linkwt seprepo" &&
>>  =09git init mainwt &&
>>  =09test_commit -C mainwt gumby &&
>> +=09git -C mainwt config worktree.useRelativePaths "$([ "$2" =3D "relati=
ve" ] && echo true || echo false)" &&
>
> Can we avoid using '[' and perhaps split this out a little further.
> Perhaps:
>
>     if test "relative" =3D $2
>     then
>         git -C mainwt config worktree.useRelativePaths true
>     else
>         git -C mainwt config worktree.useRelativePaths false
>     fi
>
> I think the duplication is more than worth the clarity here.

Sounds good, I'll make that change.

Best,

