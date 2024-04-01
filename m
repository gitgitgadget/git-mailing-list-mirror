Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962F48CE0
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991007; cv=none; b=CVWlSmds9jGSpoDlu9jBTrxAWNhrffhldLQzdWHTtthSxyPTIqSQu4GThry1rSLD79RJD7q9Bv+pGQmwnTb1/gfmUQv6zS7oBG1aC2m9HR8DaVvWJTdXe4VArJmlwQSM2Y+1I5SnmAlQaR2SPdkDwXBZH3tcl3SZ/+92MN3unGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991007; c=relaxed/simple;
	bh=PvRb5/jl5w2Mgq4pziivjwQyIii/KoUV53E2Raxc+Rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/581yAb7jRFJBs/kpY9O52zj8saG9XMj9LjeeHDpdC7ZMzQFCgE9ft5VUxrqf2IVCAoXWBL6s52047vzgaCMq11k7b/oH2LqB5FSJJMDUVm7nEN+Xh3MHa8jNGm22x0zUn4qSAq2Fy5STkIR14LDN6dTbFw8ZaHDCVnrrQMWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V1kFOwLJ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V1kFOwLJ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C974E211D1;
	Mon,  1 Apr 2024 13:03:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PvRb5/jl5w2Mgq4pziivjwQyIii/KoUV53E2Ra
	xc+Rs=; b=V1kFOwLJMxgiY6n3SiyfmDgdi19+GCErnMFgeT0MCuX/IbSHWg3uNP
	Hs2+g+8kbtJrj4dK7tzdFw2bgwDMFar8E++G/qS7JTMVApnScKSMGHdy8iiY1LLQ
	xG/1i/AHp1/LvPuDlg74LhxWlLEkVa4shU42w9pVgBttrXoed/7Og=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C1173211D0;
	Mon,  1 Apr 2024 13:03:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 38256211CF;
	Mon,  1 Apr 2024 13:03:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Peter Krefting <peter@softwolves.pp.se>,  git@vger.kernel.org,  "Osipov,
 Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <20240401163209.GB3120568@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 1 Apr 2024 12:32:09 -0400")
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
	<xmqqh6gni1ur.fsf@gitster.g>
	<5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
	<xmqq7chif1pu.fsf@gitster.g>
	<20240401023225.GA2639800@coredump.intra.peff.net>
	<c13c0751-0758-e068-282e-eb43496213b8@softwolves.pp.se>
	<20240401163209.GB3120568@coredump.intra.peff.net>
Date: Mon, 01 Apr 2024 10:03:13 -0700
Message-ID: <xmqqmsqd9fse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BACEFC5E-F049-11EE-8F6E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> So I think this is fine.
>
>> > $ git show -s --stat --summary --first-parent v1.0.0^0
>> 
>> Hmm, the git show manual page doesn't document supporting "--first-parent".
>
> I think that's a documentation bug(-ish). We do not include all of the
> traversal-related options that "git log" could use because "git show"
> does not traverse by default. But it does also affect diffs, per the
> comment added to git-log's documentation in e58142add4
> (doc/rev-list-options: document --first-parent changes merges format,
> 2020-12-21).

It's one of the "show is a command in the log family, so some of the
options that are appropriate to log applies there".  The ones that
are not useful are the ones about commit walking (e.g., "git show
--no-merges seen" would probably show nothing), but many are still
relevant.  After all "git show" is a "git log --no-walk --cc" in
disguise.  The "--first-parent" option affects both traversal (which
is useless in the context of "git show" that does not walk) and also
diff generation (which does make it show the diffstat/summary/patch
relative to the first parent), as you two saw.

>> I saw the code that tried to avoid calling one. I don't know the internals
>> well enough here to figure out if we can do without, even when using git
>> show?
>
> There's not really an easy way.

True, but this is "we show the single commit we found before
exiting"; executing "git show" as an external program is fine and
not worth "optimizing out" the cost of starting another process.

> I think the only thing you could do is call cmd_show(), but I'm
> skeptical of that approach in general. The builtin top-level commands
> are not designed to be run from other spots. And while it will generally
> work, there will be corner cases (e.g., loading config that touches
> globals, affecting the calling command in unexpected ways). I suspect
> you could largely get away with it here where showing the commit is the
> last thing we do, but I don't think it's a good pattern to get into.

Exactly.  Anybody who turns run_command("foo") into blindly calling
cmd_foo() should be shot, twice ;-).  The right way to turn
run_command("foo") into an internal call is not to call cmd_foo(),
but to refactor cmd_foo() into the part that sets up the global
state and the part that does the "foo" thing, and make the latter a
reusable function.

In the longer run, if we had infinite engineering resources, it
would be nice to have everything callable by everything else
internally, is it worth doing for this case?  I dunno.

>> That made me realize, if "git show" runs things through a pager, wouldn't it
>> then lose the "%s is the first %s commit\n" message printed by
>> bisect_next_all() before calling the function to show the contents?
>> 
>> Is that fixable?
>
> Good catch. IMHO we should disable the pager entirely by sticking
> "--no-pager" at the front of the child argv. But then, maybe somebody
> would like the output to be paged? I wouldn't.

Hardcoded --no-pager is a good workaround.  But if the output is
long and needs paging, wouldn't we see what was shown before we
spawned "less" on the screen when we quit it?  Running

    $ (echo message here ; git log --help)

and then saying 'q' to exit the pager leaves me "message" after that
command line.

> If we really wanted to keep the pager for git-show, I guess we'd need to
> have it print the "%s is the first %s commit" message. The only way I
> can think to do that is to pass it as a custom --format. But then we'd
> need to additionally specify all of the usual "medium" format as a
> custom format, too, which is quite ugly.

;-)  Ugly but fun.

I wonder how hard it is to add %(default-output) placeholder for the
pretty machinery.

Thanks.

