Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045136215A
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232740; cv=none; b=OTeAytaQWM+S6Yc0SCTGLEBzPm9qoJdUCYIDv3j5YbbvliXEZ4HNUjO5FCLM7u5OrjPnHOkbmm/WnxkeH5NgFdNPtSBu7uDuzu7LdxMZEBWeIhOO6tJV4MtwVZq9hVuQiMaeVT7qgn1tVec7GuaWHmh0oWP2A6gKxDKHPn0Hatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232740; c=relaxed/simple;
	bh=AafzrgL4B+4aZgJ8bSBtnanMG5OK/D3FCtpLItud0iU=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=FiXetzZPH1eUMbPmyg8Yg1GwDjhyCP1E1gd58NPINpnCShCp9seFFZtbyFD0KT4qJ6qn5Powqne6sDUKs4iOcn9U+/LIbPtscgDm6aGoamlyramiYJqVdUuFJTMPobYrSPUfnC7w3436uU5iovZcAM+dn6Rq/6cLkkkUViFZ/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 28513 invoked by uid 3782); 12 Jan 2026 16:45:29 +0100
Received: from muc.de (p4fe155f1.dip0.t-ipconnect.de [79.225.85.241]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Mon, 12 Jan 2026 16:45:29 +0100
Received: (qmail 6578 invoked by uid 1000); 12 Jan 2026 15:45:28 -0000
Date: Mon, 12 Jan 2026 15:45:28 +0000
To: git@vger.kernel.org
Cc: acm@muc.de
Subject: Re: Difficulties using git rebase.  Help, please!
Message-ID: <aWUXGCI3fJc_Z4vp@MAC.fritz.box>
References: <aWPFxQloyfx8x0ED@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWPFxQloyfx8x0ED@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

Hello again, Git.

On Sun, Jan 11, 2026 at 15:46:13 +0000, Alan Mackenzie wrote:
> Hello, Git.

> Some while ago I made some amendments to the Linux kernel for my own use
> (at least).  I now want to rebase these changes onto the master branch of
> the Linux Stable repository.

> When I wrote the changes, I based them off branch linux-6.13.y.  The
> command I tried to rebase with was, with PWD being the pertinent copy of
> the Linux repository:

>     $ git rebase --onto master origin/linux-6.13.y HEAD

> ..  This didn't work well.  In particular, I got a conflict in a file that
> I had never changed.  Why?

> Well, I corrected the conflicts in that file, git add'ed it, git rebase
> --continue'd, then got another conflict in a file I'd never touched.
> Same again.  After the third such conflict, I gave up with git rebase
> --abort.

> Criticism: there doesn't appear to be a --dry-run option in git rebase,
> with which one can see how many files will be conflicted.  Instead they
> are notified one at a time, drip, drip, drip, .... to the user.  In my
> case there might have been four conflicted files, there might have been a
> thousand.  Either I'm missing something, or git rebase is missing
> something, hopefully the former.

> Incidentally, when I do git status, I get as part of the output:

>     Your branch is ahead of 'origin/linux-6.13.y' by 2012 commits.

> ..  I haven't done 2012 git commits in my life.  What does this number
> 2012 mean?

> So, back to git rebase.  Would somebody please explain why I am seeing
> these conflicts at all?  Please also help me make progress.  I'm stuck.

> Thanks!

I've had a most helpful reply by private email that suggested I try:

    git log --oneline origin/linux-6.13.y..HEAD | wc -l

..  This gave 2012, the number of commits git status says I'm ahead of
that branch by.

On removing the | wc -l from the command line, I see all these 2012
commits summarised.  It turns out, just the top eight were mine,
followed by

    733381204a86 Linux 6.13.3-rc1

..  So if I delimit the commits to apply using 733381204a86 rather than
origin/linux-6.13.y, the rebasing should work.  So I tried:

    $ git rebase --onto master 733381204a86 HEAD

, which now gives me conflicts just in my own commits.  Success!  I now
have the arduous task of resolving all these conflicts.  The diff I'm
working with is around 3400 lines long.  ;-(

So many thanks to my helper.  Why don't you say who you are and collect
the credit you seem to be due?

-- 
Alan Mackenzie (Nuremberg, Germany).
