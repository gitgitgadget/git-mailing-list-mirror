Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0414A4F9
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771192727; cv=none; b=VUIjv9S0aPRTXdRP+u/pK0tVd8mwbdc0irgD9Mf8qT6eDoEIMCSTpPIHsOUhC623wBm+piYjJf7LmGK4Fig9817Md9zu0/PKLDlmUr80BUEf8H+G2FlHQy1FCSTK/iJwvt4wb8+tRLrZHp21liO8aXw1bLwbG+0qRUe0w029S0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771192727; c=relaxed/simple;
	bh=2tzuGPSwiNUUPVC9OUmMK1FxstWoEMXw08/hzc2A2Z8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=j1d24bVqB/HFuB6zWMo2sK8IKY7BnA1G3PrY+tCsF6t4iu64YcNSpU+iqzPgkVgYy7AVNlJnkEomQtwhJblhWzUA6XtGZcAR56+AVxDBZfoorqbqcg5YRjoqxt5N9muiqWdaQ4R96Vb7ZFOsxYeSKYgSIXe28ybpMyTPUGreI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu; spf=pass smtp.mailfrom=posteo.eu; dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b=ajwJHUh8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b="ajwJHUh8"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 32E8A240101
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 22:58:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
	t=1771192723; bh=ZSLYihv24lkQtMotsRF4/F5xwmv2V/TYV2Gy5Svy6L8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type:
	 Content-Transfer-Encoding:From;
	b=ajwJHUh8St0UWbIpeo2m6U/MwT/4F10cNVHUFfFEVMGy4a2tfypADYimXL7niLU+g
	 fVmFbAHIWAYpS30M8Ni/3ngH5VCmijctTJ7im6pnCObFzFX07KQitTYF71ac/LqODv
	 1kAM9aEMcKruuGKNjLgMmdC7I8MJKqhjd4cDyiML+AJ/TpCe3yKlopbDnUqwmuXaI1
	 TQ4WbUNx9I2nIVj4UObkzRhREZNUpjqeookR9HgCxQfVnwz0UDQqCl9LfyfJ9iZG09
	 WeHzkSnnBCYmcICESFQSGCbe9tlJ1oJHWkyI1s+iGi47OiBZdEhEgBsAIt1PMT4PF6
	 ZwH5DaXWrNFRg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fDftV6DN8z9rxD
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 22:58:42 +0100 (CET)
Message-ID: <d180884c-8108-4c8a-9cc7-5314a4f5a45a@posteo.eu>
Date: Sun, 15 Feb 2026 21:58:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Content-Language: en-US
To: git@vger.kernel.org
Subject: Push Certificates: Privacy Concerns Regarding the "pushee" Header
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear recipients,

I am working on an application built on top of Git, which wants to 
ingest push certificates in order to keep (something similar to) a 
transparency log (see 
<https://people.kernel.org/monsieuricon/signed-git-pushes>).

For reasons that I will only go into detail upon request, in the context 
of the application, logical "pushes to the network" are split into two 
parts: The *first part* is always local (from one repository in one 
directory on the filesystem, to another).  Bundled with the application 
is a daemon.  The daemon process then takes over the *second part* of 
the push, for further propagation of over the network in a peer-to-peer 
manner.  However, one desires the *first* part already to be certified.

This would result in push certificates of the following form (hashes 
abbreviated, signature omitted):

	certificate version 0.1
	pusher SHA256:xX6bp…T0  1771188983 +0100
	pushee /home/lorenz/.example/storage/foo
	nonce 1771188983-345389c
	
	0000000 ccae4e0 refs/heads/main

As you can see, this push certificate leaks a path on the application 
users' filesystem.  Here it is quite obviously my home directory, but 
actually the "storage path", is user-configurable at the application 
level, and considered private.

I do realize that the leak is in part due to the weird application 
architecture.  Who would have guessed that I want to certify a push *on 
my own filesystem*?  I am convinced the main motivation for this feature 
were pushes (directly) over the network.  However, I also believe that 
it could be of more general interest to allow the Git user to control 
which/whether the pushee header is emitted.

Handling of the pushee header was introduced to `send-pack.c` in 
9be89160e7382a88e56a02bcf38f4694dd6542d6, over 11 years ago, and was not 
touched since. Remarking on the current implementation, I do realize 
that `transport_anonymize_url` is used to sanitize, in order not to leak 
usernames, passwords, etc., which is appreciated.  However, file paths 
are not removed.  This makes a great deal of sense as the same function 
is used in other places where indeed the path on the filesystem is 
expected.  I think the current implementation is sensible.  However, 
allowing the Git user to ultimately control which URL is used allows for 
the greatest flexibility.

Note that the receiving end might inspect the push certificate in their 
`pre-receive` handler, and reject to receive if the pushee is malformed.

I would like to provide a patch that adds an option `git send-pack`, 
which allows the Git user to specify the pushee or indicate that the 
header should not be emitted.  My proposal is as follows.  Because of 
the connection to signed pushes, and therefore to the the already 
existing `--[no-]-signed=…` option, I would add 
`--signed-pushee=<string>` as well as `--no-signed-pushee`.

One edge case that I would like to get clarification on is how the empty 
string should be handled.  I would consider `--signed-pushee=""` 
invalid, making it impossible to specify the empty string as pushee, 
erroring out and potentially hinting at `--no-signed-pushee`.

Before I do so, I would like to ask for your feedback.  Would you accept 
such patch if implemented cleanly?  What do you think, how should the 
option be named and interpreted?  Further, if this option is added to 
`git send-pack`, one natural question is whether `git push` should also 
"inherit" it, as is the case with `--signed`?

Kind regards,
Lorenz Leutgeb
