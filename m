From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: push fails with unexpected 'matches more than one'
Date: Sat, 13 Oct 2007 18:51:58 +0200
Message-ID: <CC1A592A-443B-4039-9FA4-2386066C22AD@zib.de>
References: <11921723791817-git-send-email-prohaska@zib.de> <91A04390-89B2-47B8-9B61-7C7E652670AE@zib.de> <20071013032100.GK27899@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 18:51:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgkCK-0003KW-Cy
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 18:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbXJMQue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbXJMQud
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 12:50:33 -0400
Received: from mailer.zib.de ([130.73.108.11]:63706 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbXJMQud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 12:50:33 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9DGoTRY021554;
	Sat, 13 Oct 2007 18:50:29 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db11aa5.pool.einsundeins.de [77.177.26.165])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9DGoSVw001943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 13 Oct 2007 18:50:28 +0200 (MEST)
In-Reply-To: <20071013032100.GK27899@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 13, 2007, at 5:21 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> I read carefully through the documentation of git-send-pack and
>> git-rev-parse. The current implementation of git-send-pack is in line
>> with the documented behaviour, as is the implementation of git-rev-
>> parse.
>>
>> So formally everything is correct.
>>
>> But it is completely against my expectation that git-push <remote>
>> <head>
>> can successfully resolve a <head> that git-rev-parse fails to  
>> parse. I
>> understand that refs are not revs ;). But nonetheless, I'd expect  
>> that a
>> local ref that cannot be parsed by git-rev-parse should also fail  
>> to be
>> pushed by git-send-pack. I didn't expect that git-send-pack would  
>> locate
>> <head> as someprefix/<head>.
>>
>> Why is my expectation wrong?
>> Or is the current specification of git-send-pack's ref parsing wrong?
>
> I think its a bug.  But I didn't write the original code.
>
> Meaning I think what happened here was someone wanted to enable
> git-send-pack to match "master" here with "refs/heads/master" on
> the remote side.  One easy way to do that was to see if any ref
> ended with "/master", as that was what the ref here was called.
>
> Way back when that code was written most Git repositories probably
> only ever had that one branch anyway, or maybe two (refs/heads/master
> and refs/heads/origin) so matching the trailing suffix never came
> up as a bug.  Nobody ever had two refs that could possibly match.
>
> Then the documentation got expanded to actually document the behavior
> that git-send-pack implemented.  Unfortunately that codified the
> bug as documented behavior.
>
>
> So I agree with you Steffen, this is a bug in send-pack, and I run
> up against it every once in a while.  I've specifically told my
> coworkers "NEVER, EVER, EVER, create a branch called 'master' that
> isn't exactly refs/heads/master OR ELSE I WILL COME BEAT YOU WITH A
> CLUE STICK".  They still create "refs/heads/experiments/master".
> *sigh*.
>
> I think we should fix it.  Anyone that is relying on "git push
> $url master" to resolve to "refs/heads/experimental/master" on the
> remote side is already playing with fire.  But Junio is (rightfully
> so) very conservative and doesn't like to break a user's scripts.
> We may not be able to fix this until Git 1.6.

I'm working on this and will send patches tomorrow.

	Steffen
