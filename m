Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E771DB34B
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132165; cv=none; b=GYMjf0/1gv7YRN1A+8YSW4moY93QNu6Xpn71zHa2WJzKfCkAcucaHAJJxm3F3vDQ8H9NhDwy9JNoq1rm3mBmXvKH1TeqlnqwoLVqQEDZ/9X9djkUqAq1J9hWR8e2TizGDFwCoR/IuD0E4uheWQIHgok6JfDlWtDjpX/MhSr4TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132165; c=relaxed/simple;
	bh=JJx0lGMgbKsJqphz7873kD53i0z9QbddvP5l+ByuJZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9XgLmZXpZgaN3EL4Q988jaAFOEBPZYjNv8NxXIKQs/mJXbyFSvf8l5YKVWzp6YWdhM+ESKQC7kcFOZaFAZRO/fVS+R9KjFpBGu6zZQNQmSwB49CmJj5UyTO14V4KqW8vgU06tcezfQwpgkkdKyLoYdcfD9WMtUUPIEOOqfUEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXkNmMEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXkNmMEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46697C4CEF2;
	Thu,  5 Jun 2025 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749132164;
	bh=JJx0lGMgbKsJqphz7873kD53i0z9QbddvP5l+ByuJZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXkNmMEBVkVWzBm4pSlHr2HHVCAuRYW+ZpBe0S4HN4O88X7HXrIOamjq8mHTFCtDq
	 V6Mlt+8Gax+juhn2ZDq9nMHKDPb9UkaNp120ehdSqZCRJshKEfa2TbkXX1oLRHT+QU
	 HRfzXpqMoqbZBuupC80ynj7SFP0tPSxrR14ziLwg=
Date: Thu, 5 Jun 2025 10:02:40 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
Message-ID: <20250605-flying-lemon-junglefowl-4c1d64@lemur>
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
 <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>

On Thu, Jun 05, 2025 at 12:16:26PM +0100, M Hickford wrote:
> Hi. I'd like to fetch from a particular remote, but only if that
> remote hasn't been fetched in the last hour. How could I achieve this?
> Is there a relevant option for `git fetch`?

Not to my knowledge, but you can either look at the timestamp of FETCH_HEAD
(if that's the only remote you're fetching), or wrap git-fetch in a small
script that touches .git/last-fetched-foo file and you can then check that
file and exit if it's newer than 1 hour ago.

-K
