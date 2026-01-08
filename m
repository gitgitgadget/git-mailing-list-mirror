Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0644414
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875918; cv=none; b=bCxXf84uezY+5qmROB6MRaH2xK6LUYH1mLw9E7J4956gpofk/MviLkxX5lG4nMGmdyyWoNzuoek7iaTC6070vB5pq9kwDtRMx6DRAzBo0ZAnKww+mLyo30WV9EMcjeRRwKUVXU6lzm+dsAqvvT8lWhtjJezeIo9utkZYZxEwuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875918; c=relaxed/simple;
	bh=Krcu7y6slZAKZwZ8s5FRhUz+srxcV9sz1uDcCq19KvU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From; b=gfM0UPLpimQnexTswu9/w3onfBFN9hn3Tn+sad3yZAqmfEiGtNm44zjlj/UKAmL96m8LL+Jp/aPe8TgRoI84wj3nOQaScCTe7kWgZlI4W8TOIwdvq6dGhXxlt+2EYS8Pd35eoYs2GMbziY3R6Y49ZBcyPYqBBhIojWE2HWpbCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct/6wXTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct/6wXTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38A6C116C6;
	Thu,  8 Jan 2026 12:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767875918;
	bh=Krcu7y6slZAKZwZ8s5FRhUz+srxcV9sz1uDcCq19KvU=;
	h=Date:To:Subject:From:From;
	b=ct/6wXTcjkLNVp2UIql5xJat6Oc5dPrM5eeA0+oexI3LcJuY814sv/DicYA4R6gcg
	 fG1RDRYJlY3vyDHoJGLKgoarjlWviLXY9B4qPt9Kp8Zez9R4PQtAaCaBZTLV5PDJeB
	 BhCh/GlHrAJFNdgtxQp0zpG6FO770+sSeCiRSr1d96LBgzANFVJEYnLNcpXBDhpVBc
	 18uKoxEcvYfrnYkWqgjamf/3QYSxDlIkueFoSjUjBqxEFc7ewn3SgwGp79SA81uqCk
	 38S+P9E9joUV2gF/FalfdWhe9ezdxSBGPBmXNZQLXf5CMa8CzgFuYz8jeG05TG5BXz
	 2rz6JV4UTJm8Q==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Jan 2026 13:38:35 +0100
Message-Id: <DFJ7PJVEVOYG.377TM7121KCQJ@kernel.org>
To: <git@vger.kernel.org>
Subject: Improved Rust hunk headers
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.21.0

Hey everyone,

Recently, while looking at a Rust patch [1] for the Linux kernel, I had
an idea to improve the hunk header for Rust code. The patch's hunk
header is the function defined above the addition. To me it doesn't
provide much value in giving context; it has been a while since I last
looked at that file. It would be much more useful in this case to show
the context `pub unsafe trait FromBytes {` instead. This is because the
function that's being added is added to that trait.

In the general case it still is useful to show the function context when
the contents of a function are changed. Ideally, it would be possible to
show both the `impl` block and the function signature.

I have no knowledge of the inner workings of git, so this might be a
tall ask. But would it be possible to implement having multi-line hunk
headers and have a more advanced selection algorithm? AFAIK at the
moment a regex is used to extract the header, I think that would still
be sufficient for this case, if the `impl` block header is searched for
after the function signature.

My current solution to reviewing a patch like this is either opening the
file and scrolling to the change location. This isn't possible if
earlier patches in a series already changed the file. In that case the
only option is to create a new worktree and apply the patch series. It
would be great if I didn't have to do this for simple things.

Cheers,
Benno

[1]: https://lore.kernel.org/all/20251216-transmute-v2-1-b23e5277ad02@googl=
e.com/
