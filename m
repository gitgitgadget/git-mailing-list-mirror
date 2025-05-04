Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB94C7C
	for <git@vger.kernel.org>; Sun,  4 May 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746351511; cv=none; b=k/LWWhLwRDVDMCA2a+yb58RR0hSM8DCXt6qOfPUR1VhNgn/7J6YTnJBRQ5z+YCI+NkTjXwHyQLVj7DfOEQsFKcvtb088qiT8iALfh0eebf6jsYM8ERS2hiJjRqyH+b4Vf1EW7UtvcM0qmizE8w2ugNGlhWjy4xmnNE9lxjEfBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746351511; c=relaxed/simple;
	bh=5/ui0Na5e5roMIQYum4XaUN1mxpQN2Fg8+1RKLQT8gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=IpUMYiMR1nzgWKEfDGI8HECWMtx0TI8cnQeGCWXMdnwy4bX94eyoxXgm/646rJl7+2L1e4v2uuCdBkWvSmxjhEFP88cdfttJjbyiqKu2jnWGQ94bYLHEogdzrmWfgh1IRD8v8LHboWxK2geTF7GNBP0opHlf5FkNgJ+5b2HTIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZqzBj4lQkz7SZ7y
	for <git@vger.kernel.org>; Sun,  4 May 2025 11:00:13 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4ZqzBY1WNQzRnlJ;
	Sun,  4 May 2025 11:00:05 +0200 (CEST)
Message-ID: <50428492-8ece-426f-bfea-071b7bd2c374@kdbg.org>
Date: Sun, 4 May 2025 11:00:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: easily use meld 3-pane view to review merge commits?
To: Britton Kerin <britton.kerin@gmail.com>
References: <CAC4O8c9OJQQn_22i0-bZUDtHoi+ti6aT6FwupnQBoBFg6BNK6w@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <CAC4O8c9OJQQn_22i0-bZUDtHoi+ti6aT6FwupnQBoBFg6BNK6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.05.25 um 23:55 schrieb Britton Kerin:
> I like how git-mergetool can use meld with 3 pane view to see merge conflicts:
> 
>   git mergetool --tool=meld
> 
> I'd like to use the same sort of view to see already-committed merges,
> but I didn't find an easy way to do it.  It seems like git-diff,
> git-difftool and git-show are oriented entirely towards diff or 2-pane
> view rather than diff3/3-pane that git-mergetool uses.  Did I miss the
> existing functionality somehow?

I see a conceptual inconsistency with the desire to use a 3-pane view
with a merge commit.

When merge conflicts are to be resolved, you have exactly 4 versions of
a file to work with: base, ours, theirs, and the merge result. (Meld
does not show the base and uses only 3 panes.) For this reason, it makes
sense to have 3 panes in a merge tool, perhaps a forth for the merge
base. That's it. You never need to have more than that.

With a merge commit, you can have: the merge result, the first parent,
and the second parent... and the third parent, the fourth parent, etc.
You can have any number of versions to deal with.

How does that fit into the picture? Can meld (or any other merge tool)
have any number of panes and still work in a reasonable way? Why should
2-parent merge commits be special-cased?

That was the devil's advocate speaking. 2-parent merge commits are
common enough that some merge tool support could make sense, but we
should be aware that there is a conceptual hurdle.

-- Hannes

