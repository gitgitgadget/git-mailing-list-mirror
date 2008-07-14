From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Errors importing Apache Synapse SVN using Git
Date: Mon, 14 Jul 2008 11:14:33 +0200
Message-ID: <487B18F9.5090908@fastmail.fm>
References: <4875F5D6.9080906@wso2.com> <4875FA23.30603@wso2.com> <48774A0F.2070805@fastmail.fm> <20080714081615.GB10304@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, asankha@wso2.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 11:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIK9q-0002Th-Ua
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 11:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbYGNJOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbYGNJOt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 05:14:49 -0400
Received: from main.gmane.org ([80.91.229.2]:45450 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891AbYGNJOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 05:14:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KIK8s-0006JR-PI
	for git@vger.kernel.org; Mon, 14 Jul 2008 09:14:46 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 09:14:46 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 09:14:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <20080714081615.GB10304@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88405>

Eric Wong venit, vidit, dixit 14.07.2008 10:16:
> Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
>> Asankha C. Perera venit, vidit, dixit 10.07.2008 14:01:
>>> Hi All
>>>
>>> I am an Apache Synapse developer, and want to import the Synapse SVN 
>>> repo into Git, so that Ohloh can properly get the Synapse history 
>>> (http://www.ohloh.net/topics/1326?page=1#post_6287)
>>>
>>> However, when I try the command: "git svn clone --trunk=trunk 
>>> --tags=tags --branches=branches http://svn.apache.org/repos/asf/synapse" 
>>> it seems to take forever, (or at least until the next network glitch), 
>>> and keeps filling up a file with just plain zeros ("0") : 
>>> ./.git/svn/trunk/.rev_db.13f79535-47bb-0310-9956-ffa450edef68
> 
> The latest versions of git-svn should be vastly more space efficient
> with .rev_map files.
>  
>> Okay, besides the zero offset, there seems to be big problem with the 
>> svn repo:
>>
>> svn list -r 234478 http://svn.apache.org/repos/asf/synapse
>> branches/
>> site/
>> tags/
>> trunk/
>>
>> svn list -r 234478 http://svn.apache.org/repos/asf|grep synapse
> 
> Ah, that's because it started off in the /incubator directory, not /synapse:
> 
> $ svn log -v -r 234478 http://svn.apache.org/repos/asf
> ------------------------------------------------------------------------
> r234478 | dims | 2005-08-22 05:39:51 -0700 (Mon, 22 Aug 2005) | 3 lines
> Changed paths:
>    A /incubator/synapse/branches
>    A /incubator/synapse/site
>    A /incubator/synapse/tags
>    A /incubator/synapse/trunk
> 
> init synapse SVN

Yes, and later on there was some more moving around to 
"webservices/synapse/synapse", ".../syaps2", ".../synapse" (i.e. 
renaming "synapse/synapse" to "synapse") and then to the final destination.

Some svn client command know how to follow moves, other don't. I can't 
make them return results by using peg revisions, but I don't know how 
git-svn handles them.


> ------------------------------------------------------------------------
> 
>> Right, nothing returned.
>>
>> git-svn insists on using http://svn.apache.org/repos/asf as the base 
>> URL, which is basically correct, but doesn't work for this repo.
>>
>> Even editing .git/config and .git/svn/metadata (after git svn init, 
>> befire the first fetch) to change the url doesn't help. git svn still 
>> uses .../asf. Is this as intended? cc'ing the git svn author.
> 
> Can you try using the latest git-svn and also --no-follow-parent?
> 
> --no-follow-parent won't traverse copy history so it may be faster,
> but you'll get an incomplete history.
> 
> On the other hand, it looks like the asf repo is hopelessly slow
> for history retrieval.
> 
> I'm pulling the asf log (svn log -v http://svn.apache.org/repos/asf >
> tmp.log) but it's taking forever...  git-svn uses basically the same
> operation as 'svn log -v' and I've yet to see an SVN server take this
> long to show history.
> 
> I've gotten 70,000 revisions after over one hour with the above svn log
> command.  I'm going to restart this from a server with a better
> connection since I need to power off this one when I sleep.

Note that I'm not the OP, I'm just a git-svn user who got curious about 
that post. I think the asf repo shows exactly those mistakes which svn 
drives its users into (and which I've made also, on a much smaller 
scale, of course). As far as I understand, the synapse repo there is 
historical, and they need to convert to git in order to feed it into a 
CMS. I don't know if OP is still interested.

Michael
