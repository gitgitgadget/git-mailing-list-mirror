From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Any overview available on jgit codebase?
Date: Sat, 15 Nov 2008 15:21:50 -0500
Message-ID: <491F2F5E.20206@wellfleetsoftware.com>
References: <200811132059.16616.robin.rosenberg.lists@dewire.com>
 <491C8DBE.9080105@wellfleetsoftware.com>
 <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Sat Nov 15 21:23:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Rfu-0002pS-CV
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 21:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYKOUV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 15:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYKOUV7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 15:21:59 -0500
Received: from vms173005pub.verizon.net ([206.46.173.5]:39855 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYKOUV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 15:21:58 -0500
Received: from [192.168.1.101] ([71.184.206.167]) by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KAE00HPG5WDKI71@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 15 Nov 2008 14:21:50 -0600 (CST)
In-reply-to: <f73f7ab80811140638m4045cf83p311c593aff066002@mail.gmail.com>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101089>


I am looking for any available docs that will help me learn the layout 
of the jgit code base.

In the ideal world here is what would help newbies get productive with 
the project quickly:

1. Have a clear one line description available in the javadocs for each 
package.
2. Have a clear one line description available in javadocs for each 
class in each package.
3. Have a clear one line description available in javadocs for each 
method in each class.

I would gladly do this and contribute the changes back but its a chicken 
and egg situation since I do not know the code base.

I realize its a lot to ask but would anyone familiar with code base 
volunteer to do at least (1) above?

At minimum could anyone tell me what packages and classes to look at in 
order to make changes to jgit so it uses a database instead of 
filesystem to references.

Lastly, where can I find information on the structure of the .git directory?

Thanks for your help.

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
> on a routine basis to .git/refs for debugging purposes.  Then, for
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
