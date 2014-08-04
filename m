From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH RFC v2 05/19] rebase -i: Implement reword in terms of do_pick
Date: Mon, 04 Aug 2014 17:16:51 +0200
Message-ID: <vpqzjfki8t8.fsf@anie.imag.fr>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<a82fd64f943d4b59a01509ae52fc2d7a05d51f4a.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:17:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEK16-0003Hg-Pv
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 17:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaHDPRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 11:17:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47504 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbaHDPRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 11:17:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74FGoXh031702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 17:16:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74FGpRf003170;
	Mon, 4 Aug 2014 17:16:51 +0200
In-Reply-To: <a82fd64f943d4b59a01509ae52fc2d7a05d51f4a.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:47:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 17:16:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74FGoXh031702
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407770213.82024@2qppt4FnhumSe1AY320npQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254740>

Fabian Ruch <bafain@gmail.com> writes:

> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -555,20 +555,7 @@ do_next () {
>  		comment_for_reflog reword
>  
>  		mark_action_done
> -		do_pick $sha1 "$rest"
> -		# TODO: Work around the fact that git-commit lets us
> -		# disable either both the pre-commit and the commit-msg
> -		# hook or none. Disable the pre-commit hook because the
> -		# tree is left unchanged but run the commit-msg hook
> -		# from here because the log message is altered.
> -		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
> -			if test -x "$GIT_DIR"/hooks/commit-msg
> -			then
> -				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
> -			fi || {
> -				warn "Could not amend commit after successfully picking $sha1... $rest"
> -				exit_with_patch $sha1 1
> -			}
> +		do_pick --edit $sha1 "$rest"

I would have found this easier to review if squashed into the previous
patch. My reaction reading the previous patch was "Uh, why duplicate
code?", and reading this one "Ah, that's OK". A single patch doing both
would have avoided the confusion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
