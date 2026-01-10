Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959CC28A3F8
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768065767; cv=none; b=DHfiDXKqbamQMVand7XimpuiQuVuJNuPZ8QHaYEkXdg0LJ/LX90GXjBjefd7KfDPTiICtMBOaY1XKT9Zn3yAJPAWRHX6+WPC1AOjnz2YQH4eQMklA8wVgS3jNox9RRKX0Wp+gq2xW6iYFVL1cby409I3oKiVF4TvWwaD/7VfDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768065767; c=relaxed/simple;
	bh=XCDxgeJXcQpqV5Pkqmtgu63JpkSwnpDRqUBO5visPDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7F4cE9sF2BTcNFQ7A0MqMXx4SUUUUG2PRneG0sydvS5OLYtAc+sFdpUR2h2CiXzRBvZol0OUPcI2cPNJROdQ9WTOVmOAJ7U8db+n3NQzp/ih1sYrkY7omX9gxKLlqLXwrDcgEaqW4SLNsG+21qeoBusgrb1y1i/4wAvOIdnQsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub; spf=pass smtp.mailfrom=mail.dietrich.pub; dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b=TPZfkc9N; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.dietrich.pub
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.dietrich.pub header.i=@mail.dietrich.pub header.b="TPZfkc9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.dietrich.pub;
	s=protonmail; t=1768065752; x=1768324952;
	bh=cUqOunecZXYp6oi9UB/U9z37gQXmeut9h4IlScZEtYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TPZfkc9NDEnWSLCN3n7rFZntH0l7lBch+k32aOBhzhXOSwl9zcK+MOxgdJC6HtdPZ
	 I1dnrPncaWrOoSo3fcTEQ0ixFiIb/7Qxn5cBzhfqVVPF2AP3jVBX0hI1XMcvTrHZ+9
	 DZgwAyyZE9Llfm5FQ29us4TCY+xDwLLs7oR/AKSjJ8bT966LTKtP6hkE3qQsg8o8jL
	 N3TAFokxdBAsJdHQwHm3It4ubPm50+9JPq1OjVdwBJd6yndu4K564MW37KiYU+mmkT
	 4lSbbqWomYsnIY6RPB58QU0rAtxBTBSkNCbKTcq+FvYtswtrpbNstaY2sjudxWht8q
	 lr0LuDu2OfNiw==
X-Pm-Submission-Id: 4dpQSR1zBLz2SkKW
From: george@mail.dietrich.pub
To: ask+git@howdoi.land
Cc: george@mail.dietrich.pub,
	git@vger.kernel.org
Subject: Re: [Bug] Git subtree regression
Date: Sat, 10 Jan 2026 12:22:19 -0500
Message-ID: <20260110172219.125762-1-george@mail.dietrich.pub>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5794d99e-a7e6-4258-9a1c-1512c3f577af@howdoi.land>
References: <5794d99e-a7e6-4258-9a1c-1512c3f577af@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I did! Thank you so much! It seems it not only produces the correct commit hash but is also quite a bit more performant.

```sh
$ git --version
git version 2.51.1

$ time git subtree split --prefix="src/components/clock"
4ee66f8198b2532110b75a36575e363ccccff47e

real    0m32.971s
user    0m18.856s
sys     0m14.627s

$ git --version
git version 2.52.0

$ time git subtree split --prefix="src/components/clock"
0efb3d9858e3bfee65165508aeeacc50417c9a99

real    0m18.680s
user    0m7.698s
sys     0m12.842s

$ /home/george/dev/git/git/git --version
git version 2.52.0.408.gecb62f5599

$ time /home/george/dev/git/git/git subtree split --prefix="src/components/clock"
4ee66f8198b2532110b75a36575e363ccccff47e

real    0m10.816s
user    0m3.909s
sys     0m7.755s
```

Thanks again!
