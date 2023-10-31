Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC1363
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VDpGEJBt"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B8A6
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:19:17 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AF9B91FA25;
	Mon, 30 Oct 2023 20:19:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FsFeD1C3HZbgOLV+9V3ixyVwek3orI41QKlC0U
	gAKvs=; b=VDpGEJBtFh4XcPL01lDmr1IuzisIJXfuOa9Af8vRjCWQsflA4xNpK5
	GG0VC3P7NedBHAT60/DeDjXcKo/5XiSX6Hb7yjK/ZWje6lzv/Dl2ZAVfRniaSWWz
	76X+hf/VjKN2/GdJ7Ebto8GTWNZy1r2dqwuHA3k2iTfP54iPRQClo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A76721FA24;
	Mon, 30 Oct 2023 20:19:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 478141FA23;
	Mon, 30 Oct 2023 20:19:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Ruslan Yakauleu via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
In-Reply-To: <ZUALkdSJZ70+KBYq@nand.local> (Taylor Blau's message of "Mon, 30
	Oct 2023 16:01:21 -0400")
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
	<ZUALkdSJZ70+KBYq@nand.local>
Date: Tue, 31 Oct 2023 09:19:11 +0900
Message-ID: <xmqq1qdb8wzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E9CD228-7783-11EE-AE0A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This seems like a pretty niche feature to want to introduce a new option
> for. I would imagine the alternative is something like:
>
>     ff="--no-ff"
>     if test 1 -eq $(git rev-list @{u}..)
>     then
>         ff="--ff"
>     fi
>
>     [on upstream @{u}]
>     git merge "$ff" "$branch"
>
> I don't have a great sense of how many users might want or benefit from
> something like this. My sense is that there aren't many, but I could
> very easily be wrong here.

Another more fundamental objection is "Why do we special case only a
singleton commit?"

Why isn't a trivial two-patch series also OK to fast-forward?
Three?  There is no inherent reason to draw a line on one commit
topic---given that a single commit could be a large and involved one
that could have been a multi commmit series.

And you cannot decide if the "topic" is large enough to deserve a
binding merge commit even if it is a single commit topic, or if is
small enough and you want to allow fast-forward, without looking at
it first.  So from that point of view, too, I do not think this new
option is a good idea.  Let's not add an option to encourage a bad
discipline.

Thanks.


