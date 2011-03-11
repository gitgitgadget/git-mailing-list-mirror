From: Jason Miller <jason@milr.com>
Subject: Re: git-svn with big subversion repository
Date: Thu, 10 Mar 2011 16:32:55 -0800
Message-ID: <20110311003255.GA13814@home.jasonmmiller.org>
References: <20110308215342.35b8aac1@naru.jasonmmiller.org>
 <C99D031D.D0D9%jkristian@linkedin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Kristian <jkristian@linkedin.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 01:33:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxqIA-0003gj-8s
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 01:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab1CKAdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 19:33:12 -0500
Received: from eastrmfepo201.cox.net ([68.230.241.216]:49574 "EHLO
	eastrmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab1CKAdM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 19:33:12 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmfepo201.cox.net
          (InterMail vM.8.01.04.00 201-2260-137-20101110) with ESMTP
          id <20110311003310.ENCA32549.eastrmfepo201.cox.net@eastrmimpo02.cox.net>;
          Thu, 10 Mar 2011 19:33:10 -0500
Received: from cox.net ([98.182.25.247])
	by eastrmimpo02.cox.net with bizsmtp
	id HcZA1g00G5KsrWi02cZAS5; Thu, 10 Mar 2011 19:33:10 -0500
X-VR-Score: -200.00
X-Authority-Analysis: v=1.1 cv=7pnWggiXOXQ2QAfmW6m14qCrZ7JR9LVvc7C/OcPmZyA=
 c=1 sm=1 a=6OgPwM6wysAA:10 a=kj9zAlcOel0A:10 a=RvIMCnx3Jxw3m1/9SlLfAA==:17
 a=mPakLGkVfkEl_1glBk8A:9 a=GUK4UeW-gqqjjyll8RbYur3tigEA:4 a=CjuIK1q_8ugA:10
 a=RvIMCnx3Jxw3m1/9SlLfAA==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: by cox.net (nbSMTP-1.00) for uid 1000
	jason@milr.com; Thu, 10 Mar 2011 16:32:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <C99D031D.D0D9%jkristian@linkedin.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168870>

On 18:14 Wed 09 Mar     , John Kristian wrote:
Mr Kristian:
> Thanks for sharing your experience.  After patching git-svn, were you able to clone your subversion repository?

Indeed I was, it took about 48 hours to to the initial import.  However,
I forgot to mention one other important thing that was a problem.

There is a pattern in svn of doing the following:

/trunk/module1
/trunk/module2
/trunk/module3

Then some branches will be like this:
	svn cp /trunk/ /branches/mybranch1
and others might be:
	svn cp /trunk/module2 /brancyes/mybranchofmodule2

If this hasn't ever been done on your repository, you can stop reading
now.

There is no way to represent this in Git directly, so the correct thing
to do here is to create a git repository for each module.  Now the hard
thing is telling git-svn how to handle this.  I ended up writing a
python script that reads in the SVN changelog and finds all of the
children of e.g. /trunk/module1.  Any that were copied from /trunk, it
appends "/module1" to the path, and any that were copied from
/trunk/module1, it leaves alone.  This then goes in the git
configuration file as the list of branches to fetch.

-Jason
