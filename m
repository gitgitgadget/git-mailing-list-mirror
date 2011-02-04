From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git pull: Remove option handling done by fetch
Date: Fri, 4 Feb 2011 23:26:07 +0100
Message-ID: <201102042326.08607.j6t@kdbg.org>
References: <4D4C5EBC.2090100@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 04 23:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlU6t-0008UW-Vc
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 23:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab1BDW0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 17:26:30 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:46136 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751098Ab1BDW0a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 17:26:30 -0500
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 082EBCDFC3
	for <git@vger.kernel.org>; Fri,  4 Feb 2011 23:26:28 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9571D1000B;
	Fri,  4 Feb 2011 23:26:08 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C6A8819F5BF;
	Fri,  4 Feb 2011 23:26:08 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D4C5EBC.2090100@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166061>

On Freitag, 4. Februar 2011, Jens Lehmann wrote:
> In commits be254a0ea9 and 7dce19d374 the handling of the new fetch options
> "--[no-]recurse-submodules" had been added to git-pull.sh. This was not
> necessary because all options to "git fetch" are passed to it and handled
> there, so lets remove them.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> I noticed this while implementing the on-demand recursive fetch.
>
>  git-pull.sh |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index eb87f49..20a3bbe 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -38,7 +38,7 @@ test -z "$(git ls-files -u)" || die_conflict
>  test -f "$GIT_DIR/MERGE_HEAD" && die_merge
>
>  strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
> -log_arg= verbosity= progress= recurse_submodules=
> +log_arg= verbosity= progress=
>  merge_args=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short="${curr_branch#refs/heads/}"
> @@ -105,12 +105,6 @@ do
>  	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
>  		rebase=false
>  		;;
> -	--recurse-submodules)
> -		recurse_submodules=--recurse-submodules
> -		;;
> -	--no-recurse-submodules)
> -		recurse_submodules=--no-recurse-submodules
> -		;;
>  	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
>  		dry_run=--dry-run
>  		;;
> @@ -223,7 +217,7 @@ test true = "$rebase" && {
>  	done
>  }
>  orig_head=$(git rev-parse -q --verify HEAD)
>  -git fetch $verbosity $progress $dry_run $recurse_submodules 
> --update-head-ok "$@" || exit 1
>> +git fetch $verbosity $progress $dry_run 
> --update-head-ok "$@" || exit 1 test -z "$dry_run" || exit 0
>
>  curr_head=$(git rev-parse -q --verify HEAD)

Huh? What will, for example,

   git pull --recurse-submodules --no-ff origin

do before and after your patch? Doesn't your patch force users to 
write --[no-]recurse-submodules last?

-- Hannes
