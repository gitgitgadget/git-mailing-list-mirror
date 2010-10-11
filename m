From: Jan Hudec <bulb@ucw.cz>
Subject: Automating svn<->git gateway
Date: Mon, 11 Oct 2010 21:30:07 +0200
Message-ID: <20101011193007.GA30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 21:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5OHe-0006qh-Lv
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 21:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab0JKTng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 15:43:36 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:47875 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216Ab0JKTng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 15:43:36 -0400
X-Greylist: delayed 805 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2010 15:43:35 EDT
X-ASG-Debug-ID: 1286825408-1c3c7f040001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id f1SEoRNiox3BmPJz for <git@vger.kernel.org>; Mon, 11 Oct 2010 21:30:08 +0200 (CEST)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1P5O4W-0008QM-1V
	for git@vger.kernel.org; Mon, 11 Oct 2010 21:30:08 +0200
X-ASG-Orig-Subj: Automating svn<->git gateway
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1286825408
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5563 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.43398
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158784>

Hello Folks,

I want to set up a gateway between subversion and git, which would keep the
master synchonized with subversion trunk, both ways, and allow working with
any additional branches independent of subversion. For users it should behave
as any other shared git repository accessed by push and pull. And it needs to
be automatic.

Did anybody try to set up something like this?

Background:

At $work, we are considering switch from subversion to git. However to avoid
big disruptions in the work, we need to do it gradually. So the idea is to
switch to git one by one. The people who already switch need to be able to
test the final workflow with git, while other people still commit to the
subversion repository.

This basically rules out everybody just using git-svn, because individual
conversions are incompatible (or is there some way to make them compatible?),
so the people couldn't easily share their working branches.

That leaves me with creating one git-svn repository and having everybody
clone from that. Keeping the repository up-to-date from subversion side seems
trivial (just 'git svn fetch' to it from subversion's post-commit hook).

The trickier part is exporting changes pushed from the git side to
subversion. My plan is to write a post-receive hook, that will
'git svn dcommit' to svn trunk.

I suppose I will have to get the rewritten commit back from subversion and
merge it back to the master. I have not yet tested whether when dcommiting
a merge will properly keep the second parent in the rewritten commit or not.
I can do extra merge if it does not at the cost of slightly uglier history.

Thanks,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
