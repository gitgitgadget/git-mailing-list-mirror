From: Andreas Ericsson <ae@op5.se>
Subject: Re: git bisect do not work when good reversion is newer than bad
 reversion
Date: Thu, 20 Nov 2008 09:44:27 +0100
Message-ID: <4925236B.3020404@op5.se>
References: <6077B97E85E7374DAE87B42B5AA997970D0B12@sshaexmb1.amd.com> <7vljvfswek.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Cai, Crane" <Crane.Cai@amd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 09:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L35Ax-0004wB-6g
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 09:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbYKTIo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 03:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbYKTIo4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 03:44:56 -0500
Received: from mail.op5.se ([193.201.96.20]:40584 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbYKTIoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 03:44:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D946B1B8006F;
	Thu, 20 Nov 2008 09:40:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfQxEzAu5XXD; Thu, 20 Nov 2008 09:39:28 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7ED4824B000B;
	Thu, 20 Nov 2008 09:39:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vljvfswek.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101393>

Junio C Hamano wrote:
> "Cai, Crane" <Crane.Cai@amd.com> writes:
> 
>> Hi Junio,
>>
>> Sorry to disturb you. Here the requirement I met can not find answer
>> from website. That's why I directly ask you.
>>
>> I need to use "git bisect" to find what patch can fix a problem.
>> I found v2.6.25 has this problem.
>> And v2.6.26 does NOT has this problem.
>>
>> Then I use bisect as this:
>>
>> #git bisect start
>> #git bisect good v2.6.26
>> #git bisect bad v2.6.25
>>
>> No reversion cut via these steps. Do you know whether git command can
>> achieve this requirement or not?
> 
> You can use "git bisect" to find a single change that fixed the issue
> (_provided if_ such a single change exists).  There is a small mental
> trick you need to exercise.
> 
> First, realize that bisect is about "it used to be like this, but later it
> turned into that.  Where did that single transition from this to that
> happened"?  Usually, "this" is "had this particular bug and was broken"
> and "that" is "that bug was fixed and things work smoothly".  In your
> case, however, "this" is "broken" and "that" is "fixed".  IOW, the
> question you ask "bisect" is "it used to be broken but later it was fixed;
> where did that exactly happen?".
> 
> The mental trick is to swap "good" and "bad" in order to adjust to your
> use, because you are using bisect in a reverse way from the usual.  Usual
> case uses "good" mark "this" while "bad" is used to mark "that" in the
> sentence "it used to be like this, but later it turned into that".
> 
> So what you would do is...
> 
> 	(1) First of all, write on a piece of paper:
> 
> 	    good - the version _STILL_ has the bug.
>             bad  - the version does not have the bug _ANYMORE_
> 
> 	(2) Start with "git bisect v2.6.25 v2.6.26";
> 
>         (3) As you test each revision, look at the memo you made.  Say
>             "good" if it still has the bug you are interested in; say
>             "bad" if it does not have the bug anymore..
> 
>     cf. http://thread.gmane.org/gmane.comp.version-control.git/86063
> 

Or start your bisect run with this:
git config alias.fixed "!git bisect bad"
git config alias.buggy "!git bisect good"

Then you can run "git fixed" if the bug is fixed, and "git buggy" if the
bug is present.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
