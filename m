From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: Add long option completion for 'git send-email'
Date: Tue, 15 Jul 2008 04:38:39 +0000
Message-ID: <20080715043839.GE2432@spearce.org>
References: <1216023662-9109-1-git-send-email-tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIcKB-0007lk-W5
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYGOEil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 00:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYGOEil
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:38:41 -0400
Received: from george.spearce.org ([209.20.77.23]:35832 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbYGOEik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:38:40 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F10033836B; Tue, 15 Jul 2008 04:38:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1216023662-9109-1-git-send-email-tlikonen@iki.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88519>

Teemu Likonen <tlikonen@iki.fi> wrote:
> Add the following long options to be completed with 'git send-email':
...
> Short ones like --to and --cc are not usable for actual completion

I agree, these are worth including.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d268e6f..b15f3a9 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -905,6 +905,24 @@ _git_rebase ()
>  	__gitcomp "$(__git_refs)"
>  }
>  
> +_git_send_email ()
> +{
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "--bcc --cc --cc-cmd --chain-reply-to --compose
> +			--dry-run --envelope-sender --from --identity
> +			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
> +			--no-suppress-from --no-thread --quiet
> +			--signed-off-by-cc --smtp-pass --smtp-server
> +			--smtp-server-port --smtp-ssl --smtp-user --subject
> +			--suppress-cc --suppress-from --thread --to"
> +		return
> +		;;
> +	esac
> +	__git_complete_file

Don't use __git_complete_file here.  As far as I remember,
git-send-email does not accept "origin/maint:some.patch"
as an email to extract from Git prior to sending.  It looks
for files in the local filesystem.  So you want standard bash
completion for anything not starting with --.

Just use COMPREPLY=() at the end.  See _git_am for an example.

> @@ -1435,6 +1454,7 @@ complete -o default -o nospace -F _git_rebase git-rebase
>  complete -o default -o nospace -F _git_config git-config
>  complete -o default -o nospace -F _git_remote git-remote
>  complete -o default -o nospace -F _git_reset git-reset
> +complete -o default -o nospace -F _git_send_email git-send-email
>  complete -o default -o nospace -F _git_shortlog git-shortlog
>  complete -o default -o nospace -F _git_show git-show
>  complete -o default -o nospace -F _git_stash git-stash

Hmm.  With dash form commands gone in 1.6 we should remove these.

But I suspect this completion patch could be shipped in the next
1.5.6 maint release as its really quite trivial.  Junio, any comment
on that?

-- 
Shawn.
