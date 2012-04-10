From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 18:05:56 -0700
Message-ID: <7vobr0s8ej.fsf@alter.siamese.dyndns.org>
References: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org>
 <1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vwr5os9zr.fsf@alter.siamese.dyndns.org>
 <1334018233-sup-7389@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Apr 10 03:06:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHPX2-0006gQ-RT
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 03:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233Ab2DJBF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 21:05:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102Ab2DJBF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 21:05:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D5E96DC9;
	Mon,  9 Apr 2012 21:05:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VbQTTgdhQ6Dbx9uQJvqswfqpEWI=; b=KwbQyX
	oD7Jg2VAaqY2lyB1pSxpsTDYagy9HNmyZxok1T2avbHsfiOk0c9/3SOYXcsmBict
	XJG50nRfazDZc2FsQ5LNuA/JHN57GyACCNNwH9cdMnaxsS2H0910bPgjc1UTr1bq
	/Wf49sRLnt46p0mnEHp8qGgWbYGB0LhK3orL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xcrbjCbemsArIdB3lWM74Z3i3S1QhlQI
	MCYsnHhaSC9iw5bnv77fN/3CgVhQvqvgD2QpAoZSFtU6ffNaLhvpkuLum97DAAF2
	R0GMctVhXOCBr1LDIwqFAA720K90vRXNFveI2UIJw8iMmHoXB2DG5iQkCrQ7B9At
	2M2svqAQwdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F5C6DC8;
	Mon,  9 Apr 2012 21:05:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FD366DC7; Mon,  9 Apr 2012
 21:05:57 -0400 (EDT)
In-Reply-To: <1334018233-sup-7389@pinkfloyd.chass.utoronto.ca> (Ben Walton's
 message of "Mon, 09 Apr 2012 20:40:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54BFD318-82A9-11E1-977D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195054>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> I guess widely wasn't a good choice...My search wasn't narrow enough
> earlier.  Was I correct in my original thinking that the range
> notation isn't to be used then?

So far we have tried to stay within a narrow subset of BRE (see
Documentation/CodingGuidelines) in fear of upsetting exotic and/or ancient
systems. I do not mind reviewing and revising the guidelines every couple
of years, but for this particular case, I do not think [^/][^/]* is too
bad.  FWIW, it bothers me a lot more that expression does not anchor
matches against path elements with explicit '/' than the issue your patch
addresses, i.e.

	sed -e 's|[^/][^/]*/|../|g'
