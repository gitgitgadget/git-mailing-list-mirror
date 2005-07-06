From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Wed, 06 Jul 2005 08:01:38 -0400
Message-ID: <42CBC822.30701@didntduck.org>
References: <20050703234629.GF13848@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 14:06:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq8ef-0001DH-IV
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 14:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVGFMEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 08:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGFMDE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 08:03:04 -0400
Received: from quark.didntduck.org ([69.55.226.66]:53651 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262248AbVGFMA5
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 08:00:57 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j66Bxux02838;
	Wed, 6 Jul 2005 07:59:56 -0400
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050703234629.GF13848@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
>   Hello,
> 
>   I'm happy to announce the release of the 0.12 version of the Cogito
> SCM-like layer over Linus' GIT tree history storage tool. Get it at
> 
> 	http://www.kernel.org/pub/software/scm/cogito/
> 
> or cg-update if you have an older version cloned.
> 
>   I wanted to release it later with more cool features, but after all
> releasing often is good and people will get to test things more, and
> I wanted to make it possible for kernel.org to upgrade to newer RPM.
> But it may not be as stable as I'd wish and may have some rough edges,
> so be warned.
> 
>   This release contains the latest stuff from Linus, with all the
> packing stuff and everything. Other things include heaps of bugfixes,
> enhanced options parsing, ~/.cgrc support, cg-push, real cg-tag, and
> plenty of smaller but nice stuff. And more to come in next days!
> 
>   About cg-push, it:
> 
>   (i) works only locally or over git+ssh branches
> 
>   (ii) the head updated on the other side must be 'master' too
> 	(high priority to fix)
> 
>   (iii) the head updated on the other side is re-created, thus losing
> 	all attributes (ownership, permissions)
> 	(high priority to fix)
> 
>   (iv) won't update the remote working tree if there is any associated
> 	with the repository - do cg-cancel to catch up, but that will
> 	lose any local changes you did (note that I plan to rename
> 	cg-cancel to cg-reset)
> 
>   Also, I've deprecated rsync, as I explained in another mail. Use
> cg-branch-chg to change the branch URLs to some more sensible scheme -
> most likely HTTP, or SSH if you want to push as well.

I really question removing rsync before HTTP pulls become more 
effecient.  I did a complete pull of cogito from kernel.org, and http 
took over 50 minutes to pull everything, while rsync was done in just 
over 1 minute.  I dared not even try to pull the full kernel at that speed.

I suspect that part of the problem is that the pull methods are doing a 
depth first search, so we can't request the next object until the 
current object is fully received and parsed.  Changing to a breadth 
first search would allow multiple requests in flight and asynchronous 
processing which should speed things up.  I am exploring using the 
curl_multi_* functions to do this, but this will require changes to 
common code in pull.c.

--
				Brian Gerst
