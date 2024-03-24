Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BC15E97
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711276973; cv=none; b=ed3Fp4Sc+r3qDQJKCxpaN2WIK0A2JoM/c4POwgPwMzuqhHVxy0GQqinfCSqJxC2bE+PZpMkVZw/s6IFLUKAXZG1H9jpukZp18yCv1P0mwoHxfNFSrC5XXZkj1iVpGx/HOvizfq4NmacMf/Ot+Ixh6DE80Zl6Uu+sXL1H/glhzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711276973; c=relaxed/simple;
	bh=4goz9jjxH2AAixz/ya2iOEvdqr4h9yFQynpL9Gz5MDI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=riqTnuZiAxmYkj8NjC3LDhpyio3zV2DJzHSkMZnG+MIYqzh7BJDjw0g9huJENUwqBbB5LJQLz5KOqSOwgDh9/o8Nqw6jzF66w0DRcJjBVQwZG7lNsl6H7m53KGBkmu2vbQcOWXLQgoyFv7mcdhijq4yTDwmjGNLYRlhahlDL7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Y7nR2Mla; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Y7nR2Mla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1711276968;
	bh=Bck21o0MRyhnXnPdSOxvnh7PhK9CZ/XSmoFOSruy4Ts=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Y7nR2Mlapo0LxgUNCBZyWheoQ8ph3DIsIRkiw3IpW+SssMi2NzWzZPs/toIJRfj9D
	 HfYYb2BIuNFgfcycrDFPy4FyIzrI9Hso5xG69GuqOvIEhcaYt48ZEM6V7ID5wDhJ4U
	 174/DES6P+bdUmhdedl4MEARxo1FiFu6N1zok7Y3XqkkDTDHwhk/jLlyCGytrortWI
	 HksgLFM4QHK/Z7FVojnH4adtP55tjKT7WuRJO7kw0nQ65CWCmjMFbmWlw+7Mqi/x12
	 ulwg/vUMYYOSJ+JP8gob0xCitGMx7xCRZY4pS7QfeQd+95MJsoHthEsJPEj5MxUvMw
	 8AOJUz4SLMSTA==
Received: from [192.168.42.22] (29-99-142-46.pool.kielnet.net [46.142.99.29])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 151103C01DE;
	Sun, 24 Mar 2024 11:42:48 +0100 (CET)
Message-ID: <3a197bc5-de6d-4623-9141-b227cf454450@haller-berlin.de>
Date: Sun, 24 Mar 2024 11:42:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
In-Reply-To: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 17.04.23 10:21, Stefan Haller wrote:
> The --update-refs option of git rebase is so useful that I have it on by
> default in my config. For stacked branches I find it hard to think of
> scenarios where I wouldn't want it.
> 
> However, there are cases for non-stacked branches (i.e. other branches
> pointing at the current HEAD) where updating them is undesirable. In
> fact, pretty much always, for me. Two examples, both very similar:
> 
> 1. I have a topic branch which is based off of master; I want to make a
> copy of that branch and rebase it onto devel, just to try if that would
> work. I don't want the original branch to be moved along in this case.
> 
> 2. I have a topic branch, and I want to make a copy of it to make some
> heavy history rewriting experiments. Again, my interactive rebases would
> always rebase both branches in the same way, not what I want. In this
> case I could work around it by doing the experiments on the original
> branch, creating a tag beforehand that I could reset back to if the
> experiments fail. But maybe I do want to keep both branches around for a
> while for some reason.
> 
> Both of these cases could be fixed by --update-refs not touching any
> refs that point to the current HEAD. I'm having a hard time coming up
> with cases where you would ever want those to be updated, in fact.

Sorry for continuing to beat this dead horse, but I just can't help
adding this other use case that I just ran into yesterday and that
supports my point as well.

Suppose I have a branch b, and I realize that it has commits for two
separate features, so I want to split it up into two independent
branches. The most natural way to do this is to create a branch b2 off
of b, do an interactive rebase on b and drop half of its commits, then
checkout b2, do an interactive rebase on it too and drop the other half
of the commits. With rebase.updateRefs set to true, the first
interactive rebase changes both b and b2, which is not what I want.

Of course you can argue that since I'm doing an interactive rebase in
this case, it's easy to see the update-ref todo and delete it if I don't
want it. That's true, but it's an extra thing that I have to pay
attention to.

Also, there's a twist as I'm writing this from the perspective of
lazygit again. Lazygit has a feature to drop commits from a branch
without doing an interactive rebase; it runs an interactive rebase
behind the scenes, sets the marked commits to "drop", and continues the
rebase. I don't get a chance to delete the update-ref todo in this case.

Now you can argue that this is really lazygit's problem then, and I can
add code to it to delete the update-ref todo in this scenario if that's
what I want. That's true again, and I will, but it bugs me that we have
to add clients around stock git to get the desired behavior. I would
prefer to change git so that it behaves in the desired way in the first
place.

And finally you can argue again that there's Phillip Wood's
counter-example, where you create b2 off of b with the intention to
create a stack, but before you make the first commit on b2 you realize
there's this unwanted commit in b that you want to drop first. In this
case you do want to update both b and b2. My take on this is that 1)
it's a much more rare case in my experience, and 2) it's much easier to
recover from. Once you realize that b2 wasn't updated by the rebase, you
just reset --hard it to b again. This is a straight-forward operation
that even novice git users know how to do. Compare this to having to
reset b2 back to where it was when you realize that it was updated by
the rebase and you didn't want it to; you need to get it back from the
reflog in that case, which is a more advanced operation for many users.

-Stefan
