From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Thu, 31 Jan 2013 09:32:12 -0800
Message-ID: <7vzjzpgswz.fsf@alter.siamese.dyndns.org>
References: <20130131172805.GC16593@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0y0Q-0004zx-Om
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720Ab3AaRcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:32:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab3AaRcP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:32:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8DF3CC15;
	Thu, 31 Jan 2013 12:32:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XXuu8h+EmhWQWPsmJB8EbkicBGo=; b=m7pRWl
	5k/iDy0qUgJYrbnpNJh4pfrWwmNBeF1x4+M+AeFmkXYDy608BdMYHJf3T2K/ct+i
	jLCNxoMC+Xpm/5ZWQkfsGyGi3qw8BrQzO8EQ8aOcsTuCtwiN317P0Pl0MJY17lAK
	q3Tr91BHy/ZniTfZJad/xgHt4Pl6m1i80FVQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rU4bXWO4GAiWwdQ8x+iPNRQ7SQQwWQ7G
	WUBb1Vumd/xyTs4HYuEK964y+ICXg8KSP9CGT5NJHKzq4dGxEhaum+j5wR92pREg
	AEpn9+4egR6WfNX/rHCn1z94WwKqtNEpXBL0TvdlNWhrEfCtM6f3fOqLEY5k+hoh
	45xdwBOsExo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4C7CC13;
	Thu, 31 Jan 2013 12:32:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A341CC11; Thu, 31 Jan 2013
 12:32:14 -0500 (EST)
In-Reply-To: <20130131172805.GC16593@kroah.com> (Greg KH's message of "Thu,
 31 Jan 2013 18:28:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26B0C77C-6BCC-11E2-A13D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215131>

Greg KH <gregkh@linuxfoundation.org> writes:

> The way we upload the Linux kernel to kernel.org involves creating a tar
> archive, signing the archive, and then just uploading the signature.
> The server then checks out the repo based on the tag, generates the tar
> archive and checks the signature to make sure they match.
> 
> A few days ago I released the 3.0.61 kernel, and it turned out that I
> couldn't upload the kernel release because 'git archive' now creates a
> binary file that differs from an older version of git.
> ...
> Now keeping binary compatibility of tar archive files isn't really a big
> deal, but, the commit to git that causes this seems a bit odd, is it
> really needed?  Or can we just fix the version of tar with NetBSD
> instead?  :)
>
> Any ideas?

How about fixing kup to teach the "let's cheat and let the other end
run 'git archive', if the resulting archive and GPG signature
locally created does match, we do not have to transfer the tarball
itself" trick a fall-back mode that says "but if the signature does
not match, then transfer the bulk used to create the signature to
the remote anyway".  This fallback can and should of course be
useful for the compressed patch transfer.
