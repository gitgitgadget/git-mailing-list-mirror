From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Trim leading / off of paths in git-svn prop_walk
Date: Wed, 9 Jan 2008 14:55:32 -0800
Message-ID: <20080109225532.GA31363@untitled>
References: <1199860640-74118-1-git-send-email-kevin@sb.org> <7v63y2hg8x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Benoit Sigoure <tsuna@lrde.epita.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCjq7-0003cd-AX
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 23:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYAIWze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 17:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbYAIWze
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 17:55:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36058 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbYAIWzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 17:55:33 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A4D472DC08B;
	Wed,  9 Jan 2008 14:55:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v63y2hg8x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70022>

Junio C Hamano <gitster@pobox.com> wrote:
> Kevin Ballard <kevin@sb.org> writes:
> 
> > prop_walk adds a leading / to all subdirectory paths. Unfortunately
> > this causes a problem when the remote repo lives in a subdirectory itself,
> > as the leading / causes subsequent PROPFIND calls to be executed on
> > the wrong path. Trimming the / before calling the PROPFIND fixes this problem.
> >
> > Signed-off-by: Kevin Ballard <kevin@sb.org>
> 
> Eric, the change is very limited in scope (only the parameter to
> ra->get_dir() changes) so I can apply myself, if you agree this
> is a trivially correct fix.  I just do not know svn-perl
> interface well enough to judge.

Yes it is.  It appears this regression was introduced in
01bdab84e31763a98206c31cf99b9dc3cb221356 so yes, it's trivially
correct :)

Acked-by: Eric Wong <normalperson@yhbt.net>

> 
> > All tests passed after this change, but since it seems to only apply
> > to WebDAV SVN repos I saw no way to add a new test.
> >  git-svn.perl |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 3308fe1..d5316eb 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1858,6 +1858,7 @@ sub rel_path {
> >  sub prop_walk {
> >  	my ($self, $path, $rev, $sub) = @_;
> >  
> > +	$path =~ s#^/##;
> >  	my ($dirent, undef, $props) = $self->ra->get_dir($path, $rev);
> >  	$path =~ s#^/*#/#g;
> >  	my $p = $path;
> > -- 
> > 1.5.4.rc2.68.ge708a-dirty

-- 
Eric Wong
