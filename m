From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 11:13:50 +0200
Message-ID: <vpqfvwlkqb5.fsf@anie.imag.fr>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
	<1371200178-9927-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 11:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnQ51-0003mv-UC
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 11:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab3FNJN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 05:13:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36481 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab3FNJNz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 05:13:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5E9Do0d007609
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 11:13:50 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UnQ4t-0005w6-6X; Fri, 14 Jun 2013 11:13:51 +0200
In-Reply-To: <1371200178-9927-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 14:26:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 14 Jun 2013 11:13:50 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227800>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -44,6 +44,7 @@ merge_args= edit=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short="${curr_branch#refs/heads/}"
>  rebase=$(git config --bool branch.$curr_branch_short.rebase)
> +autostash=$(git config --bool rebase.autostash)
>  if test -z "$rebase"
>  then
>  	rebase=$(git config --bool pull.rebase)
> @@ -203,6 +204,7 @@ test true = "$rebase" && {
>  			die "$(gettext "updating an unborn branch with changes added to the index")"
>  		fi
>  	else
> +		test true = "$autostash" ||
>  		require_clean_work_tree "pull with rebase" "Please commit or stash them."

Trivial, indeed!

It would be nice to have an --autostash command-line option too, and the
error message in "require_clean_work_tree" could suggest using it. That
would make the feature easily discoverable.

Perhaps this patch could mention "pull --rebase" in the doc, like (config.txt)

- 	ends.  This means that you can run rebase on a dirty worktree.
+ 	ends.  This means that you can run rebase or `git pull --rebase` on a dirty worktree.

(or perhaps it's obvious enough and not needed)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
