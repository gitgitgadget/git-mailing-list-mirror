Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B018E1D
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624961; cv=none; b=EaCQXr42szhABIjqXl9SoPdymsk0Z7cQreoZysPablb5WVHt2yq4RWgH+qhnGy/CAR1dNYQfc9M0gYCrinKhlrTF40yfHE6sdAY7IzZbNViDhb+f+rE4VXOmluqKszCZXWPQS2pBg5n+QRL8auPffWCcbjRqcNEDO649sSNkLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624961; c=relaxed/simple;
	bh=BxuLJSZUAvK+hXfZ6fU8KiKfT1JtIOUmBGpAV3cilHo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C0xpQdINOZNkfljP+PtMu/ngMnhfZIa7USLL9ZAw6+8rVNVbOhl9Jgk33ZzUcUgYeYcMG7brZ5SBc/pl9KjJtkJMiZkPVyDF48nXMcIg5IwmE9I0ZHOWWOJvmbg36/cjQFWnqf0DEqUCUWjpdu57iWUsXSV8ZRaMSzPdT9BqpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=RpLFxiwL; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="RpLFxiwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1709624414;
	bh=Q7cBNKAfuak5AuaIAnnv3Rj7NuqxFSxc8INk/eGPtqE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=RpLFxiwL8xUP0ZL163s/uHLBTXgQtLKIYcQ58PqrZ6cF1JwtPf7Bn/MbpAX6Ks8T5
	 w7QtDlmI6Rl/shpQ/nXVgR9z364G6JaVwLYAjjKuc++18jiGA2phnb9Vgivit8ousD
	 CyMJO5prydEw4egFf8RrS9/rodFRlfS6fZzWvpWb6ags0gBcB6LMvtnMLkqCiEzXHh
	 KjJgLSkldx9QNt9OuqTvcLj3pmndJdtnE3rf6MZKN1CB+5awvGf8FAvpCAYaIEZSsn
	 7hrAH3YINkZkzpeHPdte5qgJbgIi3XR/pawNeye73mTXw1LnVS+TyWaakB9f24z509
	 qTlzAN2/+l89Q==
Received: from [192.168.42.22] (56-97-142-46.pool.kielnet.net [46.142.97.56])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id AD4513C11B5;
	Tue,  5 Mar 2024 08:40:14 +0100 (CET)
Message-ID: <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de>
Date: Tue, 5 Mar 2024 08:40:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
From: Stefan Haller <lists@haller-berlin.de>
To: git@vger.kernel.org
Cc: Derrick Stolee <derrickstolee@github.com>,
 Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Content-Language: de-DE, en-US
In-Reply-To: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 17.04.23 10:21, Stefan Haller wrote:
> The --update-refs option of git rebase is so useful that I have it on by
> default in my config. For stacked branches I find it hard to think of
> scenarios where I wouldn't want it.
> 
> However, there are cases for non-stacked branches (i.e. other branches
> pointing at the current HEAD) where updating them is undesirable. In
> fact, pretty much always, for me. Two examples, both very similar:
> 
> 1. I have a topic branch which is based off of master; I want to make a
> copy of that branch and rebase it onto devel, just to try if that would
> work. I don't want the original branch to be moved along in this case.
> 
> 2. I have a topic branch, and I want to make a copy of it to make some
> heavy history rewriting experiments. Again, my interactive rebases would
> always rebase both branches in the same way, not what I want. In this
> case I could work around it by doing the experiments on the original
> branch, creating a tag beforehand that I could reset back to if the
> experiments fail. But maybe I do want to keep both branches around for a
> while for some reason.
> 
> Both of these cases could be fixed by --update-refs not touching any
> refs that point to the current HEAD. I'm having a hard time coming up
> with cases where you would ever want those to be updated, in fact.

Coming back to this after almost a year, I can say that I'm still
running into this problem relatively frequently, and it is annoying
every single time. Excluding refs pointing at the current head from
being updated, as proposed above, would be a big usability improvement
for me.

And I now see that "git replay --contained --onto" has the same problem,
which I find very unfortunate. In my opinion, "contained" should only
include refs that form a stack, but not copies of the current branch.

Of course, since branch stacks are only a heuristic and not a built-in
concept, it's impossible for git to distinguish between a pair of copied
branches and a degenerate stack whose top-most branch is (still) empty,
as in the example in [1]. In my personal experience though, degenerate
stacks like that are very rare, but copied branches are not, so for me
it would make a lot of sense to change the behavior of both "rebase
--update-refs" and "replay --contained".

-Stefan

[1] <https://public-inbox.org/git/
     98548a5b-7d30-543b-b943-fd48d8926a33@gmail.com/>
