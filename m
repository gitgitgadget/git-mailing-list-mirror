From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git merge driver / attributes bug in 2.3.1?
Date: Mon, 09 Mar 2015 10:35:15 +0100
Message-ID: <54FD6953.9030406@drmicha.warpmail.net>
References: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>	<54F98EBE.8080903@drmicha.warpmail.net>	<D8780C527EB1E642B3150E6D705B46D448E8058B@DWPWHMS531.dwpbank.local>	<54F9B5C0.9050604@drmicha.warpmail.net> <xmqqlhj9yftb.fsf@gitster.dls.corp.google.com> <D8780C527EB1E642B3150E6D705B46D448E8063B@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:35:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUu5r-0001g0-7y
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 10:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbbCIJfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 05:35:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35364 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753322AbbCIJfR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2015 05:35:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 4ABA421422
	for <git@vger.kernel.org>; Mon,  9 Mar 2015 05:35:15 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 09 Mar 2015 05:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Kzat9SWNjgERN5niBheCIA
	9w7i8=; b=rk0oaiHNxHgq2DHxLQmKROhuRFbcuzo7sj7v4zr8Y3cDOOgFtaDD9Q
	yc2uJZxJ4mVoWpyOqs/yya8xdhHOKACFLsufJML938sBed5WoPQt2qGOkmpji6ln
	DCjXRuAmF4A7bkEKdslWMR8YQhFQCUIjSCrVZzk5iE6zOXPfkoOIQ=
X-Sasl-enc: xCD/B+1gTSJOGOpfWLXou8ZQwbe15cJEZZIlGBaHcCZE 1425893716
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2031FC002A5;
	Mon,  9 Mar 2015 05:35:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D448E8063B@DWPWHMS531.dwpbank.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265139>

Gondek, Andreas venit, vidit, dixit 09.03.2015 10:02:
> We used a merge driver to create a conflict semaphore file whenever a
> merge conflict occurs in Atlassian Stash. This worked for several
> month until we got to update our Git version because of another
> problem.

That is the first issue: Can you reproduce with an older Git and your
test repo the effect that you wanted to achieve?

I have tried a few older Git's with your test repo, and I always get the
same behavior as with current Git (and as we would expect). So,
something else has to be going on here.

> If I understand it correctly, a merge driver is executed before the
> normal internal merge happens? So I would need to call a git
> merge-file in my merge driver, test the result and return the exit
> code of the git merge-file?

First, the tree level merge checks whether the two sides introduce
different changes to the same files. If not a simple tree level merge is
done (which may or may not be OK, see Junio's shopping list example).

If yes (different changes to the same files), a merge driver is used,
either an external one if specified, or the internal 3-way merge driver.
But I'm not a merge expert ;)

If I understand correctly, you want to use the external merge driver to
signal a conflict that git may miss otherwise?

On a side note, this discussion and the shopping list example show how
badly a tool like git-dep(endency) can go wrong, just like the automatic
merge. Just imagine a library change on one branch, and the introduction
of a new call site following the old library calling convention on
another branch. No dependency detected, clean tree-level merge by git,
and fails to compile (hopefully) or run (worse). Automatic mergers can
only guess, they are no code analyzers.

Michael
