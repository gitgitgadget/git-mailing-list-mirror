From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-merge: run commit hooks when making merge commits
Date: Thu, 12 Jul 2007 11:21:35 +1200
Message-ID: <469565FF.5040103@vilain.net>
References: <11841499201242-git-send-email-sam.vilain@catalyst.net.nz> <7vd4yy4opa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 01:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8lVE-0004WA-0p
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 01:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763622AbXGKXVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 19:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbXGKXVp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 19:21:45 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60386 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757986AbXGKXVo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 19:21:44 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 53B0C20C177; Thu, 12 Jul 2007 11:21:42 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 8307F20C177;
	Thu, 12 Jul 2007 11:21:37 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vd4yy4opa.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52223>

Junio C Hamano wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
> 
>> git-merge.sh was not running the commit hooks, so run them in the two
>> places where we go to commit.
>>
>> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
>> ---
>>    Not sure if it should call these or some specialist hooks, like
>>    git-am does.
> 
> I suspect some people have pre-commit scripts that have been
> meant to catch style errors for their own commits, and invoking
> that on merge would wreak havoc --- there is not much you can do
> if you want to get the work done by somebody else at that point.
> Introducing a new pre-merge-commit hook would probably be safer;
> if one wants to use the same check as one's pre-commit does, the
> new hook in the repository can exec $GIT_DIR/hooks/pre-commit.
> 
> The commit-msg hook I have no clue what people usually use it
> for in the real world, but a merge commit message tends to be
> quite different from the message you would give to your own
> straight line commits, so custom reformatting rules people have
> in commit-msg hook may not apply to merge commit messages.

True.  OTOH, if you commit with `git commit` after a merge which failed
or was called with --no-commit, then it will call the commit hook.  So
those scripts would have to deal with that case anyway.

So, should `git commit` detect it is committing a merge and call the
merge-hooks, should we use the same hooks, or, should this be something
like hooks/*-automerge ?

Sam.
