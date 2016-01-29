From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] Handle errors when setting configs
Date: Fri, 29 Jan 2016 10:55:52 -0800
Message-ID: <xmqqsi1gi5af.fsf@gitster.mtv.corp.google.com>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
	<20160129082036.GA8591@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:56:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPED8-0002p1-W3
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932838AbcA2Szz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:55:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932495AbcA2Szy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:55:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2F4C3F97E;
	Fri, 29 Jan 2016 13:55:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vDQHga+XPdrz2Wrr0LZN4wqOKK0=; b=mDLw9U
	WPqJwDTi9uyGSQ7d546Wx8UiDX6uzxK885j7QaFAXhWWULXsmEoc6bL6ZsgB86z/
	ztUW0W2CxDjLv34CV8p/ojAPvTTra8Re8obBezm+bNnQrwD2Wnakew3Uu9VRGg8F
	uxhSElSPL6J6x89cao5GuNSRT6ip3vt7ROi1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0JR56RO1wdnZNPdWyugjISRyKNqWEYp
	Z3rA9yCmU4RaKeOMlIpdpnyXrN8uRNPhjzVRLEzBK4IK1P0RfMDswKJwBS4H/IoM
	+hCEoSx5k/3UOazUkG5BihNjFLGC4+F0iknsKi6V/CgBX5Yx7noa1KJkkFzFOiFo
	lsTyp0rOeCs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBF843F97D;
	Fri, 29 Jan 2016 13:55:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B4873F97B;
	Fri, 29 Jan 2016 13:55:53 -0500 (EST)
In-Reply-To: <20160129082036.GA8591@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jan 2016 03:20:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBE98C22-C6B9-11E5-9005-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285088>

Jeff King <peff@peff.net> writes:

> The end result is roughly the same, but it's a lot less churn, and it's
> more likely for new callers to get it right, because they have to go the
> extra mile to ignore the error. I say "roughly" because it treats cases
> we missed as "die", whereas yours leaves them as "ignore". I find it
> highly unlikely that any of them actually _want_ the ignore behavior,
> though.

Yes, I like this approach better.  It admittedly is more risky in
that it would die if the conversion missed a case that should
ignore, but I suspect that such a breakage would be found rather
quickly (and the one that goes latent are the ones that do not
matter in practice because people would not encounter them).

> I'm just pondering, though. I don't find the "or_die" variant bad at
> all, so if you really prefer it, I don't mind.
>
> Just to get a sense of what the reverse would look like, I worked up the
> patch below (which compiles but does not link, as I did not actually
> implement the "gently" form). Some error-checking call-sites are
> converted to the "die" form, because that's essentially what happens
> anyway (and I'd venture to say that the config code can provide a much
> better error message).

This variant certainly looks nicer to me, for the reasons give above.
