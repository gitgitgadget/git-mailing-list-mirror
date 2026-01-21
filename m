Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D1410D1B
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996935; cv=none; b=jj4RkA6YGN/NapZkacuzkRZVTFk+0CZx7TZmfXn6E4By8mFBR9TnDueiXGI7UYd0/XqIqGL0ZrSGCmY52ef75AZ9fBK0egD4Wfp28ZQbqUJ+z1rCzbD2Xu28BzXz7tKrhG6WAdNIYR1Zvv4+p9hFWxMjXPsDdQmRuewfrkQD68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996935; c=relaxed/simple;
	bh=5PfXraV23oIW+Q805/dMQMwGj4itUjf61YqmSpC3bok=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=be4l2ZdMDczMvWNxRuVW9p5Vl5UaL6jp03z8DzQ6BlZdg0KYpfWeyaOmzEmFPIDhksYER3X2Zzi+V+n97B9ORtdVa/b6qRr2FzCefyTQZYXHPka4bAT49LlshYj6KHCMVPZQV9fiD7Spxa96gJVRJmSj6PDVUJcFqh7sEGOY90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 142883F9B3
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:54:36 +0100 (CET)
Message-ID: <a612ea8e-a741-436d-8ed2-6ff09ba7945b@hogyros.de>
Date: Wed, 21 Jan 2026 20:54:32 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Missing and omitted objects
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

we're having a bit of a discussion in Debian.

The goal is to move towards git based storage for source packages, away 
from tarballs; ideally we'd like to reuse the upstream git archive as 
far as possible, so it is easy to check for differences.

However, some projects are shipping files that aren't redistributable, 
or that we want to omit for other reasons (such as vendored 
dependencies, when there is a perfectly working common version 
available, and we really really want to make sure these don't get used 
accidentally).

The goal here is to allow the recipient of such a bundle to verify that 
any files received are unmodified, and get a list of paths that were 
removed (which may be an entire subdirectory). Ideally, they could also 
continue working on a clone of this and generate commits on top as long 
as the affected paths aren't touched.

The minimal amount of data we'd want to archive is a single commit and 
its tree and dependencies, plus optionally a signed tag pointing at it 
if it exists (i.e. the same information we get if we use git-archive, 
plus the signature on the tag, plus the option to clone from such a 
snapshot). For the simple case where nothing is removed, this already 
works well and covers most of the use cases, but, sadly, not all of them.

As a side effect, this could make recovery of a broken repository that 
is missing objects more robust.

Right now, I'd like some feedback whether someone has a better idea, and 
if such a feature could ever work or if it violates some fundamental 
design principles.

    Simon
