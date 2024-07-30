Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B01A072E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335389; cv=none; b=jBbqvfRwJa4FFYDwyjmnBTzcxHhvkJzacHT9PSBdmN2gC5e+9H7v8KGjkrRTFTCgeTWhZk7lGZdGZ9Elsv2oBqJugsDeoTdQFxuIqM9hCnWRVqhM35y7k35CS8OZKQIOJOzAFfzVwr/0MylZyHD/bgWBUBVGLXlvYyOwHYS7P6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335389; c=relaxed/simple;
	bh=32BJ1RzvvlycA0PW6vxNluYF7goytpHhbm//VYKWpKE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=YIyExwz4WeHOuHw3QfYS01clAH0ajCRZD1pmB5y6bkl5EM6DzGO292WubjbsWcyL4keP0lbUjk/9JTQ7Xtcmw3u7TznimI7uOJuoTSKZcfbfAnUxU+809CnbJ1jq22SCkj4henWEqk4YcsQfcEEzxICGFEBF+VPbFONmYdArjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TfzeUtde; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TfzeUtde"
Received: from canonical (unknown [109.125.103.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 67DE73F10D
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722335384;
	bh=32BJ1RzvvlycA0PW6vxNluYF7goytpHhbm//VYKWpKE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=TfzeUtdemoBDcLa/EMJbiR0vC1jH0AgQGFf4KlcWgpXrlXDsWiswpdtuHBHSpa+pi
	 i9Vj0DVhauZ7tMl1/Njl0IdGhGRckjEhnaLTLsBNDEeI7PMUGUcIekjVtv9lm8WlzR
	 E8rNzL1s/Xd1t9chUvqgRNsOeWiyCf6fWPfltv6F7JZJV8fYsw5AY9b+59ZclJ6aX1
	 /pNxmvN9fuhxXd6waASOaZOYZ7scDNkNJUxSur9aSR8ytSV9Jg/nF4ksW458lY0yiT
	 Q+FFSYWbwlXIEzQWD75IK+qCXumgrITzPellDuXaUK98kuOmj/VQoonkhdc/6Uwliu
	 zky1UhpoN5Zlg==
Date: Tue, 30 Jul 2024 12:29:26 +0200
From: Nathan Teodosio <nathan.teodosio@canonical.com>
To: git@vger.kernel.org
Subject: Tracked file cannot be added, mentions to sparse checkout that I
 don't have.
Message-ID: <20240730122926.638a9263@canonical>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

What did you do before the bug happened? (Steps to reproduce your issue)

I modified a tracked file.

What did you expect to happen? (Expected behavior)

The file is listed as modified in git status and added with git add etc.,
i.e. the usual commit routine.

What happened instead? (Actual behavior)

I cannot add or commit the changes done to that file.

--->
% echo 1 >> snapcraft.yaml
% tail -n1 snapcraft.yaml
1
# I expected snapcraft.yaml to show here:
% git status -s
?? git-bugreport-2024-07-30-1212.txt
# I expected snapcraft.yaml to be added here:
% git add snapcraft.yaml
The following paths and/or pathspecs matched paths that exist
outside of your sparse-checkout definition, so will not be
updated in the index:
snapcraft.yaml
hint: If you intend to update such entries, try one of the following:
hint: * Use the --sparse option.
hint: * Disable or modify the sparsity rules.
hint: Disable this message with "git config advice.updateSparsePath false"
<---

What's different between what you expected and what actually happened?

The difference is that the file cannot be added or commited, as if no changes
had been made to it.

Anything else you want to add:

--->
% git branch --show-current
dev
% git ls-tree -r dev --name-only|grep snapcraft
snapcraft.yaml
% git sparse-checkout list
fatal: this worktree is not sparse
<---

Git was yesterday in my system updated and I never encountered
anything similar to this issue before.

--->
% grep ' installed git:' /var/log/dpkg.log
2024-07-29 10:37:19 status installed git:amd64 1:2.45.2-1ubuntu1
<---

Git does recognize modifications to another file in the same directory,
so I am completely stumped what is special about this snapcraft.yaml.


[System Info]
git version:
git version 2.45.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-31-generic #31-Ubuntu SMP PREEMPT_DYNAMIC Sat Apr 20
00:40:06 UTC 2024 x86_64 compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
