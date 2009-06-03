From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] Rename submodule.<name>.rebase to submodule.<name>.update
Date: Wed, 3 Jun 2009 06:15:44 +0200
Message-ID: <200906030615.45791.markus.heidelberg@web.de>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org> <1243983552-24810-2-git-send-email-johan@herland.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apenwarr@gmail.com, peter.hutterer@who-t.net
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 06:15:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBhtD-0005kL-Eo
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 06:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZFCEPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 00:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZFCEPh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 00:15:37 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:32883 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbZFCEPg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 00:15:36 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id AFEC6FEA0CB5;
	Wed,  3 Jun 2009 06:15:33 +0200 (CEST)
Received: from [89.59.123.189] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MBhsz-0006Ox-00; Wed, 03 Jun 2009 06:15:33 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1243983552-24810-2-git-send-email-johan@herland.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19Cmb1Ihrm3ktc+f+yINrzdHyxXSzuD61uyc9KJ
	Nn4qZ43HjaJSDBn1op4Cd5KZSVy26AVRm5Btl+VtaLR7r9SPkS
	z7W7s+6Maju1tQqTvdug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120580>

Johan Herland, 03.06.2009:
> The addition of "submodule.<name>.rebase" demonstrates the usefulness of
> alternatives to the default behaviour of "git submodule update". However,
> by naming the config variable "submodule.<name>.rebase", and making it a
> boolean choice, we are artificially constraining future git versions that
> may want to add _more_ alternatives than just "rebase".
> 
> Therefore, while "submodule.<name>.rebase" are not yet in a stable git
> release, future-proof it, by changing it from
> 
>   submodule.<name>.rebase = true/false
> 
> to
> 
>   submodule.<name>.update = checkout/rebase
> 
> where "checkout" specifies the default behaviour of "git submodule update"
> (checking out the new commit to a detached HEAD), and "rebase" specifies
> the --rebase behaviour (where the current local branch in the submodule is
> rebase onto the new commit). Thus .update == checkout is .rebase == false,
> and .update == rebase is equivalent to .rebase == false. Finally, leaving
                                                    ^^^^^
.rebase == true

> diff --git a/git-submodule.sh b/git-submodule.sh
> @@ -400,9 +400,9 @@ cmd_update()
>  			die "Unable to find current revision in submodule path '$path'"
>  		fi
>  
> -		if test true = "$rebase"
> +		if ! test -z "$update"

Isn't this simpler: if test -n "$update"
OTOH I think I have heard something about portability, but I'm not sure.

> @@ -420,16 +420,18 @@ cmd_update()
>  				die "Unable to fetch in submodule path '$path'"
>  			fi
>  
> -			if test true = "$rebase_module"
> -			then
> -				command="git-rebase"
> +			case "$update_module" in
> +			rebase)
> +				command="git rebase"

I think it is common practice to use the dashed form in scripts and this
patch shouldn't change it anyway.

>  				action="rebase"
>  				msg="rebased onto"
> -			else
> -				command="git-checkout $force -q"
> +				;;
> +			*)
> +				command="git checkout $force -q"

ditto
