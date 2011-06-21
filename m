From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 10:19:16 +0200
Message-ID: <4E005404.5010901@drmicha.warpmail.net>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kasra Khosoussi <kasra.mail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 10:19:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYwBG-0008EV-Nq
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 10:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab1FUITY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 04:19:24 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37240 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317Ab1FUITW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 04:19:22 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0BEE720A69;
	Tue, 21 Jun 2011 04:19:22 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 21 Jun 2011 04:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VYBh9R1kXtAdW3S5m6oC0TB46lc=; b=LJbOSZiZf+AML+t99M1wm6sGlE15PKxSh/djjOUCVYAdQPNjBFwQAkt84T2gmhKFP/X9HD2swoFvgXSD2K//OS8hmJ2kHtj61LIYJynIhXBxb9IJLTUCtBDDBN1WQr6qCh1oToCL65SooatoZI3fWHVTkZ2p5zBDBjJWqGEITsI=
X-Sasl-enc: vsBQtr7ipX63JwTm8YkNM/tVvpcHSJJr8rrGqHi/YWU7 1308644361
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 51C4B402947;
	Tue, 21 Jun 2011 04:19:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176132>

Kasra Khosoussi venit, vidit, dixit 21.06.2011 08:58:
> Hi all,
> 
> My thesis repository is corrupted and I don't have any recent backup
> (my files are OK, but the history is lost). I've seen the recovery

Backup now!
I guess you've done that meanwhile anyways, but it's important before
any recovery attempts.

Is your reflog OK, i.e. do you get proper output from "git reflog" or
"git log -g"?

> examples in the manual, but I believe my case is somehow different.
> The repository is linear.
> 
> 1- At the beginning, git status/log/fsck -full said:
> 
>> fatal: object 0a83757505387aacc2fd36b3c996729e6bf9d6e5 is corrupted

Hopefully and probably only the most recent commit (the one above) is
lost, not all of our history.

> 
> and there was an empty file in .git/objects/01/8375... .

.git/objects/0a83... probably

> 
> 2- If I move the corrupted object, git fsck --ful would return this:
> 
>> error: HEAD: invalid sha1 pointer 0a83757505387aacc2fd36b3c996729e6bf9d6e5
>> error: refs/heads/master does not point to a valid object!
>> dangling tree 06f388dc60cfb014b5e1f70ecdaa568efe6bd0fa
>> dangling tree d86f8c75e836e13b6e0336361641223f48fde722
> 
> 3- I guess I have to edit refs/heads/master and replace the corrupted
> sha1 with another hash, but I'm not sure how I can find the proper
> commit (e.g.,maybe by using find -mtime?).
> 
> Thanks in advance,
> 
> -Kasra

The reflog will give you the previous value of HEAD. You can set
refs/heads/master to that (git update-ref) and then rebuild the lost
commit on top of that (assuming only one commit is lost). The dangling
trees are not necessarily due to the corrupt commit object. Have you
changed any files since the corrupt commit? Do you remember which files
you changed in that commit?

Michael
