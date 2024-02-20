Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957367E63
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436044; cv=none; b=inNgUgIlNxkqfW3+6Peh1nyz2kMtbmPyGsQKWJb0zP0uOelkRkqrF9FKhD51zqK/UpnRyPrFkpmk4k55RxoHYVHKCyO37LuL093yM+GX7SWsonmIqzf2OTXZ7ayGtglkrbTMNaejfEykTzmAqbVA1GWZX/bmLpr++HRTlFJQGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436044; c=relaxed/simple;
	bh=1cXwVxRbv6eLaRA5vUUaSO8eYhRz+1SG0M/9XbcsAsg=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:References:
	 In-Reply-To:Content-Type; b=kBItW1HFR0RYLRJwcksLjoN1Am5hV0qmltW4xgSVK4mfoQLt28dbGVcJQ3dlw/cg5pyv4fxwSJCoNRpm9yp3d4+q7rkHSSquNoAvb9n3cOKlvZp7j6i65TPza1WkbLjn3QzNBlFx3f+8qVHQipG79iaTKdoZ+u5ow0BkOs2kBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mfriebe.de; spf=pass smtp.mailfrom=mfriebe.de; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mfriebe.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mfriebe.de
Received: from [84.163.76.207] (helo=[192.168.2.202])
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <git@mfriebe.de>)
	id 1rcQG0-00EllF-Ub
	for git@vger.kernel.org;
	Tue, 20 Feb 2024 14:34:00 +0100
Message-ID: <0705b34b-464c-4e7c-88cc-c8507eaf9485@mfriebe.de>
Date: Tue, 20 Feb 2024 14:34:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martin <git@mfriebe.de>
Subject: Re: [PATCH] Revert "Declare both git-switch and git-restore
 experimental"
Cc: git@vger.kernel.org
References: <20240220092957.1296283-2-matttbe@kernel.org>
 <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
Content-Language: en-GB
In-Reply-To: <3523e325-98bf-4d2d-847b-28e5c4a85ec5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Con-Id: 349877
X-Con-U: 0-listmfriebede

On 20/02/2024 10:36, Kristoffer Haugsbakk wrote:
> On Tue, Feb 20, 2024, at 10:29, Matthieu Baerts (NGI0) wrote:
>> This reverts commit 4e43b7ff1ea4b6f16b93a432b6718e9ab38749bd.
>> Version 2.44 is approaching, almost 5 years after the introduction of
>> these two commands, it then looks safe to remove this experimental
>> status.
> Is this only based on the amount of time passed? Has there been any
> relevant discussions on the mailing list that discuss how mature these
> commands are and if they should be changed (with presumably a “no” to
> the question about being changed)?
>

Isn't the absence over such a long time of such a discussion in itself a 
statement?
If there had been need for a discussion, would it not have happened by now?
Unless, it is assumed that no one is using it, nor has wanted to use it 
(but has been deterred by the experimental state).
Has *every* other additions always had a "relevant" discussion, or would 
feature in the past have been accepted if no one objected?


Furthermore, if something is functional (I am using it, I can attest it 
works), and if it had no breaking changes over a very long time, then 
making/keeping it experimental forever => would that not create a "boy 
who cried wolf" effect? More and more people will use it. If it gets 
incompatible broken the outcry will be there. And the documentation as 
experimental will not lessen that outcry.


On the other hand I have been part of one discussion touching that topic 
=> However this wasn't about: should switch/restore exist at all. It was 
about if individual options to those commands had been assigned the 
optimal choice of letter. In that case "-c" for "create", which for 
users of "git branch" is associated with "copy".

If that is the case, it would be enough to move the experimental to 
those particular options. And have discussions on those options, rather 
than the overall existence/naming of switch/restore?


About the "-c":  create vs copy:
> The |-c| and |-C| options have the exact same semantics as |-m| and 
> |-M|, except instead of the branch being renamed, it will be copied to 
> a new name, along with its config and reflog.
"copy" is basically creating a new branch "to a new name" with a copy of 
certain metadata (config, reflog).
The flaw here is in "git branch" which by default list branches, but if 
give a name (and no option to specify an action) "git branch foo" will 
change its action to "create".

Anyway, the discussion on "-c" for copy in "switch" is only relevant if 
there had been a discussion if this is across all git users a common 
enough action, so it requires a shortcut outside of "git branch". And if 
it does, and given that copy can't be done without creation, then should 
"copy" not be an option that in "git switch" should be given together 
with "create"? e.g. git switch -c newname -X oldbranch  
[commit-startpoint]" where X is the option that says "copy metadata 
from" (if it wasn't the worst idea ever, a 2nd "-c" would come to mind. 
-a "assign" -o "Origin" -r "reflog" -s "source" -w "with" ... though 
many of them may have potential to conflict too.


