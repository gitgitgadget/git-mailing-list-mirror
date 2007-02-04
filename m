From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/8] bash: Add space after unique command name is completed.
Date: Sun, 4 Feb 2007 03:13:01 -0500
Message-ID: <20070204081301.GE16766@spearce.org>
References: <20070204073827.GD17603@spearce.org> <7vr6t6xs3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 09:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDcUq-0005E0-Vw
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 09:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbXBDINJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 03:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbXBDINI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 03:13:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56274 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbXBDINH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 03:13:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HDcUg-0001WJ-Ng; Sun, 04 Feb 2007 03:13:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 18A1820FBAE; Sun,  4 Feb 2007 03:13:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr6t6xs3d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38667>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +__gitcomp ()
> > +{
> > +	local all c s=$'\n' IFS=' '$'\t'$'\n'
> > +	for c in $1; do
> > +		case "$c" in
> > +		--*=*) all="$all$c$s" ;;
> > +		*)     all="$all$c $s" ;;
> > +		esac
> > +	done
> > +	IFS=$s
> > +	COMPREPLY=($(compgen -W "$all" -- "${COMP_WORDS[COMP_CWORD]}"))
> > +	return
> > +}
> > +
> 
> I do not understand what is going on here.  Care to explain?
> 
>  (1) "for c in $1": because $1 is not dquoted, it is split into
>      word with IFS -- which IFS applies to this splitting?  The
>      local one you hand-define to the typical " \t\n" value?

Correct.
 
>  (2) when this function returns, what IFS value does the caller
>      would have?  Is the "local" used to avoid screwing up the
>      caller?
> 

Correct.


Basically at the time I'm forming 'all' I want $1 split based on
normal splitting rules, as I'm using space, tag and LF within the
script in some places for the first parameter to __gitcomp.

But when I run compgen I need IFS to be just LF ($s) so that $all
is split only on LF and not on spaces, as spaces were added to $all
after each unique option.  This way the trailing space is part of
the unique option, and bash will tack in the trailing space for me,
despite having -o nospace enabled.

-- 
Shawn.
