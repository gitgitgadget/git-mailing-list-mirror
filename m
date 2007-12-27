From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Using git for file archival/backup purposes - deletion strategy
Date: Thu, 27 Dec 2007 10:18:29 +0100
Message-ID: <47736DE5.40509@viscovery.net>
References: <46a038f90712261443t6aa0cd76u46d8ae88fc7c1eba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 10:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7owr-0001z4-Ob
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 10:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbXL0JWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 04:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXL0JWM
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 04:22:12 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9958 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbXL0JWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 04:22:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J7osx-00060y-G9; Thu, 27 Dec 2007 10:22:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B872D6EF; Thu, 27 Dec 2007 10:18:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46a038f90712261443t6aa0cd76u46d8ae88fc7c1eba@mail.gmail.com>
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69259>

Martin Langhoff schrieb:
> What I am not 100% clear on is the "old history" deletion strategy.
> The history will be *strictly* linear, so my intention is to keep the
> last N commits, by overriding the parent of the Nth commit that git
> log lists with a "shallow" entry in $GIT_DIR/shallow as documented in
> Documentation/technical/shallow.txt , and call gc after that.
> 
> Is that the correct way to "forget" old history? Searching high and
> low in the list, I fail to find a definitive answer. Shallow and
> grafts entries are discussed as ways of doing this, but I can't find a
> "correct" way of doing this.

I'm doing something like this. Basically:

   git rev-parse "HEAD~$N" > .git/info/grafts
   git filter-branch -f HEAD

If you omit filter-branch, then a repack -a -d will corrupt the repository
(I think) unless you keep the grafts file with it and in all its clones
forever.

-- Hannes
