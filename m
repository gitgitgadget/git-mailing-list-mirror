From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document conventions on static initialization and else
 cuddling
Date: Wed, 19 Sep 2012 13:43:46 -0700
Message-ID: <7vk3vpg2v1.fsf@alter.siamese.dyndns.org>
References: <7v627pzsr7.fsf@alter.siamese.dyndns.org>
 <1348081202-17361-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TER7n-0001Qf-EA
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2ISUnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:43:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52705 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab2ISUnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:43:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD058EE8;
	Wed, 19 Sep 2012 16:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ix3fOGWkDHnziOWj+c3OpY+6grs=; b=pkNbLy
	r0WQvjlWdh3u7onOJGYBWV+rngDa8wPiYEezi4cNpOAkvekHJxABpivAaaBVEiBd
	3AVD6qFxIE2tsxxJMXa0Nw3c47z/w9lASrpXlqsAPiJ+wQMWkr4ZtK8vTfW7AEcV
	ShVrEwIUG4GG4+5hT3pBYC7OI/EgBRyN1T4HM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsuFTVjI+GvGocQC0a2xZYrLgngDYSI6
	jUWQE2AZCBhSbQh0zs1tz2Cq7zYV0vr9JleqWvCrRiBrNhK4tvZYQ9ThkzXiW7eo
	78N5LA7pGLYQQs58H+dfpq8JGs0JapSUsWdmwmjtilB4NSeggsgeE4fWdVIKuqup
	ZCRheP9Xfk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 682168EE7;
	Wed, 19 Sep 2012 16:43:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 745388EE6; Wed, 19 Sep 2012
 16:43:47 -0400 (EDT)
In-Reply-To: <1348081202-17361-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Wed, 19 Sep 2012 20:00:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5EB26F8-029A-11E2-BBD2-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205998>

Adam Spiers <git@adamspiers.org> writes:

> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>
> I have begun work on fixing existing code to adhere to these
> guidelines on braces, but there are currently a lot of violations,
> which means any patches to fix them would be large.  So before I spend
> any more time on it, I would like to check whether such patches would
> be welcomed? And if so, should I be doing that on the master branch?

In general, no.

The cost/benefit ratio of carrying such a change is very high.

The guidelines are not a set of hard rules that any and all code in
violation have to be fixed right away.  I am reluctant to pile more
detailed "rules" in the existing list in the document to give it an
incorrect impression that they are hard rules that all lines should
abide by, which inevitably leads to people who end up wasting time
on creating "style fixes" patches whose only practical effect is to
collide with other topics in flight.

Especially if such a "style fix" is done as a single patch, it will
block all the other topics that happen to touch the overlapping
regions for reasons more important than "style fix".

To mitigate the risk of such unnecessary collisions, while improving
the health of the codebase, we tend to do two things:

 - review new code and make sure it does not introduce guideline
   violations.  Two sets of new code that touch overlapping area by
   definition have to collide and their conflicts resolved anyway,
   so this does not add any additional cost to the project.

 - before updating existing code, clean up the area and small
   surrounding area it touches as a preparation step of the patch
   series.  As long as "surrounding area" is kept sufficiently small
   (the preparation step may have to refrain from touching the whole
   file, depending on what other topics are still in flight), this
   again does not add any additional cost to the project.

There is a third-option that we tend try to avoid but occasionally
do take:

 - update a dormant code that nobody has touched for a long time and
   no discussion on the list (with or without patch) is likely to
   result in a new topic that might want to touch it.

By the way, I have a handful of my favorite styles that are not
listed in the document, and when I write new code myself I try to
stick to them, but I do not raise a red (or any color) flag when
seeing "violating" code in a new patch [*1*].

> I have also added some simple rules such as `check-brace-before-else'
> to the top-level Makefile which perform appropriate `grep -n' commands
> to detect violations and for example easily fix them via emacs' M-x
> grep.  These rules can be invoked together via a `check-style' target.
> Would this also be welcomed?  If so, should the checks all be
> introduced in a single commit, or each check along with the code which
> was fixed with its help?

I am not enthused, personally.

> BTW I briefly tried to find an existing tool out there which could
> already do the checking for us, but only found ones like uncrustify
> which rewrite code rather than warning on inconsistencies.  I also saw
> that the kernel's scripts/checkpatch.pl only worked with patches and
> was also extremely kernel-specific in the nature of its checks.

The checkpatch.pl script works with patches for a very good
reason. It is a tool to look for "new" problems patches
introduce.

I often run "checkpatch.pl --no-tree" on incoming patches, by the
way.

>  Documentation/CodingGuidelines | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 57da6aa..1a2851d 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -117,17 +117,49 @@ For C programs:
>     "char * string".  This makes it easier to understand code
>     like "char *string, c;".
>  
> + - We avoid unnecessary explicit initialization of BSS-allocated vars
> +   (static and globals) to zero or NULL:
> +
> +	static int n;
> +	static char **ch;
> +
> +   rather than:
> +
> +	static int n = 0;
> +	static char **ch = NULL;

As I said, I am in general not in favor of piling more rules here,
but we've seen this one in new contribution often enough that it is
a good addition.

> +
> +   These are superfluous according to ISO/IEC 9899:1999 (a.k.a. C99);
> +   see item 10 in section 6.7.8 ("Initialization") of WG14 N1256 for
> +   the exact text:
> +
> +     http://open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf

But I do not think this explanation is necessary.  "This is one of
our house rules" is a sufficient reason people, who want to blindly
obey guidelines, need to see.

>   - We avoid using braces unnecessarily.  I.e.
>  
>  	if (bla) {
>  		x = 1;
>  	}
>  
> -   is frowned upon.  A gray area is when the statement extends
> -   over a few lines, and/or you have a lengthy comment atop of
> -   it.  Also, like in the Linux kernel, if there is a long list
> -   of "else if" statements, it can make sense to add braces to
> -   single line blocks.
> +   is frowned upon.  A gray area is when the statement extends
> +   over a few lines, and/or you have a lengthy comment atop of
> +   it.  Also, like in the Linux kernel, it can make sense to add
> +   braces to single line blocks if there are already braces in
> +   another branch of the same conditional, and/or there is long
> +   list of "else if" statements.

Reflowing text without reason is frowned upon as it makes the
review unnecessary harder by hiding where things have changed.

You are suggesting to

        /* Turn this into ... */        /* ... this instead */
        if (condition)                  if (condition) {
                true;                           true;
        else {                          } else {
                otherwise;                      otherwise;
                ...                             ...
        }                               }

I do not think such an update is wrong per-se, but among different
shades of gray, the left is probably one of the most minor kind of
violations.



[Footnote]

*1* An example of them is "when 'if (...) ... else ...' chooses
between two equally plausible conditions, write it in such a way
that the body of the else clause runs longer".  That is because
it is far easier to get confused about the condition when looking at
what the body in the "else" clause is doing after a long body in the
"if" clause:

        /* BAD */                       /* GOOD */
        if (condition) {                if (!condition) {
            ....                                ....
            ....                                ....
            ....                        } else {
            ....                                ....
            ....                                ....
            ....                                ....
            ....                                ....
        } else {                                ....
            ....                                ....
            ....                                ....
        }                               }

But that can safely be done only when "condition" and "!condition"
are both equally natural expressions.
