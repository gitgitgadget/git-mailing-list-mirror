From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow the tag signing key to be specified in the config file
Date: Fri, 26 Jan 2007 22:37:47 -0800
Message-ID: <7vodolnfes.fsf@assigned-by-dhcp.cox.net>
References: <200701261413.46823.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 07:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAhCE-0003VF-AL
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 07:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbXA0Ghu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 01:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbXA0Ght
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 01:37:49 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54610 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbXA0Ght (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 01:37:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127063748.NMCA2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 01:37:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G6cq1W0041kojtg0000000; Sat, 27 Jan 2007 01:36:50 -0500
In-Reply-To: <200701261413.46823.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 26 Jan 2007 14:13:46 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37922>

Andy Parkins <andyparkins@gmail.com> writes:

> This patch adds a configuration entry "user.signingkey" which, if
> present, will be passed to the "-u" switch for gpg, allowing the tag
> signing key to be overridden.  If the entry is not present, the fallback
> is the original method, which means existing behaviour will continue
> untouched.


> diff --git a/git-tag.sh b/git-tag.sh
> index 94499c9..01e6526 100755
> --- a/git-tag.sh
> +++ b/git-tag.sh
> @@ -112,7 +112,11 @@ git-check-ref-format "tags/$name" ||
>  object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
>  type=$(git-cat-file -t $object) || exit 1
>  tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
> -: ${username:=$(expr "z$tagger" : 'z\(.*>\)')}
> +
> +keyid=$(git-repo-config user.signingkey)
> +if [ -z "$keyid" ]; then
> +	: ${keyid:=$(expr "z$tagger" : 'z\(.*>\)')}
> +fi


Why do you use ": ${parameter:=word}" substitution after having
already checked that keyid is empty, I wonder...  Am I missing
something subtle?

Other than that, I think what this patch does makes a lot of
sense.
