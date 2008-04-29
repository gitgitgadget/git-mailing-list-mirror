From: Andreas Ericsson <ae@op5.se>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 14:27:46 +0200
Message-ID: <48171442.4050707@op5.se>
References: <200804281829.11866.henrikau@orakel.ntnu.no>	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>	 <4816CC80.9080705@op5.se> <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Russ Dill <russ.dill@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Apr 29 14:28:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqowp-0006Hi-Ht
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 14:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbYD2M1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 08:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYD2M1u
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 08:27:50 -0400
Received: from mail.op5.se ([193.201.96.20]:43620 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbYD2M1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 08:27:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 498BD1F08090;
	Tue, 29 Apr 2008 14:27:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PwV9lYslvnf1; Tue, 29 Apr 2008 14:27:52 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 48C671F0808B;
	Tue, 29 Apr 2008 14:27:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80679>

Sverre Rabbelier wrote:
> On Tue, Apr 29, 2008 at 9:21 AM, Andreas Ericsson <ae@op5.se> wrote:
>> Russ Dill wrote:
>>  If the server is hacked and objects are replaced, they will either
>>  no longer match their cryptographic signature, meaning they'll be
>>  new objects or git will determine that they are corrupt, or they
> 
> We were assuming here that once SHA-1 is broken really determined
> hackers will be able to come up with objects that -do- match the
> SHA-1, so the above is not relevant.
> 
>>  *will* match an existing object, but then that object won't be
>>  propagated to other repositories since git refuses to overwrite
>>  already existing objects. [...]
> 
> What about new users cloning the repo? They're just out of luck?

Only until someone who's already cloned the repository fetches
from it, at which point the collision will be detected.

> I
> don't think this argument holds, if we want to 'advertise' that git is
> cryptographically secure we can do so only as long as our hashing
> algorithm is. (As such, should SHA-1 ever be fully broken we'd need to
> either switch to another algorithm or stop advertising being
> cryptographically secure.)
> 

True. So far though, the only attacks that have been successful requires
that the attacker is allowed to create both the colliding data-sets,
and so far none has been found that would allow the attacker to follow
any kind of syntactical rules what so ever, so from a practical point
of view, SHA1 is 100% secure *for sourcecode*.

>From a theoretical point of view, no hash is 100% secure, so changing
algorithm buys us nothing.

Besides, "cryprographically secure" is not the same as "will never ever
be broken", because all hashes are obviously susceptible to brute-force
attacks. "Cryptographically secure" means, insofar as I've understood it
that given a source-file and a key, it would take such an extremely
long time to find a different data-set that hashes to the same key that
the result is unusable because the original source is obsolete.

That is why legal documents are always signed with the "most secure"
(or rather, "least insecure") of all available hashes. For our
purposes, SHA1 suffices until someone comes up with a relatively
trivial way of creating a collision within the parameters above.


>>  [...] Either way, gits refusal to overwrite
>>  objects it already has plays a part in making malicious actions
>>  futile, since malicious code is only worth something if it's
>>  propagated and actually used.
> 
> Of course this is true, it makes it a lot harder to do damage, but it
> doesn't eliminate the problem, it's just a free 'extra protection'.
> Yes, malicious code is only worth something if it's propagated and
> actually used, no, it is not impossible to do so in git if/when SHA-1
> turns out to have collisions every other file.
> 

Points of fact so far:
* It possible to create objects with colliding names (SHA1 hash keys).
  This holds true whichever algorithm we use, although it will be more
  difficult with a stronger algorithm.
* It is impossible to distribute the colliding content to already cloned
  repositories. This also holds true for all hash algorithms.

I've been arguing that the value of the first point is so greatly
diminished by the second, that even if SHA1 turns out to be horribly
broken, projects using git will still have a decent protection against
malicious code entering the repository without the knowledge of one of
the authors.

You've been arguing that SHA1 is not theoretically secure, which is
obviously true since no hash is theoretically secure.

I can think of one way to make git a lot more resilient to hash
collisions, regardless of which hash is used, namely: Add the length
of the hashed object to the hash.

In order for an evil-minded hacker to succeed in doing any real harm,
he/she now has to create a conflicting file which is valid for its
type (be it C, PHP, JPEG, AVI, PDF or whatever) and is also the same
length as the original source, without being allowed to create the
original object.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
