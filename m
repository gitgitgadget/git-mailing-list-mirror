Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00D56B65
	for <git@vger.kernel.org>; Sat, 11 May 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444263; cv=none; b=Q8+D0XbstCaQ7cVxRUyRd1xxjo/XKV9ht8/8nTVz4vh/ovf8U61dMiuQIR3aZAUMFj1Amb6v0SbR7c2FBDUUUsTlhHFYiQvrnMbgg1EKGg/tIWrgH9I1VtRsGfV6sV+kIO5VbA2nRKu2dJMka5ePSdgzmUg8WicTtttS6UquDc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444263; c=relaxed/simple;
	bh=4sOcPhbfNF0IHDDsrpUzUxvnjLVPAIYo+GXNGqzSxcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MdgM/Ze6dojzas/734FyMmE9hc8nal2MqXlJO+YbDNy+xBrF3Y3TMJMNaGyDu/vv+GkaaC8GqDzqRl87jlsnF6keU1AhlGhL9/NS2uu58FVAXjTjVT08/yMZXXvtGUMKQeBEPECAWna6O19EZ07uEu1lXM8ZNG/dLGdYo2LqwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bAGrM9gJ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bAGrM9gJ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 85BCC305DC;
	Sat, 11 May 2024 12:17:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4sOcPhbfNF0IHDDsrpUzUxvnjLVPAIYo+GXNGq
	zSxcs=; b=bAGrM9gJ3M0HFVzIRhRKR5j+wCi++GauYMRsZ3JBuioggHBo1PWdpc
	BTMS6oKF3ofHGz4s5w7d5iK7i3SXuuzIXckFWC9RmypbR6EvEVcCQUJweJmTyPVv
	WmnbS+/lg5jfJUPyXBKawWuOcE49vElb+v425+EE2nDu9gtnt9axw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EC44305DB;
	Sat, 11 May 2024 12:17:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9026305DA;
	Sat, 11 May 2024 12:17:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Gerald Pfeifer <gerald@pfeifer.com>
Cc: git@vger.kernel.org
Subject: Re: git shortlog --committer=name is documented, alas not implemented
In-Reply-To: <77e42d15-fcaf-5c1b-3a00-f1f1e3cedfc4@pfeifer.com> (Gerald
	Pfeifer's message of "Sat, 11 May 2024 14:34:12 +0200 (CEST)")
References: <77e42d15-fcaf-5c1b-3a00-f1f1e3cedfc4@pfeifer.com>
Date: Sat, 11 May 2024 09:17:38 -0700
Message-ID: <xmqqfruo1fx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FCFAC342-0FB1-11EF-A34B-25B3960A682E-77302942!pb-smtp2.pobox.com

Gerald Pfeifer <gerald@pfeifer.com> writes:

> `man git shortlog` (from git 2.45.0) has the following:
>
>    --author=<pattern>, --committer=<pattern>
>        Limit the commits output to ones with author/committer header lines 
>        that match the specified pattern (regular expression). With more 
>        than one --author=<pattern>, commits whose author matches any of 
>        the given patterns are chosen (similarly for multiple 
>        --committer=<pattern>).
>
> Now `git shortlog --author=gerald` works as expected.
>
> However `git shortlog --committer=gerald` results in an error:
>
>   error: option `committer' takes no value
>
> This is either a doc bug or an implementation issue?

It is a UI and documentation issue.

For those who do not want to understand the underlying issue, a
workaround is to use the "shortlog" in the fitler mode, and use a
separate "log" as the commit selector, e.g.

    $ git log --pretty=fuller --committer=gerald |
      git shortlog [--committer] [-s] ...

The upstream of this pipeline finds only commits by gerald and shows
them with both Author: and Committer: header lines.  The downstream
of this pipeline reads the "log" stream, and does the usual "shortlog"
thing as a filter.

The "--committer" option of the "shortlog" command does not take a
value; it is a boolean that tells the command "I know you usually
group commits by authors, but in this invocation I want you to group
them by committers".  So if you have multiple "--committer=<who>"
things on the upstream "git log" side, you can sift these commits by
committer on the downstream "git shortlog".

Now for those who want to understand the underlying issue, the
"shortlog" command works in two modes.  One is the filtering mode we
just saw.  The other, which is more commonly used these days, is to
invoke the "git log" command that it reads from in the "filtering"
mode internally.  Which means that "shortlog" command now needs to
understand options and arguments for "git log" family of commands,
like

 - limiting the commits to a revision range, e.g.,
   "v2.44.0..v2.45.0",

 - finding patterns in the commit object, e.g., "--grep=<pattern>"
   and "--author gerald",

 - limiting the commits that touch specified paths, e.g.,
   "Documentation/"

as well as its own options, like "-s" "-n" "--committer", that
affects how it summarizes the "log" stream.

So, now you see where one of the two problems you observed, i.e. the
manual page talks about --author=<who> and --committer=<who>
limiting, comes from.  It is because the documentation of the
"shortlog" command tries to borrow from parts of the documentation
of the "log" command.

And the other one you observed is now easy to understand. As the
"shortlog" needs "--committer" as a boolean "are we grouping with
the committer?", it thinks that you told it to do that but by
mistake you added the option an unwanted value when you said
"--committer=gerald".

An 80%-OK-fix may be to teach the command option parser of shortlog
that "--committer" (which it currently thinks is a strict boolean)
is now an option that takes an optiona value, and when it is given
with a value, ignore it and pass it down to the underlying "git log".
Unlike the real "git log" where you can say "git log --committer gerald",
with such a fix, you can only say "git shortlog --committer=gerald" (i.e.,
you are forced to use the "--option=value" form and "--option value" form
is not allowed), but that may probably be OK.

With such a 80%-OK-fix, the documentation bug will disappear, which
would be a big plus ;-)

