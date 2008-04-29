From: Andreas Ericsson <ae@op5.se>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 16:41:39 +0200
Message-ID: <481733A3.4010802@op5.se>
References: <200804281829.11866.henrikau@orakel.ntnu.no> <20080429124152.GB6160@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 16:43:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqr32-0006Ds-Mu
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 16:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbYD2Olv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 10:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760701AbYD2Olv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 10:41:51 -0400
Received: from mail.op5.se ([193.201.96.20]:56442 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763484AbYD2Olu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 10:41:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5A6C31F08090;
	Tue, 29 Apr 2008 16:41:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vawdsop-88PD; Tue, 29 Apr 2008 16:41:52 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id F18591F08085;
	Tue, 29 Apr 2008 16:41:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <20080429124152.GB6160@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80686>

Dmitry Potapov wrote:
> On Mon, Apr 28, 2008 at 06:29:07PM +0200, Henrik Austad wrote:
>> As discussed in [1], SHA-1 is not as secure as it once was (and this was in 
>> 2005), and I'm wondering - are there any plans for migrating to another 
>> hash-algorithm? I.e. SHA-2, whirlpool..
> 
> SHA-1 is broken in the sense that it requires computation less than
> finding a collision  by brute force (2^80). It is still very costly and
> AFAIK no one yet has found a single collision for SHA-1 yet, but even if
> such a collision is found, the question is how it can be exploit?
> 
> This collision cannot be used to replace any existing code in Git. The
> only way to exploit this collision is to submit a patch based on one
> sequence to the maintainer and it should look legitimate to be accepted
> and then create another blob with malicious code based on the other
> sequence, so the second blob has the same SHA-1 then anyone who pulls
> from you will get malicious code.
> 

But they won't, because it's impossible to add two objects with the same
SHA1 hash key to a git repository, since it will lazily re-use the
existing one. In practice, this means that in the case of an "innocent"
hash-collision, git will actually break by refusing to store the new
content.

> However, it is tricky to create these two blobs -- one which should pass
> inspection and look like as a real improvement but the other one that
> should do what you want. All what you have is two sequences of 20 bytes
> with the same SHA-1 and you have no control over them. For some binary
> files, it is possible by including both good and bad contents in the
> submitted blob and using one sequence in the right place to hide the bad
> part and make only the good one active/visible. Then the other blob will
> be almost the same but contains the other sequence, which is used to
> activate the bad part. This can work if the maintainer cannot see
> everything but only the "visible" part. However, I don't think you can
> do anything like that with _source_ code, which is inspect. And if
> submitted code is not reviewed, there is nothing that can protect you
> from malicious code getting into the repository (and even worse it will
> get directly into the official repository!).
> 
> So, I don't think we have to worry much about possibility a collision
> attack, but only about preimage attacks; and a preimage attack on SHA-1
> is far away from reality.
> 

Right.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
