Received: from 18.mo581.mail-out.ovh.net (18.mo581.mail-out.ovh.net [188.165.56.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6810F4
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.56.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730437398; cv=none; b=afdmP7TAKaoTKI0W8xlQPL2Oa65lDfdlBrLkni/81/ktc6Ftd3QKkehxXbzmqXdljgyNjf7zPsVyqo2gojBf6vIcA7+uzAutd9w+22/ULZSrjg3YB7+ovMUBXDz8Kmk4UKi/8PJ2sSFH9BU7DdWGsKRhjkyXXLZ/Tacy5Jz0a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730437398; c=relaxed/simple;
	bh=c01SjdLwsTXHi4jN1o4nmnXSSW1utpAO/JtcpJ0z3OI=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=OT1zQmllO4D3H4iRulsQ3MP5BQ7eeVfIsmO4OwhwlfJILX1bNurmqRwk7wzEpjdHvrnI7mNBFC8hbltx0P/E0yINamagSOwZbEx3WfVGwUDnOWnAUCvy/cNhDF3X9TCdP4RpI6gvxze97jQbzUmLNBTr1cfjYjSiaJpIuOZszCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cleb.io; spf=pass smtp.mailfrom=cleb.io; dkim=pass (2048-bit key) header.d=cleb.io header.i=@cleb.io header.b=Oxr02GO/; arc=none smtp.client-ip=188.165.56.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cleb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cleb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cleb.io header.i=@cleb.io header.b="Oxr02GO/"
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.148.87])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4XfhJN0Czzz1Q0Z
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 00:17:24 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-2gkmb (unknown [10.110.101.130])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B84E61FD38
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 00:17:23 +0000 (UTC)
Received: from cleb.io ([37.59.142.110])
	by ghost-submission-5b5ff79f4f-2gkmb with ESMTPSA
	id YHFEIRMeJGcsGQkALo/peQ
	(envelope-from <iago-lito@cleb.io>)
	for <git@vger.kernel.org>; Fri, 01 Nov 2024 00:17:23 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-110S00497c697dc-165c-4c8d-82e1-748ae4d2a1e8,
                    46D1B4683961587D9DEF0E4191837953488DDB30) smtp.auth=iago-lito@cleb.io
X-OVh-ClientIp:92.184.100.142
Date: Fri, 1 Nov 2024 01:17:20 +0100 (GMT+01:00)
From: Iago-lito <iago-lito@cleb.io>
To: git@vger.kernel.org
Message-ID: <3af246eb-3473-4964-9aed-ecff62b215b7@cleb.io>
Subject: `git apply -p` doesn't remove source prefix in 'rename' diff
 entries.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <3af246eb-3473-4964-9aed-ecff62b215b7@cleb.io>
X-Ovh-Tracer-Id: 2167075846063340283
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvkffugggtgfesthejredttddtjeenucfhrhhomhepkfgrghhoqdhlihhtohcuoehirghgohdqlhhithhosegtlhgvsgdrihhoqeenucggtffrrghtthgvrhhnpeffudehveegtddugfdtledufeehheefiedvvedutefhhefhfffgfeevheelgedtjeenucfkphepuddvjedrtddrtddruddpledvrddukeegrddutddtrddugedvpdefjedrheelrddugedvrdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehirghgohdqlhhithhosegtlhgvsgdrihhopdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=c01SjdLwsTXHi4jN1o4nmnXSSW1utpAO/JtcpJ0z3OI=;
 c=relaxed/relaxed; d=cleb.io; h=From; s=ovhmo4982009-selector1;
 t=1730420244; v=1;
 b=Oxr02GO/4vnQ6plYOdrKOXczY/CqQp1GT7hLDu0mUIhJNOjW2yR+LihaBxt366dZPPMsZIzJ
 p98AnhAFG+FWl7cE0oPN655SD1HWsDK4OumGd7lmixZRuJBwi/IiTfZ+niA/2QeWe51SkgBbDuN
 dRseUe+vbzl28LaAp+bsUbNKsxxGKuSyIxQurn/vO9BzH9ehTs/9gDIJPn7ATT72+uhspl8orpd
 4zW7GzqC1qawWjcUAXfqKzUhmYeG3HDWuMVtodA99f+R3B7IZssB2t9vNhEwSp4M3mDC8OGytWw
 yBtZu2PkqJnTW15m3R/zop9RQmXuC0O0qnOrgOA7z2wIQ==

Hello,

I have troubles understanding the behaviour of `git apply` with respect to renames in a `--no-index` context.

Let us craft a toy folder:
```sh
$ mkdir x
$ echo a > x/a # To be modified.
$ echo b > x/b # To be renamed.
```

Duplicate it twice to get three identical folders `x = y = z`.

```sh
$ cp -r x y
$ cp -r x z
```

Modify `y`:
```sh
$ echo newline >> y/a # Edit.
$ mv y/b y/c # Rename.
```

Now I would like to use git as a "better GNU patch".
Calculate the diff from `x` to `y`:
```sh
$ git diff --no-prefix x y | tee patch
diff --git x/a y/a
index 7898192..4030aa5 100644
--- x/a
+++ y/a
@@ -1 +1,2 @@
a
+newline
diff --git x/b y/c
similarity index 100%
rename from x/b
rename to y/c
```

Then apply this patch to `z` so as to end up with `x != y = z`:
```sh
$ git apply -p1 --directory z patch
error: z/x/b: No such file or directory
```

I would expect `z/b` to be renamed into `z/c`, but I get the above error instead.

Although understand that `z/x/b` is not a valid path, I don't understand that git produces such a path, because I'm assuming that `-p1` is supposed to remove the `x/` part.

Interestingly, the procedure works fine without the rename. The rename also worth fine if I manually remove the `x/` and `y/` prefixes from the rename lines in the patch.

This makes the behaviour of `git apply` appear inconsistent. It is nonetheless expected ? If so, why ? If not, then is it a bug ?

Thank you for support,

[System Info]
git version:
git version 2.46.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.10.1
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.10.10-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 12 Sep 2024
17:21:02 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show

--
Iago-lito
