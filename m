From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] push --follow-tags
Date: Wed, 06 Mar 2013 07:55:07 -0800
Message-ID: <7v8v60seuc.fsf@alter.siamese.dyndns.org>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
 <20130306084105.GB2018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 06 16:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDGgt-0001h2-Ks
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 16:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758594Ab3CFPzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 10:55:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334Ab3CFPzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 10:55:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 064B1B816;
	Wed,  6 Mar 2013 10:55:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JXEPgF94cEuxW5ekFEF3F1bx/Ig=; b=gkFKqp
	D+V9kpvReqI8t+F9FqjxPvWsyx0KlprixC9udg+YV8mJI2s5U5HFAvi+mO+pCMGt
	B6wXPSW2gvF5WTmiR5fPt5Gx2CBG3ud073cy3AEwe0RjEszaBEvEEMpWCvqfHBVP
	s8Kagvzm5G8OQPXqv9y4EM1VK2Fg3fN2wDwto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xZzfKpZULaLuAZSRw6aeyQlg+Mk+N76E
	A8PtEE+PKoceMMdog2/zEYoEfUKqoLfmOgHmxLm4DqytmS4le91WOG5tM9omC5Fb
	ZV1koxfuom94Dmvz10f0ml0sgFBDElsnkOD+fHs5EE3UMwXSOE8VhxXHks0f/fJg
	H8lQOatD1dY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF919B815;
	Wed,  6 Mar 2013 10:55:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67915B814; Wed,  6 Mar 2013
 10:55:09 -0500 (EST)
In-Reply-To: <20130306084105.GB2018@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Mar 2013 03:41:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38F3FC5A-8676-11E2-AD1B-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217531>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 05, 2013 at 02:47:15PM -0800, Junio C Hamano wrote:
>
>> The primary change since the last round is that it pushes out only
>> annotated tags that are missing from the other side.
>
> Like you, I have mixed feelings on treating annotated tags separately. I
> don't feel like the previous discussion actually came to a conclusion.
>
> I kind of lean towards the "if we are pushing A..B to a ref,...

I rejected that approach when I started writing the initial round of
this topic, primarily because A (i.e. dst_ref->old_sha1) may not
necessarily be what the current pusher pushed out during his last
push.

The criteria for the tip of a branch to be good enough to be pushed
out and the criteria for a commit to be good enough to be tagged are
different.  You may know that a commit together with the history
behind it is solid and may be sure that you will not have to rewind
beyond that commit---that is when you _can_ push out (you do not
have to, and I usually don't, so this is not a problem for me
personally).

But at that point in time, you may still not know if the commit and
the history behind it is the good point to be tagged for a release,
or you would still need some other commits on top to polish other
areas for the tagged release is complete.

As I made a habit of not pushing anything out if I am planning to
tag in a near future (and my tagged commits are ones designed to be
tagged, not just an ordinary commit that happens to be tagged), it
is not a problem for me, but it would be for "centralized workflow"
people, where there is more pressure to publish a commit as early as
possible.  Once you know the commit is good enough so that you do
not anticipate that it will need to be rewound, you want to push it
out so that you can unblock others who want to build on it.  It is
plausible to see:

    (1) The pumpking pushes 'master' after being satisfied the
        correctness of the history that leads to it.  The pumpking
        hasn't decided if the commit is to be tagged, or needs some
        other commits on top, for the next release.  But he prefers
        to push the current state out so that he can unblock other
        people.

    (2) Another committer pulls and pushes with his changes.

    (3) The pumpking tags what he pushed out with (1), attempts a
        push, fails the ff check, pulls (2) and then pushes the
        result out with "push --follow-tags".
