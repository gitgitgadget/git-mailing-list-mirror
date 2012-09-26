From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Teach git-completion about git p4
Date: Tue, 25 Sep 2012 20:48:38 -0400
Message-ID: <20120926004838.GA29907@padd.com>
References: <1348264271-99395-1-git-send-email-rcumming@ea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ryan Cumming <etaoins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGfo2-0007x2-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 02:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960Ab2IZAsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 20:48:42 -0400
Received: from honk.padd.com ([74.3.171.149]:42963 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab2IZAsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 20:48:41 -0400
Received: from arf.padd.com (unknown [50.55.128.112])
	by honk.padd.com (Postfix) with ESMTPSA id 9969262AF;
	Tue, 25 Sep 2012 17:48:40 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 50BAB313BC; Tue, 25 Sep 2012 20:48:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1348264271-99395-1-git-send-email-rcumming@ea.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206388>

etaoins@gmail.com wrote on Fri, 21 Sep 2012 14:51 -0700:
> git p4 was moved out of contrib in 1.7.11 but it git-completion didn't
> know about it. Add git p4 completion based on the existing SVN
> completion. It covers all known subcommands and options except for the
> -/ option for clone which doesn't use the standard -- prefix.

Very nice, thank you.  A couple nits.

> +_git_p4 ()
> +{
> +	local subcommands="
> +		clone sync rebase submit
> +		"
> +	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> +	if [ -z "$subcommand" ]; then
> +		__gitcomp "$subcommands"
> +	else
> +		local common_opts="--git-dir= --verbose"
> +		local sync_opts="
> +			--branch= --detect-branches --changes-file=

It's --changesfile (no dash), weird, but true.

> +			--silent --detect-labels --import-labels
> +			--import-local --max-changes= --keep-path
> +			--use-client-spec $common_opts
> +			"
> +		local clone_opts="
> +			--destination= --bare $sync_opts
> +			"
> +		local submit_opts="
> +			--origin= -M --preserve-user --export-labels
> +			$common_opts
> +			"

Very recently we added --dry-run and --prepare-p4-only and
--conflict to submit.  Follow 8db3865^2 to see the patches
for those.

> +		case "$subcommand,$cur" in
> +		clone,--*)
> +			__gitcomp "$clone_opts"
> +			;;
> +		sync,--*)
> +			__gitcomp "$sync_opts"
> +			;;
> +		rebase,--*)
> +			__gitcomp "$common_opts --import-labels"

This would be prettier if it had its own local rebase_opts.

> +		submit,--*)
> +			__gitcomp "$submit_opts"
> +			;;
> +		submit,*)
> +			__gitcomp "$(__git_refs)"
> +			;;
> +		esac
> +	fi
> +}
> +
>  _git_pull ()
>  {
>  	__git_complete_strategy && return
> -- 
> 1.7.12.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
