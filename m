From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sun, 15 Feb 2009 12:21:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151212320.10279@pacific.mpi-cbg.de>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org> <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com> <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org> <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 12:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYf4o-0007fS-R7
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 12:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZBOLUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 06:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbZBOLUx
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 06:20:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:53622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751638AbZBOLUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 06:20:52 -0500
Received: (qmail invoked by alias); 15 Feb 2009 11:20:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 15 Feb 2009 12:20:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HvEYTZMxHJA3bb0qWCnYJed3bvbE0xok7RmcQ5C
	yP0l0s64oREtAT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109993>

Hi,

On Sat, 14 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > - update-ref does _not_ interpret @{-<n>} as the branch name (which I 
> >   find okay, as update-ref is plumbing), but instead creates the file 
> >   '.git/@{-<n>}' (which I think is a bug).
> 
> I do not think it make any sense for update-ref to expand @{-1} to the
> name of the last branch,

As I said, I find the behavior okay.

> The particular plumbing command, following the example of recent 
> loosening the rule back to "HEAD is allowed to point outside 
> refs/heads/", should be allowed to create anything that passes 
> check_ref_format(), and perhaps bit more because we would need to allow 
> ".git/HEAD".

That was what I was referring to when talking about a bug.

> > Now, show-branch indeed does not substitute the branch _name_, but 
> > otherwise it works correctly, no?
> > otherwise it works correctly, no?  And given the fact that show-branch 
> > does not substitute "HEAD" with the current branch name, either,...
> 
> The tip commits come from get_sha1(), so obviously it would "work", but it
> does not show what branch it talks about.  HEAD is shown only when the
> user says HEAD (e.g. "git show-branch master HEAD") so I do not see much
> similarity there.

Well, it _is_ a substitution.  If you ask for "HEAD", you get "HEAD".  As 
a new user, if passing "@{-2}" to show-branch would not show "@{-2}", but 
DWIM the branch name, I would expect, really, that passing "HEAD" does the 
same sort of DWIMming for me.

In the name of consistency, I'd rather leave show-branch as it is.

However, IMO there is a much worse issue lurking: people might want to 
_know_ what "@{-2}" would expand to, _without_ switching branches.  At the 
moment, I can only think of

	git show -s --decorate --pretty=format:%d @{-2}

which is

- convoluted (I would not expect _any_ new user to think of this),

- wrong (it shows all the refs that point to the commit, not only the one 
  we wanted to find out).

And no, do not suggest using "git rev-parse --symbolic-full-name @{-2}", 
you know exactly what I think of teaching new users plumbing, and you know 
I am right in this respect.

Ciao,
Dscho
