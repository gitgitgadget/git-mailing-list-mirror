From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send.txt: remove the use of sslverify=false in
 GMail example
Date: Wed, 10 Apr 2013 11:44:03 -0700
Message-ID: <7vmwt6mdjg.fsf@alter.siamese.dyndns.org>
References: <51657E59.7030001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:44:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ00D-0005GT-55
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab3DJSoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:44:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab3DJSoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:44:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBACD156F2;
	Wed, 10 Apr 2013 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZN1cE0bOXH/QWTa6XDaMlxr5PgI=; b=Y+3Df5
	Zjya7lMA7IyJq8Em02RkxqoU5BlVJ2x8OKi7/Jj9Vq1DRmVVGGF8Fh48VqUjEVxt
	raTmknoEpfNZ9tXOV0RAnw8FU/couV52WvssdaS46CsZlATb7So937r7W/7aCjYY
	DFukT2ICcleHjgbi1kZaf2LMY+BGDo3B+p7Fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LfX9aE5egjfpHTs4nk3uSMMXkoIWj0Mz
	pzATLZu/LkMCJ1UX2yVV7I7tTy247xbUDMQC14tlQB0CgHROo8jRcBNIpcJXPvpr
	+qLumbA8RgLq2IR7JcG6TSHx7gejqirTGQ21yrHyLhpRfW7NfAy/IjLKjBYyiUkp
	mwKvPdbgq5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D333B156EF;
	Wed, 10 Apr 2013 18:44:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22660156EE; Wed, 10 Apr
 2013 18:44:05 +0000 (UTC)
In-Reply-To: <51657E59.7030001@gmail.com> (Barbu Paul's message of "Wed, 10
 Apr 2013 17:59:37 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EC5274E-A20E-11E2-B2F9-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220718>

Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com> writes:

> Since GMail is SSL capable there is no need to set sslverify to false, the
> example using it may confuse readers that it's needed since it's also used in
> the previous example configurations, too
>
> Signed-off-by: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
> ---

Thanks.

While removing that item from the configuration is a good thing to
do in the post 1.8.2.1 era, the reason why it is does not have much
to do with "GMail is SSL capable".

The configuration item is not about "Do we connect over SSL when
talking to this host?", but is about "When we use SSL with this
host, do we verify the certificate it gave us?".

The reason why we can run with sslverify=true against gmail is
because we know imap.gmail.com gives a validly signed certificate
that leads all the way to a root CA the user's OpenSSL installation
is likely to trust (if your hand-rolled imap-over-ssl server uses a
snakeoil certificate, even though the server may be "SSL capable",
you may not be able to successfully connect to it without sslverify
turned off).

Side note.  Before 1.8.2 and/or 1.8.1.4, git-imap-send did not
implement sslverify correctly; CVS-2013-0308 was inherited from its
origin "isync", where it _did_ verify the certificate is valid, but
did not make sure the certificate was for the host it thought it was
talking with.

Also note that 1.8.2.1 and/or 1.8.1.6 were the first versions that
support Server Name Identification (RFC4366). Connection with older
versions of git-imap-send over SSL to hosts like googlemail.com that
multi-home different SSL hosts can receive a valid certificate for
another host that sits at the same IP address, which will lead to
the sslverify check to fail.

>  Documentation/git-imap-send.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
> index 875d283..b15dffe 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -123,7 +123,6 @@ to specify your account settings:
>  	host = imaps://imap.gmail.com
>  	user = user@gmail.com
>  	port = 993
> -	sslverify = false
>  ---------
>   You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
