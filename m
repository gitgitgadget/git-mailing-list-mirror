From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 12:05:55 +0100
Message-ID: <tnxzmj1ppm4.fsf@arm.com>
References: <4430D352.4010707@vilain.net>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 13:06:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQjMU-0000I4-Im
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 13:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWDDLGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 07:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWDDLGM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 07:06:12 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:60379 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751848AbWDDLGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 07:06:10 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k34B5vuc012253;
	Tue, 4 Apr 2006 12:05:57 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 4 Apr 2006 12:05:57 +0100
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <4430D352.4010707@vilain.net> (Sam Vilain's message of "Mon, 03
 Apr 2006 19:48:34 +1200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 04 Apr 2006 11:05:57.0282 (UTC) FILETIME=[BFB96020:01C657D7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18387>

Sam Vilain <sam@vilain.net> wrote:
> "Patch dependency chains", the best plain-English term we could find for
> the scary sounding darcs term "patch calculus", are said by some to be a
> very good reason to use a system like darcs, even to some its
> fundamental advantage over systems such as git.

As Linus pointed out, while darcs theory is interesting, it doesn't
work properly in practice. Dependency tracking can create problems
with merging. Darcs' patch commuting theory has (a big, IMHO) problem
since every time you pull a patch (or more) it needs to commute all
the patches back to the common ancestor. Over time, the merging
becomes slower and slower (i.e. even much slower than what darcs shows
in simple tests with the Linux kernel).

Inexact patch commuting can be achieved using diff3 (or merge) with 3
snapshots of the tree (the bottom of the patch, the top of the patch
and the current head on top of which the patch is being applied) which
GIT handles very well and fast since there is no need to commute
thousands of patches back to the common ancestor. The slight
disadvantage is that diff3 merging is not as exact as Darcs' patch
commuting but OK for 99% of the real cases.

StGIT is based on this inexact patch commuting "theory" and, with the
addition of upstream merging detection (based on reverse-applying), it
is seems to behave properly in almost all the cases (though you can
deliberately create some patches to break the algorithm).

I've been thinking about adding patch dependency tracking to StGIT but
only as a recommendation and not enforcement. The algorithm would be
similar to the upstream merging detection.

-- 
Catalin
