From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sat, 14 Feb 2009 12:44:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902141241270.10279@pacific.mpi-cbg.de>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>  <1234578258-48870-1-git-send-email-git@randomhacks.net>  <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>  <431341160902132117s1696c975mbf20dfbdc65a7df3@mail.gmail.com>
 <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Kidd <git@randomhacks.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 12:45:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYIxi-0002bq-Kl
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 12:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbZBNLoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 06:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbZBNLoE
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 06:44:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:59830 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751337AbZBNLoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 06:44:02 -0500
Received: (qmail invoked by alias); 14 Feb 2009 11:44:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 14 Feb 2009 12:44:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18zizJVX4gzi9llglP/qYxQaKUW0/Fe6uWzlWX3u6
	0Ak+Bl7xEr7G2e
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8c5c35580902140103o3e5dd091qe2a18ca52b6fe44a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109861>

Hi,

On Sat, 14 Feb 2009, Lars Hjemli wrote:

> On Sat, Feb 14, 2009 at 06:17, Eric Kidd <git@randomhacks.net> wrote:
> > On Fri, Feb 13, 2009 at 11:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Eric Kidd <git@randomhacks.net> writes:
> >>> ...
> >>> If the submodule has moved around the source tree, specify one or more
> >>> values for alternate_dir.  To specify the URL of the newly created
> >>> repository (for use in .gitmodules), use the --url parameter.
> >>
> >> Unfortunately, I do not think we have designed fully (nor implemented at
> >> all) behaviour to check out different points of history that has the same
> >> submodule moved around in the superproject tree.
> >>
> >> There were several unconcluded discussions done in the past (and I admit I
> >> participated in a few of them), but it may be hard to use the resulting
> >> repository out of this tool.
> >
> > Thank you for looking at this proposal!
> >
> > I think that the resulting repository is usable (though it could
> > certainly be better). In particular, the following commands will
> > always give you a working checkout:
> >
> >  git checkout any-version
> >  git submodule update --init
> >
> > The unit tests for git-submodule-split.sh actually walk through the
> > entire history and run 'git submodule update --init' at each revision.
> > This works correctly because git-submodule-split creates the necessary
> > .gitmodules entries for each revision, and includes the
> > submodule.*.url value that you specify.
> >
> > Unfortunately, this means that whenever the submodule moves to a new
> > location in the tree, 'git submodule --init' will actually have to
> > clone it again. That's not a perfect situation, but it will work for
> > reasonably small submodules.
> 
> <hand-waving>
> I didn't look at the patch, but if the submodule uses a single
> module-name while moving around, the re-cloning problem would by
> solved if the submodule git-dir was stored inside the git-dir of the
> containing repository  (by using the git-file mechanism). Maybe I
> should try to finally implement this...
> </hand-waving>

How should that help with the _working directory_ of the submodule?  After 
all, _that_ is the part we are having with, as the untracked files in that 
directory _are_ part of the submodule.

The real kicker is that when we want to "git submodule checkout" the 
(moved) submodule, we no longer know where it was found last time (and 
where it still is).  We need a sane semantic for that (and I think it 
involves the addition of submodule.<name>.path to the superproject's 
config, something we do not do yet).

Ciao,
Dscho
