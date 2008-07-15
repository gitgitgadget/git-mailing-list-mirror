From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] bash: Teach the bash completion about 'git
	send-email'
Date: Tue, 15 Jul 2008 06:31:53 +0000
Message-ID: <20080715063153.GA3638@spearce.org>
References: <1216023662-9109-1-git-send-email-tlikonen@iki.fi> <20080715043839.GE2432@spearce.org> <20080715063034.GA3316@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jul 15 08:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIe5l-0000z7-CH
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 08:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbYGOGbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 02:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbYGOGby
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 02:31:54 -0400
Received: from george.spearce.org ([209.20.77.23]:37290 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbYGOGby (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 02:31:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B0E733836B; Tue, 15 Jul 2008 06:31:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080715063034.GA3316@mithlond.arda.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88531>

Teemu Likonen <tlikonen@iki.fi> wrote:
> Add the following long options to be completed with 'git send-email':
> 
>     --bcc --cc --cc-cmd --chain-reply-to --compose --dry-run
>     --envelope-sender --from --identity --in-reply-to
>     --no-chain-reply-to --no-signed-off-by-cc --no-suppress-from
>     --no-thread --quiet --signed-off-by-cc --smtp-pass --smtp-server
>     --smtp-server-port --smtp-ssl --smtp-user --subject --suppress-cc
>     --suppress-from --thread --to
> 
> Short ones like --to and --cc are not usable for actual completion
> because of the shortness itself and because there are longer ones which
> start with same letters (--thread, --compose). It's still useful to have
> these shorter options _listed_ when user presses TAB key after typing
> two dashes. It gives user an idea what options are available (and --to
> and --cc are probably the most commonly used).
> 
> Signed-off-by: Teemu Likonen <tlikonen@iki.fi>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks for the quick reply cleaning up the minor details.  :)


> Shawn O. Pearce wrote (2008-07-15 04:38 +0000):
> 
> > Don't use __git_complete_file here.  As far as I remember,
> > git-send-email does not accept "origin/maint:some.patch" as an email
> > to extract from Git prior to sending.  It looks for files in the local
> > filesystem.  So you want standard bash completion for anything not
> > starting with --.
> > 
> > Just use COMPREPLY=() at the end.  See _git_am for an example.
> 
> Done. And thanks.
> 
> > > +complete -o default -o nospace -F _git_send_email git-send-email
> 
> > Hmm.  With dash form commands gone in 1.6 we should remove these.
> > 
> > But I suspect this completion patch could be shipped in the next 1.5.6
> > maint release as its really quite trivial.  Junio, any comment on
> > that?
> 
> This is a for-1.6 version so the completion for dashed command
> (git-send-email) is dropped. I see Shawn already sent a patch which
> drops all those.
> 
> 
> 
>  contrib/completion/git-completion.bash |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d268e6f..48ebbf7 100755
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
> +	COMPREPLY=()
> +}
> +
>  _git_config ()
>  {
>  	local cur="${COMP_WORDS[COMP_CWORD]}"
> @@ -1376,6 +1394,7 @@ _git ()
>  	rebase)      _git_rebase ;;
>  	remote)      _git_remote ;;
>  	reset)       _git_reset ;;
> +	send-email)  _git_send_email ;;
>  	shortlog)    _git_shortlog ;;
>  	show)        _git_show ;;
>  	show-branch) _git_log ;;
> -- 
> 1.5.6.3.316.g01fc
> 

-- 
Shawn.
