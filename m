From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git branch -D: give a better error message when lockfile creation fails
Date: Sat, 26 Sep 2009 22:12:55 +0200
Message-ID: <vpqr5tt5ut4.fsf@bauges.imag.fr>
References: <1253972051-31980-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 22:16:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrdgV-0003eT-HA
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 22:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbZIZUPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZIZUPt
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 16:15:49 -0400
Received: from imag.imag.fr ([129.88.30.1]:64238 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbZIZUPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 16:15:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8QKCt0E000633
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 26 Sep 2009 22:12:55 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MrddX-0000cq-9D; Sat, 26 Sep 2009 22:12:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1MrddX-00063K-7p; Sat, 26 Sep 2009 22:12:55 +0200
In-Reply-To: <1253972051-31980-1-git-send-email-vmiklos@frugalware.org> (Miklos Vajna's message of "Sat\, 26 Sep 2009 15\:34\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 26 Sep 2009 22:12:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129176>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/refs.c b/refs.c
> index 24865cf..4eb4fc7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -972,8 +972,10 @@ static int repack_without_ref(const char *refname)
>  	if (!found)
>  		return 0;
>  	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
> -	if (fd < 0)
> +	if (fd < 0) {
> +		unable_to_lock_index(git_path("packed-refs"), errno, 0);
>  		return error("cannot delete '%s' from packed refs", refname);
> +	}

If unable_to_lock_index is called for something other that the index,
it should probably be renamed.

Other than that, I like what the patch does (I'm the one who wrote the
message for the index ;-) ).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
