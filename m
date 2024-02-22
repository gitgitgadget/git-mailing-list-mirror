Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87A548EB
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630459; cv=none; b=LQGeHo9bIdhWZEQLbQKGH2KTyVOC+vyrWCqmYqZvyQ159auA1nGnfTGBjDATBaqwnTL3F/dPV28n8W5k1syn/bkSiGPCxNhwzgFyh7bN24LfU+UECoI056uiUI88KKyShc8x/Bd6MrsgYSOweJdcduxznwQGTDmb/iyhxoZpajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630459; c=relaxed/simple;
	bh=sSN2Ud2vS2Z02nQ9AFJdzGCv1ogo0uaaEWWDm9KkiP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbDgCgXqwLN7ADmZOBNp69hk8aCyIrhKUBK7ODm6HSwO7O8gCMylzVw/zGcU/lBk5toU7X4EnOqmYozDW75j/Uv7yHeFeQ9D6W0tgABgBGuT/pj9+uCc5kQOHVhsXMwi2Fu74H9VKkKtIOpuyNANn6hQ7Pmxc0Eo19GH5GaGO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WxfITQD+; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WxfITQD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1708630454; x=1708889654;
	bh=sSN2Ud2vS2Z02nQ9AFJdzGCv1ogo0uaaEWWDm9KkiP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WxfITQD+qr0OayRydxkbjbhv0a50i9Y5tIeXAXPqXE6s2naRoRTtY/ZiBpDNq9tkm
	 ReKtHpX8o0EODyaKvx6mmPtkn6bAYkvoLK1vommHiTG0B9345mLPhjt18B/XpZh5Gm
	 QIjpBC83r1JIRHGkFkE4Wx6jvCpBfNwtE7YfiEZcHdLi3pzDmHOCDMreeY7l8dswY+
	 qJRcFxIV8msBcpfdu+TBEJgx/uHuvMQuD0LMZWDBwqfnNOC6flQUvPnqcSZdaWN/eC
	 NyUigOXXjzBhxF+erWg0L6Hhqy6x5PHQNkRTDcRUgJttS7nnMDEWFGrK/AWSRf6UBB
	 ilW2MVHuu8Oqg==
Date: Thu, 22 Feb 2024 19:34:01 +0000
To: Jeff King <peff@peff.net>
From: charmocc <charmocc@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git commit causes data download in partial clone
Message-ID: <MIda3qF70GEKtbezTxMyZo7RrlyBmvzN8w1T28cnCro4dmTqwjhQjBe2A-PYbgS6jkkev3pzd4oxqmbOfucfifVhTRQsynmjCpbQmvPzm8k=@proton.me>
In-Reply-To: <20240220024310.GD2713741@coredump.intra.peff.net>
References: <OK9E_kNDYqB1tDn6YJhtTgkdDDrcr2LhZEGRdmqismu6KyTki-M22CpCAxXHZCn45SZICjnPNYxvw02BnWeJic3mx47-zeI0HDhzdgoJpG0=@proton.me> <20240220024310.GD2713741@coredump.intra.peff.net>
Feedback-ID: 101377472:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff thank you for taking a look at this.

On Tuesday, February 20th, 2024 at 3:43 AM, Jeff King <peff@peff.net>=20
wrote:

> a. Your --no-checkout skips the checkout, but it does not tell Git
> that you are fundamentally uninterested in those other paths. To do
> that, you can try the sparse-checkout mechanism. I'm not super
> familiar with the feature myself, but doing:
>=20
> git clone --sparse --filter=3Dblob:none $url nes

That's it! Now git knows exactly what I want from it. I am now able=20
to add and commit new files and git status no longer lists any deleted=20
paths. Also I can search for files I actually need with "git ls-files"=20
and add them to the sparse checkout incrementally with "git=20
sparse-checkout add". I haven't explored this feature before because=20
because I assumed it is limited to selecting entire directory=20
subtrees not individual files which would not help with the=20
mentioned repo.

> Do note that --sparse checks out the contents of the top-level tree
> by default. That's OK for your repo (all of the files are in the
> Named_Titles directory), but it might not be true for some other
> repos (it may also not work if your intent is to put another entry
> into Named_Titles, though it looks like you might just need to say
> "git add --sparse").

I think this could be avoided by cloning with --no-checkout,=20
creating index with "git reset" and setting up empty sparse=20
checkout afterwards with "git sparse-checkout set /".

Anyway it seems like with these tools I'm finally ready to tackle any=20
huge git repo they throw at me in the future :)


