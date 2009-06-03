From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/2] Rename submodule.<name>.rebase to
	submodule.<name>.update
Date: Wed, 3 Jun 2009 10:15:54 +1000
Message-ID: <20090603001553.GB27149@dingo.bne.redhat.com>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org> <1243983552-24810-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apenwarr@gmail.com, markus.heidelberg@web.de
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 02:16:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBeA2-0007Nq-R4
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 02:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbZFCAQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 20:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZFCAQq
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 20:16:46 -0400
Received: from leo.clearchain.com ([199.73.29.74]:64263 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbZFCAQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 20:16:45 -0400
Received: from leo.clearchain.com (localhost [127.0.0.1])
	by mail.clearchain.com (8.14.3/8.14.3) with ESMTP id n530GZmL034022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 09:46:35 +0930 (CST)
	(envelope-from peter.hutterer@who-t.net)
Received: (from whot@localhost)
	by leo.clearchain.com (8.14.3/8.14.3/Submit) id n530GYeq034021;
	Wed, 3 Jun 2009 09:46:34 +0930 (CST)
	(envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: whot set sender to peter.hutterer@who-t.net using -f
Content-Disposition: inline
In-Reply-To: <1243983552-24810-2-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (mail.clearchain.com [127.0.0.1]); Wed, 03 Jun 2009 09:46:35 +0930 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120564>

On Wed, Jun 03, 2009 at 12:59:11AM +0200, Johan Herland wrote:
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
> .update unset is equivalent to leaving .rebase unset.
> 
> In future git versions, other alternatives to "git submodule update"
> behaviour can be included by adding them to the list of allowable values
> for the submodule.<name>.update variable.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  Documentation/git-submodule.txt |    4 ++--
>  Documentation/gitmodules.txt    |   10 ++++++++--
>  git-submodule.sh                |   32 +++++++++++++++++---------------
>  t/t7406-submodule-update.sh     |   16 ++++++++--------
>  4 files changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index acd16ac..cd8e861 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -116,7 +116,7 @@ update::
>  	Update the registered submodules, i.e. clone missing submodules and
>  	checkout the commit specified in the index of the containing repository.
>  	This will make the submodules HEAD be detached unless '--rebase' is
> -	specified or the key `submodule.$name.rebase` is set to `true`.
> +	specified or the key `submodule.$name.update` is set to	`rebase`.
>  +
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in .gitmodules, you can automatically initialize the
> @@ -186,7 +186,7 @@ OPTIONS
>  	superproject. If this option is given, the submodule's HEAD will not
>  	be detached. If a a merge failure prevents this process, you will have
>  	to resolve these failures with linkgit:git-rebase[1].
> -	If the key `submodule.$name.rebase` is set to `true`, this option is
> +	If the key `submodule.$name.update` is set to `rebase`, this option is
>  	implicit.
>  
>  --reference <repository>::
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 7c22c40..1b67f0a 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -30,8 +30,14 @@ submodule.<name>.path::
>  submodule.<name>.url::
>  	Defines an url from where the submodule repository can be cloned.
>  
> -submodule.<name>.rebase::
> -	Defines that the submodule should be rebased by default.
> +submodule.<name>.update::
> +	Defines what to do when the submodule is updated by the superproject.
> +	If 'checkout' (the default), the new commit specified in the
> +	superproject will be checked out in the submodule on a detached HEAD.
> +	If 'rebase', the current branch of the submodule will be rebased onto
> +	the commit specified in the superproject.
> +	This config option is overridden if 'git submodule update' is given
> +	the '--rebase' option.
>  
>  
>  EXAMPLES
> diff --git a/git-submodule.sh b/git-submodule.sh
> index bbca183..19a3a84 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -18,7 +18,7 @@ quiet=
>  reference=
>  cached=
>  nofetch=
> -rebase=
> +update=
>  
>  #
>  # print stuff on stdout unless -q was specified
> @@ -311,10 +311,10 @@ cmd_init()
>  		git config submodule."$name".url "$url" ||
>  		die "Failed to register url for submodule path '$path'"
>  
> -		test true != "$(git config -f .gitmodules --bool \
> -			submodule."$name".rebase)" ||
> -		git config submodule."$name".rebase true ||
> -		die "Failed to register submodule path '$path' as rebasing"
> +		upd="$(git config -f .gitmodules submodule."$name".update)"
> +		test -z "$upd" ||
> +		git config submodule."$name".update "$upd" ||
> +		die "Failed to register update mode for submodule path '$path'"
>  
>  		say "Submodule '$name' ($url) registered for path '$path'"
>  	done
> @@ -345,7 +345,7 @@ cmd_update()
>  			;;
>  		-r|--rebase)
>  			shift
> -			rebase=true
> +			update="rebase"
>  			;;
>  		--reference)
>  			case "$2" in '') usage ;; esac
> @@ -379,7 +379,7 @@ cmd_update()
>  	do
>  		name=$(module_name "$path") || exit
>  		url=$(git config submodule."$name".url)
> -		rebase_module=$(git config --bool submodule."$name".rebase)
> +		update_module=$(git config submodule."$name".update)
>  		if test -z "$url"
>  		then
>  			# Only mention uninitialized submodules when its
> @@ -400,9 +400,9 @@ cmd_update()
>  			die "Unable to find current revision in submodule path '$path'"
>  		fi
>  
> -		if test true = "$rebase"
> +		if ! test -z "$update"
>  		then
> -			rebase_module=true
> +			update_module=$update
>  		fi
>  
>  		if test "$subsha1" != "$sha1"
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
>  				action="rebase"
>  				msg="rebased onto"
> -			else
> -				command="git-checkout $force -q"
> +				;;
> +			*)
> +				command="git checkout $force -q"
>  				action="checkout"
>  				msg="checked out"
> -			fi
> +				;;
> +			esac
>  
>  			(unset GIT_DIR; cd "$path" && $command "$sha1") ||
>  			die "Unable to $action '$sha1' in submodule path '$path'"
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 3442c05..0773fe4 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -76,9 +76,9 @@ test_expect_success 'submodule update --rebase staying on master' '
>  	)
>  '
>  
> -test_expect_success 'submodule update - rebase true in .git/config' '
> +test_expect_success 'submodule update - rebase in .git/config' '
>  	(cd super &&
> -	 git config submodule.submodule.rebase true
> +	 git config submodule.submodule.update rebase
>  	) &&
>  	(cd super/submodule &&
>  	  git reset --hard HEAD~1
> @@ -93,9 +93,9 @@ test_expect_success 'submodule update - rebase true in .git/config' '
>  	)
>  '
>  
> -test_expect_success 'submodule update - rebase false in .git/config but --rebase given' '
> +test_expect_success 'submodule update - checkout in .git/config but --rebase given' '
>  	(cd super &&
> -	 git config submodule.submodule.rebase false
> +	 git config submodule.submodule.update checkout
>  	) &&
>  	(cd super/submodule &&
>  	  git reset --hard HEAD~1
> @@ -110,9 +110,9 @@ test_expect_success 'submodule update - rebase false in .git/config but --rebase
>  	)
>  '
>  
> -test_expect_success 'submodule update - rebase false in .git/config' '
> +test_expect_success 'submodule update - checkout in .git/config' '
>  	(cd super &&
> -	 git config submodule.submodule.rebase false
> +	 git config submodule.submodule.update checkout
>  	) &&
>  	(cd super/submodule &&
>  	  git reset --hard HEAD^
> @@ -131,9 +131,9 @@ test_expect_success 'submodule init picks up rebase' '
>  	(cd super &&
>  	 git config submodule.rebasing.url git://non-existing/git &&
>  	 git config submodule.rebasing.path does-not-matter &&
> -	 git config submodule.rebasing.rebase true &&
> +	 git config submodule.rebasing.update rebase &&
>  	 git submodule init rebasing &&
> -	 test true = $(git config --bool submodule.rebasing.rebase)
> +	 test "rebase" = $(git config submodule.rebasing.update)
>  	)
>  '
>  
> -- 
> 1.6.3.rc0.1.gf800

I noticed this patch still leaves the --rebase commandline flag. Shouldn't
that be changed to --update=rebase for consistency?

Cheers,
  Peter
