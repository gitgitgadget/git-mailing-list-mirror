Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D78488
	for <git@vger.kernel.org>; Wed, 14 May 2025 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233763; cv=none; b=kgz5Ao3WWH/g3E7YL7jE5ob9OAkqQXDPL5YrejMuwBrcHOlqKo87em6MAVlMI2bl2TT8MJZzjiBvBNbPbLsjkFUQ9ASc2wg2hfUgO8jIIN3IkvzdbVEo/D+gKJtya4t+DRueIysV4Zwe2WVf75MMUvvyH1eUc5lADDf76daXJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233763; c=relaxed/simple;
	bh=kr0mHhZEFyedWHKUSdnH5rJpM2MX2kk/BBNAI6gIw/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4YiAAYKbM0gOCIZhTgGph16lDasqu9xAatrTBYLX5NxqxPcv6TEyHooGoMKclbBCEf2PO9B0IxQHkCHOEVFAGViCEMzxKUMn0gQWc5y6xwkhxL4UJwHZR3qxMRKKLvXo9RV6kB5JlEUzX/63XuT/UzSrCBv5wegm+Qw0767Jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YB0aAWzi; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YB0aAWzi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747233755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+b0nzduu4S1NJgGtkaD0RALBNLll2sfuPPt3fjxxJ4=;
	b=YB0aAWzizoJKXYZ91On7tUsx+lb/bQllFENhc2LBCvgVXfZl2f5e+11fg42/Je7p2/gryc
	UOLFsXiOWnk0DA1TNt7/m7P9gI/AUHhnTfsQZtG1CED8RXkxEh0RGifOeR5UTfv13w3SwB
	2QEl0eHtqX3cvSwGlt7QO9+EQE4E2BY=
From: Toon Claes <toon@iotcl.com>
To: Marc Branchaud <marcnarc@xiplink.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
 <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
Date: Wed, 14 May 2025 16:42:20 +0200
Message-ID: <874ixnjltf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 2025-05-08 10:26, Junio C Hamano wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>> 
>>> This distinction brings up a wrinkle in my proposed DWIMery: should
>>> 	git blame path/to/file
>>> show the annotated blamed lines of the file, or simply display the
>>> last commit that changed the file?
>> 
>> I thought you switch to blame-at-the-file-level only when you are
>> given a directory (or a tree)?  "git blame path/to/file" has ALWAYS
>> done "blame these lines that appear in this file", and cannot change.

I don't know about that. What if you want to blame multiple files:

  $ git blame-tree refs.c refs.h

or (letting your shell do the globbing):

  $ $ git blame-tree *.h

I see these use-cases are very convenient. At GitLab we need to have
some kind pagination on files in a tree, if we can pass individual
filenames, we could use that for pagination.

>> Of course you can say "git blame path/to/ | grep file"; as you said
>> yourself,

This isn't very efficient. If a file in that tree was only touched in
the "initial commit" you have to wait for the blame process to walk the
history all the way down to that commit, while you're not actually
interested in that file.

>> 
>>> 	git log -1 path/to/file
>> 
>> is so obvious, we do not need to introduce yet another way to get to
>> the same information, I think.

Well, if you can pass multiple files (which git-blame-tree(1) currently
can) it's way more efficient to walk the history once, and see along the
history which file was touched when. For us at GitLab that's the whole
idea of upstreaming this feature.

> Fine by me.  I personally don't think of "git blame" when I want to see 
> a file's commit history.

Personally I don't like the idea of the DWIM approach. I rather keep
following the UNIX philosophy and having each command do one thing well.
I think it weird to change behavior based on context.

You said earlier in this thread:

> This distinction brings up a wrinkle in my proposed DWIMery: should
>         git blame path/to/file
> show the annotated blamed lines of the file, or simply display the last 
> commit that changed the file?

For me this gives good motivation to not mix behavior of file-level and
line-level blames into a single command. If behavior in ambiguous, we
should avoid it.

> I can appreciate the convenience of being able to do that with "git 
> blame".  I suggest adding an option for this specific case, like maybe 
> "--latest" (I don't feel strongly about the option's name).

What makes `git blame --latest` better than `git blame-tree`?

> I agree that blaming is a well-(known) concept.  I also agree that most 
> users would understand what blame-tree would do, *once they find it*.

I'm also not convinced why a option argument to an existing command
would be easier to discover than a new command. I think it's more an
issue of us advertising features, than commands being discoverable on
it's own.

> Also, I think sacrificing usability because it makes the coding hard is 
> unfortunate.

Agreed, that was not a good motivation from my side to make.

I wrote:
> > Forgive me, but I think folding into git-blame(1) will also solidify
> > Git's reputation of obscurity.
> 
> Please elaborate.

As I mentioned above, I think having behavior of git-blame(1) depend on
the type of the argument (is it a dir or a file) is rather obscure. The
format of the output returned will be drastically different in both
cases, and having to machine-parse this might be tricky.

Cheers,
-- Toon
