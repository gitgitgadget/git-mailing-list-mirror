Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D61D6389
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855036; cv=none; b=NKnmOmSHhhb+WgM0ISFirikPvzZPNeoTve4D40tWb8D3WSJNdGK2yGOEqj2zpEzjQdVWafRNNg3FWZSroV35Guznp8t3JLqAyxPbg/62l+ncRq5TNeEM56kurBRIjxm88M+a6OIkI7SakgKiZ0SVM59cofG/tV48u2tkumLwWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855036; c=relaxed/simple;
	bh=7PEz5yY4hpmXL1mimT5s75UNnSyrXWxtGzFGDKmbTGE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RIv/y9QgvGHOZA/pYdRWYp8YvVYtTDs+cgDzcVrLsfbUCXmSA6B4VWCpDysOtxK3TRO7s6KBxQeCHrLxaMBx/9LVaF3N2Sis7bEubizqmS1fgLwOXJiwchJc2+fq6Lxd/cs2ZRZZVarxZcTe1z4748GCagvMtVaDkqsC/lcPLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me; spf=pass smtp.mailfrom=amyspark.me; dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b=V77zq/EL; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amyspark.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b="V77zq/EL"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 846D140003;
	Thu, 11 Apr 2024 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amyspark.me; s=gm1;
	t=1712855032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vGpi1DgkCatbCw14JyhJYtcq8i9tGnyL2ceRl//dhA=;
	b=V77zq/ELfR8gmzu6zfmg5YsuFPnwnv6PilMWtopPd8cI/+IJRy+oZR+1XjlOjk3C7oYONB
	YcuT1jJNOaROYrrSt2yChnzT6qJ2wJSu3Nqf+dlYaZcDXJw91BKuKRxV8WQS1YHOJNDAni
	FWtV5r9U9e2zy//3KwrACAa3h/A/KVx6xbXCqjXfvVQlTpMCvWoXp2Apw/FVpSOJUcTpJl
	wjcywv5fPx1vFGSnvUpU89bPd4mU5OK6AlcewYu34JMer1q8A8fhDflTgNCGEEPcfeWlpA
	f1an1lKWtICSMQm6ibbb05ULQRYIilEmN817XW3c9P4Yy8SLpTlhAbrhimwjSw==
Message-ID: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
Date: Thu, 11 Apr 2024 14:03:43 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: git@vger.kernel.org
From: "L. E. Segovia" <amy@amyspark.me>
Subject: [BUG] Clones from local repositories do not work correctly under
 Windows
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: amy@amyspark.me

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Under Windows 10 21H2, I cloned a Git repository off an existing local
copy, then applied a patch to it using `git am`.

What did you expect to happen? (Expected behavior)

Operations on the repo like `git status` and `git log` should work out
of the box.

What happened instead? (Actual behavior)

I keep getting this error:

> error: unable to normalize alternate object path:
/c/Users/Amalia/.cache/cerbero-sources/librsvg-2.40.20/.git/objects

With `git status` it happens only once, but with `git log` it's a wall
worth of that error before the log is actually generated and paged.

This error makes Git complain, but tools depending on it (in particular
Cargo) outright crash. For instance, this is the error I got when
attempting to build the Rust crate above:

> Error: CliError { error: Some(failed to determine package fingerprint
for build script for librsvg v2.58.0-beta.1
(E:\cerbero\build\sources\msvc_x86_64\librsvg-2.40.20\rsvg)
>
> Caused by:
>     0: failed to determine the most recently modified file in
E:\cerbero\build\sources\msvc_x86_64\librsvg-2.40.20\rsvg
>     1: failed to determine list of files in
E:\cerbero\build\sources\msvc_x86_64\librsvg-2.40.20\rsvg
>     2: object not found - no match for id
(32467a0191907fd571b502e395d033a06dfee655); class=Odb (9); code=NotFound
(-3)), exit_code: 101 }

What's different between what you expected and what actually happened?

It seems that under Windows, the code in
https://github.com/git/git/blame/436d4e5b14df49870a897f64fe92c0ddc7017e4c/object-file.c#L525
is not able to resolve the absolute path of the "remote" (the original
copy) at all. I checked if it was a filesystem traversal issue by
issuing the clone against a folder in the same drive, but there was no
change.

Anything else you want to add:

Possibly introduced in 2.39.0:
https://github.com/git/git/commit/199337d6ec5c656e52b914b5dac3820cc5e363f3

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.44.0.windows.1
cpu: x86_64
built from commit: ad0bbfffa543db6979717be96df630d3e5741331
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 13.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]

-- 
amyspark 🌸 https://www.amyspark.me

