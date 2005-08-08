From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: use of temporary refs in resolve
Date: Mon, 08 Aug 2005 11:26:20 +0100
Message-ID: <tnxr7d4vi5v.fsf@arm.com>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
	<tnxk6iwx161.fsf@arm.com> <7vfytkdcgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 12:28:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E24qT-00027X-JO
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 12:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVHHK06 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 06:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVHHK06
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 06:26:58 -0400
Received: from fw-nat.cambridge.arm.com ([193.131.176.54]:27582 "EHLO
	ZIPPY.Emea.Arm.com") by vger.kernel.org with ESMTP id S1750812AbVHHK06
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 06:26:58 -0400
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 8 Aug 2005 11:26:52 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfytkdcgm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 08 Aug 2005 02:06:49 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 08 Aug 2005 10:26:52.0445 (UTC) FILETIME=[B15D64D0:01C59C03]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>> Is FETCH_HEAD going to be preserved by the git-fetch-script operation?
>> It should be, unless, git-pull-script removes it or it is changed to
>> do the fetch as well.
>
> I am not quite sure what is being asked (especially "operation";
> I take it you meant "surgery" or "butchering"), so my answer may
> be missing the point.

OK, I wasn't that clear. Currently git-fetch-script stores the fetched
head in the FETCH_HEAD file and git-pull-script uses this file to do
the merging (by passing its content to git-resolve-script). Anyway, I
can easily change StGIT to only use git-pull-script directly, without
the intermediate fetch.

> I would like to update fetch to deal with multiple references,
> and if the user tells it to fetch N references, the FETCH_HEAD
> file would contain N lines, one line for each SHA1 object name.
> Initially I will not allow pull to take more than one reference
> because I will need to make resolve capable of resolving more
> than two parents (i.e. octopus merge) before that happens.  But
> once that is done, then pull will accept N references and call
> fetch with these N references, then fetch leaves N lines in
> FETCH_HEAD, and those N SHA1 object names along with the current
> head would be given to resolve to create an (N+1)-head king
> ghidorah.  I do not know how well this would go, but at least
> that is the current plan.

It might be hard to deal with conflicts resulted from merging N > 2
heads at the same time. I suspect it would call 'merge' (diff3) for
every new head but it might not be that obvious which head merging
failed (it depends on how you implement it). A way of continuing the
merge for the rest of the fetched heads after a failure needs to be
available.

-- 
Catalin
