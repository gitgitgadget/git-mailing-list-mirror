From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 17 May 2013 18:24:22 -0700
Message-ID: <7vfvxlw055.fsf@alter.siamese.dyndns.org>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
	<1368793403-4642-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 03:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdVst-0003SD-BI
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 03:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab3ERBY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 21:24:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752337Ab3ERBY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 21:24:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4F914BA1;
	Sat, 18 May 2013 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7WVt0VMnHxl1060vHJCNKAMmKEA=; b=pdw/C6
	EqAy3dLd+VwE8vbb/qi8/xXivmhImmF0RdbIJM3pkO/7Y2iL0DleNLheamdIIxRl
	stAILJALxiL611lOM32rDl8AgdzR6XmcymC7NzhqnWyucMoC1s3bFUCwLK22S5Ri
	PEZOXlDrbdSO9pfxGlRXSz0w//ZsfWBAUIi/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wQqiBvF/lbO+zph/PAWw/9S86mBgFKOx
	ThjGdHHILT1S42UiTD32godJEsgRDzqD6+9rKgW4zaC57Cw+xm4ZL87O+ze47Un1
	ZNZ/LLvhTve1OtEjshXW4i0mwnAZRRG1W2R8Z3q/hBIfDLBCd+le00ZA0SRM9FdJ
	th7gTG/xclc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3166D14B9E;
	Sat, 18 May 2013 01:24:25 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FA1014B9A;
	Sat, 18 May 2013 01:24:24 +0000 (UTC)
In-Reply-To: <1368793403-4642-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 17 May 2013 17:53:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC90E4EA-BF59-11E2-B3F0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224748>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 104579d..b61a666 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -383,14 +383,35 @@ ifndef::git-format-patch[]
>  	that matches other criteria, nothing is selected.
>  
>  -S<string>::
> -	Look for differences that introduce or remove an instance of
> -	<string>. Note that this is different than the string simply
> -	appearing in diff output; see the 'pickaxe' entry in
> -	linkgit:gitdiffcore[7] for more details.
> +	Look for commits that change the number of occurrences of the

The first part of the change is misguided.  First of all, this text
also appears in the documentation of "git diff" and -S limits the
output to those filepairs that match its criteria.

"git log A..B -- foo" looks for commits that has changes in paths
that matches 'foo'.  "git log" that selects commits is affected by
the outcome of what "diff" shows.  This "looks for *commits*" is a
characteristic of "log", not specific to the -S option.

The aspect of "diff" behaviour that is affected by -S is what is
considered as difference.  Usually "diff" says "preimage and
postimage are different" for any change, but -S changes that.  The
preimage and postimage has to have different number of specified
block of text to be considered different.

And that is why the original says "look for differences".

> +	specified string (i.e. addition/ deletion) in a file.
> +	Intended for the scripter's use.
> ++
> +It is especially useful when you're looking for an exact block of code
> +(like a struct), and want to know the history of that block since it
> +first came into being.

I am not sure this half-way description is a good idea.  If you want
to use it to discover what happend "since it first came into being",
you need to use this (and the feature is designed for such a use
pattern) iteratively, find the first commit that changes the block
of the text that appear in the latest version, find the corresponding
block of interest in the preimage and then feed that to -S and start
digging from that first-discovered commit.  If the text describes
that iteration fully, I think that is fine, but if you read the
above literally, it looks as if you feed one version of -S and it
would do the necessary adjustment on its own, which is misleading.

>  -G<regex>::
> -	Look for differences whose added or removed line matches
> -	the given <regex>.
> +	Grep through the patch text of commits for added/removed lines
> +	that match <regex>.  `--pickaxe-regex` is implied in this
> +	mode.

The same comment on differences vs commits apply to this.

If there were any behaviour change --pickaxe-regex introduces to -S
that also applies to -G "other than the pattern is used as a regular
expression", I would agree it is a good idea to say that other
behaviour is implied, but as far as I know, there is no such
implication.  Drop --pickaxe-regex, as it is not even implied in the
code:

	} else if ((argcount = short_opt('G', av, &optarg))) {
		options->pickaxe = optarg;
		options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
		return argcount;
	}

