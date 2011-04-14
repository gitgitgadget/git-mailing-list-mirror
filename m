From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interdiff between amended commits
Date: Thu, 14 Apr 2011 09:08:47 +0200
Message-ID: <4DA69D7F.5050304@drmicha.warpmail.net>
References: <1jzlxb0.12qxbsl1na9qhzM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Thu Apr 14 09:09:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAGfq-0002nF-8I
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 09:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824Ab1DNHIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 03:08:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58021 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757643Ab1DNHIv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 03:08:51 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DDB0320DBE;
	Thu, 14 Apr 2011 03:08:49 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 14 Apr 2011 03:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+BsahcJIIzzYlfOtpO/alUda7ko=; b=lLG4MgnkbfMKqHqcWQob0kmb9dUiwDPTLkdNhXlv8C6yRT+Gc29aG82VYZ29WZCCLMAsfzy+8SMmy+kqivRqCaJTlLDkKU+NB/thZQ/io/heDL6TZkJl6f604oWXTk1duA5TX7cvM5zBdVBMOgw+/deHOclEzE21v/20q7lqPWE=
X-Sasl-enc: KSRjvjXaCMLaMFEjvauf+WWWWi1LHiNk+uC+XCiP/LK5 1302764929
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 625D2405789;
	Thu, 14 Apr 2011 03:08:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1jzlxb0.12qxbsl1na9qhzM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171506>

Stefan Haller venit, vidit, dixit 13.04.2011 13:54:
> I'd like to show an interdiff between two commits, e.g. when a commit
> was amended.
> 
> I'm aware of the "intercommit" alias in the git wiki:
> 
>   $ git show commit1 > .git/commit1 && git show commit2 > .git/commit2 && interdiff .git/commit[12]
> 

This basically computes the diff between two patches, using a tool which
groks the patch format.

> It only works for simple cases though, and I'd also like to avoid the
> dependency to an external tool if possible.

You could use git diff --no-index instead, so that would work in really
simple cases only, probably.

> 
> So one thing I came up with is this:
> 
>   git checkout commit1^
>   git cherry-pick --no-commit commit2
>   git diff --cached

That does something completely different. It compares the tree of
commit1^ with the tree of (commit1^ with commit2's patch applied). I
don't see how commit1's patch plays any role here.

Depending on what your actual use case, you may be happier with "git
diff commit1 commit2". Alternatively, you may produce a fake merge with
parents commit1 and commit2 and tree commit1^ and look at "show -R -c"
for that. Sounds weird, I know ;)

Michael
