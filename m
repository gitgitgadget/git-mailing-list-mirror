Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F178F32
	for <git@vger.kernel.org>; Tue, 27 May 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365289; cv=none; b=BSK7HpGuQZpG7hXULewaNUpU2nkfMkRt3/xL2ionw/s89hh9QxxunXOMF1Kfl7Y/uSKcs5dN3B+vHf/BuJTQDobeH7Db3KLU4zsdU07Ut/zGEh1/fFNT3WtA+qJU16Xcq4Pd0BQDysSmsSyCCOemHhjvN/4gcZw4VgOfRxXOr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365289; c=relaxed/simple;
	bh=MRqg+bwEICMI17Y8oxV7SN7yzKN4D+42AW59WSGiIDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaoFltbM9me1mU2IiK/6sQMTlMEqd3AQYfpPIJU10HN5PjgCDjI3w4tHjYyBWxeKBMbi3BJoCvF3Ci61qi+JcHTFsoco/pJAAJDKjzvndKZnDgf6vDrQn8MlOGtAsMneoBcq007ropxXMJ/e7bZysraKZTZFAYYiVd+dlOlthfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=iul/zKXf; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="iul/zKXf"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Jxg1uCWQTaTZGJxg3uoWpv; Tue, 27 May 2025 18:01:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1748365283; bh=PwuRyWa307BAqUKEmPak/jf3F/XYRHoZNeA3bYpiNCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iul/zKXfs5nTLM2lYgvNuSgK7CFKrcsSDePpco3JkWCRwNVovV8DjdF6EeIT5xKOQ
	 mHO+QTdfZqSDlFUFYfnU8qg8WjCoTRVc8C3C3JO1CBMTvxWpKFgCoJMHiy6mnm/ZwK
	 pP7oHZToJuNiGHr6SmQMt2X137P9mSh34Xv6+tiSDJiIREFKcsI5A+V/axih/fQlM0
	 ry5FIcuq9UJhCwm+LQMyd48mPgzho8FlnQOrymn4+yNGXNixB1w5acgsHwLLufGVQb
	 qv66E0mgdyz0KEl9jwwO7kQZijyBx6FTuMPKF58lCt3xUwWbG40Bu9p0N+X5V6zyXM
	 5u0roZbyiem+A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=6835efe3
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=E3qmV8WEUGa4lOVf6uIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <5c9f9bc1-da0d-4952-a424-1d2c99fce0d3@ramsayjones.plus.com>
Date: Tue, 27 May 2025 18:01:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] builtin/maintenance: let tasks do maintenance
 before and after detach
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, david asraf <dasraf9@gmail.com>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250527-b4-pks-maintenance-ref-lock-race-v1-8-e1ceb2dea66e@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-8-e1ceb2dea66e@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAJcN3j/u70xnyc7zNBIWl5D+Dw0nW0S7pj1x7my98GjyD073qezYxOKtAX9iEDZkNuWPicEd2NX1Dpl9NeRc+isbJa7rF1sw+2XldFPH2AR3d5sHFN0
 L+X3oaBWi7XATYncoLHBaePws/OuPZoc7eLshJwTl5t/L/fazd517Ae+xmdLdy9nsDu3kWrzro/iITTY3kxw2I+XsZqQ8srngEs=



On 27/05/2025 15:04, Patrick Steinhardt wrote:
> Both git-gc(1) and git-maintenance(1) have logic to daemonize so that
> the maintenance tasks are performed in the background. git-gc(1) has
> some special logic though to not perform _all_ housekeeping tasks in the
> background: both references and reflogs are still handled synchronously
> ni the foreground.

s/ni/in/

> 
> This split exists because otherwise it may easily happen that git-gc(1)
> keeps for the "packed-refs" file locked for an extended amount of time,

s/keeps for the/keeps the/

> where the next Git command that wants to modify any reference could now
> fail. This was especially important in the past, where git-gc(1) was
> still executed directly as part of our automatic maintenance: git-gc(1)
> was invoked via `git gc --auto --detach`, so we knew to handle most of
> the maintenance tasks in the background while doing those parts that may
> cause locking issues in the foreground.
> 
> We have since moved to git-maintenance(1), which is a more flexible
> replacement for git-gc(1). By default this command runs git-gc(1), only,
> but it can be configured to run different tasks, as well. This command
> does not know about the split between maintenance tasks that should run
> before and after detach though, and this has led to several bug reports
> about spurious locking errors for the "packed-refs" file.
> 
> Prepare for a fix by introducing this split for maintenance tasks. Note
> that this commit does not yet change any of the tasks, so there should
> not (yet) be a change in behaviour.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
[snip]

ATB,
Ramsay Jones

