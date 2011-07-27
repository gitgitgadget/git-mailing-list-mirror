From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 10:22:28 +0200
Message-ID: <4E2FCAC4.7020408@drmicha.warpmail.net>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com> <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <7v8vrmrxok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlzO2-00024p-C2
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015Ab1G0IWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:22:33 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39200 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280Ab1G0IWb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 04:22:31 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 11DAF20C1E;
	Wed, 27 Jul 2011 04:22:31 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 27 Jul 2011 04:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=wRTY03MC/eACCTYsWiaoAP
	ZttsA=; b=a81RvmBki8m4CGinr+WWZkyPiGU2PkZQej9PIbmy5nXVJlMPrhnFkT
	zt4mWIZ6k4u7fWXPUy8P8YHSccw50z0rmsgWCuVuD0T2fUsATKvdzMcNFqbpezcN
	duEM/WVBS9ylUqzHRThI34qbaMxJairPZL7KDUWTP8FiFZAY7ZZyw=
X-Sasl-enc: /hwi4pgUwh8niYxDjrAEEQPYa/DXnseIHiE9B4x/KQp7 1311754950
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 760B04137D5;
	Wed, 27 Jul 2011 04:22:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <7v8vrmrxok.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177946>

Junio C Hamano venit, vidit, dixit 25.07.2011 21:02:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> RFC because lack of test, and also because I'm not sure we want this, and
>> what to do about git add which has the same problem, but would need a
>> different fix.
> 
> The reason you doubt we would want *this* is...?

I'm not sure the patch has side effects; I'm not sure we want to change
existing behaviour. I.e., is this behaviour intentional or a bug?

> Also what is the "same
> problem"?

The one reported by the OP for commit:

git rm ../a
git commit -m "blurb" ../a
error: pathspec '../a' did not match any file(s) known to git.

has the obvious analogue for add (add is going on behind the scenes of
the above commit, although we don't call the add codepath):

git rm ../a
git add ../a
fatal: pathspec 'a' did not match any files

Restaging a staged change should be a noop, shouldn't it?

The difference is that "git add a" does not work from the root directory
either after the removal of a has been staged. That's why we can leave
it as is. "commit", otoh, clearly behaves differently (depending on
subdir or root dir).

BTW: Note how different our messages are.

> Perhaps it would become clearer if you supported *this* with a sample
> workflow?

Well, the workflow is that described by the OP. It could go into the
commit message of an actual non-RFC patch.

Michael
