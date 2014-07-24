From: Ross Boylan <ross@biostat.ucsf.edu>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 17:24:07 -0700
Message-ID: <1406161447.29001.235.camel@localhost>
References: <1406083743.29001.139.camel@localhost>
	 <53CF66D4.7060201@gmail.com> <1406143336.29001.185.camel@localhost>
	 <xmqqmwbzda80.fsf@gitster.dls.corp.google.com>
	 <1406158252.29001.223.camel@localhost>
	 <xmqqvbqnab1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:24:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA6pW-0000YY-SI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 02:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933737AbaGXAYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 20:24:11 -0400
Received: from upstrm185.psg-ucsf.org ([38.99.193.74]:37606 "EHLO
	biostat.ucsf.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933585AbaGXAYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 20:24:10 -0400
Received: from ns208-a-650ts.psg.net ([10.0.2.3]:46107 helo=[192.168.40.102])
	by biostat.ucsf.edu with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <ross@biostat.ucsf.edu>)
	id 1XA6pG-0001qc-QT; Wed, 23 Jul 2014 17:24:02 -0700
In-Reply-To: <xmqqvbqnab1n.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254142>

On Wed, 2014-07-23 at 16:51 -0700, Junio C Hamano wrote:
> Ross Boylan <ross@biostat.ucsf.edu> writes:
> 
> >> Either
> >> 
> >> 	git fetch origin master:refs/remotes/origin/master
> > Great; that works.
> > Is that procedure supposed to be the usual way I track upstream in this
> > (1.7) version of git?  It seems arcane.
> 
> No, and no.  
Good.  How should I handle getting updates from origin?
> The command is designed so that most of the time you
> can just say "git fetch<ENTER>" without anything extra, which will
> let the configured remote.*.fetch to kick in as the default refspec
> to slurp updates to all the branches.  This is because the branches
> of a single project are supposed to be related, and a single "git
> fetch" goes over a single network connection, establishment of which
> is expected to be a large overhead.  Letting a single invocation of
> "fetch" to slurp updates to _all_ the branches is supposed not to be
> too much overhead over grabbing updates to everything (let alone
> invoking a "git fetch" per each individual branch), and is the
> normal mode of operation.
> 
> A single-shot "git fetch origin master" to explicitly decline
> following of everything other than 'master' *is* the special case.
> 
> And it was a very conscious design decision not to molest the remote
> tracking branch when this kind of explicit command line request is
> made, so that you do not lose track of what commit you _saw_ before
> you ran the command.  That way "git log origin/master..FETCH_HEAD"
> can be used to inspect what got changed since you fetched last time.
> 
> Over the years, with reflogs enabled for everybody, preserving the
> remote tracking branches when the user does not explicitly ask to
> store the result has become much less important.  For this reason,
> modern Git applies, when it sees "git fetch origin master", the
> configured remote.*.fetch as refmap to map the name "master",
> i.e. the only branch you are fetching, to the remote tracking branch
> you use to store the result, i.e. "refs/remotes/origin/master".

For this case I think "get fetch" will attempt to retrieve from the
"personal" remote.

Will "get fetch origin" (with no other arguments) update all the
branches in origin, updating the remote tracking branches, particularly
in git 1.7?  

When I tried "git fetch origin" nothing happened (it returned
immediately with  no messages and git branch -v -a showed the same heads
as before).  It's quite possible none of the other branches have changed
since I last got them, so I don't think the exercise proves much.

Ross
