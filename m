Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B718059
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717802890; cv=none; b=pDEUGkKY1iKDZd2DB/lxwRWW6sgavcHplHbiGbQOZ5pruaLKXwE1jWlaCTvo7M+J+qtoTeG/k1yCxNFKyzCadB/Ye8o5Uw7pEbzXIXSdvZuT8RkfN0BjDZjeTbSnLeKH1SPhKE41yM7dj0xbfBnbx7MknGv63bgo7Vxt0Yn5L4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717802890; c=relaxed/simple;
	bh=A3F83lDI5drTOqp9YbbQgV7EhvEpH1KyMGYRUPBi930=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NkqvKuEaXAAjWHrOeIOd5SKsUFWyVHM64KlJLTI0PfiqlFSx3BD6FGIgaPw825IwglUgX4AqzVz0p8YoSzQFr3likO4xDxGdxmULAKaUs94mRb61eFmQV/w76RTuufblyXQ5sRtahhhROvAHeFB7cJARk2G/mQOuTwqZeRb7O+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Received: from [10.42.0.97] (dynamic-176-007-192-159.176.7.pool.telefonica.de [176.7.192.159])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 9326A1806A1
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 23:27:01 +0000 (UTC)
Message-ID: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
Date: Sat, 8 Jun 2024 01:28:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: ellie <el@horse64.org>
Subject: With big repos and slower connections, git clone can be hard to work
 with
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear git team,

I'm terribly sorry if this is the wrong place, but I'd like to suggest a 
potential issue with "git clone".

The problem is that any sort of interruption or connection issue, no 
matter how brief, causes the clone to stop and leave nothing behind:

$ git clone https://github.com/Nheko-Reborn/nheko
Cloning into 'nheko'...
remote: Enumerating objects: 43991, done.
remote: Counting objects: 100% (6535/6535), done.
remote: Compressing objects: 100% (1449/1449), done.
error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly: 
CANCEL (err 8)
error: 2771 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
$ cd nheko
bash: cd: nheko: No such file or director

In my experience, this can be really impactful with 1. big repositories 
and 2. unreliable internet - which I would argue isn't unheard of! E.g. 
a developer may work via mobile connection on a business trip. The 
result can even be that a repository is uncloneable for some users!

This has left me in the absurd situation where I was able to download a 
tarball via HTTPS from the git hoster just fine, even way larger binary 
release items, thanks to the browser's HTTPS resume. And yet a simple 
git clone of the same project failed repeatedly.

My deepest apologies if I missed an option to fix or address this. But 
summed up, please consider making git clone recover from hiccups.

Regards,

Ellie

PS: I've seen git hosters have apparent proxy bugs, like timing out 
slower git clone connections from the server side even if the transfer 
is ongoing. A git auto-resume would reduce the impact of that, too.



