From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
	to "rebase-merge"
Date: Wed, 23 Jul 2008 03:13:41 +0200
Message-ID: <20080723011341.GE5904@leksak.fem-net>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com> <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx> <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness> <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org> <4882350B.6020003@free.fr> <7v3am5zfea.fsf@gitster.siamese.dyndns.org> <20080722234703.GD5904@leksak.fem-net> <7vbq0pifwq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Marin <dkr+ml.git@free.fr>, Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:14:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSwJ-0003KD-9I
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYGWBNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYGWBNr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:13:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58531 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751543AbYGWBNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:13:46 -0400
Received: (qmail invoked by alias); 23 Jul 2008 01:13:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp017) with SMTP; 23 Jul 2008 03:13:45 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+F1woI/FqFi3ky+aHxtUhfip3zVxIlmtAR6VB9B4
	VCZJrLOm236xQk
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLSvF-0005ZI-Bc; Wed, 23 Jul 2008 03:13:41 +0200
Content-Disposition: inline
In-Reply-To: <7vbq0pifwq.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89589>

Hi,

Junio C Hamano wrote:
> Stephan Beyer <s-beyer@gmx.net> writes:
> > Junio C Hamano wrote:
> >> Olivier Marin <dkr+ml.git@free.fr> writes:
> >> > @@ -203,9 +204,10 @@ then
> >> >  
> >> >  	case "$abort" in
> >> >  	t)
> >> > -		rm -fr "$dotest" &&
> >> > +		git rerere clear &&
> >> >  		git read-tree -m -u ORIG_HEAD &&
> > [...]
> >> diff --git a/git-am.sh b/git-am.sh
> >> index a44bd7a..5cbf8f4 100755
> >> --- a/git-am.sh
> >> +++ b/git-am.sh
> >> @@ -203,9 +203,9 @@ then
> >>  
> >>  	case "$abort" in
> >>  	t)
> >> -		rm -fr "$dotest" &&
> >> -		git read-tree -m -u ORIG_HEAD &&
> >> -		git reset ORIG_HEAD && :
> >> +		git rerere clear
> >> +		git read-tree --reset -u HEAD ORIG_HEAD
> >
> > Perhaps I am confused, but ...
> > Why is there "HEAD" and "ORIG_HEAD" and not only "ORIG_HEAD"?
> 
> Just being a bit defensive -- in this case I think it might be Ok to say
> "read-tree --reset -u ORIG_HEAD", but I haven't checked in a conflicted
> case.

Well, the test suite fails:
* FAIL 4: am --abort goes back after failed am

                        git-am --abort &&
                        git rev-parse HEAD >actual &&
                        git rev-parse initial >expect &&
                        test_cmp expect actual &&
  here>                 test_cmp file-2-expect file-2 &&
  ...                   git diff-index --exit-code --cached HEAD &&
                        test ! -f .git/rr-cache/MERGE_RR

* FAIL 7: am --abort goes back after failed am -3

                        git-am --abort &&
                        git rev-parse HEAD >actual &&
                        git rev-parse initial >expect &&
                        test_cmp expect actual &&
 and here>              test_cmp file-2-expect file-2 &&
                        git diff-index --exit-code --cached HEAD &&
                        test ! -f .git/rr-cache/MERGE_RR

So no reason to be defensive ;)

> If some path was added between ORIG_HEAD (that is where we started from)
> and HEAD (that is where we are and we decide we do not want it), and that
> path is conflicted in the index, a single tree form "read-tree --reset -u
> HEAD" would leave it behind in the working tree, wouldn't it?

Seems so.

The reason of my question was that I *blindly* incorporated the change into
sequencer to make it able to work on a dirty working tree and thus to be
able to migrate am onto it without losing the ability to apply patches
on a dirty working tree....
All am tests applied afterwards, but the sequencer and the rebase-i
test suite failed in a place where I didn't expect it. I *then* had
a deeper look at the read-tree line and I was wondering what the "HEAD"
should achieve.
I removed it and all tests passed. (I didn't have t4151 in my branch
at that point.)

Now, because t4151 does not pass, I am wondering what's the best thing
I could do...

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
