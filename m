From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-bisect annoyances
Date: Fri, 11 Apr 2008 13:41:04 +0200
Message-ID: <20080411114104.GE9205@elte.hu>
References: <20080409101428.GA2637@elte.hu> <20080410114739.GA15229@elte.hu> <200804110741.40732.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Apr 11 13:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkHdq-0007dJ-9H
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 13:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759718AbYDKLlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 07:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759677AbYDKLlS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 07:41:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40080 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759343AbYDKLlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 07:41:17 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JkHcx-0002RW-9l
	from <mingo@elte.hu>; Fri, 11 Apr 2008 13:41:15 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 1BAFA3E21D8; Fri, 11 Apr 2008 13:41:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200804110741.40732.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79272>


* Christian Couder <chriscool@tuxfamily.org> wrote:

> >  #
> >  # So perhaps this new, unnamed branch is what is causing the trouble?
> >  # Lets try a specific branch then:
> >  #
> >
> >  dione:~/linux-tmp4> git-checkout master
> >  Previous HEAD position was 4991408... Linux 2.6.24
> >  Switched to branch "master"
> >
> >  dione:~/linux-tmp4> git-bisect start
> >  won't bisect on seeked tree
> 
> This seems to work for me with git 1.5.5 on the git tree:

> What git version do you have ?

git-core-1.5.4.3-2.fc8, like for the previous report.

and it worked for me too in a later tree - so the condition seems 
transient.

> >  dione:~/linux-tmp4> git-bisect good v2.6.24 bad HEAD
> >  dione:~/linux-tmp4>
> 
> This is really bad, because, as you can see from the man page or "git 
> bisect -h" (see also the patch I just sent), "git bisect good" can 
> take many known good revisions:
> 
> git bisect good [<rev>...]
>         mark <rev>... known-good revisions.
> 
> So you marked also "bad" and HEAD as "good".
> 
> This is really strange, because here I get for example:
> 
> $ git-bisect good bad HEAD
> Bad rev input: bad HEAD
> 
> So you must have something tagged as "bad" or have a "bad" branch, and 
> that's why the command works for you but does the wrong thing.

no, there are no 'bad' braches or revisions.

and ... if "git-bisect good X bad Y" is invalid syntax it should be 
detected by the tool ... I did not think up that syntax myself, i think 
i saw it somewhere else mentioned by someone and found it logical. 
Weird. Generally i do use the separate commands though.

> >  dione:~/linux-tmp5> git-bisect visualize
> >  You need to give me at least one good and one bad revisions.
> >  (You can use "git bisect bad" and "git bisect good" for that.)
> >  dione:~/linux-tmp5> git bisect bad HEAD
> >  dione:~/linux-tmp5> git bisect good v2.6.24
> >  Bisecting: -1 revisions left to test after this
> >  [eb36f4fc019835cecf0788907f6cab774508087b] fix oops on rmmod capidrv
> 
> That's much better but you didn't "reset" or "start" again before 
> giving it correctly the good and bad revs, so there are still some 
> wrong left over from your previous start above.
> 
> >  #
> >  # -1 revisions left to test? Ouch ...
> >  #
> >  # But why did "git bisect" make a difference to "git-bisect" ?
> 
> It should not have made any difference.

it probably didnt - i was just grasping at straws because there was no 
reassuring feedback about what happened so my confidence about my 
_assumptions_ what was happening in the background gradually eroded so i 
went in larger and larger circles around the problem dropping more and 
more assumptions and re-checking them.

But i pasted this directly from that session so the "-1" is definitely 
not imaginery and it is anomalous.

	Ingo
