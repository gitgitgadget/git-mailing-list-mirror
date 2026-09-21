Received: from rush.cubic.ch (rush.cubic.ch [176.9.78.115])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597844F55C7
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015430; cv=none; b=Jv//iNX8sHjJKjVaMiegNyjDx29mjf6f9g2bfDYb07LkDWaK1YxXBfJdk+g6XlFw3Y+r5QAjkwJJkENqqebfbxGV9MHUEaIj3Lf6mOhODpRR1DXmPrz2mPwwRJ9ycw//dswLoW0Mi3TXH5th62j0WkKEsDRf4mnDJSjG1zAQhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015430; c=relaxed/simple;
	bh=b374QgeAP0GnSX6ihxS0B0ZLlUfeapsbc+P+kDPlco8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tbmBMqspKZm9MxQhPz+YEp2tAKZMVglPPuZarwVjtzO0JYDWlSFJsGbQQ5ta5bUmfoQseS7a/JGAY2BKbX5epTKP4dT302f1UtaERukbWo+LEqrR6/UDf/q9VeXE2/Eh1wz5I05ew4VS64mS7XDqsCQGYr5Oh/v9tTgSHT16PuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch; spf=pass smtp.mailfrom=decentral.ch; dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b=A//fCNzt; arc=none smtp.client-ip=176.9.78.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decentral.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentral.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentral.ch header.i=@decentral.ch header.b="A//fCNzt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=decentral.ch; s=rsa2;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID; bh=gfpMcvhB9ClKpB+DYLliVGDCNv/AigVrCIKTgXbqYK8=;
	b=A//fCNztyqm+xtN9DdMFzMgOdEnmRjW/3N4GNUuqJrk+8SeJDr1F6TSyXId1BTEEMbi/zk3E40EVWRgmnb926CmCVVlTCXNPc7DNBi+yxt0Cnnyw4JHrIjPws0bI5YA4Vx0KnzdSfFuRd1Kq1LaXZShZqdL8KlTEY7fu6igG30WPAP9VjB2BBKFF3B4qd6yR6jH8kkaI+p4vk1H9FSfChtG59PcbwY0cW8pwgEunKKHeey+r62FZLoZLNNaP/GXIKwByjaE9/7CwurUI+TyKBQRiqhoZkL9KLJa9v2E6C6hkgjqqHSi17Q6rgbFGkGpRLJzuJJPm9Hj7RxkaEngu9A==;
Received: from james.decentral.ch ([85.195.242.225] helo=[192.168.219.13])
	by rush.cubic.ch with esmtpa (Exim 4.76)
	(envelope-from <stuff@decentral.ch>)
	id 1x8iNh-0005CQ-NV; Mon, 21 Sep 2026 20:04:45 +0200
Message-ID: <b6600538-afdd-4402-ad2c-2a5380b6c0cd@decentral.ch>
Date: Mon, 21 Sep 2026 20:04:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bugreport: git log -L
To: Nikita Makarov <n.makarov@yadro.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
Content-Language: en-US
From: Tim Tassonis <stuff@decentral.ch>
In-Reply-To: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/21/26 09:45, Nikita Makarov wrote:
> Hello, I have the found the strange behavior of "git log -L" command with python function.
> It is counting a blank line that sits after a function's last statement as part of that function.
> This happens only when the function is at the end of a file.
> 
> The way to reproduce that
> 
> git init repro && cd repro
> git config user.email t@t && git config user.name t
> 
> printf 'def foo():\n    return 1\n\n' > bug.py
> git add bug.py && git commit -qm c1
> 
> printf 'def foo():\n    return 1\n' > bug.py
> git add bug.py && git commit -qm c2
> 
> Then do
> 
> git log -L :'foo':bug.py
> 
> And you'll see
> 
> Author: t <t@t>
> Date:   Fri Sep 18 18:21:10 2026 +0300
> 
>      c2
> 
> diff --git a/bug.py b/bug.py
> --- a/bug.py
> +++ b/bug.py
> @@ -1,2 +1,3 @@
>   def foo():
>       return 1
> +
> 
> Though I expect that commit "c2" should never appear in log, since the changes from it doesn't affect the functions body at all.

 From git log --help
...
If :<funcname> is given in place of <start> and <end>, it is a
regular expression that denotes the range from the first funcname
line that matches <funcname>, up to the next funcname line.
:<funcname> searches from the end of the previous -L range, if any,
otherwise from the start of file.  ^:<funcname> searches from the
start of file. The function names are determined in the same way as
git diff works out patch hunk headers (see Defining a custom
hunk-header in gitattributes(5)).
..

So, the bug is rather the expectation that such a thing can reliably 
know what a function is, regardless of coding style and language used.

To quote the late and great Christopher Tolkien: This could only be 
achieved. if at all, at heavy and needless cost.

Bye>
> [System Info]
> git version:
> git version 2.43.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 7.0.0-31-generic #31~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon Aug 10 09:38:02 UTC 2 x86_64
> compiler info: gnuc: 13.3
> libc info: glibc: 2.39
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]

-- 
decentral.ch - IT Stuff
Tim Tassonis
Badenerstrasse 219
8003 Zürich
stuff@decentral.ch
+41 79 229 36 17

