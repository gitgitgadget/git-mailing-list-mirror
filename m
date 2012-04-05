From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not
 make sense
Date: Thu, 05 Apr 2012 13:34:31 -0700
Message-ID: <7vy5q95354.fsf@alter.siamese.dyndns.org>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
 <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
 <20120405184345.GA6448@burratino> <7vlima5591.fsf@alter.siamese.dyndns.org>
 <7vhawy54nd.fsf@alter.siamese.dyndns.org> <vpqsjgi53mh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFtOE-0000Zr-34
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab2DEUef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:34:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab2DEUef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:34:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14D071FF;
	Thu,  5 Apr 2012 16:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S5XuTpAlMDKXutJ5iSCFTB4PVbA=; b=ZRrJXD
	WvcmXHhJCe3TbhNhkqzG+QfxKjX5cOa6rjc+1Ud7n07V9e/x0eMvJTfNtrK/OH3n
	HjkhxDEstBchWF90Nb4ts8Xm+3+KgX0oTjEUs1KsyXc3NT3fu74YRpQrWsH0qBHn
	v2Wm508DH+8U3wrFOJ2HY7d1MnscKxzAPIjy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzTzHn2N+pzx+TAfgKAIOJtVu6psPAJO
	lsgd3r8bhMjHYopimfHuoauZXFfrjFcQGzVaG4WBv0vF57k8Hk//ygEshU2LXZKt
	+KQkkuSD9iAXgwg/CH6UYHhEvowyjc9Ev39WNXiLD0dB238r7KVEr6Rr2NpOiqSb
	EKQ7Hi2Ne+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E470C71FE;
	Thu,  5 Apr 2012 16:34:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 775A471F9; Thu,  5 Apr 2012
 16:34:33 -0400 (EDT)
In-Reply-To: <vpqsjgi53mh.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Thu, 05 Apr 2012 22:24:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0BBBF76-7F5E-11E1-8C9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194807>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  		die(_("You are pushing to remote '%s', which is not the "
>> -		      "upstream of your\ncurrent branch '%s'.\n"),
>> +		      "upstream of your\ncurrent branch '%s',\n"
>> +		      "without telling me to push which local branch to\n"
>> +		      " update which remote branch with."),
>
> Sounds overly complex sentence to me. "without telling me what to push"
> sounded good enough without being long, so I prefered it.

You are right; it is overly complex.

After sending the updated patch, I rewrote it again to:

    You are pushing to remote '%s', which is not the upstream of
    your current branch '%s', without telling me what to push
    to update which remote branch.

The point of Jonathan's 'refspec' and this attempt to rephrase it without
using a jargon is to make sure that the user realizes that both ends can
be specified.

> I like accompanying these messages with the way out for the user, so
> perhaps we can add stg like
>
> "To push the current branch to this remote, run:
>
>   git push <remote> <branch>
>
> "

I am afraid that the above advice is a lot worse than leaving it unsaid.

We are in no position to assume that the user wanted the "current"
semantics when we issue this message.  Otherwise, we would be better off
switching the default semantics to "current", not "upstream".  But the
working assumption in this series is that "upstream" is an improvement
over "current", no?
