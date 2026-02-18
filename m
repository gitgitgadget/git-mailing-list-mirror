Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7633D4E6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408604; cv=none; b=TcjRfEy+0d5raVGguvq6ggbmOauM8tGJ9SG9801WXnMtt0RtbxSKFziCaBlG6RIB41QE8GvKQ3KcurWdFJrXVotsvW5fSl6I9f86Kv2Crc/uEtRkIqvSR+79UEWXWraFINJLSE51DMxTUdotXqyLp0mfsgx5DCxQHYXM6wWubKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408604; c=relaxed/simple;
	bh=hxvfoD6gOZcnodTWTG73cxOqZUGZHSRODdL18/zvgiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhMU9kx/+oOppuZDnMnRH9NXIcQehcd0hvJYpLyLIDMXnsVNEF01sJ9QnFv5AEpybikQNdVLZy9dMKAywmImOvQEGW+GFMtSwYdACQV/wW1Aa+eZFzQQWUGNEdUAJUr1r0FiNpcCmUXdtPjPQt2gIkJ827XAsyU2bHUDN4sUHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu; spf=pass smtp.mailfrom=posteo.eu; dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b=hbUxIWh8; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.eu header.i=@posteo.eu header.b="hbUxIWh8"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 838E0240101
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 10:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
	t=1771408599; bh=2oguyDW9uZmCfiVEXCb31pugQhgxFaFfJa4Um7FENl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=hbUxIWh8ce3idJy58xdmBtrBLZCCdZ7onDwkL80mfZ/hdbavox5wpoIZjejm0OrPx
	 x95n3lIGZXtjMnzJ6DIVmVlu7aYBQ7dBwFr6WiNRBcZp1kKQR2bOvGk8HtW+tmZ5y/
	 X0YDguGpTmjCzOE8za+RpHAzMxtX8Yh8IjzjkDzbnWVFLapzC/efz2sU5GfuupXEzm
	 tY3ci4UjGNSQ2bJ3BhH493EJSlMzrMe9xmbRWS2k2CCC5l2RsvB2Yh2uavZh2K0+Vc
	 8Hdbxmjd2fhRLnlPveNwXefEHg5tdekJ5uw8AIdxJU78Yyz5wiWK8A5c7Wm5wiJ1MR
	 LVWH8P1UrjwTw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fGBjz1Lbgz9rxB;
	Wed, 18 Feb 2026 10:56:39 +0100 (CET)
Message-ID: <abfb7c91-3065-4569-a080-ab0e0c259a12@posteo.eu>
Date: Wed, 18 Feb 2026 09:56:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Push Certificates: Privacy Concerns Regarding the "pushee" Header
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <d180884c-8108-4c8a-9cc7-5314a4f5a45a@posteo.eu>
 <xmqqldgrb1ha.fsf@gitster.g> <19c5dd32-6752-43fa-a664-5e6d29d9e681@posteo.eu>
 <xmqqo6lm8ubv.fsf@gitster.g>
From: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Content-Language: en-US
In-Reply-To: <xmqqo6lm8ubv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

So, imagine a world where push certificates are more "end-to-end". 
Think transparency log meets Git (see https://transparency.dev/ for more 
context).  Not only `git push --signed`, but also `git pull --signed` 
exists.  The remote being fetched from must provide evidence for the 
puller verify the range being pulled, e.g. 0000000..ccae4e0.  It does so 
by sending along the blob that contains the corresponding push 
certificates[^1].

In this bright future, where any puller is an auditor, you would run 
into an issue if you want your repository to be pulled from different 
places (pullees? fetchees?).  However, there is a way out: Let the 
pusher specify with which locations they are happy to have their push 
end up at.  In your case, since you are happy for others to pull from 
https://github.com/gitster/git, you add to your push certificate:

	certificate version 0.1
	pusher SHA256:xX6bp…T0  1771188983 +0100
	pushee https://example.com/repo.git
	pushee git@github.com:gitster/git.git
	nonce 1771188983-345389c

	0000000 ccae4e0 refs/heads/main

I will also give you the counter arguments:  Firstly, with repositories 
that have many mirrors, the number of headers might become 
problematically large.  One remedy would be to allow configuration of 
aliases on the side of the puller/verifier.  One could accept all values 
of `remote.<name>.url` as valid.  One could introduce 
`remote.<name>.alias`.  Secondly, for repositories with exactly one 
canonical location, no configuration would be necessary and the value 
being used today would be correct.

---

[1]: In general, it would have to send multiple push certificates. 
Firstly because there might be multiple refs being pulled over multiple 
ranges.  Secondly because that range might have been established over 
multiple pushes.
