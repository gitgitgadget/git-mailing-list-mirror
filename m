From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Wed, 01 May 2013 16:07:33 -0700
Message-ID: <7vzjwe2tai.fsf@alter.siamese.dyndns.org>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
	<1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
	<7vppxa5z01.fsf@alter.siamese.dyndns.org> <5181967E.9020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 01:07:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXg7g-0004Ks-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 01:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147Ab3EAXHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 19:07:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757553Ab3EAXHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 19:07:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A14B51B1B7;
	Wed,  1 May 2013 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+DYr6StZs4f7vZK3bqAeG1ZJtbM=; b=v+YJ7p
	KsU5Mk+OC1TgorF+g5iTXJMCV/CwPtknr4v95+ctJiOi1njM54LENd985BZqbH0G
	KCy7hTUkS7onkyZOwYGP5WBrOumOGpQ9lF0XUFYmAlXleVchaW8xfVfpvmKW4LPj
	mHWXOHR6+00nZzR3HbvYXA4RrYHaNerwzimGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzj39v1H3wuTVh+Jq1K0e3xoDXgQ/3Zq
	PlBK1fSGIEMy5Y12WkzJOlfHQRNuiFxyXcVFxqDgAvG1eD5BwiPzujzbFSX+DHyl
	tS/3OO9/JIYwmZpoxOOjCqtU+X4hZpgUweZ2h3iTQkp/em/tLXPAhxqZOu9G1ECN
	MBJe72mFR5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98EC61B1B5;
	Wed,  1 May 2013 23:07:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05C231B1B4;
	Wed,  1 May 2013 23:07:34 +0000 (UTC)
In-Reply-To: <5181967E.9020601@gmail.com> (Vikrant Varma's message of "Thu, 02
	May 2013 03:56:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8DE78B6-B2B3-11E2-9D61-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223165>

Vikrant Varma <vikrant.varma94@gmail.com> writes:

> On 02-05-2013 00:05, Junio C Hamano wrote:
>> If you step back a bit, you would notice two things.
>>
>>   (1) Saying 'foo' when the user means 'origin/foo' is hardly the
>>       only (or even the most common) kind of mistake that the code
>>       you need to add to 'git merge' would encounter and could help
>>       the user with.
>
> Yes. I like your suggestion of using levenshtein.c, similar to what's
> been done in help.c:help_unknown_cmd. However, where do you draw the
> line? Do you also suggest 'remotes/origin/foo' for 'remotes/foo'?
> Also, which would you then prioritize for 'foo': 'fob' (this is local)
> or 'origin/foo'? In other words, what kind of mistakes are you looking
> to correct -  typos, or forgetful omissions, or both and something
> more?

This is your itch, so you get to choose what you would propose to
the list and have people tweak it ;-)

I personally think the first version should not use levenshtein _at
all_ (hence not solving my 'git checkout mastr'). I however want to
make sure the code is structured in such a way that allows other
people to build on top later.

> However, making the caller responsible for printing the suggestions
> may not be the best alternative.

That "responsibility" could be encapsulated in a separate helper
function the callers call instead of die().

The lower level machinery to come up with a suggested list of refs,
when the caller suspects that there is a typo in refs, is the same
across different commands, and it is insufficient to have a single
helper function that hardcodes "not something we can _MERGE_", and
copy the function to create many other helpers that do the same
thing but with different error messages.

You would need two layers, one that collects suggested list of refs,
and another that is directly called by the top-level caller that
takes the refname and the die message, and the latter would use the
former.  What I was showing was the lower level one, without the
higher level one that takes die message and a suspicious user input
(the higher level one would be trivial and do not need hand-holding
while designing).
