From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFH: unexpected reflog behavior with --since=
Date: Fri, 11 Nov 2011 22:50:28 -0800
Message-ID: <7v62iprg0b.fsf@alter.siamese.dyndns.org>
References: <4EB9C7D1.30201@nextest.com>
 <20111109220128.GA31535@sigill.intra.peff.net>
 <20111109222032.GB31535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@nextest.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 12 07:50:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP7QJ-0002f5-CA
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 07:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab1KLGuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 01:50:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab1KLGub (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 01:50:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89A7E2B79;
	Sat, 12 Nov 2011 01:50:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LQrIxZNptrPskE75X2qHDpybqjE=; b=tX7NeQ
	TPydME0/lW2371z59FWEJvgp90zsgulrL3sTd8W8+q782oHQ7fnaXEvWQTG9IDxM
	x8qT9Mx3R2CEJGOswCswoYfktXGzYrrLqKgtkGhFg8h3TJ4zqCbJwczvEhuE2LUX
	ZtDSJ7VeTNjALjNOn6cvsu+qNTjiC8EmxOK+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vcAkQC1gyxS/p+NxxfqbpOreD+ITzaN0
	9xtqS7l2+0BadVj9LuS7OZJdI0kPUAscQlidSf+NRoeLBjyJjtGcl1gYVkcmceat
	K0+8Z92qtjCsXqdx9d84e53KMqFxiwtNXTjA7+IampKCyJ3jRstX6FXTqD0ibJ6w
	E1CEVYoNz1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 762B02B78;
	Sat, 12 Nov 2011 01:50:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3C7F2B75; Sat, 12 Nov 2011
 01:50:29 -0500 (EST)
In-Reply-To: <20111109222032.GB31535@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 9 Nov 2011 17:20:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C2DED9A-0CFA-11E1-87B7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185300>

Jeff King <peff@peff.net> writes:

> So I think the only decision is whether "--since" should respect the
> commit timestamps (and be used as a sort of "grep" filter for
> timestamps), or whether it should be respecting the fake history we
> create when doing a reflog walk.
>
> I think I am leaning towards the latter.

I tend to agree as far as the semantics go.

Also at least as a short term solution at the implementation level, I am
OK with the change. But in the longer term, I have this suspicion that we
should not be rewriting commit objects themselves with these phony data,
which makes things like "git log -g --stat" and "git log --parents -g"
totally useless.

That of course is not a fault of this patch; it does not make things any
worse than the original, and that is why I say I am OK with it.

Thanks.
