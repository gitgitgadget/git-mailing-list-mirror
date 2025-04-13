Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA1A927
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744582916; cv=none; b=GXd6QzEv73l68fO6OmePEHA3w33h5Zoh672SWpxVQnwUjEKKAoiKyR+dwPpCTMBVq44OsIIxxAv+od8U1Qy+N7j8s2gJFE7IShDm1zqNX43dpYaBVVF51FTKsgzhRnnD+w1W8qkzE0TaGD9jNFJYlrBNJqItSzeaDC+jtu/bfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744582916; c=relaxed/simple;
	bh=dxKjj+hhs8xCp4r749S84H9oKRGahIV4Fe07432ZE9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=K6fAP9nSZxhiaJnk9QauBmIJeofUVa3cjY00SdxVJcYtU5/1swd4iS74ndf3yHwGkTtti5oMJh64Mc0PxxFOVEXpPmYf+VdUa6PC+zaSd4neQgqhGUYlkBAdDJSkhSRRsKIIzyWdFBI0geRmHckfUGGA92GYqiFBX0vk1UvLkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=kIhOzjzf; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="kIhOzjzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1744582907; bh=dxKjj+hhs8xCp4r749S84H9oKRGahIV4Fe07432ZE9E=;
	h=Date:Subject:To:From:References:In-Reply-To:From;
	b=kIhOzjzfKlYl7GOUUpRg0ZuXgOJ556qKcuZxn4yJTYSlO2Bt1+TS0xzZWli2HcwQp
	 tlc8CmDebz2NxsqOg32Tg4ds1Gf1TdhlAk7vntS1gUW+2L26dy9tTHonb3VPvHJcbS
	 HFZhzRNJ+ZaL1Yx7XkeXptFDK2s7Jh0JBj7gmbXc=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 3AD3261727
	for <git@vger.kernel.org>; Sun, 13 Apr 2025 22:21:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Apr 2025 18:21:46 -0400
Message-Id: <D95V0Z9YMEX2.3J99CE4F6ZP8S@lfurio.us>
Subject: Re: How to gpg signed email patches?
To: <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>
In-Reply-To: <fx2ofmmhkjmjqfqya5e3qvmovvmpnjepteqobcz4eia5sw64bg@yquuljpwok3f>

Hi

On Sun Apr 13, 2025 at 3:17 PM EDT, Klaus Frank wrote:
> how do I get "git send-email" to send the patches gpg signed? I tried
> first signing the commit but after spending time looking into the
> documentation I couldn't work out how to do it. All I discovered so far
> is that the "git send-email" appears to be using "git format-patch"
> internally and that's where it currently gets lost.

There's a conceptual issue with mailing patches from signed commits.
Once your patch recipient goes to apply it to their branch, they are
recorded as the "committer" identity of the new commit object.  This
would break the validity of any existing signature.

This is likely the reason by the related git tools (format-patch, am)
ignore this information.

You may have also noticed that commands like git-rebase and
git-cherry-pick will drop signatures from commits as well, since they
are being replayed onto a different history, changing the commit data.
