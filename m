From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: different git-merge behavior with regard to submodules in
	1.6.2.4 vs. 1.6.2.1
Date: Tue, 28 Apr 2009 23:12:57 +0200
Message-ID: <20090428211257.GA31191@pvv.org>
References: <gt7err$3m4$1@ger.gmane.org> <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Olsen <tim@brooklynpenguin.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 23:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyueV-0006Nh-4P
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 23:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193AbZD1VNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756521AbZD1VNR
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 17:13:17 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:53216 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057AbZD1VNO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 17:13:14 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1Lyubp-0004ct-Rh; Tue, 28 Apr 2009 23:12:58 +0200
Content-Disposition: inline
In-Reply-To: <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117820>

On Tue, Apr 28, 2009 at 11:29:49AM -0700, Junio C Hamano wrote:
> Tim Olsen <tim@brooklynpenguin.com> writes:
> 
> > $ git merge origin/deployed
> > fatal: cannot read object 83055ffdddde60d41d9811aae77e78be50b329f8
> > 'rubydav': It is a submodule!
> >
> > Nothing in my history suggests that rubydav was at one point not a
> > submodule.
[...]
> > So then I downgraded to the last debian package of git which is 1.6.2.1.
> >  Now I get a result which is more approachable:
> >
> > $ git merge origin/deployed
> > Auto-merging rubydav
> > CONFLICT (submodule): Merge conflict in rubydav - needs
> > 167a344227c4745031d50a210869e6fb59a5ac03
> > Auto-merging server
> > CONFLICT (submodule): Merge conflict in server - needs
> > 82a74ae791c8563ca65f29187d2fe5ebfbc167ea
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > Both merges are from freshly checked out clones.
> >
> > Is this a bug in 1.6.2.4?  Please let me know what other information I
> > can provide to help debug the problem.
> 
> Thanks for a report.  I think the following commits are involved.
> 
>     39d8e27 simplify output of conflicting merge
>     0eb6574 update cache for conflicting submodule entries
>     f37ae35 add tests for merging with submodules
> 
> Clemens, these seem to be yours.  Thoughts?

The current error message is not an improvement I think, it should say
that merge does not support merging submodules, not complain about
being unable to read some object because it is a submodule.

I added the "CONFLICT (submodule) Merge conflict .. needs <SHA-1>"
messages when I tried to work with submodules a while (1-2 years?)
ago.  The intention was that you could enter the submodule(s), write
"git merge <SHA-1>", and resolve the conflict that way.

git is unfortunately not capable of merging submodules at all, so I
added these error messages to give me a hint about what I needed to do
in conflicting submodules to get something useful. I have used git a
lot more now, so maybe it is time to pick this up again and implement
proper recursive sub-module merging.

- Finn Arne
