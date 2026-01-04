Received: from mail.codeberg.eu (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BCF14A60C
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767503613; cv=none; b=N97KpC1gO/tuAmoIdlb05ZK4DFJlQ5omEzMAofEjfcEBABpJe6ZKjvZPcYwFYPRCO3Eg+57MpupFJIqHgWbKxO33wTNEfTYgWY+k3/yA8nJDHDS3jtPRFOeZ1XkihDsjAHO5hCPo1L3jUUXc+a4zZtYzDHyAGCUHC5Fa30wgefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767503613; c=relaxed/simple;
	bh=o4JBuPGEsmlWfHgER9gqZfmaXqIAXcLJW9WoH1rtvgY=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=mpaIT9rZR8UAxz4K2qrWIUOVWWMjxsO5JfyCGqOJ1moJV+PSvePCRVWCIJd4otszO8RJMu4E3v+EwTRBeV3RM3r+9A4tEmPtYPWJ1bRZpYZ4lnqlmKwPEepgBcawQLijci/9HnKkYplOif8ppjBA7A+pB1N5MI0CBgA3THx8LLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=xP/3xKVd; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=UVl02wvB; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="xP/3xKVd";
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="UVl02wvB"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767503608; bh=H/Rb9Vf5YZM1PbIHDN6/i2i
	f+akXhsUZtS7hxtCJOrk=; b=xP/3xKVdsPdykqQPFmHUyFsfQbSKXHt7lwBLs7wJ48jITR64DP
	NzVgGI3ZrAEs68SGg4clL2k6vUdt7N+CXlUPO7oqpfDaPkB3Qt/RuSDC9eyxYs53NCUmVTi5moe
	qYnB5mBN99VjFKNstvk8/j3qesq86CVDtxleY/Ystd3NqpHxKLyRsBnSwYCHMCaUi0x4kUNqt6c
	sb/oPza5KulXnHB86Hle2gzlG+eRFnGgDBgW6p6YfLidDH5yULgsV3Ugy9dYnS86qYE3fQM31jr
	elfbHyibNxH+e2woGgROS/cjY7sZY4PAXHyAjGw9WCyFvEeUFA1d2PYRADMjlsqyCTQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1767503608; bh=H/Rb9Vf5YZM1PbIHDN6/i2i
	f+akXhsUZtS7hxtCJOrk=; b=UVl02wvBiCu4TbEGiJ/NLn52r1GXR96s4eSoP3etzk4mQc9CI3
	Xhp2KHctt1MIiesJYfWfqebQaFO9vl5stcCg==;
Message-ID: <03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org>
Date: Sun, 4 Jan 2026 06:13:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: git-last-modified weirdness
Content-Language: en-US, en-JM
References: <406222e6-d10b-47d8-a177-de5912db4512@codeberg.org>
To: git@vger.kernel.org
From: Gusted <gusted@codeberg.org>
In-Reply-To: <406222e6-d10b-47d8-a177-de5912db4512@codeberg.org>
X-Forwarded-Message-Id: <406222e6-d10b-47d8-a177-de5912db4512@codeberg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Resending this mail as it looks like it might not have arrived (couldn't 
find
it in the mailing list archive).

For Forgejo, I wanted to look into using git-last-modified to gain extra
performance for larger repositories where this can often result in being 
(one
of) the slowest git operation. However I noticed some problems that 
looks to
be bugs.

I've ran all the following commands on the following Git repository, on Git
v2.52.0 (Arch Linux) and my git config does not enable or disable any 
feature
that should've impacted the any of the following observations.

$ tmp=$(mktemp -d)
$ git clone https://codeberg.org/forgejo/forgejo $tmp
$ cd tmp

During some experiments I noticed it being slower for some files. An 
example:

$ hyperfine --warmup 5 'git log --max-count=1 DCO' 'git last-modified DCO'
Benchmark 1: git log --max-count=1 DCO
   Time (mean ± σ):      86.9 ms ±   0.8 ms    [User: 70.1 ms, System: 
15.6 ms]
   Range (min … max):    85.5 ms …  88.3 ms    34 runs

Benchmark 2: git last-modified DCO
   Time (mean ± σ):     151.3 ms ±   4.3 ms    [User: 133.4 ms, System: 
15.9 ms]
   Range (min … max):   145.4 ms … 167.1 ms    19 runs



This might be me misunderstanding the feature, but it looks to me this 
cannot
be used for paths that is inside a directory. The following two commands 
yield
the same output:

$ git last-modified -- web_src
24019ef5e83fd7bed7f31ad09dd8d5f26b4bdc69        web_src
$ git last-modified -- web_src/svg
24019ef5e83fd7bed7f31ad09dd8d5f26b4bdc69        web_src

Where I expected the latter command to return the last commit of 
web_src/svg.



I'm not sure why I tried this, but I can trigger a BUG when giving it some
nonsense input:

$ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584
BUG: builtin/last-modified.c:456: paths remaining beyond boundary in
last-modified
[1]    690163 IOT instruction (core dumped)  git last-modified

`fb06ce04173d47aaaa498385621cba8b8dfd7584` is the tree commit id of 
web_src. I
suppose this should've returned a nice error message or blank output. It 
does
give a blank output when you specify a valid path:

$ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584 web_src

Kind regards,
Gusted

