From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash deletes/drops changes of
Date: Thu, 23 May 2013 16:20:27 -0700
Message-ID: <7v4ndtcmh0.fsf@alter.siamese.dyndns.org>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
	<loom.20130523T185301-635@post.gmane.org>
	<87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
	<7vd2shcnx7.fsf@alter.siamese.dyndns.org>
	<87obc15mq5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Greenleaf <james.a.greenleaf@gmail.com>, <git@vger.kernel.org>,
	"Petr Baudis" <pasky@ucw.cz>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 24 01:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeoH-0003dW-JW
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 01:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759904Ab3EWXUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 19:20:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759895Ab3EWXUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 19:20:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F056E21242;
	Thu, 23 May 2013 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BkSs22zuwBP6wVwA+V2882Xcvjw=; b=xVtk/s
	GBoa7q/Oho0pEPix4BlmaTAJgeg2Bz/Uoqw+p78aEdlFilMhX2T2ygkKPxqRwWox
	qhLdiQLO+Z6CVPomUj/dK9gFBmm6IBDlP9ux0z+9wC3mACBBvIp8va7VtlEqmtXZ
	nku2Wt3ueRB0vLCWA5kbCuAcjlDs65yEJBMq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kWNHyfZNL3uvoT8F2sMoETaCFIutmV/b
	jhsjs6agIt0hvO5YU+fRr9r9Z+oYU8tbB6dYA3DbMfSl2ofTmFbuIPUVHtc0xuAK
	NjLLcaMNU5VjyvjZAedsgksnd4NXy2czo4VJj1ud1la0zq+wGXy3qpt865nxRzKy
	ASBer9XgwbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E791A21241;
	Thu, 23 May 2013 23:20:29 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53C4F21240;
	Thu, 23 May 2013 23:20:29 +0000 (UTC)
In-Reply-To: <87obc15mq5.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 24 May 2013 00:56:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B7CA012-C3FF-11E2-8D05-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225317>

Thomas Rast <trast@inf.ethz.ch> writes:

>> What are the workflows that are helped if we had such a bit?  If
>> we need to support them, I think you need a real --ignore-changes
>> bit, not an abuse of --assume-unchanged.
>
> I gather -- from #git -- that it's mostly used for config files, which
> have an annoying habit of being different from the repository.
>
> Which is wrong, really.  But we still claim that --assume-unchanged is a
> solution to it in git-update-index(1).

That is doubly wrong, then ;-)

How would we want to proceed from here?  The obvious first step
would be to fix the documentation, but then what is next?

Thinking aloud, ignoring that "Which is wrong, really" part in your
message and assuming that we do want to support --ignore-changes....

Can the way we handle "--ignore-changes" files be a strict superset
(or is it subset?) of what we currently do for "--assume-unchanged"?
That is, if we "fix"^Wchange the behaviour of "--assume-unchanged"
to be less aggressive in assuming that the user kept his promise,
can we get "--ignore-changes" without losing much of the performance
benefit of "--assume-unchanged" the people who originally wanted to
have that feature have enjoyed for all these years?

If you are working on a project with a large working tree, by
marking paths in one directory you do not care about (and do not
use) with the --assume-unchanged bit, checking out another branch
can be done without inspecting if there are uncommitted changes in
the part of the working tree that may be clobbered with the
different version of the file in the other branch.  That has to go
for "--ignore-changes", for example.  Are there others that need to
suffer?

If so, these two have to be done as totally independent options, but
if -ignore-changes can be just a slightly less agressive
-assume-unchanged, we could "fix" "--assume-unchanged", introduce
"--ignore-changes" as a synonym and be done with it.  I highly doubt
that is doable.

The only sensible way forward, it seems to me, is introduce a proper
"--ignore-changes" that is independent from "--assume-unchanged".
What does "--ignore-changes" really mean?

The end user does not want to see changes to a config file when he
runs "git status" and "git diff".  I think "git commit -a" would
ignore the local changes to the configuration file as a natural
consequence if we teach "git status" to ignore paths marked with the
"--ignore-changes" bit.  But the same "git diff" (between the index
and the working tree) logic is internally used to decide if a path
has local changes when running "git checkout" to check out another
branch, "git rebase" to see if there are local changes, etc. and the
user do want to view the paths as modified.

I am not so sure if there is a clear semantics other than
an unactionable blanket statement "ignore local changes".
