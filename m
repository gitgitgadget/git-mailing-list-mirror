Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4251859
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727508824; cv=none; b=P0kO1n+PeQx6Phi4xvSacctrOoV6F/UzXpANSmiUPXdxyFAzIf4eeEJEy7QRVEtAQcIIbwYDnVyCsvrKSJGPMQ2b+6SpAbx83qFniEkYVQpFjSe/Jab5w1yTebs2C6Rtk1kdlHgB/E+Tp3uPVuSOsLxhFUUjQVpuNwp1dHekUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727508824; c=relaxed/simple;
	bh=5IwEAkI5wRvnwlT+ClAbBzvRLvyJgKGhd8sH44WwnBI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qTbZt0nIvQawlqn1SrZUby8ib6dMGVAf4VLwrQ7z5uaNs1va5AzDDXXh94l4v0Yr29D5qY2MXrDmqDwcZaS3mjJyFkK4rj8fphd8aTmAjEpbDv5LLVFOOuY7EggZG0+FLhLSWApoIaO4gMz6JsUS0hujjkGGGR/AID86yxl+G34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4XFyrn0vsTz5ttr
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 09:00:09 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4XFyrb0Zw3zRpKl;
	Sat, 28 Sep 2024 08:59:57 +0200 (CEST)
Message-ID: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
Date: Sat, 28 Sep 2024 08:59:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: How dangerous is --committer-date-is-author-date these days?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The option --committer-date-is-author-date of git-rebase rewrites the
committer dates like its name suggests. It is not uncommon that commits
are rearranged and cherry-picked. Then, as a consequence, author dates
are not decreasing when walking back in history. Now, if such a history
with a non-monotonic author date is rebased one final time with
--committer-date-is-author-date, this creates a history with
non-monotonic committer dates. I recall that this is not a good thing to
have since it can confuse our history walker.

- Why do we have --committer-date-is-author-date in a porcelain command?
- Should we remove it?
- Should we require an explicit --force instead of implying it?
- Should we issue a big warning about the consequences?

Here is the discussion that introduced the option git-rebase:
rebase -i: support --committer-date-is-author-date
https://lore.kernel.org/git/20200817174004.92455-4-phillip.wood123@gmail.com/

I am asking this here after I have participated in this Stackoverflow
question, where git rebase --committer-date-is-author-date was suggested
as a solution to "rewrite name and email, but not timestamps".
https://stackoverflow.com/questions/79024409

-- Hannes
