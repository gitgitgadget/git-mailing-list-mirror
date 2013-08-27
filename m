From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/credential/netrc/git-credential-netrc: Use of uninitialized value in string
Date: Mon, 26 Aug 2013 20:56:23 -0700
Message-ID: <xmqqr4dfhjmg.fsf@gitster.dls.corp.google.com>
References: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Ted Zlatanov <tzz@lifelogs.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 05:56:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAOo-0004Hv-1b
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 05:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab3H0D43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 23:56:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab3H0D40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 23:56:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E972F379C3;
	Tue, 27 Aug 2013 03:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2/89bavzBOG/8wjCRSZePeeFiWA=; b=lWl8/8
	PHq+3ayoZsf4GLSYpPWH83n4gwBZHdQ8f65kJdWV3IWrg34s5mwnGc2DgXKBrx+2
	A9hKCTwJf5+DX6/osY7MOt6M2flQMoVbcyXUhVr6CPOjlETPsW2NwG6dMsbGbm7s
	pyycTE+vJ3cy1loiiDVuwzsMhrX9kpUsIKxVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bz0+ww1IUs9/sRgwcCGYQKtsJIEfbq/Q
	xjQnKyjdivWsHf78NWjmZ03l/WElJhWQTM3or4ky05cceXkhgZ8vQKsiYSEgTT8N
	JrO7ZShtY/7F9QuGDE+U9MB6IoxtHVCVezbT9UEC1rQi8bqKRZ8nSpRksXdv9quj
	HSuJZ0u/R7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFBB4379C2;
	Tue, 27 Aug 2013 03:56:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 486E8379BF;
	Tue, 27 Aug 2013 03:56:25 +0000 (UTC)
In-Reply-To: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
	(Antoine Pelisse's message of "Sat, 24 Aug 2013 16:55:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4D936D6-0ECC-11E3-AE59-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233045>

Antoine Pelisse <apelisse@gmail.com> writes:

> I've tried to use the netrc credential with git-send-email
> (v1.8.4-rc2), and I've had the following log (running with -d -v):

Peff what do you think?  From credential layer's point of view, I
think we make it totally up to the helper to decide if a request
matches what it supports, and if a particular helper wants to make
sure it is asked for a specific protocol, that is an OK thing to do,
but it feels unnecessarily unfriendly and treating missing proto
specification as a wildcard to talk to the specified host over any
protocol may not hurt, I would think.

> We were given search token protocol and value smtp
> We were given search token host and value smtp.gmail.com:587
> We were given search token username and value apelisse@gmail.com
> Searching for host = smtp.gmail.com:587
> Searching for password = (any value)
> Searching for path = (any value)
> Searching for protocol = smtp
> Searching for username = apelisse@gmail.com
> Using GPG to open /home/antoine/.authinfo.gpg: [gpg --decrypt
> /home/antoine/.authinfo.gpg]
>
> You need a passphrase to unlock the secret key for
> user: "Antoine Pelisse <apelisse@gmail.com>"
> 2048-bit RSA key, ID DE2A8792, created 2010-12-31 (main key ID A066A853)
>
> gpg: encrypted with 2048-bit RSA key, ID DE2A8792, created 2010-12-31
>       "Antoine Pelisse <apelisse@gmail.com>"
> compare host [smtp.gmail.com:587] to [smtp.gmail.com:587] (entry:
> password=secret, username=apelisse@gmail.com, host=smtp.gmail.com:587)
> OK: any value satisfies check password
> OK: any value satisfies check path
> Use of uninitialized value $_[2] in printf at
> /home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
> line 419.
> compare protocol [] to [smtp] (entry: password=secret,
> username=apelisse@gmail.com, host=smtp.gmail.com:587)
> Use of uninitialized value in string eq at
> /home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
> line 378.
>
> I can fix the problem by adding a "protocol smtp" to the matching
> line, but I wonder why this would be necessary ? After all, if host
> smtp.gmail.com:587 matches, do we need to match the protocol ?
>
> Cheers,
> Antoine
