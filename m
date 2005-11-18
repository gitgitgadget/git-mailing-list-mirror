From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Sat, 19 Nov 2005 00:45:48 +0100
Message-ID: <437E67AC.2010400@op5.se>
References: <20051117193714.428785C7FA@nox.op5.se>	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se> <7voe4hfssj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 00:47:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdFvV-0006oa-N7
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVKRXpu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVKRXpu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:45:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:9185 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751218AbVKRXpu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 18:45:50 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DC4D16BCFE; Sat, 19 Nov 2005 00:45:48 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe4hfssj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12286>

Junio C Hamano wrote:
> 
> I think it might make sense to inserting something like the
> attached untested patch in your series, between library and
> upload-pack.

I'll run the clone/fetch/push test-suite again tomorrow, with this 
applied. It looks good though.

>  The validation done by path_ok() in git-daemon
> probabaly needs to lose alternate checks and validate only the
> path returned by enter_repo().  This would make writing
> whitelist by git-daemon administrator a bit more cumbersome,


Not necessarily. The repositories in the whitelist should be validated 
(and possibly converted) using the path_ok() function. This will also 
make it possible to catch typos and permission errors that are just 
plain annoying for the admins.

In non-strict mode this isn't really a problem so long as all 
whitelist-paths are absolute and doesn't contain any symlinks, although 
we could use the chdir() + getcwd() thingie since we don't need the 
ability to go back to where we started and that's what will be used 
later when serving the repos.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
