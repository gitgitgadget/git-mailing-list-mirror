From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: allow author-specific timezones
Date: Mon, 15 Oct 2012 10:40:50 -0700
Message-ID: <7vpq4jws4d.fsf@alter.siamese.dyndns.org>
References: <1350261054-5171-1-git-send-email-crorvick@cogcap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <crorvick@cogcap.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNof3-0000uD-GF
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 19:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab2JORky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 13:40:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab2JORkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 13:40:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCEF38231;
	Mon, 15 Oct 2012 13:40:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ph9HnhuAXFMweyarLKOQIp+dbU=; b=DZRrZ9
	IN7h+3pbMknHSgyVAZGH2+ZYe+T61Z8giyZpIpVERVwbezxYLkgiSE0y2RgEBcC1
	rw7DVvzy5wWP/KKu7VQ8VBMhO6GqCpqnGFGrBp79CpaOABWI+WSIyx+rE07JM4pd
	Y59eW3MiNs/ICkvFUl7Gdd6DLKK8ESwq4KB7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F9T5DpMLo1bYqEnEYI9hFKy0PHyi7ViT
	DQnVMkzAscUe5TAycB9bczbVQ8By6HcJXGwo3xXOM7RCbSd9nRk6zkuaV4s+1IJW
	63fMoiTAt0dtKGdYU6Hlk8wNXjy/eu9WvA8JKiEgzZ77kpSo6ftt8ZAiV9wJN9Hm
	PqJX5z7WRas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA7128230;
	Mon, 15 Oct 2012 13:40:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5A2C822E; Mon, 15 Oct 2012
 13:40:51 -0400 (EDT)
In-Reply-To: <1350261054-5171-1-git-send-email-crorvick@cogcap.com> (Chris
 Rorvick's message of "Sun, 14 Oct 2012 19:30:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76B0C68C-16EF-11E2-8B7A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207764>

Chris Rorvick <crorvick@cogcap.com> writes:

> From: Chris Rorvick <chris@rorvick.com>
>
> CVS patchsets are imported with timestamps having an offset of +0000
> (UTC).  The cvs-authors file is already used to translate the CVS
> username to full name and email in the corresponding commit.  Extend
> this file to support an optional timezone for calculating a user-
> specific timestamp offset.
>
> Signed-off-by: Chris Rorvick <chris@rorvick.com>
> ---
>
> This supercedes the patches submitted for using the local timezone in
> commits.
>
>  Documentation/git-cvsimport.txt    |   5 +-
>  git-cvsimport.perl                 |  22 ++-
>  t/t9604-cvsimport-timestamps.sh    |  92 +++++++++++++
>  t/t9604/cvsroot/.gitattributes     |   1 +
>  t/t9604/cvsroot/CVSROOT/.gitignore |   2 +
>  t/t9604/cvsroot/module/a,v         | 265 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 381 insertions(+), 6 deletions(-)
>  create mode 100775 t/t9604-cvsimport-timestamps.sh

OK, a new test script has its executable bit set (correct).

>  create mode 100664 t/t9604/cvsroot/.gitattributes
>  create mode 100664 t/t9604/cvsroot/CVSROOT/.gitignore
>  create mode 100664 t/t9604/cvsroot/module/a,v
>
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index 6695ab3..35dc636 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -141,13 +141,14 @@ This option can be used several times to provide several detection regexes.
>  +
>  ---------
>  	exon=Andreas Ericsson <ae@op5.se>
> -	spawn=Simon Pawn <spawn@frog-pond.org>
> +	spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
>  
>  ---------
>  +
>  'git cvsimport' will make it appear as those authors had
>  their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
> -all along.
> +all along.  If a timezone is specified, GIT_AUTHOR_DATE will
> +have the corresponding offset applied.

The description above the context reads:

    -A <author-conv-file>::
            CVS by default uses the Unix username when writing its
            commit logs. Using this option and an author-conv-file
            in this format

which probably need to be updated to describe what "this format" is
a bit better.

	... an author-conv-file that maps the name recorded in CVS
	to author name, author e-mail and an optional timezone for
	the author

or something.

>  For convenience, this data is saved to `$GIT_DIR/cvs-authors`
>  each time the '-A' option is provided and read from that same

> @@ -844,7 +854,9 @@ sub commit {
>  		}
>  	}
>  
> -	my $commit_date = strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date));
> +	$ENV{'TZ'}=$author_tz;
> +	my $commit_date = strftime("%s %z", localtime($date));

With this, because it updates $commit_date, the specified timezone
applies to both AUTHOR and COMMITTER dates (which is correct---I am
just pointing it out).

> diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
> new file mode 100644

Huh?  What happened to the executable bit we saw earlier?

