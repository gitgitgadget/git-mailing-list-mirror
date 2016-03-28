From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Mon, 28 Mar 2016 09:56:36 -0700
Message-ID: <xmqqh9fqzgl7.fsf@gitster.mtv.corp.google.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
	<xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
	<xmqqmvpm18sw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbbVN4kQyQoTk+3o5yPZPAdGULtOhKisOLUf9-u7ssh7A@mail.gmail.com>
	<xmqqegay175q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 18:56:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akaT7-0002Ue-BX
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 18:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbcC1Q4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 12:56:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753893AbcC1Q4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 12:56:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CC374F461;
	Mon, 28 Mar 2016 12:56:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jkDy4YDW/Osx/w+f3lNxdKinf4Y=; b=ZnNiOB
	saw2jrotnp6PN883bPazpsXhfTygSiihKB78AbzRx5eNVXdjBN4hlCXvAy3KaeC1
	xJUbTzhIl2KkXP6Jo9at5Nb8ELJeKh3ctmVRlWAkI+fO1RxyAjmiEHcMGJD20VtI
	kdAO9QzFESW+Wf0FDZOr7Kt2Ver1weRJrcPrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XawC8vDd1KMAPkebdIeUHpmGN3/rjsBu
	bX7WEtwo0jGYzMsnUIXLxpe2HtBqXDP5lL6YlGVLoIDZGY6HuGiYw92HfxCIurw9
	LoC+uIYyZv3Xnj0czBBkQaMERKcw8Ka+E0hSVOj62Ead7ZC5itYcAlgd7o7RKZrr
	f7H5fuP3YNk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13D234F460;
	Mon, 28 Mar 2016 12:56:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E0524F45E;
	Mon, 28 Mar 2016 12:56:38 -0400 (EDT)
In-Reply-To: <xmqqegay175q.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Mar 2016 16:15:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 09948202-F506-11E5-95F8-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290048>

Junio C Hamano <gitster@pobox.com> writes:

> I am talking about a case where
>
>       cd repo
>       cd untracked
> 	git submodule <cmd> --recurse-submodules --read-from=file
>
> wants to run <cmd>, using information stored in repo/untracked/file,
> and work on submodules repo/sub and repo/sub/subsub.  The reference
> to the original location somehow needs to be carried through if we
> wanted to allow this kind of thing.

Let us step back a bit and try a simplified scenario to help us
think "prefix" through from the first principle.

Imagine there is a project P like this:

	/leading/path/Q/P/.git/
	/leading/path/Q/P/one/file
	/leading/path/Q/P/one/msg

and we do

	cd /leading/path/Q/P/one
	edit file
        git commit -F msg file

This example illustrates that there are two quite different uses of
"prefix".  It is used to serve as a name of the path that is used in
the history of the project (i.e. "file" is prefixed with "one/" to
form "one/file" that is the full path recorded in the history).  It
also is used to name an entity on the filesystem that does not have
anything to do with any path recorded in the history (i.e. the
message is read from "one/msg", even though the argument given to
"-F" is "msg").

This distinction may be hard to realize until we start doing some
unusual thing.  Suppose there is a directory Q/R just next to P and
we did this:

	cd /leading/path/Q/R
	cp ../P/one/file ../P/one/msg .
        edit file msg
	GIT_WORK_TREE=/leading/path/Q/P
        GIT_DIR=$GIT_WORK_TREE/.git
	export GIT_WORK_TREE GIT_DIR
        git commit -F msg file

What should happen (we are trying to think things through from the
first principle, so this is not asking about the implemented
behaviour)?

As this "file" refers to /leading/path/Q/R/file that is outside of
the working tree of the project, the reference to it by "git commit"
does not make any sense.  The reference to "msg", however, does make
sense--there is no reason why the contents of the message read by
"-F" option have to be inside the working tree.  So it probably is
sensible to fail this command.  It is the same story if you replace
"file" with ".", i.e. "git commit -F msg .".  The reference to
"current directory" the latter makes to name set of paths to be
recorded in the history, made outside the working tree, makes the
command a nonsense.

	Side note: I suspect that the current implementation of
	"commit" actually does wrong things to these two uses of the
	prefix in that (1) it would not find "msg" and (2) it would
	happily use an empty string as the "prefix" without failing.
	The former is something we may want to fix, but I suspect
	this is not a low-hanging fruit.  The latter is taking the
	only sensible fallback position and I do not feel a strong
	need to change it to error out.

Without "file" parameter, however, it may make sense to allow making
the commit.  After all, the command is not talking about any paths
at the point, and telling us to work on the entire working tree.

Up to this point, the scenario is simplified by not having any
submodule.  Now, imagine the case where Q is the top-level superproject
of P, i.e.

	/leading/path/Q/.git/
	/leading/path/Q/P/.git/
	/leading/path/Q/P/one/file
	/leading/path/Q/P/one/msg
	/leading/path/Q/R/file
	/leading/path/Q/R/msg

When "submodule <cmd> --recurse-submodules" does the work of <cmd>
in a submodule, as far as the submodule repository that gets
recursed into (i.e. P) is concerned, the situation is exactly like
the above example: a command that is meant to work on project P is
launched from ../R that is outside its working tree.

So a parameter like "--read-from=file" in the original example may
make sense, while taking any pathspec to be applied inside the
visited submodules does not, and instead we should declare that the
work of <cmd> for each visited submodule is to be done on the entire
working tree of the submodule.

In other words, the correct value of "prefix" for its two different
uses are different.  The "prefix" for the paths recorded in the
history (i.e. those that correspond to "file" in the above example)
has to be an empty string to denote that the work of <cmd> applies
to the entire tree, while the "prefix" for the filesystem entities
that does not have anything to do with the paths in the recorded
history (i.e. those that correspond to "msg" in the above example)
would be pointing outside the working tree (e.g. "../R").

Now, "git submodule" uses $wt_prefix to grab the return value of
"git rev-parse --show-prefix" upfront, and it _is_ possible to use
the variable to refer to the "file" in the original location in "git
submodule <cmd> --recurse-submodules --read-from=file" if we wanted
to, if its mechanism is taught to correctly maintain the variable
relative to the root of the working tree of submodules as it visits
them.

But even if we did so, we shouldn't be using that same variable for
the other use of "prefix", i.e. "which subdirectory in the working
tree of the submodule being visited is the one that is being worked
on and paths should be understood relative to".  That "prefix" has
to be empty string, and for this reason, your patch 1&2 is the right
thing to do within the context of the current code.  As we'd need
two correct values for "prefix" for two different needs, if we ever
want to allow an option like "--read-from=file", we'd need to add a
new variable different from $wt_prefix that is not cleared to an
empty string but instead is maintained to serve as "the original
location".

Two pieces of concluding remarks:

 - I am OK if we decide to postpone introducing a new variable to
   hold the value of "prefix" suitable for the other use, so that we
   do not close the door to submodule enhancements that need an
   option like "--read-from=file" in the example.

 - I suspect that the fix in your 1&2 may be demonstratable without
   forcing an early failure by switching to "git -C".  If the
   command gets a wrong prefix, its pathspec limitation would become
   incorrect, so the work of "<cmd> --recurse-submodules" that is
   done on P when run from /leading/path/Q/R/ directory with "R/" as
   a wrong prefix, would try to limit its operation to subdirectory
   "R/" in project P (which does not exist) and would miss things in
   directory "one/", even though we would want the entire tree of P/
   to be affected.
