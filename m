From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH v1] stash show: fix breakage in 1.7.3
Date: Sat, 25 Sep 2010 00:45:42 -0400
Message-ID: <AF7816CF-7515-4386-9736-417005434433@gernhardtsoftware.com>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net> <1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: robbat2@gentoo.org, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 06:52:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzMk9-0006zH-61
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 06:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab0IYEpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 00:45:46 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51932 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0IYEpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 00:45:45 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 7B4391FFC6B7; Sat, 25 Sep 2010 04:45:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 532851FFC6B5;
	Sat, 25 Sep 2010 04:45:32 +0000 (UTC)
In-Reply-To: <1285385521-17012-1-git-send-email-jon.seymour@gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157117>


On Sep 24, 2010, at 11:32 PM, Jon Seymour wrote:

> due to a faulty assumption that:
>   git rev-parse --no-revs -- stash@{0}

This assumption is faulty, it should be "git rev-parse --no-revs --flags stash@{0}", which works properly for all revision arguments and flags _except_ -q and --quiet.

> This revision further simplifies the parsing code
> by removing use of git rev-parse for FLAGS parsing
> altogether.

That is simpler, and does fix this specific issue.  However, I would strongly argue that "git rev-parse --no-revs --flags" is broken.  I really don't have the time tonight or probably this weekend to work on it, but git-rev-parse should only take "-q" and "--quiet" for itself if "--verify" was passed.  (Since that is the only mode in which rev-parse uses quiet, AFAIK.)

Possibly rev-parse should also (or instead) separate "arguments for rev-parse" and "arguments rev-parse is parsing" using the standard "--".  I don't know if this will affect any current users.

~~ Brian
