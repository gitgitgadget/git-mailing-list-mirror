From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule update: when using recursion, show full path
Date: Fri, 22 Feb 2013 20:17:48 +0100
Message-ID: <5127C45C.2020204@web.de>
References: <CAFwrLX7CroJ1Au-w0G7jo7F7DAu5=u2E6iVc9YUTLytVBuHVhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Stefan Zager <szager@google.com>
To: Will Entriken <fulldecent@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8y8R-00069X-A5
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 20:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089Ab3BVTRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 14:17:54 -0500
Received: from mout.web.de ([212.227.15.4]:65213 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757077Ab3BVTRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 14:17:53 -0500
Received: from [192.168.178.41] ([91.3.179.163]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0M5x4z-1V5uX00gsT-00yKwW; Fri, 22 Feb 2013 20:17:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <CAFwrLX7CroJ1Au-w0G7jo7F7DAu5=u2E6iVc9YUTLytVBuHVhw@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:Db7u2FaND7L0ladt0iMIER6o+Rw5/ModoAmdRk3jsGC
 B+qkUMxZoRCHRC99WT9SNPCwKY6NELvIPzuQMm9G/V1JAdIKzU
 DcX0Va8ZDTEKLLLVmkac6XLlLPN46a+MflFMw40bAV0b135Qkz
 xh5Z9QdN+bFoerPk/0P1YE5t4cuDCIGsxPwAFblt1hrZGuH23+
 ErsWq4EqH7aQT1n207eZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216856>

Thanks. Your code changes are looking good and the commit message
explains what you did and why you did it. A few comments below.

Am 22.02.2013 05:25, schrieb Will Entriken:
>>From d3fe2c76e6fa53e4cfa6f81600685c21bdadd4e3 Mon Sep 17 00:00:00 2001
> From: William Entriken <github.com@phor.net>
> Date: Thu, 21 Feb 2013 23:10:07 -0500
>
> Subject: [PATCH] submodule update: when using recursion, show full path

The lines above aren't necessary as they are taken from the mail header.

> Previously when using update with recursion, only the path for the
> inner-most module was printed. Now the path is printed from GIT_DIR.

You should replace "from GIT_DIR" with something like "relative to the
directory the recursion started in" here.

> This now matches the behavior of submodule foreach

Please add a '.' at the end of the sentence.

> ---
> 
> First patch. Several tests failed, but they were failing before I
> started. This is against maint, I would consider this a (low priority)
> bug.

Strange that you have failing tests, for me everything runs fine (With
or without your patch). But I agree that this is a low priority bug.

> How does it look? Please let me know next steps.

This patch does not apply due to removed leading whitespaces and a
few wrapped lines. Please see Documentation/git-format-patch.txt on
how to convince the mailer of your choice to send the patch out
unmangled.

> Signed-off-by: William Entriken <github.com@phor.net>

The Signed-off-by belongs just before the "---" line above, as
everything between "---" and the line below won't make it into the
commit message.

>  git-submodule.sh | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2365149..f2c53c9 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -588,7 +588,7 @@ cmd_update()
>   die_if_unmatched "$mode"
>   if test "$stage" = U
>   then
> - echo >&2 "Skipping unmerged submodule $sm_path"
> + echo >&2 "Skipping unmerged submodule $prefix$sm_path"
>   continue
>   fi
>   name=$(module_name "$sm_path") || exit
> @@ -602,7 +602,7 @@ cmd_update()
> 
>   if test "$update_module" = "none"
>   then
> - echo "Skipping submodule '$sm_path'"
> + echo "Skipping submodule '$prefix$sm_path'"
>   continue
>   fi
> 
> @@ -611,7 +611,7 @@ cmd_update()
>   # Only mention uninitialized submodules when its
>   # path have been specified
>   test "$#" != "0" &&
> - say "$(eval_gettext "Submodule path '\$sm_path' not initialized
> + say "$(eval_gettext "Submodule path '\$prefix\$sm_path' not initialized
>  Maybe you want to use 'update --init'?")"
>   continue
>   fi
> @@ -624,7 +624,7 @@ Maybe you want to use 'update --init'?")"
>   else
>   subsha1=$(clear_local_git_env; cd "$sm_path" &&
>   git rev-parse --verify HEAD) ||
> - die "$(eval_gettext "Unable to find current revision in submodule
> path '\$sm_path'")"
> + die "$(eval_gettext "Unable to find current revision in submodule
> path '\$prefix\$sm_path'")"
>   fi
> 
>   if test "$subsha1" != "$sha1" -o -n "$force"
> @@ -643,7 +643,7 @@ Maybe you want to use 'update --init'?")"
>   (clear_local_git_env; cd "$sm_path" &&
>   ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>   test -z "$rev") || git-fetch)) ||
> - die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> + die "$(eval_gettext "Unable to fetch in submodule path '\$prefix\$sm_path'")"
>   fi
> 
>   # Is this something we just cloned?
> @@ -657,20 +657,20 @@ Maybe you want to use 'update --init'?")"
>   case "$update_module" in
>   rebase)
>   command="git rebase"
> - die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path
> '\$sm_path'")"
> - say_msg="$(eval_gettext "Submodule path '\$sm_path': rebased into '\$sha1'")"
> + die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path
> '\$prefix\$sm_path'")"
> + say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': rebased
> into '\$sha1'")"
>   must_die_on_failure=yes
>   ;;
>   merge)
>   command="git merge"
> - die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path
> '\$sm_path'")"
> - say_msg="$(eval_gettext "Submodule path '\$sm_path': merged in '\$sha1'")"
> + die_msg="$(eval_gettext "Unable to merge '\$sha1' in submodule path
> '\$prefix\$sm_path'")"
> + say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': merged
> in '\$sha1'")"
>   must_die_on_failure=yes
>   ;;
>   *)
>   command="git checkout $subforce -q"
> - die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule
> path '\$sm_path'")"
> - say_msg="$(eval_gettext "Submodule path '\$sm_path': checked out '\$sha1'")"
> + die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule
> path '\$prefix\$sm_path'")"
> + say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked
> out '\$sha1'")"
>   ;;
>   esac
> 
> @@ -688,11 +688,16 @@ Maybe you want to use 'update --init'?")"
> 
>   if test -n "$recursive"
>   then
> - (clear_local_git_env; cd "$sm_path" && eval cmd_update "$orig_flags")
> + (
> + prefix="$prefix$sm_path/"
> + clear_local_git_env
> + cd "$sm_path" &&
> + eval cmd_update "$orig_flags"
> + )
>   res=$?
>   if test $res -gt 0
>   then
> - die_msg="$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
> + die_msg="$(eval_gettext "Failed to recurse into submodule path
> '\$prefix\$sm_path'")"
>   if test $res -eq 1
>   then
>   err="${err};$die_msg"
> --
> 1.7.11.3
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
