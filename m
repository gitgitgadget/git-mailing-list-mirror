From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 12:54:34 -0700
Message-ID: <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 21:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQNZz-0003Pu-2C
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 21:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab3DKTyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 15:54:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63153 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab3DKTyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 15:54:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C68215E6C;
	Thu, 11 Apr 2013 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7jV33uF7Q7BIYUrXlvb6lg3tkKU=; b=InkB7J
	ktZn27tfpzRM4ZeU2irR/SeqnW0sd1J3WOS/rqOcRemQkWSAOttkRAoEo+vaRJrG
	H8DoqlxcOtMTtTap5yCaGdks66MYbcOU0hf3XfmAL35EXTTdhY3yCnGxv9Bccieg
	aS5a8WqBS8r50BFx8aVnqFKTX1lTgW7A9chto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yaMH06Qg8AZiG3lyWsGehAxnK5BZ/GS1
	zOzYSDJZo0DlvrDEFywlBxsGcxQ+KzwrwluxlBN6QSYvnG4WmCjPR3F/BSykEu+z
	f9yLUjunL/N2ZuKnsW+Nj2FGgm2eImMzuaxvmLbJk+PXNVeFXxdXVnM7wlFxVOrv
	3TvCSSgEMWg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E39915E6A;
	Thu, 11 Apr 2013 19:54:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F96415E57; Thu, 11 Apr
 2013 19:54:35 +0000 (UTC)
In-Reply-To: <20130411181439.GA2820@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 11 Apr 2013 14:14:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A302B9C4-A2E1-11E2-874C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220921>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 11, 2013 at 11:11:03AM -0700, Jonathan Nieder wrote:
>
>> > -- >8 --
>> > Subject: [PATCH] daemon: set HOME when we switch to --user
>> 
>> Thanks for taking care of it.  For what it's worth,
>> 
>> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>> 
>> I'm not sure whether to keep 96b9e0e (config: treat user and xdg
>> config permission problem as errors) in the long run, BTW.  There have
>> been multiple reports about dropping privileges and not being able to
>> access the old HOME, and I'm not convinced any more that the
>> predictability is worth the breakage for such people.  Though checking
>> if $HOME is inaccessible and treating that case specially would be
>> even worse...
>> 
>> Insights welcome.
>
> I could go either way. I think 96b9e0e is the right thing to do
> conceptually, but I kind of doubt it was affecting all that many people.
> And though it's _possible_ for it to be a security problem, I find it
> much more likely that the site admin tries to set some config, gets
> annoyed when it doesn't work, and debugs it. So from a practical
> perspective, 96b9e0e may be doing more harm than good, even though it's
> the right thing.

Recent reports in this thread make us think so, I guess.

But reverting 96b9e0e alone would not help these people very much
though.  They will have reams of warning messages in their server
logs, and the way to "fix" it would be the same as the way to work
around the access_or_die(), namely, to set $HOME to point at a more
appropriate place before running "git daemon".

I also have a suspicion that your patch makes things worse for
people who are more adept at these issues around running daemons
than the people who introduced this problem in the first place (eh,
that's "us").  It is plausible that they may run multiple instances
of "initially root but setuid() to an unprivileged user" daemons,
giving each of them a separate play area by setting $HOME to
different values, just for management's ease not necessarily for
security (hence sharing the same unprivileged user), which will be
broken by the patch that unconditionally overrides $HOME.

A trade off to make things slightly easier for one sysadmin by
making another thing impossible to do for another sysadmin does not
sound like a good one.
