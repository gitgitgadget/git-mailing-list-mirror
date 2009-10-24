From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 12:25:40 -0700
Message-ID: <7vd44c61cb.fsf@alter.siamese.dyndns.org>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
 <20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
 <7vocnxajj6.fsf@alter.siamese.dyndns.org> <20091024091758.GF4615@mx.loc>
 <m28wf1unop.fsf@whitebox.home> <20091024100502.GG4615@mx.loc>
 <m2ocnxt6jl.fsf@whitebox.home> <m2ocnxuej2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 21:26:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1mFU-0002jY-6I
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 21:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbZJXTZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 15:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZJXTZv
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 15:25:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41560 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbZJXTZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 15:25:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0183765976;
	Sat, 24 Oct 2009 15:25:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uCQGV3kZmZ2Mmk1J+o3I80YN7DI=; b=hJdKvHAP3T9RgoX4+NlOLQw
	EKWae9uhBAIZb+E0i7cLGw0DGQFuTifQlTavPaVh8vrXvFqoC79puUWa7RJvSMeR
	UXP8gRgL+Dqk1FNh92LSw4n/bXF+hg8RbS/PtVysUbE2mKtUEtlOIikrjFDc698F
	WiMlEaEd7oocntOEIyUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=duhiyHaGV9UTclod4CziE/7bpvAhy+zVFOtfkb2gJmuT48db6
	5pNYOyzRBH/pMpWwv12hcV8ScIXVJH9eGu1/hCWo7Dn6otAnNy1eOqIVNZZgY2on
	zI+VkSfT+oK1qZj/FR7/wXasBUNiB6sKWApLnog9vlO6zt+n2lVUCbjcnc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A86DF65975;
	Sat, 24 Oct 2009 15:25:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC03965973; Sat, 24 Oct
 2009 15:25:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08D562DC-C0D3-11DE-9009-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131173>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Like this.

Yeah, correct and it beautifly explains the issue.  Thanks.

>>From ebadb41b346c305b94f27e3bb787bf0ba6bb8a5b Mon Sep 17 00:00:00 2001
> From: Andreas Schwab <schwab@linux-m68k.org>
> Date: Sat, 24 Oct 2009 15:01:03 +0200
> Subject: [PATCH] Work around option parsing bug in the busybox tar implementation
>
> Traditionally the first argument of the tar command was interpreted a
> bundle of letters specifying the mode of operation and additional options,
> with any option arguments taken from subsequent words on the command line
> as needed.  The implementation of tar in busybox apparently treats this
> bundle as if preceded by a dash and then parses it by getopt rules, which
> mishandles 'tar xfo -'.  Use 'tar xof -' instead which is parsed the same
> way by both traditional tar implementations and busybox.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  templates/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/templates/Makefile b/templates/Makefile
> index a12c6e2..408f013 100644
> --- a/templates/Makefile
> +++ b/templates/Makefile
> @@ -50,4 +50,4 @@ clean:
>  install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>  	(cd blt && $(TAR) cf - .) | \
> -	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
> +	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
> -- 
> 1.6.5.1
>
>
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
