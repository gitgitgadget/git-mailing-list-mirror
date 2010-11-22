From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash completion: add basic support for git-reflog
Date: Mon, 22 Nov 2010 16:24:09 +0100
Message-ID: <20101122152409.GA7010@neumann>
References: <1290274368-3212-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 16:24:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKYFf-00061O-JW
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 16:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab0KVPYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 10:24:14 -0500
Received: from francis.fzi.de ([141.21.7.5]:46842 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755737Ab0KVPYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 10:24:13 -0500
Received: from localhost6.localdomain6 ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 22 Nov 2010 16:24:09 +0100
Content-Disposition: inline
In-Reply-To: <1290274368-3212-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 22 Nov 2010 15:24:09.0987 (UTC) FILETIME=[4F734D30:01CB8A59]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161898>

Hi,


On Sun, Nov 21, 2010 at 01:32:48AM +0800, Tay Ray Chuan wrote:
> Add basic completion for the three subcommands - show, expire, delete.
> Try completing refs for these too.

Heh, I've always thought reflog is plumbing, and that's why the
completion script doesn't support it.

> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  contrib/completion/git-completion.bash |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f710469..4007ca1 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1632,6 +1632,22 @@ _git_rebase ()
>  	__gitcomp "$(__git_refs)"
>  }
>  
> +_git_reflog ()
> +{
> +	local SUB_CMDS=(show delete expire)
> +	local cur="${COMP_WORDS[COMP_CWORD-1]}"
> +
> +	for val in ${SUB_CMDS[*]}; do
> +		if [[ "$val" == "$cur" ]]; then
> +			# this is a subcommand
> +			__gitcomp "$(__git_refs)"
> +			return

This only looks at the previous word on the command line, and leads to
wrong behavior when an option is used:

  $ git reflog expire --verbose <TAB><TAB>
  delete   expire   show     

To prevent this you could use the __git_find_on_cmdline() helper
function and follow how other completion functions use it.


> +		fi
> +	done
> +
> +	__gitcomp "${SUB_CMDS[*]}"
> +}
> +
>  __git_send_email_confirm_options="always never auto cc compose"
>  __git_send_email_suppresscc_options="author self cc bodycc sob cccmd body all"
>  
> -- 
> 1.7.3.2.496.g9c54
> 
> 
