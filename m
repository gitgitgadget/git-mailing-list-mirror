Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5932459E7
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964577; cv=none; b=gyoOeXY7G/BwZ/Hhv0V+UT7cvwMYZ9F76kzvj6yf/oIBNy+LPl5fyHj5MfXWZelrMLGbw6DO19MAsAwj4mnuT8ZBHjKc5AEUr7peJ0LXS3cDYSGcPeH5g3d0FcthVoYS74LUkg6XgJ9nblMMmKzyGLOUa8uE7IoDg1nUNTTJZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964577; c=relaxed/simple;
	bh=ECv7TT5PfGrvpRCAzef7LHzTwnce8I6fMeTPKeViPFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9jTnCz1oMBnz2MF8IYvXkbtA9lIGLeZs+3lpLzk09ITissUKGDmrS16uZTNQdMdxoqOYClOvv6xgMQTKhV1LvWze3yYYThl4vBitRKmdfILLvqjh286BPk25YJaV+OsIlLXdY1eNHVlfz4+UwL/V2Dnt1zMzVtQurv3SwGlQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Necl7FpU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Necl7FpU"
Received: (qmail 8681 invoked by uid 109); 29 Apr 2025 22:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ECv7TT5PfGrvpRCAzef7LHzTwnce8I6fMeTPKeViPFQ=; b=Necl7FpUlyRfiFzWEKOL+5GBGVSbMP9Ctt/wGsZnd2nNJoPjpTmQCxNVf6esJT5Z0UNf5oyuRs/cxAY8xU+RwC1GCtfbYJq6s0k+4lUhacQqsmGDu45oRENEchnNr6BTnI35zzOAep7Cq4aoyLGQAEOnDoFADcq0vhATxTbJ7xCBm9b+lile/vbrmaxs2A2YTHkqWPHXuJogA14ORz7qRqepuBe/DOO6rFvvKE+ATDV5Dvmih2bDDSA70/97uCsBxkeK5hHPywm943iFxLQcZ3R2zFc72Zd2MRjd5p0Ue6EPeD0xxzP85oAz6Mi48RMTek4WBGCvCsnutrqPcJizOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Apr 2025 22:09:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13722 invoked by uid 111); 29 Apr 2025 22:09:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Apr 2025 18:09:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Apr 2025 18:09:33 -0400
From: Jeff King <peff@peff.net>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
Message-ID: <20250429220933.GC36727@coredump.intra.peff.net>
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>

On Tue, Apr 29, 2025 at 10:16:15AM +0100, Leon Michalak wrote:

> - make `diff.context` setting extend to the interactive patch commands
> (not sure how a change like this would be welcomed considering it
> could change users command outputs seemingly out of nowhere)
> - add an `interactive.context` setting that would work like the
> existing `diff.context` setting but apply only to the interactive
> patch commands

In my opinion it would be fine to respect diff.context (and probably
diff.interhunkcontext[1]) by default. Though it does change the command
output, the interactive output is by definition user-facing, so we
shouldn't be breaking scripts. And we already respect other porcelain
level config like colorizing.

I think the only reason we don't already do so is that the interactive
code is built around the plumbing commands, which conservatively avoid
various config options. So the calling code has to explicitly check the
config itself.

-Peff

[1] Looking at git_diff_ui_config(), which are all the options read by
    porcelain git-diff but not by plumbing git-diff-files, etc, there
    may be other config in the same boat. E.g., I'd guess that people
    with diff.colormoved set would appreciate seeing that effect in the
    colorized versions we show. But I think it is OK to just consider
    diff.context for now, and see if anybody ever cares enough about
    other options to look into them.
