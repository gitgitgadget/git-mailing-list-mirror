Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC65163A9B
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260761; cv=none; b=i2+8yLEs8CYEX28tmfR/5l9e8ZNjzoz6biYF+oW7YywaEJcP7Gpb41xAU7VSrfmeJZCeA5sJ+Jw5s7ube+sMrzlJveU2m0JYRhTnPnhvXc9Y2h2ktNYcmpgdyYP3GPWjWY5HZhKriaMr2l/jWeVAzrA7XT4kr08TPd0lkcQaQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260761; c=relaxed/simple;
	bh=PUvii7E2UjWlYIvJrjl9BFiMc4ZdB8GZr3Fg6GBarRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NMV4Y9z8U0Oyabp06vpfuAs1KqxZ3mqoRJMwSYZpV0hR77zjE32MAv3I8JbZcTaICoZ57iBFxmb95JsZaqHX4QBboXJf3UiTUZDoBpJW86yeOdDbrq885kxo69gws7YE3LlyMdvVuy7J4mCBifkwGBypcD4pr7oOYAOYvRSwefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HXzomdFN; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HXzomdFN"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CC632FC43;
	Wed, 21 Aug 2024 13:19:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PUvii7E2UjWlYIvJrjl9BFiMc4ZdB8GZr3Fg6G
	BarRE=; b=HXzomdFNfMcVx7hpHkavWAawVz0bTUY/19BekgjgtusX/Obc2OSOu4
	qM1quMPHzXqD99AMjuhPHwiPGEbnHGx3HshucFMV4CvhYydinP3e/1sR7I6hZwoG
	XM+3+7KXa7vPzliwtJ30hj4wdmrsRH+Vt5QSS8kLKubtFQfroEHOg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 76A2B2FC42;
	Wed, 21 Aug 2024 13:19:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F013B2FC3F;
	Wed, 21 Aug 2024 13:19:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "ahmed akef via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ahmed akef <aemed.akef.1@gmail.com>
Subject: Re: [PATCH v2] docs: explain the order of output in the batched
 mode of git-cat-file(1)
In-Reply-To: <pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
	(ahmed akef via GitGitGadget's message of "Wed, 21 Aug 2024 10:05:29
	+0000")
References: <pull.1768.git.git.1724232485264.gitgitgadget@gmail.com>
	<pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
Date: Wed, 21 Aug 2024 10:19:14 -0700
Message-ID: <xmqqa5h5ztd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E1E870E-5FE1-11EF-B90E-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"ahmed akef via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  If `--batch` or `--batch-check` is given, `cat-file` will read objects
> -from stdin, one per line, and print information about them. By default,
> -the whole line is considered as an object, as if it were fed to
> -linkgit:git-rev-parse[1].
> +from stdin, one per line, and print information about them in the same
> +order as they have been read from stdin. By default, the whole line is
> +considered as an object, as if it were fed to linkgit:git-rev-parse[1].

A few "Huh?" I had while reading the above.

 * "as they have been read from stdin"; drop "from stdin" here, as
   we already know we are talking about the mode that reads object
   names from the standard input and there is no need to repeat it.

 * "considered as an object" -> "considered to be an object name" or
   "used as an object name" [*].  This primarily comes from my
   spinal reflex against "consider as", plus my desire to be more
   precise in terminology.

Thanks.

Nothing mentioned below should be part of this patch, but as I
noticed it while studying the current documentation to prepare this
review, I'll record them as #leftoverbits.

The description of how lines read from the standard input should
look like needs more work.  Documentation on "--batch" says "the
input lines must specify the path, separated by whitespace", but is
it clear that it expects "<object name>", followed by a whitespace
(not necessarily a single SP), followed by "<path>"?  Without prior
knowledge, I wouldn't be surprised if somebody read the text as
asking for paths separated by whitespace, e.g.

    README.txt COPYING Makefile

that gives three paths.  The text needs to be tightened to say
something like "must give the path after the object name, separated
by whitespace.  The path is used to find the textconv and smudge
filter".

The section also says "See the section BATCH OUTPUT below for
details." but the section it refers to does not talk anything about
this whitespace thing.  It also is unclear what would happen if the
input line says:

    :COPYING Makefile

Would it apply the textconv/filters meant for Makefile to the blob
stored at COPYING in the index?  If we say

    :README.txt
    
would the command be smart enough to know that the blob came from
the path README.txt and apply the textconv/filters meant for that
path, without the input repeating the same information twice like:

    :README.txt README.txt

or something silly like that?


[Reference]

* https://www.britannica.com/dictionary/eb/qa/consider-and-consider-as


