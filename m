From: Andreas Ericsson <ae@op5.se>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 16:37:52 +0200
Message-ID: <481732C0.5020208@op5.se>
References: <200804281829.11866.henrikau@orakel.ntnu.no>	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>	 <4816CC80.9080705@op5.se> <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com> <48171442.4050707@op5.se> <48171D24.9000104@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, Russ Dill <russ.dill@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 16:40:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqqzw-0004xP-W4
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 16:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761490AbYD2Oh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 10:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbYD2Oh6
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 10:37:58 -0400
Received: from mail.op5.se ([193.201.96.20]:56150 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761443AbYD2Oh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 10:37:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D00B41F0808F;
	Tue, 29 Apr 2008 16:37:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rPfNt8BpX9DZ; Tue, 29 Apr 2008 16:37:59 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id DC7851F08010;
	Tue, 29 Apr 2008 16:37:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <48171D24.9000104@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80685>

Paolo Bonzini wrote:
> 
>> I can think of one way to make git a lot more resilient to hash
>> collisions, regardless of which hash is used, namely: Add the length
>> of the hashed object to the hash.
> 
> Not really, because most attacks are about collisions, not second 
> preimages.  They produce two 64-byte blocks (hence, same length) with 
> the same hash value.
> 
> As such, they allow to change a blob that *the attacker* injected in the 
> repository.  The way the more "spectacular" attacks are devised requires 
> a "language" with conditional expressions -- for documents, for example, 
> Postscript is used.  If you prepare a postscript file whose code is
> 
>    if (AAAA == BBBB)
>      typeset document 1
>    else
>      typeset document 2
> 
> where AAAA and BBBB are collisions, and you change it to "if (BBBB == 
> BBBB) the hash will be the same, but the outcome will be document 1 
> instead of document 2.
> 
> The fact that this requires having the two "behaviors" in the blob is 
> not a big deal for source code, going in the wrong branch of an "if" can 
> be an attack.  On the other hand, it makes adding the length useless for 
> collision attacks.  True, it wouldn't be useless for second preimage 
> attacks, but SHA-1 is still secure with respect to those.
> 

So what you're saying is that if someone owns a repository and adds a
file to it, he can then replace his entire repository with an identical
one where the good file is replaced with a bad one, and this will affect
people who clone *after* the file gets replaced.

Gee, that's one fiendishly large attack vector, quite apart from the
fact that said author first has to come up with a program that gets
widespread enough that a lot of people all of a sudden wants to use
it, but not so widespread that anyone would want to review it before
using it.

I remain unconvinced as to whether or not SHA1 is, for all practical
purposes, cryptographically secure for git's uses. Sure, evil programmers
can screw you over if you use their software without reviewing it, but
that's hardly due to git using a particular cryptographic algorithm.

Otoh, I'm not familiar enough with the nomenclature to say with 100%
certainty what's cryprographically secure and what isn't. I just know
that there are no collision-less hashes, so whatever "cryptographically
secure" really means wrt hashes, "100% collision-free" isn't it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
