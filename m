From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is
	strict subset of remote ref
Date: Fri, 2 Nov 2007 09:24:46 -0400
Message-ID: <20071102132446.GA31758@hermes.priv>
References: <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@zib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <472AF5F8.40208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InwTl-0000I0-3b
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 14:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbXKBNWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 09:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbXKBNWN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 09:22:13 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:7338 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbXKBNWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 09:22:12 -0400
Received: by ik-out-1112.google.com with SMTP id c28so302818ika
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=yrJtVsyJN4ygdtDUeWG4RSFD5/GpxfSIsxhAhIXk8O8=;
        b=QU7hpXttloIV83+1vG8HP2jU4aMaUz+/ws/y912ZFUZ3RZR/Z7JKy5005TbF3edaQ6p1yCCkYjSN2w80txO4zxtazfXB3yygk80yiIkktu0wR4EizsQXehd2E3juR76JkeLsdQPtUqGa3DoSqlsrMqOBMkmAGsLJRDhPjsDCJFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=j5RDjWgLyOjQGvyFQJEM49QPmFtmOagNS3O32BeOqCkaQoV0hBDaWG1eDP6pc4aU76PvXkzMv9fzx2rCpiKulIm19sw+bQUHL4WICsM4oXYxsHhcpPUsZHEnYcraUDeFyQtCu7bcmq0IirDRzKcHH+dfJPYQa5uAqwjzKbKyWN8=
Received: by 10.142.215.5 with SMTP id n5mr423780wfg.1194009727632;
        Fri, 02 Nov 2007 06:22:07 -0700 (PDT)
Received: from hermes ( [74.14.67.175])
        by mx.google.com with ESMTPS id g36sm2786025rob.2007.11.02.06.22.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 06:22:06 -0700 (PDT)
Received: by hermes (nbSMTP-1.00) for uid 500
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	Tom; Fri,  2 Nov 2007 09:24:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <472AF5F8.40208@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63115>

On Fri, Nov 02, 2007 at 11:03:36AM +0100, Andreas Ericsson wrote:
> Steffen Prohaska wrote:
>> On Nov 1, 2007, at 10:11 AM, Andreas Ericsson wrote:
>>>
>>> It's easier to bisect. If git bisect lands you on a merge-commit,
>>> you need to start a new bisect for each of the parents included
>>> in the merge. Hopefully the nature of the merge gives a clue so
>>> the user can make an educated guess as to which parent introduced
>>> the bogus commit, but for an "evil octopus" (unusual) or if the
>>> merge had conflicts which were resolved in a buggy way (not
>>> exactly uncommon), it can be quite a hassle to get things right.
>>> With a mostly linear history, this problem goes away.
>> This is really an interesting point. I did not start to use
>> git bisect regularly. But I certainly plan to do so in the future.
>> Couldn't bisect learn to better cope with non-linear history?
>
> Perhaps it could, but it's far from trivial. I started hacking on
> a wrapper for git-bisect which would do just that, but gave up
> rather quickly as the book-keeping required to remember each and
> every parent-point tried just got out of hand, and it *still*
> wouldn't run in full automatic. It broke down because I also
> wanted merges on non-first-line parents to be delved into. If
> that didn't happen, I wouldn't *know* the bisect would run fine
> without me watching it, so then it was as useless as if I'd have
> had to sit there the entire time anyway.

I haven't had occasion to use git-bisect much, but I was under the
impression that bisect could already handle merges, or any other shaped
history just fine.

If you test a merge and it is bad, git (eventually) picks a commit on one of
the branches. If that commit is good, then the merge-base is good, so that the
bug lies on some other branch. If that commit is bad, then the bug is on some
ancestor of the branch. Thus, no need for special book keeping.

  Tom
