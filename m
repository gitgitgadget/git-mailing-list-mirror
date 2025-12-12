Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C510234984
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545938; cv=none; b=UKlW0eRqkMUbtfXLW8ZVy4Co+YS8hX93cM/XI6vTMYDvfh9XMq7/qbz36c/xvGSlVq4WHuEZOqezdLpH1dqcruYgnKCu69b2s4PN5TlnpsLhTkvn5qSX9bTQl8ZnrM03LqFYB34nqacdouJ8FsTBbTu+bE6ubdcpzMwqcGLMjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545938; c=relaxed/simple;
	bh=mgwYPoAGvT9Autc+C0ykEXq+iZ5E4r7ga9tvR75A6UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYaDQTV2zCljfq+Ua1NPnCda19TRArIGoVQkWxkOEfRijcBNNEzs4VeVeGA6Uc23YVf57OP4c8Jx7El8pdjURo4qK5W0mPeinaa52hECNkC/AkEEO9f4zHBYwp/BGlDYk5IzY6dIDgaf8A6QQeC0RYXJeTpWbEMJhj23ts0a1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=OQJbkobT; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="OQJbkobT"
Received: from localhost ([47.65.176.65])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.1/8.17.1.9) with ESMTPSA id 5BCDPMQT005942
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 12 Dec 2025 14:25:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1765545922; bh=mgwYPoAGvT9Autc+C0ykEXq+iZ5E4r7ga9tvR75A6UA=;
	h=From:To:Cc:Subject:Date;
	b=OQJbkobTbmUFX5lFH7pEoNTG52ZZLjZlPdr0zi3n0sAlLryzaUwgkQvqa1BUm8qdu
	 /7yPCgZy6du+O9VMvHFYHQxQhfkOWPsYXuUES21xnC2OOWnUU/afbdF3mv2ae1VJhk
	 BAr2/ChSc0rhrjrG+o006oEkE5c49FkvmPJnh+Tc=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Possible problem in --pretty=reference?
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 12 Dec 2025 14:25:22 +0100
Message-ID: <ghfr9fbznh.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I just did a commit to code I am working on ([1] gives you a link to the
full repo) and noticed that --pretty=reference seems to not like my
commit message:

This is the output of `git log`:

------------------------------------------------------------------------
commit 93abaadcb0150e3555c91ff1f136cb029da87c0f (HEAD -> next)
Author: Dirk Gouders <dirk@gouders.net>
Date:   Fri Dec 12 13:54:36 2025 +0100

    line.normalized: fix a comment and a call of lsp_mdup2str() in the code

    When .normalized of lsp_line_t was given a null-terminator
    (ee7b96f (lsp_normalize: null-terminate returned data, 2025-12-03))
    a comment in lsp_line_t has been overseen.

    Fix this now.

    Further, at one location, .normalized is still copied with lsp_mdup2str()
    which isn't longer necessary.  That still works but doesn't show that we
    know, .normalized is null-terminated.

    Fix this by using lsp_mdup(), instead.

    Fixes: ee7b96f (lsp_normalize: null-terminate returned data, 2025-12-03)
    Signed-off-by: Dirk Gouders <dirk@gouders.net>
------------------------------------------------------------------------

And here is the output of `git log --pretty=reference`:

------------------------------------------------------------------------
93abaad (line.normalized: fix a comment and a call of lsp_mdup2str() in the code, 2025-12-12)
------------------------------------------------------------------------

All other commits look good with --pretty=reference...

Regards,

Dirk

[1] https://github.com/dgouders/lsp/tree/next
