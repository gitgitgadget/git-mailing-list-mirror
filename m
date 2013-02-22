From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files (resubmit
 with reviewed-by)
Date: Fri, 22 Feb 2013 10:49:13 -0800
Message-ID: <7v7gm0dw0m.fsf@alter.siamese.dyndns.org>
References: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Joshua Clayton <stillcompiling@gmail.com>,
	Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:49:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8xgj-0003Ur-LP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 19:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab3BVStR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 13:49:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846Ab3BVStQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 13:49:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD96BCFC;
	Fri, 22 Feb 2013 13:49:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jp8nybqx9q3z1lmfM4qOS6PAxn4=; b=VDASIL
	waPDz1ACLPzzNVhoRMqrlwN4PILcDa7QxP0EVgQme0hnb+0yuCN62Fn18G2qf0kI
	2Rn6SB81x0YptW4ED4z4+H+su5bj1dP0qCmaZAxAoz7b0aRaBFo+VPd9lQHgVUrj
	HTz+lN4mHGPFrlW/X81w60YdXa9+WM0kKkR04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHweUqyDWT37L+IBBE0NJkgnS40tYkpi
	Jx37jxPWRZhDYKcH2M0KRTzELBBUjrCSFAFFWyp/DvPO3KUoQ7UoiZmSD9zFB8ZV
	X1yMegTYM4LR/58vBrjNpLXuEXZW2s4yr1M9Lq2df4PlEti7VW1sgM6/s99kSN5J
	yTWDPW9dh8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE806BCFB;
	Fri, 22 Feb 2013 13:49:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1543ABCFA; Fri, 22 Feb 2013
 13:49:14 -0500 (EST)
In-Reply-To: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com> (Joshua
 Clayton's message of "Fri, 22 Feb 2013 09:30:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E18ED80-7D20-11E2-85C1-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216853>

Joshua Clayton <stillcompiling@gmail.com> writes:

> Read and write each 1024 byte buffer, rather than trying to buffer
> the entire content of the file.
> Previous code would crash on all files > 2 Gib, when the offset variable
> became negative (perhaps below the level of perl), resulting in a crash.
> On a 32 bit system, or a system with low memory it might crash before
> reaching 2 GiB due to memory exhaustion.
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Jeff King <peff@peff.net>
> ---

Thanks.

>> Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files (resubmit with reviewed-by)

Please drop the () part.  A rule of thumb is to make "git show"
output understandable by people who read it 6 months from now.  They
do not care if the commit is a re-submission.

It seems that this issue was with us since the very beginning of
this sub since it was introduced at 7182530d8cad (Git.pm: Add
hash_and_insert_object and cat_blob, 2008-05-23).

>  perl/Git.pm |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 931047c..cc91288 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -949,13 +949,16 @@ sub cat_blob {
>                 last unless $bytesLeft;
>
>                 my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
> -               my $read = read($in, $blob, $bytesToRead, $bytesRead);
> +               my $read = read($in, $blob, $bytesToRead);
>                 unless (defined($read)) {
>                         $self->_close_cat_blob();
>                         throw Error::Simple("in pipe went bad");
>                 }
> -
>                 $bytesRead += $read;
> +               unless (print $fh $blob) {
> +                       $self->_close_cat_blob();
> +                       throw Error::Simple("couldn't write to passed
> in filehandle");
> +               }

Corrupt patch, line-wrapped by your MUA.

I wonder if we still need $bytesRead variable.  You have $size that
is the size of the whole blob, so

	my $bytesLeft = $size;
	while (1) {
		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
		my $bytesRead = read($in, $blob, $bytesToRead);
		... check errors and use the $blob ...
                $bytesLeft -= $bytesRead;
	}

may be simpler and easier to read, no?
