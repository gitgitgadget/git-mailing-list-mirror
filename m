From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 16:29:15 -0400
Message-ID: <42E1571B.8070108@gmail.com>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>	<20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:31:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4AN-0000pm-DV
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 22:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVGVUaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVGVUaP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 16:30:15 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:43849 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262158AbVGVU3o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 16:29:44 -0400
Received: by wproxy.gmail.com with SMTP id i36so446932wra
        for <git@vger.kernel.org>; Fri, 22 Jul 2005 13:29:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sVv1oRqLjNx0ma/sQeRkeEkEESA3XlmykWzFiyQXd415fh6LQiFYpi9FbJxaOEda8D3i8ovVYr2njMi4wMO2pFnmeWQh9+2IKbDXgYHNmD2BanZb/Xw0Lhc6ehzirGbpJbsOuAHMbK9Tt5Crlm/4PSXoVMR5jHHv2EoKynI1YOg=
Received: by 10.54.68.4 with SMTP id q4mr1472104wra;
        Fri, 22 Jul 2005 13:29:29 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 8sm1617045wrl.2005.07.22.13.29.27;
        Fri, 22 Jul 2005 13:29:29 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
>>On Fri, Jul 22, 2005 at 09:56:19AM -0700, Junio C Hamano wrote:
>>>Now if we had a mechanism to graft a later history which starts
>>>at 2.6.12-rc2 on top of this earlier history leading up to
>>>it,...  ;-)
>>We do - it's not even very hard, we just end up with 2 commits for every
>>change/merge that's unique to git, until we get to the current head:
> 
> Aren't you essentially rewriting the history after 2.6.12-rc2?.
> I suspect that would invalidate the current linux-2.6 history
> people have been basing their work on since 2.6.12-rc2, which is
> unacceptable.  That is not what I meant by "grafting".
> 
> What I meant was to give a hint to the core that says "this
> 2.6.12-rc2 commit in the current linux-2.6.git tree is recorded
> as not having a parent, but please consider it the same as this
> other 2.6.12-rc2 commit in the 2.4.0->2.6.12-rc2 history when
> traversing the commit ancestry chain".
> 
> If git-rev-list is taught about that, then you will see "git
> log" going across 2.6.12-rc2.  If git-merge-base is taught about
> that, it will be able to find a merge base to merge a line of
> development that is forked from say 2.6.11 to the current tip of
> linux-2.6 tree.

I think that "rewriting history" in this case may be the better option 
in _this_ case. But only because the tools are new and the users are 
understanding. :-)

To do it without the history rewrite, create an alternate_history 
directory under .git with it's own objects tree. And populate that 
object tree with "alternative" content for the objects in the normal 
trees. Then teach the things the lookup/read objects to look there first 
and to _not_ care about invalid SHAs. Of course, if you do this, you 
will never be able to trust your repository.
