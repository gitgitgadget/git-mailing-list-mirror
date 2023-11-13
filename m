Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC12374B
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aq0.de header.i=@aq0.de header.b="L9oBfS0l"
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 12:52:14 PST
Received: from mail.aq0.de (mail.aq0.de [IPv6:2a01:4f8:1c1b:c00e::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF8D5E
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 12:52:14 -0800 (PST)
Message-ID: <bef9d5b3-bb64-4662-8952-d000872c5244@aq0.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aq0.de; s=mail;
	t=1699908130; bh=zg+YGFuD/FqVj8AOxXeQgJzbtzvrBhFsnX0eG8jieXs=;
	h=Date:To:From:Subject;
	b=L9oBfS0lhu9qZp/NlMFiIAIcuJZTdPgNQMCCBeNKVn8ez2fP6t2VzVzQdUCThxDDE
	 ZezV9hNJXjUhd7HUlHbU17YQr4hFl8QsoTFBvP0Y880qHuxO+H4at9CvxjLw2fdB9f
	 3Ui6N8MPMh28cAGmvNl/4LXFY/leUM+d818e/Uck=
Date: Mon, 13 Nov 2023 21:42:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: git@vger.kernel.org
From: Janik Haag <janik@aq0.de>
Subject: git-bisect reset not deleting .git/BISECT_LOG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
```bash
git init /tmp/reproduce-bisect-warning
cd /tmp/reproduce-bisect-warning
touch .git/BISECT_LOG
git bisect reset
git switch -c log
```

What did you expect to happen? (Expected behavior)

`git-bisect reset` should have deleted .git/BISECT_LOG

What happened instead? (Actual behavior)

.git/BISECT_LOG is still there

What's different between what you expected and what actually happened?

git switch and some external tools like shell prompts are relying on 
that file to know if we are doing a bisect so switch printed a warning 
that we are still bisecting. Funnily enough git checkout doesn't print 
that warning.

Anything else you want to add:

In case you are wondering why I created the .git/BISECT_LOG file with 
touch instead of using the git cli, I forgot how I ended up there in the 
first place that was like a year ago and the warning didn't really 
bother me, today someone told me to look for anything in .git namend 
BISECT* and after deleting the log by hand it worked. So I figured 
git-bisect reset should probably have done that after I ended up in that 
unkown state. the content I had in BISECT_LOG before deleting it was:
```
# good: [e24028141f2] qdmr: fixup
git bisect good e24028141f278590407dd5389330f23d01c89cff
```


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: 
/nix/store/lf0wpjrj8yx4gsmw2s3xfl58ixmqk8qa-bash-5.2-p15/bin/bash
uname: Linux 6.1.61 #1-NixOS SMP PREEMPT_DYNAMIC Thu Nov  2 08:35:33 UTC 
2023 x86_64
compiler info: gnuc: 12.3
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /run/current-system/sw/bin/zsh


[Enabled Hooks]

