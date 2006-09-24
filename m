From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] cg-commit: fix signed off handling
Date: Sun, 24 Sep 2006 20:32:46 +0200
Message-ID: <20060924183246.GA695@diku.dk>
References: <20060825002740.GH2817@diku.dk> <20060924174519.GW20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 20:33:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRYmh-00012h-10
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 20:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWIXSc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 14:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbWIXSc4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 14:32:56 -0400
Received: from [130.225.96.91] ([130.225.96.91]:65451 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1752116AbWIXScz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 14:32:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id C8D0F77003B;
	Sun, 24 Sep 2006 20:32:47 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05828-07; Sun, 24 Sep 2006 20:32:46 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 8D4AA770035;
	Sun, 24 Sep 2006 20:32:46 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2785A6DF88D; Sun, 24 Sep 2006 20:30:50 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 71DD662A3D; Sun, 24 Sep 2006 20:32:46 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060924174519.GW20017@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27686>

Petr Baudis <pasky@suse.cz> wrote Sun, Sep 24, 2006:
> Dear diary, on Fri, Aug 25, 2006 at 02:27:40AM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> said that...
> > Handle the sign off insertion before starting the CG: comment lines. Also,
> > fix typo in grepping for existing sign off lines.
> > 
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> > ---
> > 
> > The late calling of the add_signoff function has multiple problems,
> > since at that point comment lines has already been added and the sign
> > off line will end up in only one of the log message files.
> 
> Well, the commit that moved this was
> 
> Commit: 4cf220db10c0b937f9852513effc5565fcbb4f86
> Author: Petr Baudis <pasky@pixie.suse.cz> Thu, 20 Jul 2006 11:37:31 -0400
> 
>     * cg-commit:
> 
>     Add signoff past the message if getting it from stdin
> 
> What about this?

The thing you committed seems to work, so I am happy again. :) 

> diff --git a/cg-commit b/cg-commit
> index 43e6c6c..beedb6f 100755
> --- a/cg-commit
> +++ b/cg-commit
> @@ -402,10 +402,6 @@ if [ "$msgfile" ]; then
>  	written=1
>  fi
>  
> -# Always have at least one blank line, to ease the editing for
> -# the poor people whose text editor has no 'O' command.
> -[ "$written" ] || { tty -s && echo >>"$LOGMSG"; }
> -
>  add_signoff() {
>  	if [ "$signoff" ] && ! grep -q -i "signed-off-by: $signoff" $LOGMSG; then
>  		grep -q -i sign-off-by $LOGMSG || echo
			   ^^^^^^^^^^^

My patch also fixed this to grep for "signed-off-by".

-- 
Jonas Fonseca
