Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3989385521
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067031; cv=none; b=R+SbRlRyGBeH/CeCatRkLV/BzYV6DsSIc9AqJ+Ku06aNhN6mC0xdNpYo2cxJAzw+XfjVOEvmvaT2A8cQe6Ca7O/iuen+Ri+0HRMRmmtY7L6eNVm06HWTVXDZi+MX+eb6vVzwv9ejDyfUS3rTwiAXd5a9GCTrkc49t8BE4AWfiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067031; c=relaxed/simple;
	bh=040RfhxetU8uSIoDJgJV6SyQWrzXenOqSKOmY2+Jc4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3rT5cVN/xzIOzzuyN3hQ1bwq45hwB73OwvRC1jEHcTh+ibhN6PEhkPDgtVoI7wSFIjsFoZSYOjvGwXlMY9OXXx6CFNBiEcug43rjPsMNVLrwAVY5s6E+PtC/jTuyJrYJOTvIxptjMr9uJeoP0hC3MSAiAvtSFnfMo8LlCEyTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g9DBXAb5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g9DBXAb5"
Received: (qmail 32634 invoked by uid 106); 10 Sep 2026 19:03:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=040RfhxetU8uSIoDJgJV6SyQWrzXenOqSKOmY2+Jc4A=; b=g9DBXAb5VIWLKR2yFPqhk5OyrDis0Xs+E0kJH5oA3F6eB0AYMSPm4RnQD5oabTnGxy4rhve1B8KgDa9ZpD43IeDIB3xCke8j+PSGDt2PcfEUlunwcNutZlALVW+QkyBbyXWBV/EFlXmUhvHjy2meHkMPa1O5vVZ7VDnpSozwqQlZYKW3wMHhhh9A83TmHGQCZZw1Kj1sRGOW+zKhTkVcJqsFdItjJ8kQqTDaXu62KjkWZqYn0X0zH3mjDcFMZ7XqwM8csb+XR3Z849UFiopYXQgdV71BHrJzpAYrQA1742W1rYBQI0MQ7WcTjRX122riV6bsCXXX3XsS2qJj5TyAmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 19:03:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 160332 invoked by uid 111); 10 Sep 2026 19:03:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 15:03:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 15:03:45 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, git@vger.kernel.org,
	ben.knoble@gmail.org, gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Message-ID: <20260910190345.GA903701@coredump.intra.peff.net>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
 <20260910085353.109373-3-ub4nal@mail.ru>
 <xmqqzexpf78k.fsf@gitster.g>
 <20260910155247.GA251185@coredump.intra.peff.net>
 <xmqqpkyldke1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpkyldke1.fsf@gitster.g>

On Thu, Sep 10, 2026 at 11:35:50AM -0700, Junio C Hamano wrote:

> The primary reason why I didn't think of "--worktree" is because
> output of "git config --help" has room for improvements.  This is a
> tangent, but one of its SYNOPSIS item reads like this:
> 
> 	git config set [<file-option>] [--type=<type>] [--all] \
> 		[--value=<pattern>] [--fixed-value] <name> <value>

If it makes you feel any better, I did not even know --worktree existed
until today. ;) I only discovered it when looking at the possible values
returned by config_scope_name().

I still have trouble imagining why a particular piece of advice would
make sense only in --worktree mode. The only concrete case I've seen for
any advice scoping is that clone/init advice config does not make sense
in repo config. And --global is the sensible solution to that (--system
works, too, but it is not a very helpful recommendation).

I kind of wonder if _all_ advice should just say "--global". I cannot
think of an advice flag that is really repo specific. They are about
silencing extra help because the _user_ understands the situation and
wants Git to be less chatty.

> --- >8 ---
> Subject: [PATCH] doc: clarify <file-option> in "git config --help"
> 
> The SYNOPSIS section of "git config --help" refers to <file-option>
> without explaining what they really mean.
> 
> I *think* they meant to refer to the mechanism to limit the file(s)
> read from or written to by giving the scope options or the '--file
> <filename>' option.  Spell it out early in the description.

I agree that we should use the term <file-option> to refer to it. I
think the paragraphs just below what you touched try to explain these,
but don't use the term.

Something like the patch below uses the term. There's also a lot of
duplication between the reading/writing paragraphs that could be
condensed (but I didn't do it here).

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 8d080e301b..18cee89f84 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -40,16 +40,14 @@ outgoing values are canonicalize-able under the given <type>.  If no
 unset an existing `--type` specifier with `--no-type`.
 
 When reading, the values are read from the system, global and
-repository local configuration files by default, and options
-`--system`, `--global`, `--local`, `--worktree` and
-`--file <filename>` can be used to tell the command to read from only
+repository local configuration files by default. Provide a
+`<file-option>` (`--system`, `--global`, `--local`, `--worktree`,
+or `--file <filename>`) to tell the command to read from only
 that location (see <<FILES>>).
 
 When writing, the new value is written to the repository local
-configuration file by default, and options `--system`, `--global`,
-`--worktree`, `--file <filename>` can be used to tell the command to
-write to that location (you can say `--local` but that is the
-default).
+configuration file by default. A `<file-options>` can be used to tell
+the command to write to that location.
 
 This command will fail with non-zero status upon error.  Some exit
 codes are:


I also considered that the options themselves should be grouped as
sub-entries of a <file-options>:: entry, but I think that may create
other awkwardness.

There is also --blob, which affects the source/dest of config, but isn't
really a "file" option. It is really more of a "location" option (and
that is what it is called in the macro grouping within the code, though
that is never exposed to the user).

>  * The SYNOPSIS section also refers to <display-option> for many
>    operations; I have no idea what it means.  I left a needswork
>    comment there.  We should either clarify it in a similar way, or
>    remove it if it does not refer to anything.

It comes from 14970509c6 (builtin/config: introduce "list" subcommand,
2024-05-06), and there's similar macro magic. It really just means
"stuff that changes the list output".

I think the manpage could probably be rewritten to focus on the
different command modes, and have a section for "here are the useful
options in list mode". Whereas historically, "--list" was just another
option. That would be a much bigger rewrite of the page, though.

-Peff
