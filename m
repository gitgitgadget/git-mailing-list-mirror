From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to revert one of multiple merges
Date: Mon, 19 Oct 2009 17:19:35 +0200
Message-ID: <4ADC8387.9010808@drmicha.warpmail.net>
References: <19162.32265.738503.382638@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 17:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuCR-0008OG-1X
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 17:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627AbZJSPa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 11:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756609AbZJSPa4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 11:30:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33228 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756257AbZJSPaz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 11:30:55 -0400
X-Greylist: delayed 673 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 11:30:55 EDT
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 183DCB4117;
	Mon, 19 Oct 2009 11:19:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 19 Oct 2009 11:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mOA3EgzRdMsSvq1giYCizSAdV8g=; b=EEQDhH6k0Durfb/xx1Vg2YNc9AP9uh+ImjcpSQY7gcc3EcvIzJ6d8O03vV5WsHtmx5aoY3bVCFp9gnRXXTsEfe0O3MqiUIIDqp+vxOBZU5Ym5PElYzxi54Zuup97nsARUM6LbFJtWNxLF33I+82XXhoDCYcPO6T0SpDHUXC1xrw=
X-Sasl-enc: kaRFunwdycen5ZG45C1ZHXne2Byik9UyhvAziqTsIaZH 1255965582
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2AFDF297A3;
	Mon, 19 Oct 2009 11:19:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091019 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <19162.32265.738503.382638@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130700>

Bill Lear venit, vidit, dixit 18.10.2009 04:31:
> Branch A, B, C each have 20 commits, 0-19.
> 
> Branch v1.0.0 created, then merge of A, B, C performed.
> 
> After testing, we realize that the branch B is not ready for
> production release and we'd like to remove it from branch
> v1.0.0.
> 
> If I do
> 
> % git merge A B C
> 
> I get a single commit:
> 
> % git log -p
> 
> commit 1644a0b98c01869aa83e59aa41374c22098c47b6
> [...]
> Date:   Fri Oct 16 09:52:32 2009 -0500
> 
>     Merge branches 'A', 'B' and 'C' into v1.0.0
> 
> [20 x 3 commits]
> 
> If I do
> 
> % git merge A
> % git merge B
> % git merge C
> 
> Then:
> 
> % git log -p
> 
> commit 8946edd381384d0882221c87b5b3b7bf47127d70
> [...]
> Date:   Sat Oct 17 21:28:36 2009 -0500
> 
>     Merge branch 'B' into v1.0.0
> 
> commit 076ed422443e3684e564f7cae2b92e4538088ae6
> [...]
> Date:   Sat Oct 17 21:28:35 2009 -0500
> 
>     Merge branch 'A' into v1.0.0
> 
> but no "Merge branch 'C' into v1.0.0".

Do you get any commits after the merge of B? If yes, then v1.0.0 got
fast-forwarded (you can avoid that using --no-ff). If no, C was
contained in v1.0.0 already.

In both cases, it's not clear how C could have been "ready" when B was not.

> And so, I'm faced with git rebase -i posing some unanswerable questions
> to our release manager.  She cannot easily remove B from the merge after
> doint either merge A B C, or merge A, merge B, merge C.

The way you described the situation there are no commits after the
merges. So, why not reset to before the merge and do a "git merge A C"?

Michael