> index 0000000..fb7459c
> --- /dev/null
> +++ b/t/t9604-cvsimport-timestamps.sh
> @@ -0,0 +1,92 @@
> +#!/bin/sh
> +
> +test_description='git cvsimport timestamps'
> +. ./lib-cvs.sh
> +
> +setup_cvs_test_repository t9604
> +
> +test_expect_success 'check timestamps are UTC (TZ=America/Chicago)' '
> +
> +    TZ=America/Chicago git cvsimport -p"-x" -C module-1 module &&
> +    git cvsimport -p"-x" -C module-1 module &&
> +    (cd module-1 &&
> +        git log --pretty="format:%s %ai" -- >../actual-1 &&
> +        echo "" >>../actual-1
> +    ) &&
> +    echo "Rev 16 2011-11-06 07:00:01 +0000
> +Rev 15 2011-11-06 06:59:59 +0000
> +Rev 14 2011-03-13 08:00:01 +0000
> +Rev 13 2011-03-13 07:59:59 +0000
> +Rev 12 2010-12-01 00:00:00 +0000
> +Rev 11 2010-11-01 00:00:00 +0000
> +Rev 10 2010-10-01 00:00:00 +0000
> +Rev  9 2010-09-01 00:00:00 +0000
> +Rev  8 2010-08-01 00:00:00 +0000
> +Rev  7 2010-07-01 00:00:00 +0000
> +Rev  6 2010-06-01 00:00:00 +0000
> +Rev  5 2010-05-01 00:00:00 +0000
> +Rev  4 2010-04-01 00:00:00 +0000
> +Rev  3 2010-03-01 00:00:00 +0000
> +Rev  2 2010-02-01 00:00:00 +0000
> +Rev  1 2010-01-01 00:00:00 +0000" >expect-1 &&
> +    test_cmp actual-1 expect-1
> +'

A handful of issues.

    - (style) Please use one tab for one level of indent;
    - (style) Learn to use <<-\HERE document to make list easier to
      read; 
    - You shouldn't have to choose --pretty=format which places LF
      in between records and add another LF yourself.  Instead, you
      can use --pretty=tformat that uses LF as record terminator, or
      its short-hand form --format="...";
    - I am not sure what you are gaining out of the trailing "--".

See below for a suggested way to lay this out better.

> +test_expect_success 'check timestamps are UTC (TZ=Australia/Sydney)' '
> +
> +    TZ=America/Chicago git cvsimport -p"-x" -C module-2 module &&

This look identical to the first one, but even with a trivial change
to use Australia/Sydney instead of Chicago, I am not sure what the
test buys us.

> +test_expect_success 'check timestamps with author-specific timezones' '
> +
> +    echo "user1=User One <user1@domain.org>
> +user2=User Two <user2@domain.org> America/Chicago
> +user3=User Three <user3@domain.org> Australia/Sydney
> +user4=User Four <user4@domain.org> Asia/Shanghai" >cvs-authors &&
> +    git cvsimport -p"-x" -A cvs-authors -C module-3 module &&
> +    (cd module-3 &&
> +        git log --pretty="format:%s %ai" -- >../actual-3 &&
> +        echo "" >>../actual-3
> +    ) &&
> +    echo "Rev 16 2011-11-06 01:00:01 -0600
> +Rev 15 2011-11-06 01:59:59 -0500
> +Rev 14 2011-03-13 03:00:01 -0500
> +Rev 13 2011-03-13 01:59:59 -0600
> +...
> +Rev  2 2010-01-31 18:00:00 -0600
> +Rev  1 2010-01-01 00:00:00 +0000" >expect-3 &&
> +    test_cmp actual-3 expect-3
> +'

In addition to the same comments as above, this one would benefit
having %an in its output to illustrate that the code is handling
locations with daylight saving time correctly.  It would make it
stand out that Rev 16 is done during the standard time while Rev 15
is done during the DST.  It would look more like this (with the
style fix):

test_expect_success 'check timestamps with author-specific timezones' '
	cat >cvs-authors <<-EOF &&
	user1=User One <user1@domain.org>
	user2=User Two <user2@domain.org> America/Chicago
	user3=User Three <user3@domain.org> Australia/Sydney
	user4=User Four <user4@domain.org> Asia/Shanghai
	EOF
	git cvsimport -p"-x" -A cvs-authors -C module-3 module &&
	(
		cd module-3 &&
		git log --format="%s %ai %an"
	) >actual-3 &&
	cat >expect-3 <<-\EOF
	Rev 16 2011-11-06 01:00:01 -0600 User Two
	Rev 15 2011-11-06 01:59:59 -0500 User Two
	Rev 14 2011-03-13 03:00:01 -0500 User Two
	...
	Rev  2 2010-01-31 18:00:00 -0600 User Two
	Rev  1 2010-01-01 00:00:00 +0000 User One
	EOF
	test_cmp actual-3 expect-3
'
