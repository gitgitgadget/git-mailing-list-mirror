From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Mon, 10 Jun 2013 12:09:59 -0700
Message-ID: <7vobbdhjeg.fsf@alter.siamese.dyndns.org>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
	<1370798000-2358-3-git-send-email-artagnon@gmail.com>
	<7vip1moq3k.fsf@alter.siamese.dyndns.org>
	<CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
	<7v4nd6l31d.fsf@alter.siamese.dyndns.org>
	<CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
	<7vwqq2j7c9.fsf@alter.siamese.dyndns.org>
	<CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 21:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um7Tn-0003FY-B2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 21:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3FJTKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 15:10:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab3FJTKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 15:10:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0B2127622;
	Mon, 10 Jun 2013 19:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8v+dND2Uh9A4LeAI6tix6rxNsY=; b=POzxuy
	3dXvpJTTKz/wNiuYDtf2SXr4PppEc76xq6okJI7Ps99CPzrX8rW5b1jUxCFxwrxS
	Md5BEuq3eCCNFTv4atJdkmo1Gv+SNFZOKlF0ITq8oPq9HAzC+NDmt00hhZgd/AKI
	ng2bfUTw6FzbC1z2MVziDLQgQrvSL9LZMFN8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHg5aA5ZMq5fZQb149PmMGeao3PaSE6M
	W5wLPetemLcHWdqhUJ/MZDdt73EihDjYAAI+U98cES8CT0erGBjiItWLu6RlV2lM
	+oACGWhxu0b5sv1/l2AjvdYl8gYOCox6Iob2mlTBq/VAGv121+CxbyELIX5hK6Bv
	XuITyTfXm5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC2427621;
	Mon, 10 Jun 2013 19:10:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 071F42761D;
	Mon, 10 Jun 2013 19:10:00 +0000 (UTC)
In-Reply-To: <CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 10 Jun 2013 21:37:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5959FDBA-D201-11E2-A2F5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227362>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> I am not saying that you have to pick one to use for push.default
>> among the remaining ones (i.e. matching, current, what else?).  It
>> is very plausible that the triangular workflow wants a different
>> logic to pick what branches are to be updated and how.  Perhaps we
>> would want something that is capable of mapping your local branch
>> name to a branch name suitable in your publishing repository, and I
>> am not opposed to have such a mode.
>
> Okay, we'll have to do some sort of split and mark push.default =
> upstream/ simple suitable-only-for-centralized-workflows, or something
> to that effect (deprecation?) :|

Among the current ones, I think "upstream" is the only one that has
the "branch I fetch and integrate with is the one I want to update
with my result" connotation.  The "current" and "matching" modes
determine what gets pushed solely between the local repository you
are pushing from and the remote repository you are pushing to,
without getting "what do I fetch and integrate with" in the
equation.

As an extension to "upstream", the current implementation of
"simple" of course has the same issue, but because the name "simple"
does not inherently have such "branch I fetch and integrate with is
the one I want to update with my result" connotation, we can clean
up its semantics to match the new reality after triangular workflow.

If you recall the earlier discussion on "@{publish} which is
different from @{upstream}", one idea to allow mapping on the push
end was to introduce "push.default = single" that would act as
"upstream" when in "branch I fetch and integrate with is the same
branch at the same repository the one I want to update with my
result" workflow, and in a triangular workflow maps the branch being
pushed using remote.$name.push refspecs (if exists).

I think extending it further to act as 'current' if no push refspecs
are set for the remote you push to in a triangular workflow might be
a way to go if we want the mapping flexibility without having to set
branch.$name.push to each and every branch.
