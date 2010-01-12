From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] lockfile: show absolute filename in unable_to_lock_message.
Date: Tue, 12 Jan 2010 11:20:09 +0100
Message-ID: <vpq1vhvk4km.fsf@bauges.imag.fr>
References: <4B44DB6A.2050804@kdbg.org>
	<1262876050-345-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 12 11:23:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUdtv-0006Sv-0j
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 11:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0ALKW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 05:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924Ab0ALKW4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 05:22:56 -0500
Received: from imag.imag.fr ([129.88.30.1]:64517 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753910Ab0ALKWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 05:22:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0CAKAQq003876
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jan 2010 11:20:11 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NUdr8-0006tz-1J; Tue, 12 Jan 2010 11:20:10 +0100
In-Reply-To: <1262876050-345-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Thu\,  7 Jan 2010 15\:54\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 12 Jan 2010 11:20:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136712>

Just ping-ing ...

I think the patch makes sense. Junio, can you either queue the patch,
or argue against it? I promise I'll be nice if you chose the second
option ;-).

Thanks,

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> When calling a git command from a subdirectory and a file locking fails,
> the user will get a path relative to the root of the worktree, which is
> invalid from the place where the command is ran. Make it easy for the
> user to know which file it is.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>> Since these are merely informative, wouldn't it be more suitable to
>> use make_nonrelative_path()?
>
> Sensible, yes.
>
>  lockfile.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 6851fa5..b0d74cd 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -164,9 +164,10 @@ static char *unable_to_lock_message(const char *path, int err)
>  		    "If no other git process is currently running, this probably means a\n"
>  		    "git process crashed in this repository earlier. Make sure no other git\n"
>  		    "process is running and remove the file manually to continue.",
> -		    path, strerror(err));
> +			    make_nonrelative_path(path), strerror(err));
>  	} else
> -		strbuf_addf(&buf, "Unable to create '%s.lock': %s", path, strerror(err));
> +		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
> +			    make_nonrelative_path(path), strerror(err));
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -- 
> 1.6.6.81.gda96d0

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
