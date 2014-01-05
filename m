From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/2] git-submodule.sh: Support 'checkout' as a valid
	update command
Date: Sun, 5 Jan 2014 21:20:10 +0100
Message-ID: <20140105202009.GA3737@book.hvoigt.net>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 21:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzuBP-0001Ar-Fs
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 21:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbaAEUUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 15:20:23 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:35017 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaAEUUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 15:20:23 -0500
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzuBI-00048L-Qb; Sun, 05 Jan 2014 21:20:20 +0100
Content-Disposition: inline
In-Reply-To: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239970>

On Sun, Jan 05, 2014 at 03:50:48AM +0100, Francesco Pretto wrote:
> According to "Documentation/gitmodules.txt", 'checkout' is a valid
> 'submodule.<name>.update' command. Also "git-submodule.sh" refers to
> it and processes it correctly. Reflect commit 'ac1fbb' to support this
> syntax and also validates property values during 'update' command,
> issuing a warning if the value found is unknwon.

s/unknwon/unknown/

> ---
>  git-submodule.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2677f2e..1d041a7 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -622,7 +622,7 @@ cmd_init()
>  		   test -z "$(git config submodule."$name".update)"
>  		then
>  			case "$upd" in
> -			rebase | merge | none)
> +			checkout | rebase | merge | none)
>  				;; # known modes of updating
>  			*)
>  				echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
> @@ -805,6 +805,18 @@ cmd_update()
>  			update_module=$update
>  		else
>  			update_module=$(git config submodule."$name".update)
> +			case "$update_module" in
> +			'')
> +				;; # Unset update mode
> +			checkout | rebase | merge | none)
> +				;; # Known update modes
> +			!*)
> +				;; # Custom update command
> +			*)
> +				update_module=
> +				echo >&2 "warning: invalid update mode for submodule '$name'"

How about additionally telling the user the current value that is wrong
like this:

	echo >&2 "warning: invalid update mode '$update_module' for submodule '$name'"

?

But apart from those minor nits the patch looks good to me.

Cheers Heiko
