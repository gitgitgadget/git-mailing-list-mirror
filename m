From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issuing warning when hook does not have execution permission
Date: Wed, 20 Aug 2014 10:51:53 -0700
Message-ID: <xmqqzjezt5fq.fsf@gitster.dls.corp.google.com>
References: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
	<20140819080002.GB7712@peff.net>
	<xmqqegwcwhfc.fsf@gitster.dls.corp.google.com>
	<CAFOYHZCGQj1vaZfOpFXHpuf-OjTB5RXRN_37O2EkQFRvow-RfA@mail.gmail.com>
	<20140820101921.GA21527@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Babak M <babak@melon.com.au>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:52:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKA3P-0005bZ-SS
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 19:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbaHTRwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 13:52:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56479 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbaHTRwF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 13:52:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 038A430C7F;
	Wed, 20 Aug 2014 13:52:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=16/8UGMhLsdsEB/Fn26CHTIcyFo=; b=TOW6zO
	hXsi8q5MIdheZWGx3tVrq7TkiD66t4fQFLNLnfLfA1zvjSQWURmcfeK4ROGBSipw
	5fQgb+TW6d5eZe+JTgZEouchnhMorKIOs93ZRLke6Wxcyw9fMWDIl4IWh5Ny9WnT
	xHhMF0t8OC2fBveYNYVp53+P9YKDllzmM96z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FDdHRJJanY88/HC0sHqRrj7c1eDcKg5t
	5rq0bqVCUq8+JIeJFKOLWPG2OdOZwP7wP/adrXQ2AycS2tqNG71uHVWOBSvB1UPV
	Gb+KW3oER1SFZaqMxH2Hu8HBm/pEyWic2D7SA9DMhA/y4uCMmOcXuLQ5s6WoIl6S
	IXVGM6BeRV4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC57E30C7E;
	Wed, 20 Aug 2014 13:52:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2F44630C60;
	Wed, 20 Aug 2014 13:51:56 -0400 (EDT)
In-Reply-To: <20140820101921.GA21527@peff.net> (Jeff King's message of "Wed,
	20 Aug 2014 06:19:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD145BC4-2892-11E4-A4A7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255577>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 20, 2014 at 08:55:52PM +1200, Chris Packham wrote:
>
>> I actually find the existing behaviour useful. If I want to disable a
>> hook to I can just chmod -x .git/hook/... and I then chmod +x it when
>> I want to re-enable it. I guess I could live with an extra warning as
>> long as the command still succeeds.
>
> You could do the same thing "mv $hook $hook.disabled" but it involves
> retraining your fingers. I kind of agree that the existing system of
> respecting the executable bit is nice, though: it does what you told it
> to do, and a misconfiguration is your problem, not the system's. It's
> perhaps worth changing if people frequently get the executable-bit thing
> wrong, but I don't know whether they do or not.
>
> I kind of feel like we had a similar discussion around items in PATH,
> but I don't remember how it resolved.

I don't either, but IIRC the primary tricky point was what happens
when a component of $PATH list is inaccessible, making us unable to
even know if an executable we are looking for exists there or not,
which is slightly a different issue.

And I also kind of agree that the existing system is nice.  It may
sound like a good idea to warn when there is even a slight chance of
misconfiguration on the user's side, but for this particular one, it
has been a designed-in behaviour for a long time, and it may be
unwise to change it.
