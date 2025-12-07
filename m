Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDA2BE7B6
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.59.185.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765128284; cv=none; b=FSkZc35YYFOAU3RsMSEvAjo7NXTRFALpwppBjYOi1Hh/W24/gp+bGOhaejlsfd1jqKSvaBtNInKNH2NcoWjPrwysdtVzSPDRips/3b7Mqm1bAo2q9ZNKUteKa9W2XsSKdogTpYZVzzpIa8Rc87cdycTzW/TkZvycm1Cat4bDrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765128284; c=relaxed/simple;
	bh=Lxz/3q84hPwy5M7M+RqU2US/nadb+W4WJf65r+VjjHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYSjtstw9gXBXdLYstKWSi4kF7++oC/NGmr4rxzkaxihbqV0sB6lx/jyz3KVYppsU3dRUb3K8WwfTvQY7/Hslila9qWYJ08avncL6E6Sp8OpMJ9+rglDShaAtRBy7r+Oypv21EKT9zETA0rxUi2YuShsKpGlUphvCRYk69gJlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openmail.cc; spf=pass smtp.mailfrom=openmail.cc; dkim=pass (1024-bit key) header.d=openmail.cc header.i=@openmail.cc header.b=ppW3+MRE; arc=none smtp.client-ip=146.59.185.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openmail.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openmail.cc header.i=@openmail.cc header.b="ppW3+MRE"
Received: (qmail 31385 invoked from network); 7 Dec 2025 17:24:40 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with SMTP; 7 Dec 2025 17:24:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=2018; bh=Lxz/3q84hPwy5M7M+RqU2US/nadb+W4WJf65r+V
	jjHM=; b=ppW3+MREnYHgN73FLbGaYPHm7zhqxYTTiF3MOAheKixKUOl9J2wW08l
	23g+gQgV0EWscjxZWrHEym5Okzcuqk7TVtwtGmQvTe7rXVi8Yqn/75Md7z7tElaW
	peMi+VuCGGNenuXEykBBIkrhsQhooOcN8rX1NmO0SxgyONS/ilMw=
Received: (qmail 42951 invoked from network); 7 Dec 2025 11:24:39 -0600
Received: by simscan 1.4.0 ppid: 42941, pid: 42949, t: 0.0496s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (bWFuZGF5QG9wZW5tYWlsLmNj@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 7 Dec 2025 17:24:39 -0000
Date: Sun, 7 Dec 2025 18:23:30 +0100
From: Cedric Sodhi <manday@openmail.cc>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: git@vger.kernel.org
Subject: Re: Git for structured data
Message-ID: <aTW4EsiThW7WFwSl@air>
References: <aTMNdQ_NHTVPtwG8@air>
 <2ae0a2d5-e909-4c51-9459-83f5c6950d51@hogyros.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae0a2d5-e909-4c51-9459-83f5c6950d51@hogyros.de>

Hi Simon

If your suggestion at this point would be that I consider implementing an VCS in the database instead of basing it on Git, I'll be sceptical. I'd end up re-implementing Git's features.

I agree with many things you say. There is no magic recipe to apply Git to relational databases; specific tools -- at the very least one per database type, but possibly tailored further to the specific data it holds -- would have to be written.

However, I do think Git generalizes to RDBS more readily than it may seem and, in fact, one method to map a DB into a filesystem-isomorphic thing which Git knows how to handle, would fit 99% of all cases. Your example from KiCad (which can be understood as content which are stored in a RDBS), could be a good illustration:

If you normalize the file (one element per line) by sorting by UIDs corresponding to the individual elements, then you'd see no diff unless either UID or contents change. And UIDs typically wouldn't change unless you actually delete-and-recreate something. Every table in the DB which is normalized that way could be mapped as a single file. Of course a more granular mapping table-file or even row-file would be possible. In fact, mapping one row (or element of the Schema/Layout) per file would exploit Git's ability to detect "moves" meaning that you wouldn't even need UIDs for the elements to create good diffs. There is power in the semantics of the filesystem hierarchy which you lose when all contents become a single database/KiCad-file.

In short: In my opinion, there really doesn't seem to be any algorithmic difficulty. The only thing that stops Git from doing praticable versioning of databases is its inability to access its contents transparently in any of most trivial manners.

Best,
Cedric
