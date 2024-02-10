Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F3364A1
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707557004; cv=none; b=mmp7XhVa4mU3qaqOGoyyJDcb7Bia5RYX5sfUCyopLARggV1j0ZdhzY+Fk4WQJYJwisxHnjrwtL6+Ooesk0oxstUN1R3LuKTn63TUCO9ivn8ro9K47qT7MwAZH/CNwdaAxb4l/UEXi01Wu+JOQ7bQlP9irsbGooFqBrczfIYsEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707557004; c=relaxed/simple;
	bh=EPuBNhhh2YwMvMXvKMcLmrm3LDw406yeIInEAUUlMmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AGkkZXeqAFfMC8dRZQi/U8/GHoVpz7tGOG09QGLNX0RezEWqzk2FFtCnZNigS3rjo0ynjb84rmJOw9zxMR+ffGqt9QFiy5zC5RPcmQr96PIIY8hukJiMB3MAorD/TyF4bcQwDROASuaowxEhj1HDjCjRKQmTD8VuFPX1axtHwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=qAeNiDde; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="qAeNiDde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1707556997;
	bh=0ZADQNQTECAdgk2M/RVi+8NXjYAnI1Qne4UOr8UWpN0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qAeNiDdeUVZCi6B0SmsPFBQeoNaPGlg0hNOiSQ7FkbIop/p2GMNafGz/tfTnmh1Cj
	 fU+sVl0QHILPlsw5U3CC4XlDYy31IS0fBfZYA2LjsJeJbJuZOxxw5tqfCbDw6JxsXW
	 0jnw0ModsNkrwf+Io8bpZh1Kg/OcOqrMzDsFr0p/S3HP2SREjKtxntC3wJP3F9Gel7
	 fG1TbFKE7t56z2b6ha2XLBVU3giSmkob3q0oGpwR8nNSuzELfrAFkv8TFd+nHzmvqV
	 VzrRvssPEdScDl3DJd5AgwCdLeGl06Lk26OlwzVig09C8uiXnmKWO9ISy6LHE0Uxm6
	 3v73Yxs0Hdh3Q==
Received: from [192.168.178.30] (unknown [159.48.47.80])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 679033C03DD;
	Sat, 10 Feb 2024 10:23:17 +0100 (CET)
Message-ID: <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
Date: Sat, 10 Feb 2024 10:23:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interactive rebase: using "pick" for merge commits
Content-Language: de-DE, en-US
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 09.02.24 17:24, Phillip Wood wrote:
> On 09/02/2024 15:52, Stefan Haller wrote:
>> When I do an interactive rebase, and manually enter a "pick" with the
>> commit hash of a merge commit, I get the following confusing error
>> message:
>>
>> error: commit fa1afe1 is a merge but no -m option was given.
>> 
>> Is it crazy to want pick to work like this? Should it be supported?
> 
> It causes problems trying to maintain the topology. In the past there
> was a "--preserve-merges" option that allowed one to "pick" merges but
> it broke if the user edited the todo list. The "--rebase-merges" option
> was introduced with the "label", "reset" and "merge" todo list
> instructions to allow the user to control the topology.

Yes, I'm familiar with all this, but that's not what I mean. I don't
want to maintain the topology here, and I'm also not suggesting that git
itself generates such "pick" entries with -mX arguments (maybe I wasn't
clear on that). What I want to do is to add such entries myself, as a
user, resulting in the equivalent of doing a "break" at that point in
the rebase and doing a "git cherry-pick -mX <hash-of-merge-commit>"
manually.

-Stefan
