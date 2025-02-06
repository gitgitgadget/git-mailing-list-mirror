Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5491A9B29
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872375; cv=none; b=JYw8F6KDv4znvcibUauObc644b/l+xhaduoKL4J9bp3Hy7rOIqLdrGZvX8flKxzA3mqG1hFm7QSiMm/j0yVAZJddEpmoJpl65Uic1ddjURiclhZVxDqfbeC+kZ8y8DPXcisfMy7XE/j0wzYchPv2d3C5k1B3aX+cslh2K7q6Lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872375; c=relaxed/simple;
	bh=DS6HHP4L5AqZeWVsjhldN5kuls5ieCI++PaM7AvGLDw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUKcBDREJoVF2UiqZZOLOd7wZaX+h3A6jszC0/xm8ysYd7IE0T1/SMbf7vsiO8nP5kpzZLy0HKDUj0nt5GwUa4ZUPeyIlaMhev0g1bHca04sW/HU6oq0+PlLRfUP7c9znW/cppFNf/YFvTTA1oa5CrEifiznWtAc9dRwmB+MRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1tg88V-003syw-6H; Thu, 06 Feb 2025 21:06:07 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 0A29160115; Thu,  6 Feb 2025 21:04:18 +0100 (CET)
Date: Thu, 6 Feb 2025 21:04:18 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250206200418.GD30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20250205214726.GA30202@raven.inka.de>
 <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de>
 <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206134006.GC30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 06, 2025 at 02:40:06PM +0100, Josef Wolf wrote:

>    foreach $commit original-branch-commits
>        git cherry-pick $commit

I've done a lot of try and error with this approach and have come to the
conclusion, that cherry-pick totally mis-behaves in the presence of
clean/smudge filters.

IMHO, content should never have any chance to bypass clean filter on its way
to the repository. git-cherry-pick violates this and commits the smudged
content, leading to problems which can be resolved only by using
git add --renormalize . && git commit --amend --no-edit

But even when git-cherry-pick starts on a normaalized commit, it tries to
apply the picked commit without cleaning it before, so again conflits will
be thrown.

-- 
Josef Wolf
jw@raven.inka.de
