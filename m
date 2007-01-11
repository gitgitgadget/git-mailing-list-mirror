From: Andreas Ericsson <ae@op5.se>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 15:28:23 +0100
Message-ID: <45A64987.60200@op5.se>
References: <45A63E59.7030009@op5.se> <20070111135918.GO1759@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 15:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H50uq-0008MJ-QM
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 15:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbXAKO20 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 09:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbXAKO20
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 09:28:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55705 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030200AbXAKO2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 09:28:25 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DE34F6BCBC; Thu, 11 Jan 2007 15:28:23 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070111135918.GO1759@mellanox.co.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36594>

Michael S. Tsirkin wrote:
>>> I hit a quota limit on a disk my tree was on, but did not notice.
>>> Doing git pull on a tree seems to have corrupted it.
>>> Now I have:
>>>
>>> $ git-fsck-objects
>>> error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
>>> error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
>>> missing tree 10147d79b2418168d9433067b6439971bd4f1261
>>> broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
>>>               to    tree 10147d79b2418168d9433067b6439971bd4f1261
>>> dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
>>>
>>> The tree can not be pulled into, or from.
>>>
>> Can you do a "git rev-list" on the commit pointing to this tree?
> 
> On which commit?
> 

322a6c93ad86d2a151dd97a4c6b0e014a4893437

>> If so, you should be able to do "git reset HEAD~1" and re-do the fetch.
> 
> $ git reset --hard HEAD~1
> HEAD is now at 2d41bf8... Remove svn keywords
> $ git-fsck-objects
> error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
> error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
> missing tree 10147d79b2418168d9433067b6439971bd4f1261
> broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
>               to    tree 10147d79b2418168d9433067b6439971bd4f1261
> dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
> 

Humm... Seems there are other problems here.

Try

$ git reset --hard 322a6c93ad86d2a151dd97a4c6b0e014a4893437~1
$ git fsck-objects HEAD

If this tells you your repo is clean, you should be able to redo 
whatever fetches you did on top of that to get a working repository 
again. If you have objects that got half-written due to end-of-disk 
errors, you'd have to do "git prune" after resetting.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
