From: Andreas Ericsson <ae@op5.se>
Subject: Re: out of memory problem
Date: Mon, 22 Sep 2008 09:32:07 +0200
Message-ID: <48D749F7.3030008@op5.se>
References: <alpine.LFD.2.00.0809211556030.19373@homelinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Guo Tang <tangguo77@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 09:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khfv3-0000JJ-79
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 09:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbYIVHcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 03:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYIVHcI
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 03:32:08 -0400
Received: from mail.op5.se ([193.201.96.20]:54953 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbYIVHcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 03:32:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 62D5A1B800F3;
	Mon, 22 Sep 2008 09:22:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.449
X-Spam-Level: 
X-Spam-Status: No, score=-3.449 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.950, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CuJ4kqVcxBUj; Mon, 22 Sep 2008 09:22:27 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1001D1B80050;
	Mon, 22 Sep 2008 09:22:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.2.00.0809211556030.19373@homelinux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96453>

Guo Tang wrote:
> Gentlemen,
> 
> I try to run "git gc" on linux kernel tree. The virtual memory keeps 
> going up until over 3GB, then crash. 
> Tried twice with the v1.6.0.2, same result.
> Then I used the git coming with FC9 (v1.5.5.1), the peak virutal memory 
> usage is about 1.5GB. "git gc" finished without any trouble. 
> 
> Could there be a memory leak in v1.6.0.2?
> 

There could be, but most likely it's commit
38bd64979a2a3ffa178af801c6a62e6fcd658274 (Enable threaded delta
search on BSD and Linux). Do you have multiple cpu's in the
computer where 'git gc' was running? If so, and if you've set
pack.threads = 0, or --threads=0 it will autodetect the number
of CPU's you have and then saturate all of them with work. Each
thread will however consume memory close to that of a single
process running the repack, so for large repositories you might
want to set pack.threads = 1 in such large repositories.

It's a shame you didn't save the unpacked repository, or this could
have been properly debugged. While it's possible there is a memory
leak, it's a dismal project trying to locate it by staring at the
code, and the time it takes to repack huge repositories with memory
intensive parameters is sort of prohibitive for finding the possible
leak by bisection.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
