From: Peter Shenkin <shenkin@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 20:22:16 +0000 (UTC)
Message-ID: <loom.20111001T214551-834@post.gmane.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com> <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org> <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com> <loom.20111001T073652-884@post.gmane.org> <CAMOZ1Bvn64q5sVfo2-ZhTSpBttpjG1pHELJMM9sEmWsrqANCkw@mail.gmail.com> <loom.20111001T191413-25@post.gmane.org> <CAMOZ1Bsc2idQnKxeggruPi1rrY3+vsa=DoMydHY4+BM+qoW69w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 22:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA651-0007KK-Ot
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 22:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab1JAUWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 16:22:36 -0400
Received: from lo.gmane.org ([80.91.229.12]:34209 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab1JAUWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 16:22:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RA64u-0007Jn-NH
	for git@vger.kernel.org; Sat, 01 Oct 2011 22:22:33 +0200
Received: from h-67-101-25-249.nycmny83.dynamic.covad.net ([67.101.25.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 22:22:32 +0200
Received: from shenkin by h-67-101-25-249.nycmny83.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 22:22:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.101.25.249 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182574>

Michael Witten <mfwitten <at> gmail.com> writes:
>   git fetch --tags origin '+refs/heads/*:refs/remotes/origin/*'

Well, Junio had just about convinced me that there was
nothing wrong with the documentation -- just with the
way I was reading it -- until I read the above.

I tried it and yes, it does do what I want. Which was not
at all my expectation, having read Junio's comment about
how the documentation is to be read.

Junio argued that the man-page mod I suggested -- 
namely, "This flag causes all tags and their associated
objects (only) to be downloaded." -- was unneeded 
because the meaning, though correct, is clear already and
therefore redundant.

But the real problem is that the reading he gives is just
wrong.

I have the following in my .git/config file:

[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	tagopt = --tags
	url = <whatever>

Given this, I do not see how anyone could infer from 
anything in the documentation that

git fetch

would do anything different from:

git fetch --tags origin +refs/heads/*:refs/remotes/origin/*

If I am wrong about this, please cite chapter and verse.

The question is not how the --tags option should be
documented, but rather why "--tags" should behave
differently when the refspec is given on the commandline
than when the refspec is given in the .git/config file.

In fact, I no longer think it is a documentation error. It
is a just a really terrible implementation decision. If it
was desired to allow "git fetch --tags" to work without
using the user's specified refspec, then a "--no-heads"
option should have been provided to override the user's
refspec -- no matter where it was given.

Though a retrofit would likely break too many workflows,
the best one might hope for now would likely be the
addition of a "--heads" option, which would have the
effect of  bringing down the branch heads even though
this would not normally be done." 

But then it would still be necessary to say that "--tags"
does not normally obey the user's refspec if given in the
config file, but does if given on the command line. 

I might still be missing something. If anyone thinks the
current behavior is clear from a careful reading of the
documentation, I would like to hear how that inference
could be drawn. For no matter how one reads the --tags
description, it seems it is wrong in one of the two cases.

It is either wrong for a refspec on the command-line (if
you think it says it downloads tags only) or else it is wrong
for refspec in the config file (if you think it says it downloads
tags and heads).
