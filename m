From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 8 Sep 2011 12:53:39 -0700 (PDT)
Message-ID: <1315511619144-6773496.post@n2.nabble.com>
References: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com> <4DF6A8B6.9030301@op5.se> <20110614003029.GA31447@sigill.intra.peff.net> <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com> <201106141202.46720.johan@herland.net> <20110614170214.GB26764@sigill.intra.peff.net> <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com> <20110614194749.GA1567@sigill.intra.peff.net> <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 02:28:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1oxE-0006ZU-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 02:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab1IIA2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 20:28:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:48484 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756928Ab1IIA2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 20:28:14 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <mfick@codeaurora.org>)
	id 1R1kfL-000391-5E
	for git@vger.kernel.org; Thu, 08 Sep 2011 12:53:39 -0700
In-Reply-To: <BANLkTi=GZDLu-ey1=h8LLDbWssoSpsM_jd7R-oFr+b+82Otb8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181010>

Just thought that I should add some numbers to this thread as it seems that
the later versions of git are worse off by several orders of magnitude on
this one.  

We have a Gerrit repo with just under 100K refs in refs/changes/*.  When I
fetch them all with git 1.7.6 it does not seem to complete.  Even after 5
days, it is just under half way through the ref #s!   It appears, but I am
not sure, that it is getting slower with time also, so it may not even
complete after 10 days, I couldn't wait any longer.  However, the same
command works in under 8 mins with git 1.7.3.3 on the same machine!

Syncing 100K refs:

  git 1.7.6      > 8 days?
  git 1.7.3.3   ~8mins

That is quite a difference!  Have there been any obvious changes to git that
should cause this?  If needed, I can bisect git to find out where things go
sour, but I thought that perhaps there would be someone who already
understands the problem and why older versions aren't nearly as bas as
recent ones.

Some more things that I have tried:  after syncing the repo locally with all
100K refs under refs/changes, I cloned it locally again and tried fetching
locally with both git 1.7.6 and 1.7.3.3.  I got the same results as
remotely, so it does not appear to be related to round trips.

The original git remote syncing takes just a bit of time, and then it
outputs lines like these:
 ...
 * [new branch]      refs/changes/13/66713/2 -> refs/changes/13/66713/2
 * [new branch]      refs/changes/13/66713/3 -> refs/changes/13/66713/3
 * [new branch]      refs/changes/13/66713/4 -> refs/changes/13/66713/4
 * [new branch]      refs/changes/13/66713/5 -> refs/changes/13/66713/5
 ...

This is the part that takes forever.  The lines seem to scroll by slower and
slower (with git 1.7.6).  In the beginning, the lines might be a screens
worth a minute, after 5 days, about 1  a minute.  My CPU is pegged at 100%
during this time (one core).  Since I have some good test data for this, let
me know if I should test anything specific.

Thanks,

-Martin

Employee of Qualcomm Innovation Center, Inc. which is a member of Code
Aurora Forum


--
View this message in context: http://git.661346.n2.nabble.com/Git-is-not-scalable-with-too-many-refs-tp6456443p6773496.html
Sent from the git mailing list archive at Nabble.com.
