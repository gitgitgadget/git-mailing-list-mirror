From: Bart Trojanowski <bart@jukie.net>
Subject: Re: [PATCH] Add git-rev-list --invert-match
Date: Thu, 20 Sep 2007 08:38:49 -0400
Message-ID: <20070920123849.GD12076@jukie.net>
References: <20070919202615.GK3076@jukie.net> <Pine.LNX.4.64.0709201132381.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 14:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYLJb-0004VL-Sz
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 14:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbXITMiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 08:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbXITMiw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 08:38:52 -0400
Received: from tachyon.jukie.net ([205.150.199.214]:47126 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752967AbXITMiv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 08:38:51 -0400
Received: from tau.jukie.net ([10.10.10.211]:40738)
	by jukie.net with esmtp (Exim 4.50)
	id 1IYLIw-0004X9-AJ; Thu, 20 Sep 2007 08:38:50 -0400
Received: by tau.jukie.net (Postfix, from userid 1000)
	id C69A4A75A10; Thu, 20 Sep 2007 08:38:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201132381.28395@racer.site>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58771>

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [070920 06:34]:
> On Wed, 19 Sep 2007, Bart Trojanowski wrote:
> >   git log --invert-match --grep="uninteresting"
> 
> IMHO this is only half a solution.  Some of us want to say "git log 
> --grep=this --but-not-(in-the-whole-message) --grep=that".

I have noticed that unique negation flags are getting scarce... we
already have --reverse, --inverse, and --not  mean something elsewhere.
--but-not maybe be good.

I also agree that git-grep could use this extension.

Anyways, I can see four solutions for adding "show me this but not that"
functionality to git-rev-list:

 1) adding a --but-not flag, as you suggested.  It separates positive
    matches that precede it with negative matches that follow.

  Example:
    git log --grep=this --but-not --grep=that --committer="${MY_EMAIL}"

 2) Adding --not-grep, --not-author, --not-committer which add negative
    matches.  Maybe even --grep!=PATTERN, --author!=PATTERN, ...

  Example:
    git log --grep=this --not-grep=that --committer!="${MY_EMAIL}"

 3) Extending the PATTERN we accept in --grep, --author, and --committer,
    such that a prefix in the pattern tells us how to use the match:
    --grep=!PATTERN

  Example:
    git log --grep=this --grep='!that' --committer="!${MY_EMAIL}"

 4) (going on a limb here) Can this kind of match be done with perl
    regular expressions?  Maybe we could use --perl-regexp

  Example:
    I've got nothing :)

Personally I am currently in favour of 2.  It seems intuitive, and
unlike option 3, the '!' cannot clash with the pattern.  Although 3 has
the bonus of allowing other flags like extended regexp, perl regexp,
case insensitive, negation, etc.

Comments?

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
