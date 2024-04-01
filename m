Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51A38DD8
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989084; cv=none; b=ljpsOk8yMBtUmW2jFgLOvrQcvv4vkaa/CalWhnQDn1udKEUYssDMay0CgRUc6wTsHDjRuh7P5kzTajt3tXq8brSKSqZF8/lkHDzAw3QI01MJn/fEE/vp+aWAo+IN8QtBPQ1eOSyeQinlIOFJq2S+kAj4DTUhJEU2Qi5H/NY11ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989084; c=relaxed/simple;
	bh=IAC5lw1r+q7ZG5NSS7v6o30Xk57go+BoR/05TmAh5GM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4YFPUca+iENLIm7a8i5t9JCy/9UrJayekCiXWRdyd9myNn5bIrQApiolXFgngfQ5rSO2ynpdH/lx+E5f+pFXxXR3DK0diuv8hUpwm/gGpVlwDCyutshPk3vpRvTC1SBVEXKAs6q5SQ6vxCg6Orvxc06dy8EhEIzPTXlxwO8zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vDyF2BRn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vDyF2BRn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 763571E743B;
	Mon,  1 Apr 2024 12:31:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IAC5lw1r+q7ZG5NSS7v6o30Xk57go+BoR/05Tm
	Ah5GM=; b=vDyF2BRn8KOfF06n41DheEIaAxGOozuLUvvzCHgfCeUAKjUQ3TWbqj
	AShRfqAsU9DSCaillEBbDfDGJXKV78/gWME8GHFuzFWPKRGOeiaQY1F3u6jqNOh4
	ePB4q6++iwWt3bjcWH6bProoYZnQLpVGC7RUJIB/lAiKaZp9Ff9Js=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DEB21E743A;
	Mon,  1 Apr 2024 12:31:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE1D31E7439;
	Mon,  1 Apr 2024 12:31:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/add: error out when passing untracked
 path with -u
In-Reply-To: <h7yk7nk7cwyv35reqzfy7brpbn3xoaarhudteyvxfpkodvltt2@eggaahzrjryq>
	(Ghanshyam Thakkar's message of "Mon, 1 Apr 2024 18:57:12 +0530")
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
	<20240329205649.1483032-5-shyamthakkar001@gmail.com>
	<xmqqzfugvhnf.fsf@gitster.g>
	<b3j7l2ncstdiaxojtollxddmxvkbbeciou25yptguttr5qugmx@y3bzqbdxkyaw>
	<xmqqh6gnmzqs.fsf@gitster.g>
	<h7yk7nk7cwyv35reqzfy7brpbn3xoaarhudteyvxfpkodvltt2@eggaahzrjryq>
Date: Mon, 01 Apr 2024 09:31:19 -0700
Message-ID: <xmqqjzlhavu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 45BE7B5A-F045-11EE-87F4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> Well I think we should be going 'all-or-none' way as I can't think of
> any major user-facing command that does partial changes incase of
> error (besides two testcase below).

I agree that in the longer run, all-or-none would be something we
should aim for, but I'd strongly prefer leaving that outside this
topic, especially the existing ones that set exit_status to non-zero
but still commits the index changes.

I am OK, as a place to stop for now, if the topic had something like

+	if (take_worktree_changes) {
+		if (report_path_error(ps_matched, &pathspec))
+			exit(128);
+	}

in it, though, because this is a new behaviour.

> Doing this, we would need to take care of atleast 4 tests breaking in
> t3700-add:
>  error out when attempting to add ignored ones but add others
>  git add --ignore-errors
>  git add (add.ignore-errors)
>  git add --chmod fails with non regular files (but updates the other paths)
>
> while ignore-errors ones would be trivial to fix, fixing other 2 would
> probably require some more than trivial code changes, as from the title,
> their behavior seems pretty much set in stone. That's why I did the
> 'goto cleanup' approach to not break these.

I am not sure if these are expecting the right outcome in the first
place, and the need to examine what the right behaviour should be is
what makes me say "I do not want to make the all-or-none thing part
of this topic".

>> The renormalize() thing is not noticing unused pathspec elements,
>> which we might want to fix, but I suspect it is far less commonly
>> used mode of operation, so it may be OK to leave it to future
>> follow-up series.

Thanks.
