From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 14:39:18 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212193918.GA17529@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
 <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 20:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrC6V-0002cR-U5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 20:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab3LLTjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 14:39:20 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41389
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3LLTjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 14:39:19 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 90392380445; Thu, 12 Dec 2013 14:39:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239241>

Martin Langhoff <martin.langhoff@gmail.com>:
> IIRC, making the output stable is nontrivial, specially on branches.
> Two cases are still in my mind, from when I was wrestling with cvsps.
> 
> 1 - For a history with CVS HEAD and a long-running "stable release"
> branch ("STABLE"), which branched at P1...
> 
>    a - adding a file only at the tip of STABLE "retroactively changes
> history"  for P1 and perhaps CVS HEAD
> 
>    b - forgetting to properly tag a subset of files with the branch
> tag, and doing it later retroactively changes history
> 
> 2 - you can create a new branch or tag with files that do not belong
> together in any "commit". Doing so changes history retroactively
> 
> ... when I say "changes history", I mean that the importers I know
> revise their guesses of what files were seen together in a 'commit'.
> This is specially true for history recorded with early cvs versions
> that did not record a 'commit id'.

Yikes!  That is a much stricter stability criterion than I thought you
were specifying.   No, cvs-fast-export probably doesn't satify all of these.
I think it would handle 1a in a stable way, but 1b and 2 would throw it.

I'm sure it can't be fooled in the presence of commitids, though,
because when it has those it doesn't try to do any similarity
matching.  And (this is the important point) it won't match any change
with a commit-id to any change without one.

What I think this means is that cvs-fast-export is stable if you are
using a server/client combination that generates commitids (that is,
GNU CVS of any version newer than 1.12 of 2004, or CVS-NT). It is
*not* necessary for stability that the entire history have them.

Here's how the logic works out:

1. Commits grouped by commitid are stable - nothing in CVS ever rewrites
those or assigns a duplicate.

2. No file change made with a commitid can destabilize a commit guess
made without them, because the similarity checker never tries to put both 
kinds in a single changeset.

Can you detect any flaw in this?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
