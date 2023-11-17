Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="thjh5+eZ"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AD2C2
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 08:26:44 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B4A41D7C8F;
	Fri, 17 Nov 2023 11:26:42 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=Zy2Zrxy8SzWps9qu/Wxz5JgmEOLE8HlcFyNqJm7
	RrUQ=; b=thjh5+eZCA1G7l66n8aECV1dKiyLn7Y8lCFai2AwxZDpcLvp34axB++
	j4xjBMCYjJrMcyCqXft1Owt227YRJ89rubO1RWwwxPUIsq+s4QT8vYRro4Dp66Wk
	57j0wBvkQxUS2gi9vTYq6sYcjqObln+NvTfIV5ak7iJIqovyfewk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 42EE21D7C8E;
	Fri, 17 Nov 2023 11:26:42 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7BA11D7C8C;
	Fri, 17 Nov 2023 11:26:41 -0500 (EST)
	(envelope-from tmz@pobox.com)
Date: Fri, 17 Nov 2023 11:26:40 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Matt Burke <spraints@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Subject: Re: Migration of git-scm.com to a static web site: ready for
 review/testing
Message-ID: <ZVeUQEG5jIzKbvmT@pobox.com>
References: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7d20b4-a725-0ef9-f6d3-ff2810da9e7a@gmx.de>
X-Pobox-Relay-ID:
 1732B44E-8566-11EE-BAFC-25B3960A682E-09356542!pb-smtp2.pobox.com

Hello,

Johannes Schindelin wrote:
> At this point, the patches are fairly robust and I am mainly hoping for
> help with verifying that the static site works as intended, that existing
> links will continue to work with the new site (essentially, find obscure
> references to the existing website, then insert `git.github.io/` in the
> URL and verify that it works as intended).
> 
> To that end, I deployed this branch to GitHub Pages so that anyone
> interested (hopefully many!) can have a look at
> https://git.github.io/git-scm.com/ and compare to the existing
> https://git-scm.com/.

This is nice.  Thanks to all for working on it!

For checking links, a tool like linkcheker[1] is very handy.
This is run against the local docs in the Fedora package
builds to catch broken links.

I ran it against the test site and it turned up _a lot_ of
broken links.  It's enough that saving and sharing the
output is probably more work than having someone familiar
with the migration give it a run directly.

I ran `linkchecker https://git.github.io/git-scm.com/` and
the eventual result was:

  That's it. 13459 links in 14126 URLs checked. 0 warnings found. 6763 errors found.
  Stopped checking at 2023-11-17 11:11:17-004 (1 hour, 19 minutes)

The default output reports failures in a format like this:

  URL        `ch00/ch10-git-internals'
  Name       `Git Internals'
  Parent URL https://git.github.io/git-scm.com/book/tr/v2/Ek-b%C3%B6l%C3%BCm-C:-Git-Commands-Plumbing-Commands/, line 106, col 1318
  Real URL   https://git.github.io/git-scm.com/book/tr/v2/Ek-b%C3%B6l%C3%BCm-C:-Git-Commands-Plumbing-Commands/ch00/ch10-git-internals
  Check time 3.303 seconds
  Size       1KB
  Result     Error: 404 Not Found

LinkChecker can be run in a mode which directs the failures
to a file.  That would be more like:

  linkchecker -F text/utf_8//tmp/git-scm-check.txt https://git.github.io/git-scm.com/

The format of the -F option is TYPE[/ENCODING][/FILENAME]
where TYPE can be text, html, sql, csv, gml, dot, xml,
sitemap, none or failures.  The failures type is much more
terse:

  1 "('https://git.github.io/git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Plumbing-Commands/', 'https://git.github.io/git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Plumbing-Commands/ch00/ch10-git-internals')"

I found the text type much more helpful in quickly spot
checking some of the failures since it includes the text
string used for the link.

Running it against a local directory of the content would be
a lot faster, if that's an option.  It's also worth bumping
the default number of threads from 10 to increase the speed
a bit.

[1] https://linkchecker.github.io/linkchecker/

-- 
Todd
