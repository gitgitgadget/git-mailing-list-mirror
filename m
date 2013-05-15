From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 03/10] refs.c: Refactor code for mapping between shorthand names and full refnames
Date: Wed, 15 May 2013 08:14:08 -0700
Message-ID: <7v38toe0n3.fsf@alter.siamese.dyndns.org>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-4-git-send-email-johan@herland.net>
	<7vmwrzsck1.fsf@alter.siamese.dyndns.org>
	<CALKQrgf0m8r-Ofb+Ss1OpEF67dPS73b8nB+usVxH=Y=h3441Wg@mail.gmail.com>
	<7v8v3jqsy7.fsf@alter.siamese.dyndns.org>
	<7vwqr2liv6.fsf@alter.siamese.dyndns.org>
	<CALKQrgcDBMPeXPzTnpGyeosipR6Ln_zLh4Q_i1A7-eFUnTnBcA@mail.gmail.com>
	<51932F1B.9000200@alum.mit.edu>
	<CALKQrgdsBzcdtyej=qvaL-2rr-5t_UzXdOL-ZZ3a-rGW5V_i7Q@mail.gmail.com>
	<CALKQrgdroLDSf=Xc58NiHSf7fp8cRMbrR0mGrfKY7Rg0FpPFJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	jrnieder@gmail.com, normalperson@yhbt.net
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed May 15 17:14:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcdPF-0002lL-Fg
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759165Ab3EOPON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:14:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758844Ab3EOPOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:14:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2551E2E9;
	Wed, 15 May 2013 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+r3hyORiTeRFZathgOrEtLfvq+s=; b=Aps126
	GnV8S/TFkDCOYx7IyyxgNxxIBHBfIafNx9qMzv5YtbeGsD2v/fD+7q0p5RSLggLb
	/sxuR9zjzBUGHY8rslaGSOXZCl4tFgXHKeypi4breiReCQ6l7DnXkGls33nK7fGn
	O6RJvykgnbDLey3/CLKX+1x7GWquX7crgETWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KGkmV2pgJYp+8T3yiwUrAmYM95le5TkJ
	jSUPhZuH+xy1LUJs8N86MwlxaKfozGn4l8j1cETEwRUT1RCB5Hw8hyKNNkpkial9
	UbYYz4/oR4batZ6IKbipd81BpX12ke+GbF02YDbH0hk+RU+mbj/B+o/XsRQh6+it
	N/Qhy6NQ3H8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64F941E2E7;
	Wed, 15 May 2013 15:14:11 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC7FE1E2DF;
	Wed, 15 May 2013 15:14:10 +0000 (UTC)
In-Reply-To: <CALKQrgdroLDSf=Xc58NiHSf7fp8cRMbrR0mGrfKY7Rg0FpPFJg@mail.gmail.com>
	(Johan Herland's message of "Wed, 15 May 2013 15:53:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1868E09E-BD72-11E2-AF0C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224413>

Johan Herland <johan@herland.net> writes:

> On Wed, May 15, 2013 at 9:39 AM, Johan Herland <johan@herland.net> wrote:
>> On Wed, May 15, 2013 at 8:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> "refs/remotes/%1/%2" (or "refs/remotes/%1/%*") might be a nice way to
>>> imply that the rule should only be attempted if the input has at least
>>> two components, whereas something like "refs/heads/%*" would be applied
>>> even for inputs with no slashes.
>>
>> /me likes, at least for "refs/remotes/%1/%*".
>
> Unfortunately, using "refs/remotes/%1/%*" instead of "refs/remotes/%*"
> breaks a number of git-svn tests which puts refs directly within
> refs/remotes/, and then does things like "git reset --hard trunk"
> (expecting trunk -> refs/remotes/trunk, which the refs/remotes/%1/%*
> doesn't match).

Oh, I never thought refs/remotes/%1/%* was a suggestion for a
serious "improvement", but was merely a thought experiment "if all
the remotes were at least two level names, we could express it like
this to stress that fact".

We already allow 'origin' to refer to refs/remotes/origin/HEAD, so
it is clear refs/remotes/%1/%* alone will not be able to replace
what we have; we need refs/remotes/%* and refs/remotes/%*/HEAD
anyway.
