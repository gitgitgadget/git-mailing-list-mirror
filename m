From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/credential/osxkeychain: Makefile should allow to set
 CFLAGS
Date: Thu, 24 May 2012 10:35:35 -0700
Message-ID: <7vaa0xxz14.fsf@alter.siamese.dyndns.org>
References: <AB628C35-FEC2-4425-B3D8-EEC7F8D6A66B@samueljohn.de>
 <7vtxz82ap6.fsf@alter.siamese.dyndns.org>
 <20120523173653.GA29458@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel John <mail@samueljohn.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 19:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXbwu-0005TD-I7
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab2EXRfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 13:35:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53978 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910Ab2EXRfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 13:35:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 382BC8699;
	Thu, 24 May 2012 13:35:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLu6kUns3d54eBXD0CjQmzsaLrg=; b=IXmMFr
	FkWwXtDNKZZxW2NhN93UIzMFh0p8fqkaUnZUvEjRBQKGpC92B+9C+ysrZeQGe/Po
	kyDw9O6CtJj7wDl4Vn2zENixbsztfV1jsaT1yCxCvGxy0quSy8WCbyi6nvvkefan
	fFmwNeveAnx0Qdhb5/V7d800QqedLy5j+QMgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QuN/pXQ+dR+Ux7K+SWbSFrdpP1DDUvf0
	EzYBUbIPRlgCdYR6xabHlunzVeO+ycGYrBY8TxzNc1zvtqpf5gyb1SozM2icnk9Y
	YtcwiKXSHZSv8Ptxg5YmQKsYWj40Ru4vJWLMAbHMCufF2b1F20gUxVvcTWu6D8nt
	Yc7CCU7pZJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0E08697;
	Thu, 24 May 2012 13:35:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 940F68696; Thu, 24 May 2012
 13:35:36 -0400 (EDT)
In-Reply-To: <20120523173653.GA29458@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 May 2012 13:36:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF4AFAF4-A5C6-11E1-9A8B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198397>

Jeff King <peff@peff.net> writes:

> On Tue, May 22, 2012 at 02:00:05PM -0700, Junio C Hamano wrote:
>
>> It however seems to me that git-credential-osxkeychain.o does honor
>> $(CFLAGS), either from the user "make CFLAGS=..." or the default the
>> Makefile in question supplies.
>> 
>> The line you quoted is not using $(CC) as the compiler, but is using it to
>> link the final build product.  It may not hurt to have $(CFLAGS) on that
>> line, but shouldn't the line also have $(LDFLAGS) on it?
>
> I think so. Why don't we do this?

I am OK with that.

CFLAGS/LDFLAGS that come from ../../../config.mak _might_ not be suitable
for this binary, but I do not think of a concrete example how that could
be.  Besides, this is just an example in contrib/ so I'd not worry about
it too much.

Thanks.

> -- >8 --
> Subject: osxkeychain: pull make config from top-level directory
>
> The default compiler and cflags were mostly "works for me"
> when I built the original version. We need to be much less
> careful here than usual, because we know we are building
> only on OS X.  But it's only polite to at least respect the
> CFLAGS and CC definitions that the user may have provided
> earlier.
>
> While we're at it, let's update our definitions and rules to
> be more like the top-level Makefile; default our CFLAGS to
> include -O2, and make sure we use CFLAGS and LDFLAGS when
> linking.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  contrib/credential/osxkeychain/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
> index 75c07f8..4b3a08a 100644
> --- a/contrib/credential/osxkeychain/Makefile
> +++ b/contrib/credential/osxkeychain/Makefile
> @@ -2,10 +2,13 @@ all:: git-credential-osxkeychain
>  
>  CC = gcc
>  RM = rm -f
> -CFLAGS = -g -Wall
> +CFLAGS = -g -O2 -Wall
> +
> +-include ../../../config.mak.autogen
> +-include ../../../config.mak
>  
>  git-credential-osxkeychain: git-credential-osxkeychain.o
> -	$(CC) -o $@ $< -Wl,-framework -Wl,Security
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) -Wl,-framework -Wl,Security
>  
>  git-credential-osxkeychain.o: git-credential-osxkeychain.c
>  	$(CC) -c $(CFLAGS) $<
