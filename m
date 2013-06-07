From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or upstream
Date: Fri, 07 Jun 2013 08:47:59 -0700
Message-ID: <7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
References: <20130607124146.GF28668@sociomantic.com>
	<CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Leandro Lucarella <leandro.lucarella@sociomantic.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:48:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukyte-0000WA-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3FGPsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:48:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab3FGPsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:48:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8126726D46;
	Fri,  7 Jun 2013 15:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QMUhRQ9uCO99o9+78vuOd645bKE=; b=jEagDc
	0l9Wv22QcdNr7vTV/QTipIfYkAGsAOVRqxyd8OOb+0pZKT5HxD7TTKXMsIeQ0SmM
	XrX/rpcdxUdS4zpxSXe8I9O5Z47Trh7B446hxyRKCGhYFjpX15TLFN0iwh0TY9ZS
	qeLDYEgQ07kHCjvn0vYbQ/N24z3/n6Iza1L7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rAmXZL5w2FWqZyXxliTsrGfQW2G9LdN5
	A/La8S4xeJPvgvhCKYh1uaAe8N7fIs94pcpIh3yfEkrDmoFJe+pgcnITgHHkbDNC
	QOtByrNaG/eUZIIsjGjsj38Ek3R6rcx9fI4LtJpc6iQMFYexzrEBf5MeSmD2+x0o
	P3Vw0aEGzoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 753E226D45;
	Fri,  7 Jun 2013 15:48:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8B1326D3A;
	Fri,  7 Jun 2013 15:48:00 +0000 (UTC)
In-Reply-To: <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 19:41:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A228B8B2-CF89-11E2-A309-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226641>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> [+CC: jc, jk]
>
> Leandro Lucarella wrote:
>> I changed branch.master.remote to upstream and set
>> branch.master.pushremote to origin, but when I do I git push I get an
>> error:
>>
>> $ git push --dry-run --verbose
>> fatal: You are pushing to remote 'origin', which is not the upstream of
>> your current branch 'master', without telling me what to push
>> to update which remote branch.
>
> Yes, this is a defect: both remote.pushdefault and
> branch.<name>.pushremote suffer from it.

The upstream and simple modes have been defined to push to
"upstream" repository in central-shared-repository workflow.

At this point in Leandro's example, I think the configuration is:

	[branch "master"]
		remote = upstream
                merge = refs/heads/master
                pushremote = origin

and master@{u} == upstream's master, not origin's.

This shows the "triangular" support in 1.8.3 is only half-finished;
the other half was discussed a few weeks ago ($gmane/224604), but I
do not recall what the current status of the topic is.  I personally
think 'single' the root level of the thread hints is an overkill
mechanism, so here is a suggestion to show one possible way forward.

Until the branch.$name.push mechanism is introduced to specify which
destination branch is updated by the push, and/or branch.$name.push
is not specified after such a mechanism is introduced, I think the
natural extension of the current end-user configuration would be to
redefine "upstream" mode to push to update the branch with the same
name (in the above example, 'master' of 'origin' is updated), when
the "repository that is pushed to, which is different from the
repository that is fetched from" is specified via remote.pushdefault
or branch.$name.pushremote mechanisms.

This incidentally covers "simple" mode, because "pushing to update
the branch with the same name" is the only behaviour accepted by the
mode anyway.

When branch.$name.push mechanism is introduced and the user uses it,
then "upstream", "simple", or any other setting for that matter
would be ignored.  With

	[branch "master"]
		remote = upstream
                merge = refs/heads/master
                pushremote = origin
		push = refs/heads/master

it is clear that "git push" while on 'master' should push to origin
to update its master branch.
