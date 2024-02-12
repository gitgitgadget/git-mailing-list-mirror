Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C5E3E496
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755975; cv=none; b=ISRhYsnBWD5QVLNIJkwHf0oWh0d9oVpirCEsK6GwpvWzSu90BrfmzESTgYS7yIbrjidoOQ7141orElrw8wp9roGgz5ejnYjZsbtXzfuCYK06ja950PdFBCPxyte7l25dLzHMIFq7PJQi316WtOpDDdwpO5z9Ziw49nMp9wqDkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755975; c=relaxed/simple;
	bh=CkFRpl6cAJXQGrXXapTVY+BHCJg2txWv5vulB3jZd+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rjDAFKbBaDV+1EpbxyNJPYfrDXbVqAyDnpqLT9eN2RmdMjAN4bRs1qfRRW9b2ZcquVrBFFl8nvN9UcqUzwC0qLt7K+nju7UvC5il9rmvUUkFwSePav3Ic6nh2wb48YvQI8N87J5v9UXkCoxe0PecE1wtXNgcAFHnew/gzAmTNfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xikWbDHh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xikWbDHh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 51CE22FD84;
	Mon, 12 Feb 2024 11:39:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CkFRpl6cAJXQGrXXapTVY+BHCJg2txWv5vulB3
	jZd+c=; b=xikWbDHh81b82ZYQ5TNsvpREqmzIjOyFqzF6bOPpkyb29xpi6ugUMV
	GOhK+khaVIRfaPHlJUuJ8nV/RYPKLNe/3bfyc3chSoYe16Qp+tMKWcVPwb6HaZbD
	woo1lgvvxc84r4aHHaS4MqsRKY98zF4Q7vEnY4DoyhKEDtqmVjXwg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A5752FD83;
	Mon, 12 Feb 2024 11:39:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E12862FD82;
	Mon, 12 Feb 2024 11:39:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Stefan Haller <lists@haller-berlin.de>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: Interactive rebase: using "pick" for merge commits
In-Reply-To: <ZcnFl8kypKRYeLo3@tanuki> (Patrick Steinhardt's message of "Mon,
	12 Feb 2024 08:15:35 +0100")
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
	<ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
	<65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
	<ZcnFl8kypKRYeLo3@tanuki>
Date: Mon, 12 Feb 2024 08:39:28 -0800
Message-ID: <xmqqcyt18wn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4B044FFA-C9C5-11EE-B77C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 10, 2024 at 10:23:16AM +0100, Stefan Haller wrote:
>> On 09.02.24 17:24, Phillip Wood wrote:
>> > On 09/02/2024 15:52, Stefan Haller wrote:
>> >> When I do an interactive rebase, and manually enter a "pick" with the
>> >> commit hash of a merge commit, I get the following confusing error
>> >> message:
>> >>
>> >> error: commit fa1afe1 is a merge but no -m option was given.
>> >> 
>> >> Is it crazy to want pick to work like this? Should it be supported?
>> > 
>> > It causes problems trying to maintain the topology. In the past there
>> > was a "--preserve-merges" option that allowed one to "pick" merges but
>> > it broke if the user edited the todo list. The "--rebase-merges" option
>> > was introduced with the "label", "reset" and "merge" todo list
>> > instructions to allow the user to control the topology.
>> 
>> Yes, I'm familiar with all this, but that's not what I mean. I don't
>> want to maintain the topology here, and I'm also not suggesting that git
>> itself generates such "pick" entries with -mX arguments (maybe I wasn't
>> clear on that). What I want to do is to add such entries myself, as a
>> user, resulting in the equivalent of doing a "break" at that point in
>> the rebase and doing a "git cherry-pick -mX <hash-of-merge-commit>"
>> manually.
>
> It would be neat indeed if this could be specified in the instruction
> sheet. We already support options for the "merge" instruction, so
> extending "pick" to support options isn't that far-fetched. Then it
> would become possible to say "pick -m1 fa1afe1".

Would adding "x git cherry-pick -m 1 $that_one" work there?
