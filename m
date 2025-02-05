Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CD214A7C
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792110; cv=none; b=nuMwdXf8o/YCOwV8WA4Z9AjG2wu7vk0vK3TwvnO3O36W+oE0PWVpKeLKqEq1Jg/OhNiH1/JR5dbhWA3d47WTcTblVQueLEdj7J0USjBjQHTVDr1pG0N+0TQdhyVHzwL40L3JEov9iv2Xu6TuNFVK2StKWv54J8c1gxPdmDRLggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792110; c=relaxed/simple;
	bh=VnUN9xitvqhSg1voyKhVXxoXO3bSds8a7tr7XoMJ7R8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mkl0advEbPYQdLgCh6jT6mJqHyUEqyOwc3heKuuSmUOHjiIz6lkB2fEo6m8AMqondBiroCEXtWH6qCZ6mBP1+jEzybA9qKr/OBj/3kxcIq9GROfzSAke3i8U+KdNDh6UenKyJaeknHyqwG1FreWx1OkBQbA3fCMsmU1fmHmCOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tfnFo-003N3y-LD; Wed, 05 Feb 2025 22:48:16 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 22C3D60115; Wed,  5 Feb 2025 22:47:26 +0100 (CET)
Date: Wed, 5 Feb 2025 22:47:26 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: renormalize histroy with smudge/clean-filter
Message-ID: <20250205214726.GA30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hello all,

I have set up clean/smudge filters to normalzize files from an application to
reduce the pain when those files are tracked by git.

The clean/smudge filter work well on new commit and the result of
smudge+smudge+clean is the same as the result of a simple clean, so the filter
should be fine IMHO.

But whenever I do any operations which introduce not yet normalized commits, I
keep getting errors.

So to get rod of those errors, I'd like to also renormalize the history:

  $ git rebase --root --strategy renormalize
  error: Your local changes to the following files would be overwritten by
  merge:
        foo/bar/baz
  Please commit your changes or stash them before you merge.
  Aborting
  $ git add foo/bar/baz
  $ git commit -m renormalize foo/bar/baz
  $ git rebase --continue
  git: 'merge-renormalize' is not a git command. See 'git --help'.
  error: could not apply abcdef... Foo Bar Baz
  [ ... ]

Huh? I never entered a command "merge-renormalize"

BTW: It does not make any difference whether I add "-c merge.renormalze=true"

What would be the proper way to renormalize history?

Any help?

-- 
Josef Wolf
jw@raven.inka.de
