From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 22:38:34 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131213033833.GB20850@thyrsus.com>
References: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
 <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
 <20131212193918.GA17529@thyrsus.com>
 <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
 <20131212205819.GA18166@thyrsus.com>
 <CACPiFCJDP6OVju2xzm2NWR5gc=bZDeNmXsD_MFH2mgHQru_u6Q@mail.gmail.com>
 <20131212230454.GA20054@thyrsus.com>
 <CACPiFCLJfefNaPYtCXd21fO-ztmaaX6xdz1TtcMdYc0y19t56g@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 04:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrJaa-0006Rd-1l
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 04:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab3LMDig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 22:38:36 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46120
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3LMDif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 22:38:35 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 1B9F0380459; Thu, 12 Dec 2013 22:38:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCLJfefNaPYtCXd21fO-ztmaaX6xdz1TtcMdYc0y19t56g@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239256>

Martin Langhoff <martin.langhoff@gmail.com>:
> On Thu, Dec 12, 2013 at 6:04 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> > I'm not sure what counts as a nonsensical branching point. I do know that
> > Keith left this rather cryptic note in a REAME:
> 
> Keith names exactly what we are talking about.

Oh, yeah, I figured that much out.  What I wasn't clear on was (a) whether
that's a complete description of "nonsensical branching point" or whether there
are other pathologies fundamentally *different* from that one.

I'm also not sure I have the end state of what cvs-fast-export does in that
case visualized correctly. When he says: "an entirely disjoint history will
be created containing the branch revisions and all parents back to the
root", I'm visualizing something like this:

  a----b----c----d----e----f----g----h
                  \
                   +----1----2----3---4

Suppose the root is a our pathological branch point is at d, then it
sounds like he's saying cvs-fast-export will produce a changeset DAG
that looks like this:

  a----b'---c'---d'---e----f----g----h
   \
    +----b''---c''---d''----1----2----3----4

What I'm not clear on here is how b is related to b' and b'', c to c' and c'',
and d to d' and d''.  Which file changes go to which commit?  I shall have to
craft some broken RCS files to find out.

Have I explained that I'm building a test suite?  I intend to know exactly
what the tool does in these cases and document it.

> Between my earlier explanation and Keith's notes it should be clear to
> you. It is absolutely trivial in CVS to have an "inconsistent"
> checkout (for example, if you switch branch with the -l parameter
> disabling recursion, or if you accidentally switch branch in a
> subdirectory).

That last one sounds easy to fall into and nasty. 

> On that inconsistent checkout, nothing prevents you from tagging it,
> nor from creating a new branch.
> 
> An importer with a 'consistent tree mentality' will look at the
> files/revs involved in that tag (or branching point) and find no tree
> to match.
> 
> CVS repos with that crap exist. x11/xorg did (Jim Gettys challenged me
> to try importing it at an LCA, after the Bazaar NG folks passed on
> it). Mozilla did as well.
> 
> 
> IMHO it is a valid path to skip importing the tag/branch. As long as
> main dev work was in HEAD, things end up ok (which goes back to my
> flying fish notes).

The other way to handle it would be to translate the history as though every
branch of a file subset had been an attempt to branch eveything.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
