From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Mon, 14 Jul 2008 05:57:12 +0000
Message-ID: <20080714055712.GB15793@spearce.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 07:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIH4g-0003Qt-O0
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 07:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYGNF5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 01:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYGNF5N
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 01:57:13 -0400
Received: from george.spearce.org ([209.20.77.23]:35960 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYGNF5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 01:57:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E55563836B; Mon, 14 Jul 2008 05:57:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88379>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> > > 
> > > Does it fix this one too:
> > > 
> > > 	git show origin/pu:Makef<tab>
> > > 
> > > which totally screws up and becomes
> > > 
> > > 	git show Makefile
> > > 
> > > dropping the version specifier?
> 
> What version of bash do you have?

GNU bash, version 3.2.17(1)-release (i386-apple-darwin9.0)

> It definitely doesn't work for me with 
> 
> 	GNU bash, version 3.2.33(1)-release (x86_64-redhat-linux-gnu)

So between .17 and .33 they changed something.
 
> Something like this seems to be totally missing, and definitely required. 
> How can you say that it works for you? I don't see how that is possible 
> even in theory? Did you actually test it?

Yes, of course dammit, I did test it before writing an email that
said "I tested this ...".
 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 27332ed..0a87337 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -290,7 +290,7 @@ __git_complete_file ()
>  			ls="$ref"
>  			;;
>  	    esac
> -		COMPREPLY=($(compgen -P "$pfx" \
> +		COMPREPLY=($(compgen -P "$ref:$pfx" \
>  			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
>  				| sed '/^100... blob /s,^.*	,,
>  				       /^040000 tree /{

In bash 3.2.17 your change above causes completion to include the
ref name _twice_:

	git show jc/html:in<tab>
	git show jc/html:jc/html:index.html

This is not good news because it means we need to perform a version
test to identify the correct behavior we need for this shell, and
we also have to figure out what version of 3.2.X this changed in.
*sigh*

-- 
Shawn.
