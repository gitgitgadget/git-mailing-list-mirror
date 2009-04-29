From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't crash if ai_canonname comes back as null
Date: Wed, 29 Apr 2009 16:21:27 -0700
Message-ID: <7v63gn59mw.fsf@gitster.siamese.dyndns.org>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
 <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
 <6B7EA51D-8412-4E6A-BA7B-156FD5B755E8@gmail.com>
 <81b0412b0904291504k3261df5fl692d09c6c761887e@mail.gmail.com>
 <C2AC0D7A-3E11-4A3A-8447-5D7582547B13@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Benjamin Kramer <benny.kra@googlemail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Augie Fackler <durin42@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 01:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzJ5z-0001VG-26
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 01:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZD2XVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 19:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbZD2XVf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 19:21:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZD2XVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 19:21:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DF9B9138C1;
	Wed, 29 Apr 2009 19:21:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B33A4138BB; Wed,
 29 Apr 2009 19:21:28 -0400 (EDT)
In-Reply-To: <C2AC0D7A-3E11-4A3A-8447-5D7582547B13@gmail.com> (Augie
 Fackler's message of "Wed, 29 Apr 2009 18:04:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7B1D70AA-3514-11DE-826C-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117977>

Augie Fackler <durin42@gmail.com> writes:

> Fixes a weird bug where git-daemon was segfaulting
> when started by sh(1) because ai_canonname was null.
> ---
> Fixed based on feedback.

Hmm.

I've been waiting for feedback to a patch proposed earlier in the same
area, which is <49F5BA55.3060606@googlemail.com> ($gmane/117670).  How
does this new one relate to it?

>  daemon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 13401f1..ae21d92 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -459,7 +459,7 @@ static void parse_extra_args(char *extra_args, int
> buflen)
>  				inet_ntop(AF_INET, &sin_addr->sin_addr,
>  					  addrbuf, sizeof(addrbuf));
>  				free(canon_hostname);
> -				canon_hostname = xstrdup(ai->ai_canonname);
> +				canon_hostname = ai->ai_canonname ?
> xstrdup(ai->ai_canonname) : NULL;
>  				free(ip_address);
>  				ip_address = xstrdup(addrbuf);
>  				break;
> --
> 1.6.2.GIT
