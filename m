From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 18:22:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171821190.6185@intel-tinevez-2-302>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>  <7veixxaale.fsf@gitster.siamese.dyndns.org>  <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>  <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>  <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
  <7vy6w5795h.fsf@gitster.siamese.dyndns.org> <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:24:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTgL-0002zU-B3
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbZBQRXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZBQRW7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:22:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:36395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752195AbZBQRW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:22:59 -0500
Received: (qmail invoked by alias); 17 Feb 2009 17:22:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 17 Feb 2009 18:22:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/buLowHKjbWMz+fODP/wJxHo/BkxaTWaETmC7YdZ
	SDYC4D0m9kEODY
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902170914p6258b77ak81318f13757f0dfd@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110416>

Hi,

On Tue, 17 Feb 2009, Jay Soffian wrote:

> On Tue, Feb 17, 2009 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Now to something totally useless.
> >
> > After reading the builtin-merge.c and original git-merge.sh (now in
> > contrib/examples) script, I think it could have done something entirely
> > different.
> >
> > It could have done this instead.
> >
> >        sed -e '/       not-for-merge   /d'
> >
> > to learn the commits and their human-readable origins, and it could have
> > tried to reproduce what "git pull" did when it invoked git-merge using
> > that information.  Then you could use this workflow:
> >
> >        $ git pull <possibly with arguments>
> >        ... oops, conflicted and is very messy.
> >        ... I tried to resolve, but failed and made the mess even worse.
> >        ... Let's start over.
> >        $ git reset --hard
> >        ... FETCH_HEAD knows which refs are for merging
> >        $ git merge FETCH_HEAD
> >
> > That is, no matter what the arguments were for the initial "git pull",
> > what should be merged is recorded in FETCH_HEAD, and that is how you can
> > retry the merge without refetching over the network.
> >
> > But such a change makes FETCH_HEAD different from what it traditionally
> > meant, and does that only to "git merge", making the result very
> > inconsistent.  For example, "git log ..FETCH_HEAD" will still use the
> > object name on the first line, and it won't be a way to convince yourself
> > that the changes are sensible and it is Ok to run "git merge FETCH_HEAD"
> > anymore.  So I do not think such a change will be an improvement.
> 
> Unless dwim_ref() is updated to handle FETCH_HEAD specially, and
> return not the first SHA1, but the one not marked "not-for-merge".
> Then the UI would at least be consistent, but this would not be
> backward compatible.

You cannot fix parsing FETCH_HEAD as a ref (and neither will you be able 
to do with PUSH_HEAD), as it can contain _more_ than one SHA-1s.  This 
still holds true when ignoring the not-for-merge lines, as an octopus is
a quite real possibility.

Ciao,
Dscho
