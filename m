Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840D1836E2
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854527; cv=none; b=Yifnl132V6XyH6HlZLAwSFTV1Qp0R/HfXbWjYAi6TgwJ6lQ9J2PMquekB1ehYZTdaE7eH/Hmv6Iho+TXW8+CHgjAM73ifKT5vITgjw8ohMOEcGqQ8HWTiR1DqAqk1PakP7xFwCjQpTxfcx7U7gctBYXGx2P8TFKhvVtivFey6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854527; c=relaxed/simple;
	bh=ZWO6nQbtkDdPdkyPM+3y0I9kFv7jd5z30e8rgyG2ttM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=RIX33xWRrPAkg2662rUnZqb/bTmHzCEETP3lM2WQzP5lYhOuzxIfmfCPGer0DodlssTq2cHvDGqP7spsc1SFEeSRF6tZR8JzpUbvi7Yl0e7Mgb8862NbdctVPc45HYSREADpCqa4TJiQdMZfynNhJiWMzMm+MRKCxNun61aSPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=ZnA/rDSt; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="ZnA/rDSt"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1726854521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZuoyxQF0pH9iUOmH+tq6NZUUukB8c4o1HgKA9DYHz2Q=;
	b=ZnA/rDSt2eokoG5DJfEaJ0erM7/Y8oawBMLwEKPr9sudWaLg4I0kZvoIBTpU7GdN1WkvA2
	i3uVB1uI4Ic/ETL1xpLL7tU22yV9foqY5VozoIBu0EjlQdfvHE0oi64PlRrFGDriNPjW9q
	o93qYDc2n8TrQX2uFvSji5bwtzF22YA=
Date: Fri, 20 Sep 2024 17:48:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <4ace58897feee2d86839af1a36770e49810e59b8@rjp.ie>
TLS-Required: No
Subject: Archive from bare repo?
To: git@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi git,

I'm trying and failing to create a specific archive from a bare repo. The
following all works correctly:

  $ git clone https://my.git.repo/test --bare test
  $ git --git-dir=3Dtest archive @ | tar -tf - # archive of full repo
  $ git --git-dir=3Dtest cat-file -p @:.gitattributes # shows subset of f=
iles with myattr set
  $ git --work-tree=3D/var/empty --git-dir=3Dtest reset --mixed
  $ git --work-tree=3D/var/empty --git-dir=3Dtest ls-files ':(attr:myattr=
)' # list of files with myattr set

Now I get:

  $ git --git-dir=3Dtest archive @ ':(attr:login)'
  fatal: pathspec ':(attr:login)' did not match any files

The manpage indicates that git-archive should use the .gitattributes from=
 the
archived tree, and as indicated above it has the expected content. Why do=
esn't
this produce an archive with the files listed by ls-files from above? Is =
there
a way to achive the archive I want?

Thanks,
Ronan
