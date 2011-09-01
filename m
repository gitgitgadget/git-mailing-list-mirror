From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Thu, 01 Sep 2011 21:20:30 +0200
Message-ID: <4E5FDAFE.6050004@drmicha.warpmail.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 21:20:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzCoa-0007LE-BW
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 21:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757716Ab1IATUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 15:20:34 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50017 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757442Ab1IATUd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 15:20:33 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F043C209E1;
	Thu,  1 Sep 2011 15:20:32 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 01 Sep 2011 15:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Ma1eX/dcY1+rKU7F1eusRD
	EguEE=; b=mlP2qIGaHfywODQkegNv4GeDzw8EWScCDAc6wbi/CPsSxEXi9IlQvn
	xObIYedBiDiZk4/Uj6bWCrhJi06zxo4a6CWsuCOw0ipKFHvnqIuymrk25q6NOcBL
	SIoUk5BZHjMe3jrjktKLWq/eRck+T4A3CB2wKyMSo0N01Oc6Cap/c=
X-Sasl-enc: xlLI/Qm3Su/4EF70mhOfU1ptsVeslqP318G1HabwYi2g 1314904832
Received: from localhost.localdomain (p548591EE.dip0.t-ipconnect.de [84.133.145.238])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 59EB1A00699;
	Thu,  1 Sep 2011 15:20:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180565>

Junio C Hamano venit, vidit, dixit 01.09.2011 20:25:
> Suggested reading:
> 
>   http://git-blame.blogspot.com/2011/08/how-to-inject-malicious-commit-to-git.html
> 
> I am wondering if we are better off applying something along the lines of
> this patch, so that with the default configuration, users can notice if
> their upstream unexpectedly rewound their branches.
> 
> It would produce
> 
> 	[remote]
>         	url = git://.../git.git/
>                 fetch = refs/heads/*:refs/remotes/origin/*
> 
> upon cloning from my repository, and your "git fetch" will fail because
> the pu (proposed updates) branch is constantly unwinding, but that can be
> easily fixed with
> 
> 
> 	[remote]
>         	url = git://.../git.git/
>                 fetch = refs/heads/*:refs/remotes/origin/*
>                 fetch = +refs/heads/pu:refs/remotes/origin/pu
> 
> as the explicit refspec trumps the wildcard one.
> 
>  builtin/remote.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

My first thought was "Oh no", even though I saw it coming since I read
your blog entry. But I realized that it was probably due to the usual
inertia when habits have to change.

Thinking more about it, we try to encourage a workflow where locally
history may be rewritten a lot, and distribution points fast-forward
only. We have defaults and settings to discourage (pushes to checked out
branches and) non-ff pushes, for example. So I think the above change is
pretty much in line with that reasoning.

The kernel.org problems gave git some pretty good PR even without that
change, but with it we have an even stronger stop put in. On the other
hand, adding "+" to the config for "pu" (and peff...) isn't that much of
an issue, though we might also want "fetch -f" as an override - I guess
we have that already.

Plus fetch with fsck, yes.

To

"I don't need backups, I let others clone."

add

"I don't need intrusion detection, I let others fetch."

;)

Michael
