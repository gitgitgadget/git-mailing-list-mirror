From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: assume HEAD if no revision supplied
Date: Wed, 30 Jan 2008 13:03:49 -0800
Message-ID: <7vk5lrgh56.fsf@gitster.siamese.dyndns.org>
References: <47A0D0F0.1020800@nrlssc.navy.mil>
	<alpine.LSU.1.00.0801302034310.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 30 22:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKK6k-0003hf-MU
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 22:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbYA3VD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 16:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbYA3VD6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 16:03:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbYA3VD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 16:03:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B57B9201C;
	Wed, 30 Jan 2008 16:03:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F016E2017;
	Wed, 30 Jan 2008 16:03:51 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801302034310.23907@racer.site> (Johannes
	Schindelin's message of "Wed, 30 Jan 2008 20:35:00 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72069>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 30 Jan 2008, Brandon Casey wrote:
>
>> filter-branch previously took the first non-option argument as the name 
>> for a new branch. Since dfd05e38, it now takes a revision or a revision 
>> range and modifies the current branch. Update to operate on HEAD by 
>> default to conform with standard git interface practice.
>
> FWIW I think the code wanted to let "git filter-branch" without options 
> print the usage.

That might be a valid safety concern to some folks.  Previously
we have seen people say "Whenever I see a command foo that I do
not know what it does, I type 'foo <Enter>' and expect it gives
the usage back.  So any new destructive command 'foo' should not
do a damage by using built-in default." (I think it was about
"git stash" without parameter).

By the way, I do not personally think it is worth to be heavily
supportive to the practice of trying an unknown command without
understanding, and I do not agree such a safety is necessarily a
good idea, especially if it makes normal use of the command more
cumbersome by people who understand what it does.

Even though "git stash" itself is not destrictive, you need to
know its "apply" subcommand to undo the action.  In that sense,
it is destructive to clueless people who blindly type whatever
command they see.

That's why we still allow you to say "git stash", but we removed
its "git stash <randam message>" syntax, which was risky when
subcommand name was misspelled even by people who know what the
command does.  I think we struck a good balance between
usability and safety there.  And I think we can do the same
here.

Perhaps "git filter-branch <Enter>" can be prevented as in the
current implementation while "git filter-branch --foo-filter
foo" can default to HEAD to satisfy both needs.  The command
without any filter is supposed to be mostly no-op (unless you
are trying to rewrite the history with grafts).
