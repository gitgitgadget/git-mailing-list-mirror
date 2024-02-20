Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A714A4D0
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459068; cv=none; b=kcqSmbyKfcZAFfCNHbxgJcEYuttw5cKgrQ5zA1XeFyopLsRfP9VcZ+SO3SejBnL87Tf0qU3bWyxMh01dxAU4FRb78qq0KPIJzw2gVwb8RgIMMN/XcevRwo6maaitJmrQ08j0gBTA3NeSfuZ+Z8I2nbT4xZBImXpPPhbli787pAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459068; c=relaxed/simple;
	bh=GRaVF2z9cf7898zhYESemeT3oeXWS4BvxLCjTwXEtTk=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtOU3hB3bmJWsyhjvQYD7sq7NBvO+rYalGpB/SiTvzpoo98v+2v3KGJW+TVQ2AvNRSVePRGt5FvDWjHhKhx4yBPU0uorzDWjM9oImMQbjR+Oc81WA/fPEEHNfNk0y8SdiDvtM8tGXYiY6qxMf3VxbR7EXd3f3qOyrjkpxnOJKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mfriebe.de; spf=pass smtp.mailfrom=mfriebe.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mfriebe.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mfriebe.de
Received: from [84.163.76.207] (helo=[192.168.2.202])
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <lists@mfriebe.de>)
	id 1rcWFK-004bX4-CE
	for git@vger.kernel.org;
	Tue, 20 Feb 2024 20:57:42 +0100
Message-ID: <86226be8-7a1d-454a-b3dc-7d5921b47329@mfriebe.de>
Date: Tue, 20 Feb 2024 20:57:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore
 experimental"
Content-Language: de-DE, en-GB
Cc: git@vger.kernel.org
References: <20240220092957.1296283-2-matttbe@kernel.org>
 <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
 <95eb92cb-7954-41c0-b542-5169ed5f9892@kernel.org>
 <920a0f61-d30b-49f1-87b3-fb947cb3c33d@app.fastmail.com>
 <xmqqzfvvovva.fsf@gitster.g>
From: Martin <lists@mfriebe.de>
In-Reply-To: <xmqqzfvvovva.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Con-Id: 349877
X-Con-U: 0-listmfriebede

On 20/02/2024 19:04, Junio C Hamano wrote:

> [References]
> 
> *1* https://lore.kernel.org/git/211021.86wnm6l1ip.gmgdl@evledraar.gmail.com/
> *2* https://lore.kernel.org/git/xmqqzg6eocmi.fsf@gitster.g/
> 

 From 2
> I think the "switch" was written exactly for such a transition so that folks who
> wanted a different behaviour do not have to break existing users of "checkout".

Yet then the table in link 1 suggests to re-use -c and -m in the old 
style, the way the currently are used in "git branch"

"Introducing a new behaviour" is exactly not having to copy old meanings 
of options...

As I wrote
> The flaw here is in "git branch" which by default list branches, but if give a name (and no option to specify an action) "git branch foo" will change its action to "create". 

If "git branche" actually had needed an option to change its action to 
create, what would it have been? --create or -c ?

And -n (as suggested in the table) is strongly associated with dry-run. 
(not only in git)


If I look at the suggestion to replace -m by --merge, just so that -m 
can be "move", then I seriously ask, what happens more often:
- Someone switching to a branch while having modifications in their 
worktree (needing to merge)
- Someone creating a new branch, wanting to copy reflog/options

Given not only that switching to a new branch happens more often than 
creating one (and thereby makes it alt least plausible, that the -m as 
"merge" is required more often)..., but also that "git switch" is more 
about switching than creating branches..., I believe that -m as "merge" 
is entirely the better choice.

For the "git branch" features, if "git switch" should support them, they 
could easily be made available as
--cc  create and copy
--mv  move

They - by all likelihood - are used less often, and should be the long 
options. And a 2 letter long option is still easy to use.

