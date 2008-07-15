From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Tue, 15 Jul 2008 23:38:51 +0000
Message-ID: <20080715233851.GA23672@spearce.org>
References: <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org> <20080715042553.GD2432@spearce.org> <487C5A2D.3000707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIu7b-0001FI-RH
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 01:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYGOXiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 19:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbYGOXiw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 19:38:52 -0400
Received: from george.spearce.org ([209.20.77.23]:43281 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbYGOXiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 19:38:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8DC793836B; Tue, 15 Jul 2008 23:38:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <487C5A2D.3000707@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88614>

Andreas Ericsson <ae@op5.se> wrote:
> I beat you to it ;-) This works just fine for me regardless of whether
> or not I have a colon in COMP_WORDBREAKS.
...
> Subject: git-completion.bash: Handle "rev:path" completion properly
...
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d268e6f..e138022 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -293,7 +293,11 @@ __git_complete_file ()
> 		*)
> 			ls="$ref"
> 			;;
> -	    esac
> +		esac
> +		# When completing something like 'rev:path', bash behaves
> +		# differently whether or not COMP_WORDBREAKS contains a
> +		# colon or not. This lets it handle both cases
> +		test "${COMP_WORDBREAKS//:}" = "$COMP_WORDBREAKS" && pfx="$ref:$pfx"
> 		COMPREPLY=($(compgen -P "$pfx" \
> 			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
> 				| sed '/^100... blob /s,^.*	,,

Yea, I did more or less the same thing in my patch, but I also
handled this fix in git-fetch and git-push.  The : is also used
there in a refspec and we support completion the right side of the
: in both cases (and yes, on git-push that can be slow as we do
network IO, possibly over SSH).

So I'm in favor of my patch over yours, but only because of
the fetch and push fixes as well.

-- 
Shawn.
