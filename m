From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Thu, 22 Jul 2010 19:08:37 -0700
Message-ID: <7vwrsneyqi.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <201007200951.56218.trast@student.ethz.ch>
 <7v39venom7.fsf@alter.siamese.dyndns.org>
 <201007221106.39623.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 23 04:09:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc7h4-0000Nm-MW
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 04:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540Ab0GWCIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 22:08:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab0GWCIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 22:08:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C1FC6C9E;
	Thu, 22 Jul 2010 22:08:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0X5eoEIzpt/3ukjnYmOxx/fe/Dk=; b=Keq5t6
	W11UT/c+uqPk5uUuQvRy6tT9Z+tVyQXVIQlNxKLPCp7UaBr6cj7Si8zYvIL8AmTh
	suA5KTRKmt0KtBV4Byzi1TYzIWWS2LWFYzK3tdAorWIP74RPbDmnpVdxiynwRtek
	0B/7cB5mPZlXnET2KYD42Y/1bTIiRzOFaPVE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nascwg2mIIa3LW65wDhYdE/E1at7ZYf5
	HVTt1HaupQiST1Mv26S9gU1lEz0Tb3XY1+vOTYbWwfkKy0lFfv/ufbw3C9H/wKvA
	fLsSMiqVqz4yKZv3EWFkCEKSZ2VwwNFR1o92QeXLXlf0menruatgpwUJZ0TPm16h
	h+QM0hQVC4U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CA958C6C9B;
	Thu, 22 Jul 2010 22:08:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F734C6C99; Thu, 22 Jul
 2010 22:08:38 -0400 (EDT)
In-Reply-To: <201007221106.39623.trast@student.ethz.ch> (Thomas Rast's
 message of "Thu\, 22 Jul 2010 11\:06\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37B23B3C-95FF-11DF-9D5F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151499>

Thomas Rast <trast@student.ethz.ch> writes:

>> I would consider it similar to "blame --incremental"; you can choose a
>> very different output format driven by a single switch to change the mode
>> of operation.
>
> For me (and Bo seemed to agree off-list) the main interest is in the
> *history*.  Yes, it is an important feature that the diffs are also
> limited to the ranges you are scanning, but that is the secondary
> feature.
>
> [If you think that is unfair, consider:...

We are not saying very different things, I think.

I guess I shouldn't have mentined "blame --incremental"; I was referring
to a quick-hack experiment we did to show an early output when we pass
blame to parent.  You can imagine that inside pass_blame_to_parent() we
can detect if the lines around the range we are passing the blame to
parent were touched, we could show pretty-printed commit log and relevant
diff-tree output at that point, which would give you pretty much the same
history we are talking about.

> If pathspec limiting wasn't broken in the sense that it does not
> support --follow (properly, anyway), they would be exactly equivalent...

Well, --follow is from "content-id" camp, while pathspec is a revision
limiter that follows quite different philosophy, so they do not mix very
well.  "log --follow -- $path" is an unfortunate cross between these two
philosophies and spelled that way only because that was the easiest way to
cheat in the command line parser.

As you alluded to, "log --follow HEAD -- $path" would mean exactly the
same as "log -L<range>,HEAD:$path HEAD" in the mock syntax I gave you
earlier in the thread, but that does not change the fact that it is
conceptually very different from the normal "git log".

>> E.g. if you have a history of this shape where commit C is at the tip:
>> 
>>     ---o---A---x---B---o---C
>> 
>> you _could_ ask "log -p -L1,10,B:Makefile A..C" (I am not proposing this
>> syntax at all, by the way) to browse the history between A and C, looking
>> for commits that touch the region of Makefile that appeared as lines 1..10
>> in revision B.  Between B and C, some new lines might have been introduced
>> inside the range and you would dig in reverse enlarging the range to show
>> what have been added to it.
>
> [I think this would be entirely possible to do for the line-log case,

I am sure it is "entirely possible", even though it might be quite
expensive (both development wise and also the end result).

A funny thing is, I do not think it is so "hard to explain and rarely
used" case.  Imagine that you have this history:

                 y---z---D maint
                /
    ---o---A---x---B---o---C master

Wouldn't it be nice if you can ask this question?

    I have these lines in frotz.c at 'master' version, and I recently made
    fixes that I need to backport to 'maint'.  How does the corresponding
    region look like in 'maint', and what changes that may be necessary
    for and interfere with my backport are there since these two branches
    forked?

In the ugly mock syntax, you would write it like this:

    log -p -L<range>,master:frotz.c master...maint

In this example, you have two positive revisions (notice three-dots for
symmetric difference), but you can easily imagine that this will work well
when you have more than two branches you are interested in.

To produce a useful output, you would need to dig from C down to x while
listing the commit that touch the specified range and adjusting it, then
dig the other way from x through y, z and D, again mapping the corresponding
range.

I am not saying that what -L does is a bad thing, though.  All I am saying
is that it is conceptually very different, and trying to coax it into
existing command line parsing rules of "git log" might not work well.

You could use a few rules to allow something like this which might be more
friendly to the eyes that are used to looking at the input to
setup_revisions() parser:

    log -p -L<range1> <path1> -L<range2> <revs>...

The short-hand rules may look something like this:

    - -L<range> with missing <path> is the same as -L<range>,<path> for
       the last <path> we have seen used with -L (it would be cleaner to
       use a single string given to -L i.e. "-L<range>,<path>" instead of
       a rule "-L takes one or two parameters" that is totally odd-ball
       from the point of view of normal POSIX command line rules, though);

    - If there is no <path> anywhere in the first use of -L, we take the
      first pathspec element as if it were <path>.

    - -L<range>,<path> is the same as -L<range>,<rev>:<path> where <rev>
       is the first positive revision given on the command line.

No matter what syntax sugarcoating is done, conceptually when -L says
"these lines in this path", it has to talk about the range in one
revision.  -L<range>,<rev>:<path> instructs us: "you are to follow this
block of lines in that path in this particular revision---figure out how
that migrated while you traverse the history and show its evolution".
There is no room for the normal pathspec rules to take effect---as we are
operating in the "content-id" domain, we would ideally want to
automatically even do --find-copies-harder, just like --follow and blame
automatically runs rename detection (that is another reason I think the
traversal semantics is very different from the regular "log", in addition
to the need to traverse forward in addition to backward which I already
mentioned).  We may want to error out when we have any <pathspec> (after
taking the second short-hand rule above into account, that is).

In short, I don't really have a very deep preference between "log -L" and
"blame -L".

But as a very special case of allowing only one single positive rev and no
forward-walking of the history, what "log -L" gives us is much closer to
"blame -L".  That is where my suggestion came from.  If we were to
eventually have that "log -p -L<range>,master:frotz.c master...maint", not
the syntax but the capability, I am all for it to be part of the "log"
command.
