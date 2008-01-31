From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: assume HEAD if no revision supplied
Date: Thu, 31 Jan 2008 00:16:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801310013010.23907@racer.site>
References: <47A0D0F0.1020800@nrlssc.navy.mil> <alpine.LSU.1.00.0801302034310.23907@racer.site> <7vk5lrgh56.fsf@gitster.siamese.dyndns.org> <47A109A7.1070502@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 31 01:17:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKN7e-0007qc-Hs
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 01:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755968AbYAaARL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 19:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbYAaARL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 19:17:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:43009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755229AbYAaARK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 19:17:10 -0500
Received: (qmail invoked by alias); 31 Jan 2008 00:17:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 31 Jan 2008 01:17:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vyfB5M+SvHeWVd2MirT6c6qgcamNgEoHP7eJepX
	/ZVPZBn2Ph6cLP
X-X-Sender: gene099@racer.site
In-Reply-To: <47A109A7.1070502@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72080>

Hi,

On Wed, 30 Jan 2008, Brandon Casey wrote:

> Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> >> On Wed, 30 Jan 2008, Brandon Casey wrote:
> >>
> >>> filter-branch previously took the first non-option argument as the name 
> >>> for a new branch. Since dfd05e38, it now takes a revision or a revision 
> >>> range and modifies the current branch. Update to operate on HEAD by 
> >>> default to conform with standard git interface practice.
> >> FWIW I think the code wanted to let "git filter-branch" without options 
> >> print the usage.
> > 
> > That might be a valid safety concern to some folks.  Previously
> > we have seen people say "Whenever I see a command foo that I do
> > not know what it does, I type 'foo <Enter>' and expect it gives
> > the usage back.  So any new destructive command 'foo' should not
> > do a damage by using built-in default." (I think it was about
> > "git stash" without parameter).
> > 
> > By the way, I do not personally think it is worth to be heavily
> > supportive to the practice of trying an unknown command without
> > understanding, and I do not agree such a safety is necessarily a
> > good idea, especially if it makes normal use of the command more
> > cumbersome by people who understand what it does.
> > 
> > Even though "git stash" itself is not destrictive, you need to
> > know its "apply" subcommand to undo the action.  In that sense,
> > it is destructive to clueless people who blindly type whatever
> > command they see.
> > 
> > That's why we still allow you to say "git stash", but we removed
> > its "git stash <randam message>" syntax, which was risky when
> > subcommand name was misspelled even by people who know what the
> > command does.  I think we struck a good balance between
> > usability and safety there.  And I think we can do the same
> > here.
> >
> > Perhaps "git filter-branch <Enter>" can be prevented as in the
> > current implementation while "git filter-branch --foo-filter
> > foo" can default to HEAD to satisfy both needs.  The command
> > without any filter is supposed to be mostly no-op (unless you
> > are trying to rewrite the history with grafts).
> 
> That's what I was trying to do :)

But then you would have to keep the test for $#, but enhance it like this:

case "$#,$filter_env,$filter_tree,$filter_index,$filter_parent,\
$filter_msg,$filter_commit,$filter_tag_name,$filter_subdir" in
0,,,,,cat,'git commit-tree "$@"',)
	usage
esac

Yes, it's ugly.

Another method would be having the test _before_ the while loop. ;-)

Ciao,
Dscho
