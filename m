From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 19:14:02 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1210311613550.3197@iabervon.org>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info> <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com> <20121031185903.GA1480@elie.Belkin> <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 00:21:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TThao-0004Yz-C7
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 00:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab2JaXUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 19:20:49 -0400
Received: from iabervon.org ([66.92.72.58]:46368 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab2JaXUt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 19:20:49 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2012 19:20:48 EDT
Received: (qmail 32575 invoked by uid 1000); 31 Oct 2012 23:14:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2012 23:14:02 -0000
In-Reply-To: <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208855>

On Wed, 31 Oct 2012, Felipe Contreras wrote:

> Hi,
> 
> On Wed, Oct 31, 2012 at 7:59 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Felipe Contreras wrote:
> >> On Wed, Oct 31, 2012 at 7:20 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >
> >>> I just tested this with junio/next and it seems this issue is still
> >>> unfixed: instead of
> >>>
> >>>         reset refs/heads/blub
> >>>         from e7510461b7db54b181d07acced0ed3b1ada072c8
> >>>
> >>> I get
> >>>
> >>>         reset refs/heads/blub
> >>>         from :0
> >>>
> >>> when running "git fast-export ^master blub".
> >>
> >> That is not a problem. It has been discussed extensively, and the
> >> consensus seems to be that such command should throw nothing:
> >>
> >> http://article.gmane.org/gmane.comp.version-control.git/208729
> >
> > Um.  Are you claiming I have said that "git fast-export ^master blub"
> > should silently emit nothing?  Or has this been discussed extensively
> > with someone else?
> 
> Maybe I misunderstood when you said:
> > A patch meeting the above description would make perfect sense to me.
> 
> Anyway, when you have:
> 
> % git fast-export ^next next^{commit}
> # nothing
> % git fast-export ^next next~0
> # nothing
> % git fast-export ^next next~1
> # nothing
> % git fast-export ^next next~2
> # nothing
> 
> It only makes sense that:
> 
> % git fast-export ^next next
> # nothing
> 
> It doesn't get any more obvious than that. But to each his own.

I think that may be true where you have "next" in both places, but I  
think:

$ git checkout -b new-branch master
$ git fast-export ^master new-branch

ought to emit no "commit" lines, but needs to emit a "reset" line. After 
all, you haven't told fast-export that the ref "new-branch" is up to date, 
and you have told it that you want it to be exported. If you create a new 
branch off of an existing commit, don't change it, and push it to hg, it 
shouldn't be up to remote-hg to figure out what should happen with no 
input; it should get a:

reset refs/heads/new-branch
from [something]

I don't know why Johannes seems to want [something] not to be a mark 
reference (unless he's complaining about getting an invalid mark 
reference when there aren't any marks defined), but surely something of 
the above form is necessary to tell remote-hg to create the new branch.

I think it would be worth testing that:

$ git checkout -b new-branch master
$ git push hg new-branch

creates the new branch successfully (which I think it does, but wouldn't 
if "git fast-export ^master new-branch" actually returned nothing; 
parsed_refs gets it from the reset line).

AFAICT, your code relies on getting the behavior that fast-export actually 
gives, not the behavior you seem to want or the behavior Johannes seems to 
want. And the reason that you don't need any changes to fast-export is 
that your process maps marks instead of sha1s.

	-Daniel
*This .sig left intentionally blank*
