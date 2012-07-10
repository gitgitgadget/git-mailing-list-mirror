From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 16:13:15 -0700
Message-ID: <7vehojgqgk.fsf@alter.siamese.dyndns.org>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
 <1341939181-8962-2-git-send-email-cmn@elego.de>
 <20120710191354.GE8439@burratino> <7v1ukjiehe.fsf@alter.siamese.dyndns.org>
 <20120710201105.GH8439@burratino> <7vsjczgx3h.fsf@alter.siamese.dyndns.org>
 <20120710210901.GI8439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 01:13:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SojcU-0001e2-B0
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 01:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab2GJXNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 19:13:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab2GJXNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 19:13:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 059939895;
	Tue, 10 Jul 2012 19:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eQuLF672594b42seXlOjJ3ZeFfA=; b=bXmjlY
	iCfbWCtHwrjlJrFwnBkvXh3RCSvQ8WJ6l6kYx4NWgbfIHn69eldj/nRTYRDnrVdu
	NGHQbza3U/JBZxXD4pX59rmG/GjdOOB9Z/3aGBzhp+pNy4Jq1l+B8O3aM0qyTQ1c
	MdWlbZFnIN3/FxjD4azam2e8+hs8YI/jC7uDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cMPysy0qCdLQElQqE6lVhwaUHvcJJtyi
	4uHl4V8ALynYZDZLGKvWA52do0DorrzLo6OZgweIQRFlY2lvoSpHLLnEROInfrVy
	Mbz7ZlBrMn0yuDIJhwA+W74dLaBqfLW6iK75Cxrsh+1fMEfKGzkPypvG709YBJnI
	HFKg5AwrGi4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F032B9894;
	Tue, 10 Jul 2012 19:13:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59CE19892; Tue, 10 Jul 2012
 19:13:17 -0400 (EDT)
In-Reply-To: <20120710210901.GI8439@burratino> (Jonathan Nieder's message of
 "Tue, 10 Jul 2012 16:09:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5103606-CAE4-11E1-9D53-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201285>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [someone should have]
> | suggested an alternative syntax that avoids the mistake you quoted
> | above, perhaps something like:
> |
> | 	git branch --set-upstream-to=origin/master [HEAD]
>
> with which I disagree.

You can think of it this way.

"git branch" can not only _create_ a new branch (or list existing
ones, but that is another entirely different mode), but also can be
used to set attributes to an existing branch.  Imagine a new option,
say --set-description, to replace branch.frotz.description, for
example.  It would be used like this:

	$ git branch --set-description='add frotz feature' frotz

to set the description for the 'frotz' branch (i.e. the above would
set branch.frotz.description), and we default to HEAD if 'frotz' is
missing from the command line.  "git branch --option [<branch>]" is
about manipulating the branch, and we default the target of
manipulation to HEAD.

"upstream" is just another kind of attribute for the branch being
manipulated, whose value happens to be a branch name.

The mistake was that --set-upstream was coded by piggybacking the
existing --track implementation where a new branch was created, and
in that codepath, "git branch <name1> [<name2>]" creates <name1>
while defaulting a missing <name2> to HEAD.

Creating a new branch that is forked from the current HEAD is an
often useful thing to do, so defaulting a missing <name2> (aka
"start-point") to HEAD is very sensible, but reconfiguring a named
branch <name1> to integrate with the current branch is much less
useful than the other way around.  One major reason why it is so is
because you would more likely set any branch to integrate with a
remote tracking branch (rather than a local branch) and by
definition your HEAD cannot be a remote tracking branch.

It makes it worse that you would often want to reconfigure the
current branch; for the purpose of reconfiguring a branch <name1> to
integrate with something else <name2>, it is much more likely that
you want a missing <name1> to default to HEAD, not the other way
around to default a missing <name2> to HEAD, which is useful for
branch creation.

But switching which missing argument gets default based on what
options are used is insane.

If the very original "create this new branch starting at that point"
were spelled like this

	$ git branch [--start-point=<name2>] <name1>

and a missing <name2> defaulted to HEAD, it probably would have been
better. It would have made it very unlikely to tempt anybody to hack
the --set-upstream option into the system with the wrong parameter
order if such a command line convention was in place.

If anything, it could be a sensible longer-term direction to a more
intuitive UI to deprecate the two-name format and make the creation
to be specified with an explicit --start-point option with an
argument (which defaults to HEAD), but I think that falls into the
"if I were reinventing git without existing userbase in 2005"
category and it is too late for that.
