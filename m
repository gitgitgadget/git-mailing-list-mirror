From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/3] completion: complete "unstuck" `git push
 --recurse-submodules`
Date: Tue, 22 Jul 2014 21:57:30 +0100
Message-ID: <20140722205730.GD26927@serenity.lan>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
 <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
 <xmqqr41df8hu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9h83-0004Cy-JX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 22:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbaGVU5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 16:57:40 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57556 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778AbaGVU5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 16:57:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 8CB4421847;
	Tue, 22 Jul 2014 21:57:38 +0100 (BST)
X-Quarantine-ID: <mYonPOrVVJue>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mYonPOrVVJue; Tue, 22 Jul 2014 21:57:37 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 27BF02181D;
	Tue, 22 Jul 2014 21:57:32 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqr41df8hu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254038>

On Tue, Jul 22, 2014 at 01:23:25PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Since the argument to `--recurse-submodules` is mandatory, it does not
> > need to be stuck to the option with `=`.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > Change since v1:
> >     - Fix typo --recurse{_ => -}submodules
> >     - Dropped previous patch 1/4 adding ";;" at the end of the "--repo" case
> >
> >  contrib/completion/git-completion.bash | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 7a6e1d7..bed3665 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1624,6 +1624,10 @@ __git_push_recurse_submodules="check on-demand"
> >  _git_push ()
> >  {
> >  	case "$prev" in
> > +	--recurse-submodules)
> > +		__gitcomp "$__git_push_recurse_submodules"
> > +		return
> > +		;;
> >  	--repo)
> >  		__gitcomp_nl "$(__git_remotes)"
> >  		return
> 
> If you mimick the order they are handled in the case on "$cur", it
> would also let us sneak in the missing-optional ";;" to case/esac to
> keep symmetry between the two ;-)
> 
> In other words, like this, perhaps?

Makes sense.  I don't think I noted the order in the "$cur" case, I just
put the new one in here so that they were sorted lexicographically.

Do you want me to re-roll with this change or can you replace the patch
while applying?

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 019026e..b27f385 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1617,6 +1617,11 @@ _git_push ()
>  	--repo)
>  		__gitcomp_nl "$(__git_remotes)"
>  		return
> +		;;
> +	--recurse-submodules)
> +		__gitcomp "$__git_push_recurse_submodules"
> +		return
> +		;;
>  	esac
>  	case "$cur" in
>  	--repo=*)
> -- 
> 2.0.2-892-g223db29
