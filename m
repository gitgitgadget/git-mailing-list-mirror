Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016A211A16
	for <git@vger.kernel.org>; Tue, 20 May 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730983; cv=none; b=qhFEhpJ1AD8aAnVIpABkOV7h8s0T5iqY+00y/0wg5bWgCpaJYzUdSDBOqRGzbJn3tiWVQo1ITTrKcD3GHWoFNm/rj+PHI4A34xX3hMXoqQKoo535nAtM2UPYJ0KaP0BY0kkfXWK49co1pVGxypvZoLUk0dYxqmAbBso+ifCJZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730983; c=relaxed/simple;
	bh=Vecsd3sE7bwYFYb6+Nt8hryBeEf3n35EnBieVPYFah4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hhec4SnLppc88Wsu1iNyQaXU/cRsKGaiq32FSJ7Ni1EGffnW9zXi6ikfysXf8Nu5iKEqyTA2qJW6Yq31gJihZZpkUJCx2ASL4EuHH9x3RM1jC6mrO2UM1HzbMtvI9oaU0GAku6C+MCj9K1Kyw7BCTNK7JV8Od0o+cDumPMltWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oqEf/XuP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oqEf/XuP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747730975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ueucB8Oc5/8qKWxTgq0ZY5UiOE+XX5z75C1eS3LZ9aw=;
	b=oqEf/XuPz97HGkURsjlxrh4PdyRH4lxJwURHaulHdiLLpNyg/EJ/AzS4HEdG8dkbk9Mj5w
	Qskw79Jc7fiomytrafDtywCjvi4TsEy5AEoXvG2OHo2PBTlUYV+gpQy5B6w3n9yPdKz/KG
	TMIdQsSj6AE0ZmC2cOT0kT+uaBwvtpA=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: Marc Branchaud <marcnarc@xiplink.com>, Junio C Hamano
 <gitster@pobox.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
In-Reply-To: <aCbBKj7O9LjO3SMK@pks.im>
References: <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
 <874ixnjltf.fsf@iotcl.com> <xmqqy0uz7zzh.fsf@gitster.g>
 <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>
 <aCXsKHiP4uIzCMrt@pks.im> <xmqqa57d3k1d.fsf@gitster.g>
 <a97db895-5121-427a-b64f-df225309f429@xiplink.com>
 <20250515193046.GA3320240@coredump.intra.peff.net>
 <aCbBKj7O9LjO3SMK@pks.im>
Date: Tue, 20 May 2025 10:49:16 +0200
Message-ID: <87tt5fis4z.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

>> On Thu, May 15, 2025 at 01:39:59PM -0400, Marc Branchaud wrote:

> On Thu, May 15, 2025 at 03:30:46PM -0400, Jeff King wrote:
>>
>> The debate has mostly been over "blame" here. 

Okay, I'm happy to move away from "blame".

>> But I think "tree" is also inaccurate. Theoretically it can be about
>> any set of paths in the repo, not just the entries of a single tree.

Totally.

>> So:
>> 
>>   git last-modified Makefile Documentation/Makefile t/Makefile
>> 
>> would be a perfectly valid thing to ask about (and of course a
>> pathspec like '**Makefile' would be a simpler way to do so). The word
>> "tree" was there because the original use case at GitHub was getting
>> those values for all of the entries in a particular tree.
>
> I like "git last-modified". It's name is very telling and it does just
> what it says.

I like `git last-modified` too, but I'm only wondering if it makes sense
if you pass it a revision range:

    git last-modified HEAD~2..HEAD

It kind of still does, but it's a little more questionable.

>> But conceptually it is just about expanding a pathspec into a set of
>> paths, and then traversing and reporting the last time each path was
>> modified. It _almost_ fits into the "git-log" family, which is all about
>> traversing and pathspecs. The output is a bit different, but I almost
>> wonder if it would work as an option to continuously limit the pathspec.
>> Something like:
>> 
>>   $ git log --format=%H --last-modified --raw '**Makefile'
>>   89d557b950c7a0581c12452e8f9576c45546246b
>>   :100644 100644 13f9062a05 c4d21ccd3d M  Makefile
>>   [ skip a bunch of commits that touched only Makefile, nothing else ]
>>   a7fa5b2f0ccb567a5a6afedece113f207902fa6f
>>   :100644 100644 6485d40f62 b109d25e9c M  Documentation/Makefile
>>   [ skip more; now this one is interesting, because one commit touches a
>>     bunch of files! It also touches Documentation/Makefile, but we'd
>>     have already narrowed our pathspec to forget about it by this point ]
>>   5309c1e9fb399c390ed36ef476e91f76f6746fa9
>>   :100644 100644 3e67552cc5 97ce9c92fb M  contrib/credential/libsecret/Makefile
>>   :100644 100644 238f5f8c36 0948297e20 M  contrib/credential/osxkeychain/Makefile
>>   :100644 100644 6e992c0866 5b795fc9fe M  contrib/credential/wincred/Makefile
>>   :100644 100644 f2be7cc924 33c2ccc9f7 M  contrib/diff-highlight/Makefile
>>   :100644 100644 5ff5275496 2a98541477 M  contrib/diff-highlight/t/Makefile
>>   :100644 100644 4e603512a3 497ac434d6 M  contrib/mw-to-git/Makefile
>>   :100644 100644 f422203fa0 6c9f377caa M  contrib/mw-to-git/t/Makefile
>>   :100644 100644 52b84ba3d4 691737e76b M  contrib/persistent-https/Makefile
>>   :100644 100644 093399c788 2a85f5ee84 M  contrib/subtree/t/Makefile
>>   :100644 100644 667c39ed56 6c5a12bc32 M  git-gui/Makefile
>>   :100644 100644 749aa2e7ec e656b0d2b0 M  git-gui/po/glossary/Makefile
>>   :100644 100644 6911c2915a 4ff4ed0616 M  t/interop/Makefile
>>   :100644 100644 e4808aebed 9b3090c4ed M  t/perf/Makefile
>>   :100644 100644 bd1e9e30c1 722755338d M  templates/Makefile
>>   [ ... end immediately without traversing further here, since all
>>     paths have been reported ... ]

I like this idea. I think it makes sense to "commit ABBC touched X, Y, and
Z; and commit BBCD touched xx, and yy; and ...". It makes the output a
lot less verbose.

>> I dunno. I just made that up. The output is obviously quite different
>> than blame-tree produces

I think it depends on who you consider the primary user would be? Or
said differently, whether we mark this new command as plumbing or
porcelain? I would consider it a plumbing command, and that's the main
reason why I'm trying to upstream it: to use it in our tooling at
$DAYJOB. The output you present above is even more obscure than my
proposed git-blame-tree version, making it even more plumbing-like.

>> It is a bit different from regular log, though, in that we'd expand the
>> pathspec at the very start, rather than applying it continuously as we
>> traverse (otherwise we could never end early, since we'd never know if
>> there was a "foo/Makefile" deep in history).
>
> That's the biggest downside from my point of view: it works quite
> differently, so we can expect that many of the options that git-log(1)
> accepts wouldn't make sense at all.

Agreed.

>> So you could argue that "git last-modified" could also just take
>> format and diff output options. ;)
>
> But this one I agree with -- if we had git-last-modified(1), then it
> would eventually make sense to have at least `--format`. I don't have a
> use case for diff output options, but if any come up it could probably
> be added at a later point, as well.

I was planning to add `--format` to git-blame-tree(1) in the future, or
do you think it should be part of the initial version?


-- 
Cheers,
Toon
