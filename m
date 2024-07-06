Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EB13A87E
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720289180; cv=none; b=uCVFydNqc/oeNDEpdjqg841RBuIsYn7k/1uorXnL9Ywqvv63ObTBHuTHfAbO6vPIXrHpkYqRnrbHgEx3DZRfCjK5GM0RQU/ykSPgGRzinO3oH+TiWo8tC/Z3t41g1+xrinLpkLhTD2nTRIKxilDsEaC2fBv1+E2AeW0c6cC1PtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720289180; c=relaxed/simple;
	bh=wGYyD9rmKGCNku48xUL94oN0Whcrt+J9/ypKCXzoCIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFmC70I/WxnWuAGM92LGb3alIS//PfpY1HlCtve2Ns8XMzwyhu0WiZPAvsuI6GqqiYVyjc2EUJ1Do2XQ+rcDwOCZmZX5aj+mB1MNgNilBkAjbxzt2tk1QZ5aveWXMS4zEZ1X8/nICvZQq7Kx9BSAVv1O5yT48ovHIJ5XmtNJfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AjnBoha4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AjnBoha4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B7E3325A4;
	Sat,  6 Jul 2024 14:06:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wGYyD9rmKGCNku48xUL94oN0Whcrt+J9/ypKCX
	zoCIw=; b=AjnBoha4YZOAmBOMC1JGfwE2SF655+WZCbXT+CxO3BZQloXNc4rPJQ
	lo7o1oR2XMGqGvI/ruwpTUzq5N2JyN4zG8PENZtYnsESqzZw4cyHbdTeMRUBOv2R
	CPRrtoE+2KW34UGMEStegaRK10cbfGEecyJ/jjRKDgPgA/sRPk4Ro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31C8D325A3;
	Sat,  6 Jul 2024 14:06:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9254D325A2;
	Sat,  6 Jul 2024 14:06:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: Elijah Newren <newren@gmail.com>,  Antonin Delpeuch via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
In-Reply-To: <7bc2ff20-98b8-45d7-95b8-e1b09bdeda07@delpeuch.eu> (Antonin
	Delpeuch's message of "Sat, 6 Jul 2024 15:30:45 +0200")
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
	<xmqqmsmycriv.fsf@gitster.g>
	<dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
	<xmqqr0ca9qkj.fsf@gitster.g>
	<CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
	<xmqqed873vgn.fsf@gitster.g>
	<7bc2ff20-98b8-45d7-95b8-e1b09bdeda07@delpeuch.eu>
Date: Sat, 06 Jul 2024 11:06:09 -0700
Message-ID: <xmqqzfqupf8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6CC2698C-3BC2-11EF-9A0A-965B910A682E-77302942!pb-smtp2.pobox.com

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> In the documentation of the recursive merge strategy (for instance in
> "man git-merge"), it is claimed that "recursive defaults to the
> diff.algorithm config setting". As far as I can tell, both from my
> reading of the code and my interactive testing, this is wrong. This
> affects the "merge", "rebase" and "pull" commands, which all three
> mention this configuration variable in their man page without respecting
> it. Ouch!

Thanks for digging.

> I have looked for all commands which mention diff.algorithm in their man
> page and checked whether they indeed respect it. The "diff-index",
> "diff-tree" and "diff-files" commands also make this erroneous claim.

It is not erroneous if we say that these 3 diff plumbing commands
ignore the configuration variable.  They should ignore end-user
configuration for reproducibility.

See also my earlier response to Elijah <xmqqed873vgn.fsf@gitster.g>
on a related topic.

> The --diff-algorithm CLI option (as well as the --histogram and
> siblings) are respected, but not the diff.algorithm config variable.

Then they are behaving exactly as designed, which is good.  We still
need to correct their documentation, though.

> Those inconsistencies seem to be caused by the inclusion of the
> `diff-options.txt` file in the man pages, which leads their man pages to
> documenting a bunch of config variables which are in fact ignored.

That is quite understandable mistake ;-) "git merge" and other
end-user facing commands should be taught to pay attention to both
the command line option and the configuration variable.  The
plumbing commands should pay attention to the command line only.

> In any case, I would of course make sure the "ort" strategy continues to
> ignore diff.algorithm for now, given its current default value.

It may make the effort easy to follow if you do this step-wise:

 (1) start with "all Porcelain commands pay attention to the same
     diff.algorithm variable.  The plumbing commands ignore
     diff.algorithm.  All commands, either Porcelain or plumbing,
     may have different default when unconfigured (like ort does)".

 (2) then add "each Porcelain command <cmd> pays attention to
     diff.<cmd>.algorithm if defined, otherwise diff.algorithm is
     used as a fallback default.  There is no diff.<cmd>.algorithm
     for plumbing commands---they are designed not to be affected by
     the configuration variables".

 (3) optionally, doing "all Porcelain commands, when not configured,
     will use the same default (ort is no longer special---everybody
     falls back to algorithm X)" may be desiable for consistency and
     simplicity, but it would probably want further discussion can
     be left outside of the topic (e.g. right now the best candidate
     for X may be histogram, but is it suitable for all commands?
     should this extend to plumbing, making diff-index for example
     to use X as the default not myers when the command line does
     not specify --diff-algorithm?)

Thanks.

