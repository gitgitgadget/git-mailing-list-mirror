From: Mike Hommey <mh@glandium.org>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 18:38:47 +0900
Message-ID: <20160414093847.GA10852@glandium.org>
References: <20160413222919.GA10474@glandium.org>
 <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
 <20160413225234.GA21602@glandium.org>
 <vpqr3e8wo99.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 14 11:39:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqdjy-0003Xt-J0
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 11:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbcDNJjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 05:39:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:39498 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbcDNJjC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 05:39:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1aqdjb-00031b-D5; Thu, 14 Apr 2016 18:38:47 +0900
Content-Disposition: inline
In-Reply-To: <vpqr3e8wo99.fsf@anie.imag.fr>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291518>

On Thu, Apr 14, 2016 at 11:09:06AM +0200, Matthieu Moy wrote:
> I suspect you did:
> 
> $ git rebase -i
> # editor pops up
> # switch to another terminal and fetch from elsewhere
> # close editor

That's possible, but I don't remember with certainty. At least it's
plausible.

> Then only, git turns short sha1s into long ones, and does not have the
> information to resolve ambiguities.
> 
> We could save a map (short -> long) before poping the editor and use
> this map in priority when normalizing the todo-list to use long sha1s,
> but we currently don't.
> 
> But I'm tempted to say that you just went very, very unlucky, and it's
> not worth fixing ...

Yeah, that definitely is a weird corner case. Interestingly, it was
complaining about "error: short SHA1 e34ff55 is ambiguous." when apply
*other* commits that were in the list prior to it, and then had the
fatal error when it reached it.

That said, that would be less likely to happen if disambiguation was
also checking checking the object type. Collisions between commits are
less likely than between objects of different types.

As a matter of fact, of the 293143 commits in my repository, only 156
have collisions with other commits (0.05%), but when comparing them to
all the 3260854 objects in the repository, I see 3545 have collisions
(1.2%).

Mike
