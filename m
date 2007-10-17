From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 16 Oct 2007 23:20:10 -0400
Message-ID: <20071017032009.GS13801@spearce.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 17 05:20:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhzSP-0007Va-05
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 05:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291AbXJQDUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 23:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758412AbXJQDUR
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 23:20:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53743 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758291AbXJQDUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 23:20:15 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhzRw-0000KE-G8; Tue, 16 Oct 2007 23:20:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0864120FBC9; Tue, 16 Oct 2007 23:20:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071016195744.GB32132@closure.lan>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61323>

Theodore Tso <tytso@mit.edu> wrote:
> I've recently started trying to use some of the scripts in "todo" to
> send similar "What's cooking" messages, and started wondering if they
> were what Junio actually used in production to send his notes.  For
> example, the scripts don't work particularly well if the refs have
> been packed.  So I had to make changes such as these so they would
> work for me.

I think Junio just makes sure he doesn't pack his refs.  :-)
 
> diff --git a/PU b/PU
> index 4b4be2b..4643a42 100755
> --- a/PU
> +++ b/PU
> @@ -26,8 +26,8 @@ case "$#" in
>  0)
>  	# interactive ;-)
>  	shift
> -	HH=`cd .git/refs/heads && find -type f |
> -	sed -e 's/^\.\///' \
> +	HH=`git-show-ref --heads | awk '{print $2}' |\

Perhaps `git for-each-ref --format='%(refname)' refs/heads` is the
better change here as then you can avoid the pipe into awk.  We still
need the sed to strip the refs/heads/ off the results though.

> +	sed -e 's;refs/heads/;;' \
>  	    -e '/^naster$/d' -e '/^master$/d' -e '/^maint$/d' -e '/^pu$/d'`
>  	while test "$HH"
>  	do

I'm actually applying it with the show-ref variant and will wind up
pushing it into my tree later tonight.  Because I do pack my refs.

-- 
Shawn.
