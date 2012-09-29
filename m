From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: use abbreviated sha1 in 'status' output
Date: Sat, 29 Sep 2012 16:31:49 +0200
Message-ID: <50670655.3030600@web.de>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com> <1348926195-4788-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 16:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THy5R-0005NK-NZ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 16:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab2I2Ob7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 10:31:59 -0400
Received: from mout.web.de ([212.227.15.3]:61947 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab2I2Ob7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 10:31:59 -0400
Received: from [192.168.178.41] ([91.3.175.36]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MA5qv-1TB8b23rxZ-00C2xF; Sat, 29 Sep 2012 16:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1348926195-4788-2-git-send-email-artagnon@gmail.com>
X-Provags-ID: V02:K0:hLQ0SOkaAc4R9mQT5Dyl5jGC1k0+gq2prUOp3LMpx9z
 Fn3oi5d0Eg2GExScoaOVGXwGu6EvoGipSZwJ2nKDpVQug7PDuc
 IhGuT1EKITZxnrYJZnoUpI8tx3awnPYnounjcoQREgZrmuYb2/
 T3tgvDKHpYraJ2IZaAJR+rgjcbvp8ilt56GN8XcIYWKGHvx6G4
 0KGYs48ZmDcliqiGavxJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206649>

I'm not against the change per se, but do we really want to risk breaking
scripts which parse the output of "git submodule status" without even
providing a commit message explaining why we did that?

Am 29.09.2012 15:43, schrieb Ramkumar Ramachandra:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-submodule.sh |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1d61ebd..f8efc52 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -942,27 +942,28 @@ cmd_status()
>  		name=$(module_name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
>  		displaypath="$prefix$sm_path"
> +		sha1_abbr=$(git rev-parse --short "$sha1")
>  		if test "$stage" = U
>  		then
> -			say "U$sha1 $displaypath"
> +			say "U$sha1_abbr $displaypath"
>  			continue
>  		fi
>  		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			say "-$sha1 $displaypath"
> +			say "-$sha1_abbr $displaypath"
>  			continue;
>  		fi
> -		set_name_rev "$sm_path" "$sha1"
> +		set_name_rev "$sm_path" "$sha1_abbr"
>  		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
>  		then
> -			say " $sha1 $displaypath$revname"
> +			say " $sha1_abbr $displaypath$revname"
>  		else
>  			if test -z "$cached"
>  			then
> -				sha1=$(clear_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
> -				set_name_rev "$sm_path" "$sha1"
> +				sha1_abbr=$(clear_local_git_env; cd "$sm_path" && git rev-parse --short --verify HEAD)
> +				set_name_rev "$sm_path" "$sha1_abbr"
>  			fi
> -			say "+$sha1 $displaypath$revname"
> +			say "+$sha1_abbr $displaypath$revname"
>  		fi
>  
>  		if test -n "$recursive"
> 
