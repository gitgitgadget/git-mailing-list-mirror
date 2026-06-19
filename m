Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DB3B38AE
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884056; cv=none; b=T2HxV8AnQ/EX+2/HnRGiuPlAqhO/CDJhnsFWekBigh9b6Sqe6x0VU+RAWxja4EOhgGzRpGw8bDpFlSgf6xGArQPOXqOb/GJ7aHEWRkvw3NiF7uvHRna8WYZW/VrTf7XtcAqsIULZoSdIX953GFAl5wm8f/yBT3P9HUN8COyNhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884056; c=relaxed/simple;
	bh=UW0LgLTcOJxD6Fz4Pw/+sR0mFuacZ8J4dxSoYCLbRQg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BQo5xy38J4ukSazvNNSR4I0hecsGmrMeQ9oYNmrEhqxW29gRifdKBG2Em7gfY97w8cW4tUU0NGabN1Ol89w64X5wkiJu2cfFfU4cwDFI14tRA+slgIg3bGeMZ3GwJu04xkajg9qtbmf2oNbmfv9VPYwFnKJ7dNh25JD14oVbt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (2a02-8428-1b1d-4d01-96a9-491d-7b48-ba31.rev.sfr.net [IPv6:2a02:8428:1b1d:4d01:96a9:491d:7b48:ba31])
	by joooj.vinc17.net (Postfix) with ESMTPSA id 770273A1;
	Fri, 19 Jun 2026 17:44:48 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id 39683CA37B1; Fri, 19 Jun 2026 17:44:48 +0200 (CEST)
Date: Fri, 19 Jun 2026 17:44:48 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: git@vger.kernel.org
Subject: Strange behavior of "git log" with file argument
Message-ID: <20260619154448.GA769454@qaa.vinc17.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3.3+139 (2de20fe4) vl-188789 (2026-06-12)

With 2.53.0 under Debian/unstable:

* https://github.com/git/git.git repository
  at 95e20213faefeb95df29277c58ac1980ab68f701

"git log git-gui/git-gui--askyesno.sh" outputs nothing. To get logs, I
can add the -m option. In particular, this shows 3 non-merge commits.

So the behavior without -m seems incorrect, and at least unhelpful.

* https://gitlab.inria.fr/mpfr/mpfr.git repository
  at 74cb29f0908c2887dc8c3e6ba7a3c5a2f20710a3

"git log --reverse AUTHORS" shows only 2 commits:

  bfa9d064e1cf7a736740c73b9773eabb11da6ed7
  5a9521d1f305268e575c4a5c4de13614acef6321

where bfa9d064e1cf7a736740c73b9773eabb11da6ed7 corresponds to the file
creation and 5a9521d1f305268e575c4a5c4de13614acef6321 is unrelated to
the AUTHORS file:

  git show 5a9521d1f305268e575c4a5c4de13614acef6321

contains nothing about AUTHORS, and "git log AUTHORS" does not list
this commit. But "git log AUTHORS" also lists

  b28347ab59db2a99168a17c3e1804000069199aa

which had been done *before* the AUTHORS file was created!

Note: According to the git-log(1) man page, the --reverse option
is supposed to affect only the order, not the list of commits to
be shown:

  --reverse
      Output the commits chosen to be shown (see Commit Limiting section
      above) in reverse order. Cannot be combined with --walk-reflogs.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
