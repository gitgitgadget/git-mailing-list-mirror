From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: Any plans to support JTA and XA in jgit?
Date: Fri, 14 Nov 2008 09:45:51 -0500
Message-ID: <491D8F1F.7090803@wellfleetsoftware.com>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com>
 <491C8DBE.9080105@wellfleetsoftware.com>
 <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 15:47:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0zwy-0006Zl-EH
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 15:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbYKNOpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 09:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYKNOpx
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 09:45:53 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:38332 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYKNOpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 09:45:52 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAB00D3HVOF3VZ1@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 14 Nov 2008 08:45:52 -0600 (CST)
In-reply-to: <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100980>



Kyle Moffett wrote:
> On Thu, Nov 13, 2008 at 3:27 PM, Farrukh Najmi
> <farrukh@wellfleetsoftware.com> wrote:
>   
>> The problem I am trying to solve is this. In my service I need to store
>> metadata in a relational db and content in git such that both either commit
>> or not in a single transaction. If one commits and the other does not that
>> is a serious integrity issue. Seems to me, two phase commit would be the
>> right solution for that in the long run. This what JDBC + JMS topologies do.
>>     
>
> That's really easy!  First tweak jgit so that *instead* of using
> .git/refs, it uses your database to store references and exports them
> on a routine basis to .git/refs for debugging purposes.  
Wow! This does sound simple in theory. Of course I have much to learn 
about jgit code base first.
Any pointers on what parts of the code are involved that I should start 
looking at? I would hate to
keep a fork of gjit around. Would this work be of interest to the 
project if it could be done in a way
that a few properties control whether to use database or not?

Thanks Kyle!

> Then, for
> each database update:
>
> (1)  Start transaction
> (2)  Commit the change to GIT (adds ref update to the transaction)
> (3)  Make other metadata updates
> (4)  Commit transaction
>
> Then set up periodic garbage collection and you're done!  If the
> transaction is aborted, there will simply be a bunch of random loose
> objects in the git repository, which will be cleaned up the next time
> you garbage collect.  The ref update will be atomic and conditional
> with the rest of the transaction, and in git the *only* part that
> really matters for atomicity is the ref.
>
> Cheers,
> Kyle Moffett
>
>   


-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
