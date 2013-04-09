From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 13:31:05 -0700
Message-ID: <7vzjx7phti.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
 <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
 <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
 <CALkWK0k0YMWjhJQFWLv6b7kAHqRm8-Dq23gMVHYfatq1SLUDhQ@mail.gmail.com>
 <7vmwt7si6z.fsf@alter.siamese.dyndns.org>
 <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 22:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPfCE-0007gG-A0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936080Ab3DIUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 16:31:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935910Ab3DIUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 16:31:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F48E152BB;
	Tue,  9 Apr 2013 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXg+9BduMG7cWvXxTQ5Rg5D4WqE=; b=DTvHYo
	0N57+n1KlTtkCa566loK69nOn8d+vK5N0q0wkYFQa+17w/1bVMDKPzWyWx7oPbbQ
	0r+7EV17Kehw3F4ifaSJaTamjEhPxoaR0LAlrKdnotdu09ue3cuxmjnLmH4uqKaK
	45fqFZ4e4e5MioK4OQWpXjQ+49iRCsijNp2Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cuaTEfroyH34D7U/laElPmCir9ny5+hK
	m26cL/CvxauZTBpm+eaTEUKvYh0AuGdEsEjKhpHGpNVYezJCiTIEISCjmVVoWej6
	eZPNk2BeFkdDlPe00lp3nX07NCDDR8KhTH9csb+PZPCDvwQ8+n63CTAZ8PU94itS
	CtZtDS3cJgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72FD0152BA;
	Tue,  9 Apr 2013 20:31:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA9D1152B9; Tue,  9 Apr
 2013 20:31:06 +0000 (UTC)
In-Reply-To: <CALkWK0nF0aTLDZyPXfa=4kp=BnDPm3+_ZfMvP_6ZcimeJtzxvw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 9 Apr 2013 23:47:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67E78CAE-A154-11E2-8C43-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220631>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> But there are other cases to attempt to add a path that do not
>> belong to our project, which do not have to involve a symbolic link
>> in the leading path.
>
> The reader is now wondering what this could possibly be, and why you
> didn't send this patch earlier.  Perhaps clarify with: s/there are
> cases/there may be cases/ and append "One such case that we currently
> don't handle yet is a path inside another git repository in our
> worktree, as demonstrated by test tXXXX.X."

I _think_ I misread what you meant to say in the above.

We can go either way between "are cases" or "may be cases".  I meant
it as an immediate predecessor ([PATCH 1/n]) to the patch you were
working on ([PATCH 2/n] and later), so in that context, it does not
matter.  [PATCH 2/n] will start as "Now the naming is saner, let's
start noticing when the user gives a path is beyond our project
boundary because it is under control of another repository by adding
necessary logic to that function."

And I also misread "we currently don't handle" above as "but we
really should allow adding d/f when d is at the top of the working
tree of another project", but that was not what you meant to say.
Instead, "We do not notice such a bad case in today's code yet" was
what you meant.  But if we are to use "there are cases" in [1/n] and
start [2/n] with "Now we have renamed, let's do this", then we do
not have to bother saying anything in [1/n] about the upcoming
change in [2/n], especially the patches come back-to-back in a
single series.
