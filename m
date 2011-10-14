From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Bug? url.insteadOf overwrites remote.pushUrl
Date: Fri, 14 Oct 2011 17:35:25 +0200
Message-ID: <4E9856BD.3010807@drmicha.warpmail.net>
References: <CAB6D58F-A3C9-4532-A9CC-10E43CD34E4E@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 17:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REjnM-0002px-A1
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 17:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254Ab1JNPf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 11:35:29 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34586 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933221Ab1JNPf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 11:35:27 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B6834210E1;
	Fri, 14 Oct 2011 11:35:26 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 14 Oct 2011 11:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4kkdlh5zm/BQxPnYsSvIYj
	9iL8E=; b=oaCujy//DFgwYkta7a6wIBtxqkGx69teqs8dAEPRRcwL4FtzY3BWX5
	D/YmVYo6Elg7YWxkYsAb137cbAyYcOQ+xpkSb+Br1XkTd3ijXL7tfKCC31qFuZcI
	ZLZdsnzqO5up28xY8HutuPnXL5KlPF2Z4sdKtkr0RiabSCUhvEev4=
X-Sasl-enc: 5MyWvViWdAmpd7SMmE0UH7W+ojYXepZSlAOBDH7ozGbL 1318606526
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3F49248340E;
	Fri, 14 Oct 2011 11:35:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <CAB6D58F-A3C9-4532-A9CC-10E43CD34E4E@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183582>

Kirill Likhodedov venit, vidit, dixit 14.10.2011 15:55:
> 
> I've found that defining url.<base>.insteadOf overrides explicit
> remote.<name>.pushUrl.

It doesn't really override it. It is applied to it, i.e. transforms it.

> On the other hand, pushInsteadOf doesn't
> override explicit pushUrl. Is it a bug?

That is as described in the thread (thanks for linking to it).

> # cat .git/config [remote "origin"] fetch =
> +refs/heads/*:refs/remotes/origin/* url = github.com/klikh/Test.git 
> pushUrl = jetbrains.com/klikh/Test.git [url "http://"] insteadOf=jet
> 
> # git remote -v origin	github.com/klikh/Test.git (fetch) origin
> http://brains.com/klikh/Test.git (push)

The idea of "pushInsteadOf" was that, instead of having to define url
and pushurl separately, you can use different rules, say

github -> git://github.com (fetch)
github -> https://username@github.com (push)
github/ -> git@github.com: (push)

used with "url = github/otheruser/repo.git" alone, without pushurl.

pushurl predates pushinsteadof, and when the latter was introduced, one
could have argued for or against "insteadof" being applied to pushurls.
But that was necessary before, and existing behavior at the time when
pushinsteadof was introduced. So, I don't see a bug, nor anything we
could change now, though arguably most people use either pushinstead of
or pushurl, but not both.

Cheers,
Michael
