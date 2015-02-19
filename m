From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [RFD/PATCH] stash: introduce checkpoint mode
Date: Thu, 19 Feb 2015 05:58:14 -0800
Message-ID: <8AAD6FE6-75C1-4BA2-8667-4DF8BF6B1EE4@gmail.com>
References: <54E5C27E.9060109@drmicha.warpmail.net> <dbd1aae0508bd72dc3b21fabda4c420eef487720.1424349039.git.git@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Armin Ronacher <armin.ronacher@active-4.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 14:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YORcc-0002jt-PG
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 14:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbbBSN6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 08:58:22 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39445 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbbBSN6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 08:58:18 -0500
Received: by pablf10 with SMTP id lf10so9670337pab.6
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 05:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=cbZW4JaonYqrPNyaAzIE19T09QmGYi04bu9/5C4Gzrs=;
        b=KYVD7D36iPDLr9F8NFVKcN7EOU8yp6DSdGDM1UMn4OKOvbfjOQ7afc+snKlqpCmA0r
         Uj6RKRC6NhIzcAEcg3T9tmBSLaVq4TiyUzVDEnXHzI3Y7cH4mOzqp2NgX2co0y9NO/5F
         aE84+8K92I09lZ9/80QNE1AKbFExbVD6TsAOUl2pi414LSEU6X5uVTZvqqBk1ySpmg//
         Qeh/5x4dRrVmMzz5eMVc/pIrpTqX4D+FyDAOVTaLmiK1ysdiI6npPgkXCvp49mcA0F7a
         LpIakrA5SIp5yI2rJEQSqWqvPWVvx8wfK5Y3EXGL2neFnIdisnSdCeEtg0ZwycIngrTs
         RzCg==
X-Received: by 10.68.197.10 with SMTP id iq10mr7635195pbc.143.1424354297297;
        Thu, 19 Feb 2015 05:58:17 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id pj7sm23749888pbb.96.2015.02.19.05.58.15
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Feb 2015 05:58:16 -0800 (PST)
In-Reply-To: <dbd1aae0508bd72dc3b21fabda4c420eef487720.1424349039.git.git@drmicha.warpmail.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264099>

On Feb 19, 2015, at 04:34, Michael J Gruber wrote:

> "git stash save" performs the steps "create-store-reset". Often,
> users try to use "stash save" as a way to to save their current state
> (index, worktree) before an operation like "checkout/reset --patch"  
> they
> don't feel confident about, and are forced to do "git stash save &&  
> git
> stash apply".
>
> Provide an extra mode that does "create-store" only without the reset,
> so that one can "ceckpoint" the sate and keep working on it.

s/sate/state/

> Suggested-by: "Kyle J. McKay" <mackyle@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>    I'm not sure about how to best expose this mode:
>
>    git stash checkpoint
>    git stash save --checkpoint
>
>    Maybe it is best to document the former and rename "--checkpoint"
>    to "--no-reset"?

Once the user figures out that "save" is really "save-and-reset" I  
think "--no-reset" makes more sense.

It certainly seems more discoverable via an explicit "checkpoint"  
command though, but that's really just an alias so maybe it's better  
left up to the user to make one.

There would need to be some updated docs (git-stash.txt) to go with  
the change...

>    Also, a "safe return" to a checkpoint probably requires
>
>    git reset --hard && git stash pop
>
>    although "git stash pop" will do in many cases. Should we provide  
> a shortcut
>    "restore" which does the reset-and-pop?

What about a shortcut to "reset-and-apply" as well?

I have often been frustrated when "git stash apply" refuses to work  
because I have changes that would be stepped on and there's no --force  
option like git checkout has.  I end up doing a reset just so I can  
run stash apply.

What about if git stash apply/pop grokked a --force option?  That  
would seem to eliminate the need for a "reset-and-pop"/"reset-and- 
apply" shortcut while also being useful to non-checkpoint stashes as  
well.

> git-stash.sh | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index d4cf818..42f140c 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -193,12 +193,16 @@ store_stash () {
> }
>
> save_stash () {
> +	checkpoint=
> 	keep_index=
> 	patch_mode=
> 	untracked=
> 	while test $# != 0
> 	do
> 		case "$1" in
> +		-c|--checkpoint)
> +			checkpoint=t
> +			;;
> 		-k|--keep-index)
> 			keep_index=t
> 			;;
> @@ -267,6 +271,11 @@ save_stash () {
> 	die "$(gettext "Cannot save the current status")"
> 	say Saved working directory and index state "$stash_msg"
>
> +	if test -n "$checkpoint"
> +	then
> +		exit 0
> +	fi
> +
> 	if test -z "$patch_mode"
> 	then
> 		git reset --hard ${GIT_QUIET:+-q}
> @@ -576,6 +585,10 @@ save)
> 	shift
> 	save_stash "$@"
> 	;;
> +checkpoint)
> +	shift
> +	save_stash "--checkpoint" "$@"
> +	;;
> apply)
> 	shift
> 	apply_stash "$@"
> -- 

Otherwise this looks good.  A very small change to add the  
functionality.

-Kyle
