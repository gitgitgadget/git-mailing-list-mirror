From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect.txt: example for bisecting with hotfix
Date: Mon, 14 Mar 2011 10:35:14 -0700
Message-ID: <7vy64hehbh.fsf@alter.siamese.dyndns.org>
References: <20110314131623.119020@gmx.net>
 <cf85600a90cea6a0a751c674b821d17d85f34c66.1300109828.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Beulich <JBeulich@novell.com>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzBgP-0001ND-LP
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 18:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab1CNRft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 13:35:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab1CNRfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 13:35:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA46431AD;
	Mon, 14 Mar 2011 13:37:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F8pJA3E27b1X6eIh+tLRabQ2z8o=; b=szHxWz
	vy1zrj8MAvK+wTp3fKi1HCQlljVpvGDpEoHse2g5o3oHut0j0CXMDNQfaoKfS6Jh
	1K4nQUZ+NLzczkgmAXAdR4wdIqwA3Pfckf8IT9z4kEW6CRfBU07Rxhk0HKC/gZcu
	SPWJdwcDRlL8kKn6ydQtqudgI/AxVD5gCMxMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejs3KIE4uUHUqK+Z5PBYuuYAfDKu1FQO
	ZyGKcdBOEWPwl2i1WBIFZqYYiT51/QzM+gqBvGWlaU/rocDcfSZmm8LNUdFbnaJQ
	l4RAz6Mlvjg578C8nrnqh9THnlV4B0Ckb8risEWUsmvuSH0tJ/zy5rBm4r5FNfz8
	Utk0N6shCkQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4656D3197;
	Mon, 14 Mar 2011 13:37:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F8F93187; Mon, 14 Mar 2011
 13:36:47 -0400 (EDT)
In-Reply-To: <cf85600a90cea6a0a751c674b821d17d85f34c66.1300109828.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon, 14 Mar 2011 14:47:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC60F87C-4E61-11E0-B5B9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169001>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> +* Bisect with compatibility hotfix:
> ++
> +------------
> +$ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
> +$ git bisect run sh -c "git cherry-pick -n hotfix || exit 125; make || exit 125; ~/check_test_case.sh"
> +------------
> ++
> +Does the same as the previous example, but applies an additional patch
> +before building. This is useful when your build or test environment changed so
> +that older revisions may need a fix which newer ones have already.
> +

It is a good idea to add an example that shows it is perfectly Ok to muck
with the working tree before testing, but I don't see this patch as such.

First of all, doesn't bisect_checkout does its job with "checkout -q"
without "-f"?  How would that interact with running cherry-pick _every
time_ you check commit to be tested out?  In some situations it may work
OK by accident, but as an example that is likely to be cut&pasted I think
we should show a reasonably safer way than this.

There likely are more than one hot-fixes; it would make more sense to
illustrate merging a hot-fixes branch using "git merge --no-commit" than
using cherry-pick.

But the above are minor; the biggest issue I have with this patch is that
it breaks the train of thought for people who are reading from top to
bottom.

Look at what is there currently. It starts simple (single command run via
"run" interface), and demonstrates that anything complex can be easily
managed with a fully-spelled-out "one test wrapper that builds and then
runs test" example, to show the most generic way you can use. It then
introduces special exit codes in the script, as that form is easier to
read than a single command line.

It then shows, as a final aside, that it isn't strictly required to use a
wrapper script and you could use "sh -c" to wrap that in the command line,
which may be easier to use when (and only when IMO---if you will have
anything that needs debugging then you are better off with the first
approach) the command line you use for testing is trivial.

I think a new example you are adding would fit much better in the flow if
you replaced the example it refers to as "the previous example".  There
are that "previous example" that uses the "check_test_case.sh", and the
one before that one that uses "make test"; they are duplicates that do not
add much value and we would add value by dropping one of them.  It
probably is better to remove the "make test" one and keep the
"check_test_case.sh" one, as long as you explain "check_test_case.sh"
sufficiently well, because the latter is more generally applicable.

The new example would fit well as an illustration of what you _could_ have
in test.sh script when you need to do more elaborate set-up before testing
each revision, e.g., you tweak the working tree with hotfix before running
"make || exit 125", and clean that up after you tested. The core of the
new section would look like this:

	$ cat test.sh
	#!/bin/sh

	# tweak the working tree by merging the hot-fix branch
        # and then attempt a build
	if	git cherry-pick --no-commit hot-fix &&
        	make
	then
                # run project specific test and report its status
                ./test.sh
                status=$?
	else
		# tell the caller this is untestable
		status=125
	fi

	# undo the tweak to allow clean flipping to the next commit
        git reset --hard

	# return control
	exit $status
