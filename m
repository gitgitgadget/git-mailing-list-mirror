From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 10:39:32 +0200
Message-ID: <4535E844.8010604@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>	<45357411.20500@utoronto.ca>	<200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 10:39:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga6xf-0006z3-Vk
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 10:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWJRIjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 04:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWJRIjg
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 04:39:36 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:57525 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932111AbWJRIjf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 04:39:35 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 058776BD53; Wed, 18 Oct 2006 10:39:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 50A7D6BCFE; Wed, 18 Oct 2006 10:39:32 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45359B2A.1070102@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29202>

Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Carl Worth wrote:
>> Aaron, thanks for carrying this thread along and helping to bridge
>> some communication gaps. For example, when I saw your original two two
>> diagrams I was totally mystified how you were claiming that appending
>> a couple of nodes and edges to a DAG could change the "order" of the
>> DAG.
>>
>> I think I understand what you're describing with the leftmost-parent
>> ordering now. But it's definitely an ordering that I would describe as
>> local-only. That is, the ordering has meaning only with respect to a
>> particular linearization of the DAG and that linearization is
>> different from one repository to the next.
> 
> Well, the linarization for any particular head is well-defined, but
> since different branches have different heads...
> 
>> If in practice, nobody does the mirroring "pull" operation then how
>> are the numbers useful? For example, given your examples above, if
>> I'm understanding the concepts and terminology correctly, then if A
>> and B both "merge" from each other (and don't "pull") then they will
>> each end up with identical DAGs for the revision history but totally
>> distinct numbers. Correct?
> 
> The DAGs will be different.  If A merges B, we get:
> 
> a
> |
> b
> |\
> c d
> |\|
> | e
> |/
> f
> 
> If B merges A before this, nothing happens, because B is already a
> superset of A.
> 
> If B merges afterward, we get this:
> a
> |
> b
> |\
> d c
> |/|
> e |
> |\|
> | f
> |/
> g
> 

Seems like an awful lot of merge commits. In git, I think these trees 
would be identical (actually both to bazaar and to each other), with the 
exception that the 'g' commit wouldn't exist, since git does 
fast-forward and relies on dependency-chain only to present the graph 
instead of mucking around with info in external files (recording of 
fetches).

>> So in that situation the numbers will not help A and B determine that
>> they have identical history or even identical working trees.
> 
> They don't really have identical history.
> 

As explained above, they would be identical in git. The fact that you 
register a fast-forward as a merge makes them not so, but this is 
something most gitizens are against, as it can quickly clutter up the DAG.

>> So what good are the numbers?
> 
> They are good for naming mainline revisions that introduced particular
> changes.
> 
>> I can see that the numbers would have applicability with reference to
>> a single repository, (or equivalently a mirror of that repository),
>> but no utility as soon as there is any distributed development
>> happening.
> 
> Well, there's distributed, and then there's *DISTRIBUTED*.  We don't
> quasi-randomly merge each others' branches.  We have a star topology
> around bzr.dev.  So when we refer to revnos, they're usually in bzr.dev.
> 

So in essence, the revnos work wonderfully so long as there is a central 
server to make them immutable?

Doesn't this mean that one of your key features doesn't actually work in 
a completely distributed setup (i.e., each dev has his own repo, there 
is no mother-ship, everyone pulls from each other)?

I can see the six-line hook that lays the groundwork for this in git 
before me right now. I'll happily refuse to write it down anywhere. I 
get the feeling that sha's are easier to handle in the long run, while 
revno's might be good to use in development work. In git, we have 
<branch/tag/"committish">~<number> syntax for this.

In my experience, finding the revision sha of an old bug is what takes 
time. Copy-paste is just as fast with 20 bytes as with 4 bytes. Honestly 
now, do you actually remember the revno for a bug that you stopped 
working on three weeks ago, or do you have to go look it up? If someone 
wants to notify you about the revision a bug was introduced, do they not 
communicate the revno to you by email/irc/somesuch?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
