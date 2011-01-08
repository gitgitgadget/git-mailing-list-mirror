From: Kevin Ballard <kevin@sb.org>
Subject: [BUG] git rev-list --no-walk A B C sorts by commit date incorrectly
Date: Fri, 7 Jan 2011 16:19:02 -0800
Message-ID: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 08 01:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbMWY-0001oW-2o
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 01:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab1AHATH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 19:19:07 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65258 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1AHATG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 19:19:06 -0500
Received: by pzk35 with SMTP id 35so2042898pzk.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 16:19:05 -0800 (PST)
Received: by 10.142.81.3 with SMTP id e3mr2168808wfb.131.1294445945185;
        Fri, 07 Jan 2011 16:19:05 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm3355679wfd.10.2011.01.07.16.19.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 16:19:04 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164794>

-----------------------------------------------------------------------------
Running the command `git rev-list --no-walk A B C` should be expected to emit
the commits in the same order as they were specified. This is especially
important as the same machinery is used for `git cherry-pick`, and so saying
`git cherry-pick A B C` can be expected to pick A before B, and B before C.

This does not happen.

Instead, it appears to be sorting the given commits according to the commit
timestamp. To make matters worse, it's not a stable sort. If commits A and
B have the same timestamp (for example, if they were rebased together), then
git cherry-pick tends to apply B before A.

Is there any rationale for this behavior? Any place where it makes sense to
reorder the commits in this fashion? As far as I'm concerned, typing
`git cherry-pick A B C` should behave identically to typing

  git cherry-pick A
  git cherry-pick B
  git cherry-pick C

regardless of the actual commit dates on A, B, and C.

-Kevin Ballard
