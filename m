From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 17:32:15 -0500
Message-ID: <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> <ron1-62D136.13570812022010@news.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng43l-0006ZO-Nh
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab0BLWcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:32:20 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:34012 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab0BLWcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 17:32:20 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 55E8F1FFC43B; Fri, 12 Feb 2010 22:32:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.227] (unknown [64.134.71.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 25BC61FFC1CE;
	Fri, 12 Feb 2010 22:32:10 +0000 (UTC)
In-Reply-To: <ron1-62D136.13570812022010@news.gmane.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139757>


On Feb 12, 2010, at 4:57 PM, Ron Garret wrote:

> That would require a separate branch for every snapshot, no?  I want 
> this to be lightweight.  It's not so much the creation of a zillion 
> branches that bothers me, but having to come up with a new name every 
> time would be a real hassle.

Ahhhh...  You could just use the stash and use some kind of recognizable message: git stash Failed: fooed the bar badly

Or you could make a stash-like snapshot branch?  The following sequence does something like that:

  git add .
  git commit -m "Ooops"
  git branch -f
  git reset --hard HEAD^

After a few failures like that, you can look over all the snapshots with

  git log -g snapshots

By default they will be kept around for 30 days, or the current setting of gc.reflogexpireunreachable.  If you want to keep a snapshot around for more than 30 days, you probably want to give it a real branch anyway.

You could either create a script that uses the above commands or a patch that makes git-stash take a --ref= argument and then set:

  alias.snapshot = stash --ref=refs/snapshots

~~ Brian