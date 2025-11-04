Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93233112D3
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248129; cv=none; b=ANVwmw8qLbLg5TuxIFL3JCJKGYKHDL3ZPAIAZTw3V7yZHvSqcZRBJTmg7v+4ijLaUkdtXcxrYK1PofxydzS5aNOJw7E9JlxtQE5EAGqn5MMrKjbtvJp2+O9vSeP5buUmoBbtpPjydatym26E3dMVeCOTUNptIU8clgzWf21azWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248129; c=relaxed/simple;
	bh=LTfTDYCXObnxQoKMXEmDuI8OpzHW1K9o3ibTY97Or8g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=soqJTqezrM99OD416eWA3L4WtEaEhwJiwJczaTGR/VQsHp4b1M6PSUNz7Zi7EnPuzcUoT0oFbg38oneq+mzprzMibF58iIaOI9Qe4j+vTp434bpASijXkbIoo8K5e9UfyhKB0J9CXsW9v8b+k4djCdonWDzwIy8HVMeFr5nA1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mroach.com; spf=pass smtp.mailfrom=mroach.com; dkim=pass (2048-bit key) header.d=mroach.com header.i=@mroach.com header.b=dd2QQFTL; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mroach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mroach.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mroach.com header.i=@mroach.com header.b="dd2QQFTL"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mroach.com; s=key1;
	t=1762248123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zpvJmqyA3xFZjy1DSY6gF8JCx0JoHSL0y2X6oP7mtwk=;
	b=dd2QQFTLZBN8nN6Ke+NJC4fYhgsNGA5BSmreH4i4b6fYuYKUEwV2gA5sjRZL2eNyIEUEPQ
	sLnA6/VSzOxLdeFu2dyhtm8brTwTvs7VoX20Ji8f7Fe/zKIcnQm1xdIp0MfIeNnICVeWa3
	wLem/schYwSTw95bbWZ2k+ghGp++X5SlpQp2TpBLPFJ6YaamFHowKpePKyYNMTlDIMRv8K
	vBcFybXlgM64aRVs0U5jV6jHiO+TJfLTIMMiuYUhDFNNcs3MTgIPShN8jNm/C2SUmIKsIp
	Rouo9/TrCg2AYHbZ2ouMU3xKnzUDMhowd9bJveckWNvxMHFjXAhcHIJTiFY4bQ==
Date: Tue, 04 Nov 2025 09:22:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Michael Roach" <mroach@mroach.com>
Message-ID: <0be81c5272a5e42c8471239a1369ee6c32401bb1@mroach.com>
TLS-Required: No
Subject: 
To: git@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I ran:
  $ git grep -rl --color=3Dnever '#!/.*/env ruby'

What did you expect to happen? (Expected behavior)

Get a list of filenames where the contents matched the regex

What happened instead? (Actual behavior)

For one of my files named `ensure-string-env.rb` was printed with part of=
 the path in colour,
and the first dash of the filename replaced with a colon.

What's different between what you expected and what actually happened?

I expected:
  images/deploy_tools/scripts/ensure-string-env.rb

I got:
  images/deploy_tools/scripts/ensure:string-env.rb

  The string up to the colon was printed in pink

Anything else you want to add:

I tested with both zsh and bash with the same result.
I teested with git 2.47.3 and 2.49.1 everything worked correctly.
I also tried other terminals to rule that out.

2.51.1 is the current version on Fedora 42

I was able to reproduce this with:
  $ echo foo > test-one
  $ git add test-one
  $ git grep -l foo
  test:one

This seems to be reproducible with any filename containing a dash

[System Info]
git version:
git version 2.51.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.11.1
OpenSSL: OpenSSL 3.2.6 30 Sep 2025
zlib-ng: 2.2.5
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.17.5-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Oct 24 14:=
10:01 UTC 2025 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
