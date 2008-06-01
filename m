From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [Nikolaus Schulz] Re: [PATCH] git-svn fails in prop_walk if $self->{path} is not empty
Date: Sun, 1 Jun 2008 02:41:47 -0700
Message-ID: <20080601094147.GA16064@hand.yhbt.net>
References: <7v3anyf9pw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 11:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2k5g-0003fk-C0
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 11:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbYFAJlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 05:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYFAJlx
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 05:41:53 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56198 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757344AbYFAJlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 05:41:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 3DA022DC08B;
	Sun,  1 Jun 2008 02:41:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v3anyf9pw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83441>

Junio C Hamano <gitster@pobox.com> wrote:
> Ping?

Oops, missed this.  This looks right to me, (but haven't had time to
test to make sure this really works).

There is are minor spelling errors/typo in the commit message, which
I've noted below, though.

Unless Benoit steps in and objects:
  Acked-By: Eric Wong <normalperson@yhbt.net>

> Date:	Wed, 28 May 2008 00:54:02 +0200
> To:	git@vger.kernel.org
> Subject: Re: [PATCH] git-svn fails in prop_walk if $self->{path} is not empty
> Message-ID: <20080527225402.GA25550@penelope.zusammrottung.local>
> From:	Nikolaus Schulz <microschulz@web.de>
> 
> Happy coincidence!
> 
> This patch happens to fix my problem posted in "git-svn
> {show,create}-ignore chokes upon subdirs" today. 
> 
> Nikolaus
> 
> On Tue, May 27, 2008 at 08:46:55AM +0000, Gerrit Pape wrote:
> > From: Christian Engwer <christi@uni-hd.de>
> > 
> > The problem now is that prop_walk strips trunk from the path and then
> > calls itself recursively. But now trunk is missing in the path and
> > get_dir fails, because it is called for a non existing path.
> > 
> > The attached patch fixed the problem, by adding the priviously stipped
                                                      previously stripped
> > $self->{path} in the recursive call. 
> > git-svn repository for the commands show-ignore and show-external.
> > 
> > Patch was submitted through
> >  http://bugs.debian.org/477393
> > 
> > Signed-off-by: Gerrit Pape <pape@smarden.org>
> > ---
> > 
> > I'm not that much a git-svn user, and didn't test this thoroughly.  I'd
> > be happy if anyone could crossread/test this, and maybe add a Acked-By.
> > 
> > Thanks, Gerrit.
> > 
> > 
> >  git-svn.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 37976f2..72fef16 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1918,7 +1918,7 @@ sub prop_walk {
> >  
> >  	foreach (sort keys %$dirent) {
> >  		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
> > -		$self->prop_walk($p . $_, $rev, $sub);
> > +		$self->prop_walk($self->{path} . $p . $_, $rev, $sub);
> >  	}
> >  }
