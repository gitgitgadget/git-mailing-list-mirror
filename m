Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F9B20179
	for <e@80x24.org>; Thu, 16 Jun 2016 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbcFPV5y (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 17:57:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752655AbcFPV5y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 17:57:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 077D9255E4;
	Thu, 16 Jun 2016 17:57:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PI6Y3NuGUGzC8i/TmxtYktFEeKY=; b=chb/4R
	exvEiOYpPsTC22tc2qybKehJ21LtzjyKKMvdc+XewoH0W9Loy1EUSNLyQP2qA4En
	6/n57ugfGm4di/sFotmEZ3kj5l3G1TF/8IrNvqWdeLRRR9/Jpthru3NkycuiC/1c
	Pi0+HPXTAJ2FwlhQscGGdKsIdqHiVTL/9g4Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u+1O7JklsY8zv238C22RvmMR7F4+3nvm
	GqH0hbREca52g1edTGKU3MDFgumpVj4vjx6QWy5XLNZTR5OSUkhpuc/0Sa94JN21
	Oq4vWPNOAPSyJihjPUhQAtJO0t9s1wPN26wCiML9P11PYxbzt0b0g4VWvxXS/+hS
	KCNhxddkQwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F289F255E3;
	Thu, 16 Jun 2016 17:57:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70A5F255E2;
	Thu, 16 Jun 2016 17:57:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <joeyh@joeyh.name>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-3-joeyh@joeyh.name>
Date:	Thu, 16 Jun 2016 14:57:50 -0700
In-Reply-To: <20160616203259.5886-3-joeyh@joeyh.name> (Joey Hess's message of
	"Thu, 16 Jun 2016 16:32:57 -0400")
Message-ID: <xmqqy4643ig1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F9D0B06-340D-11E6-81CB-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Joey Hess <joeyh@joeyh.name> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e1b2e4..bbb9296 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1299,14 +1299,29 @@ format.useAutoBase::
>  	format-patch by default.
>  
>  filter.<driver>.clean::
> -	The command which is used to convert the content of a worktree
> -	file to a blob upon checkin.  See linkgit:gitattributes[5] for
> -	details.
> +	The command which is used on checkin to convert the content of
> +	a worktree file (provided on stdin) to a blob (written to stdout).
> +	See linkgit:gitattributes[5] for details.
>  
>  filter.<driver>.smudge::
> -	The command which is used to convert the content of a blob
> -	object to a worktree file upon checkout.  See
> -	linkgit:gitattributes[5] for details.
> +	The command which is used on checkout to convert the content of a
> +	blob object (provided on stdin) to a worktree file (written to
> +	stdout).
> +	See linkgit:gitattributes[5] for details.

A "filter" by definition reads from its standard input and writes
the result to its standard output, so I do not know if this change
is necessary.  If you are going to do this, in documentation
(i.e. not code), please spell standard input/output out, and avoid
stdin/stdout.

There is what we would want to fix, though.  "worktree file" should
be spelled "working tree file".  This used not to matter before "git
worktree" was invented (before that we used these two terms
interchangeably), but these days the distinction matters.

> +filter.<driver>.clean-from-file::

Documentation/config.txt hopefully lists all the configuration, but
I do not see anything that uses 'words-joined-with-dash' format.
Please do not invent new out-of-convention names.

> +	Optional command which is used on checkin to convert the content
> +	of a worktree file, which can be read from disk, to a blob
> +	(written to stdout).

I am not sure why we want to say "which can be read from disk".

I think what a reader needs to be told (but this paragraph is not
telling her) in order to understand what you meant to say is:

	cleanFromFile is asked to produce the "cleaned" content to
	its standard output (to be stored in the object database),
	but unlike clean, it does not work as a filter and is not
	given a file descriptor to read the working tree contents
	from.  Instead, it is told the path for which the contents
	need to be generated as the first parameter on its command
	line.

(the above is deliberately made verbose and is not meant as a
suggestion to be literally used in your updated documentation).

With that understanding, the reader may be able to guess that "can
be read from disk" is a permission for her cleanFromFile filter
(i.e. it does not necessarily have to read from it and produced its
output by some other magic); otherwise it can be misread as if the
content of a working tree file is deposited on the disk to enable
the filter to read it, but the location of that on-disk file is
somewhere unspecified by this paragraph.

> +	Only used when filter.<driver>.clean is also configured.
> +	See linkgit:gitattributes[5] for details.
> +
> +filter.<driver>.smudge-to-file::
> +	Optional command which is used to convert the content of a blob
> +	object (provided on stdin) to a worktree file, writing directly
> +	to the file.

A similar comment applies.  With ", writing directly to the file."
replaced with something like ". The command is expected to write to
the working tree file at path given as the first parameter on the
command line." it would be sufficient (i.e. it is clear enough that
it does not give the smudged contents via its standard output, and
no need to say "unlike smudge filter, ..." like we needed to for the
"clean" side).

