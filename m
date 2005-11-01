From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 01 Nov 2005 13:25:39 +0000
Message-ID: <tnxd5lkwld8.fsf@arm.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	<Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	<20051031195010.GM11488@ca-server1.us.oracle.com>
	<7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	<20051031213616.GO11488@ca-server1.us.oracle.com>
	<7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	<20051031224246.GP11488@ca-server1.us.oracle.com>
	<7vbr15b4m4.fsf@assigned-by-dhcp.cox.net>
	<20051101004255.GQ11488@ca-server1.us.oracle.com>
	<46a038f90510311702wfb43281rf4464a02e8e3be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Nov 01 14:27:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWw9v-000161-PC
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 14:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKAN0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 08:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVKAN0e
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 08:26:34 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:5799 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750745AbVKAN0e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 08:26:34 -0500
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id jA1DPbSV001566;
	Tue, 1 Nov 2005 13:25:37 GMT
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id NAA05165;
	Tue, 1 Nov 2005 13:25:50 GMT
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 1 Nov 2005 13:25:41 +0000
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510311702wfb43281rf4464a02e8e3be2@mail.gmail.com> (Martin
 Langhoff's message of "Tue, 1 Nov 2005 14:02:43 +1300")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 01 Nov 2005 13:25:41.0112 (UTC) FILETIME=[C142CF80:01C5DEE7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10932>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/1/05, Joel Becker <Joel.Becker@oracle.com> wrote:
>> > is possible) offhand.  Sometimes, when you want truly logical
>> > steps, you would end up needing intermediate steps that never
>> > existed in your true history (i.e. "in the hindsight, my
>> > development should have progressed in these steps.")
>>
>>         Yes, I always do.  But I'm not talking about that sort of large
>> feature add or whatever.  I'm talking about merely doing something on a
>> small scale, but in a temporary repository.
>
> I'm really surprised that Calalin hasn't chimed in.

Well, it was night here when this discussion took off :-).

> If you are into rewriting/merging/splitting your patches, StGIT is
> your friend. Check out: http://www.procode.org/stgit/

StGIT mainly resembles Quilt workflow but there are no patches, only
commit objects which are indefinitely replaceable (push/pop/refresh).

What I usually do is create smaller commits for different features and
just stack them together. That's usually for features which are
dependent on each-other and you can control them with a finer grain
than having separate branches. One can push/pop patches (commits) to
bring the patch to be modified at the top. After modification, a
refresh command would save it as a commit. All the patches (commits)
in the stack are accessible via HEAD and are seen as GIT commits.

It may happen to just have a bigger patch which needs splitting. What
I usually do in this case is import the patch as an StGIT patch
(i.e. GIT commit object), pop it from the stack so that it is no
longer applied, split the physical patch (diff file) into smaller, logical
changes and apply them one by one with StGIT. When you think al the
big patch was completely applied, pushing it should result in an empty
patch, otherwise you might have missed something that needs applying.

With StGIT you can also pick a commit object from a different branch
as a StGIT patch or you could merge two patches into one.

Once you are OK with the patches in the stack, just ask the gatekeeper
to pull the changes from your tree using plain GIT or mail them
automatically with StGIT.

-- 
Catalin