so even if there were some code added in the future that does

	if (options->pickaxe_opts & DIFF_PICKAXE_REGEX) {
		do this thing only when the user said
                --pickaxe-regex from the command line
	}

it will _not_ apply to users of -G.

"grep through", if the reader knows "grep", with "match <regex>", it
is crystal clear that this expects a regular expression.  And that
is the only thing that makes -G and --pickaxe-regex superficially
related.

> ++
> +To illustrate the difference between `-S<regex> --pickaxe-regex` and
> +`-G<regex>`, consider a commit with the following diff in the same
> +file:
> ++
> +----
> ++    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
> +...
> +-    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
> +----
> ++
> +While `git log -G"regexec\(regexp"` will show this commit, `git log
> +-S"regexec\(regexp" --pickaxe-regex` will not (because the number of
> +occurrences of that string didn't change).
> ++
> +See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
> +information.

This is a readable example (I think we tend not to use contraction,
so if I were writing it, I wouldn't have written "didn't change",
though).

>  --pickaxe-regex::
> -	Make the <string> not a plain string but an extended POSIX
> -	regex to match.
> +	Treat the <string> not as a plain string, but an extended
> +	POSIX regex to match.  It is implied when `-G` is used.

Ditto.  Rather, 

	Treat the <string> given to the -S option as an extended
	POSIX regular expression to match.

> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index 568d757..d0f2b91 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -222,25 +222,34 @@ version prefixed with '+'.
>  diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
>  ---------------------------------------------------------------------
>  
> -This transformation is used to find filepairs that represent
> -changes that touch a specified string, and is controlled by the
> --S option and the `--pickaxe-all` option to the 'git diff-*'
> -commands.
> -
> -When diffcore-pickaxe is in use, it checks if there are
> -filepairs whose "result" side and whose "origin" side have
> -different number of specified string.  Such a filepair represents
> -"the string appeared in this changeset".  It also checks for the
> -opposite case that loses the specified string.
> -
> -When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves
> -only such filepairs that touch the specified string in its
> -output.  When `--pickaxe-all` is used, diffcore-pickaxe leaves all
> -filepairs intact if there is such a filepair, or makes the
> -output empty otherwise.  The latter behaviour is designed to
> -make reviewing of the changes in the context of the whole
> -changeset easier.

This part is impossible to review on a bus, so I won't comment in
this message.

Why did you even have to touch the paragraph for --pickaxe-all?
That applies to both -S and -G.  I thought it would be just the
matter of slightly tweaking the introductory paragraph (which was
written back when there was only -S), keeping the second paragraph
for -S as-is, and insert an additional paragraph for -G before
--pickaxe-all.

> +There are two kinds of pickaxe: the S kind (corresponding to 'git log
> +-S') and the G kind (mnemonic: grep; corresponding to 'git log -G').
> +
> +The S kind detects filepairs whose "result" side and "origin" side
> +have different number of occurrences of specified string.  By
> +definition, it will not detect in-file moves.  Also, when a commit
> +moves a file wholesale without affecting the string being looked at,
> +rename detection kicks in as usual, and 'git log -S' omits the commit
> +(since the number of occurrences of that string didn't change in that
> +rename-detected filepair).  The implementation essentially runs a
> +count, and is significantly cheaper than the G kind.
> +
> +The G kind detects filepairs whose patch text has an added or a
> +deleted line that matches the given regexp.  This means that it can
> +detect in-file (or what rename-detection considers the same file)
> +moves.  The implementation of 'git log -G' runs diff twice and greps,
> +and this can be quite expensive.
> +
> +When `--pickaxe-regex` is used with `-S`, treat the <string> not as a
> +plain string, but an extended POSIX regex to match.  It is implied
> +when `-G` is used.
> +
> +When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves only
> +the filepairs that touch the specified string in its output.  When in
> +effect, diffcore-pickaxe leaves all filepairs intact if there is such
> +a filepair, or makes the output empty otherwise.  The latter behavior
> +is designed to make reviewing of the changes in the context of the
> +whole changeset easier.
>  
>  diffcore-order: For Sorting the Output Based on Filenames
>  ---------------------------------------------------------
