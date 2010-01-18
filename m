From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: idea: git "came from" tags
Date: Mon, 18 Jan 2010 10:49:38 +0100
Message-ID: <4B542EB2.5030407@drmicha.warpmail.net>
References: <hj0nl9$uds$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: D Herring <dherring@tentpost.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 10:51:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWoGi-0006NL-Vq
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 10:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0ARJv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 04:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283Ab0ARJv3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 04:51:29 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34651 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161Ab0ARJv2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 04:51:28 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AF1EDCDD76;
	Mon, 18 Jan 2010 04:51:27 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 18 Jan 2010 04:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qzd26OtH8F+Ziy8tY3nQR/kQRYU=; b=ILQklGoNuU8Jq5+7T9UtJ3/YH67ICM22sU3P6cdN8uM1uSbsdpVRTxKKWy/hpOikBHWhpTa5aGZfCPi3gVpBEj6futM27wKAUUxKTnXaiV2vyvWR8WluwhWay2SzlWI0j7eWWQV6deaaAZ7mupChxf5LSQeb/KOKv318BtNs+A8=
X-Sasl-enc: u+JnFQLKP5MWPFYPWQvbXvjmntRXSl8/bJ3DPaLZH2pj 1263808287
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29BDC7028;
	Mon, 18 Jan 2010 04:51:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <hj0nl9$uds$2@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137378>

D Herring venit, vidit, dixit 18.01.2010 05:22:
> Actors:
> - public "upstream" repository
> - public "local" repository
> - end users tracking both
> 
> Situation:
> - local starts by tracking upstream
> - local makes changes, commits, and sends upstream
> - users now tracking local ahead of upstream

Here I have to ask why. If users choose to track a volatile branch then
they have to live with rebasing or hard resets. If they want something
stable then they should track upstream.

> - upstream makes modified commits
> - local satisfied, wants to reset master to upstream/master
> 
> Problem:
> - A merge will perpetually leave two parallel branches.  Even though
> there are no longer any diffs, local/master cannot use the same
> objects as upstream/master.

If there are no diffs then, in fact, it can share most objects since
most trees will be the same, only a few commit objects will differ.

> - A hard reset lets local/master return to sharing objects with
> upstream/master; but this may break pulls or cause other problems for
> users.
> 
> Proposed solution:
> - Local adds a "came from" tag to upstream/master, leaves a tag on the
> head of local/master, and does a hard reset from local/master to
> upstream/master.  When a user tracking local/master does a pull, their
> client detects a non-fast-forward, finds the came-from tag, and treats
> it as a fast-forward.
> 
> Basically, this is a protocol to glue a "strategy ours" merge onto an
> existing tree.  This way local can cleanly track upstream, with no
> added complexity in the nominal (no local changes) case.

But doesn't that mean that users completely trust you about what they
should consider a fast forward, i.e. when they should do a hard reset?
So, this is completely equivalent to following one of your branches with
+f, i.e. having a public a branch which they pull from no matter what,
and having a private branch which pushes to the public one in case of
fast-forwards as well as in the case when you would use your special tag.

Michael
