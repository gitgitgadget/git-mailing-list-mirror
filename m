From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'sparse' clone idea
Date: Wed, 14 Jun 2006 11:44:41 +0200
Organization: At home
Message-ID: <e6olpv$77s$1@sea.gmane.org>
References: <e6oh2g$ngh$1@sea.gmane.org> <Pine.LNX.4.63.0606141110001.15673@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 14 11:45:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqRvl-0005ek-Ki
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 11:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWFNJoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 05:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWFNJoy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 05:44:54 -0400
Received: from main.gmane.org ([80.91.229.2]:22466 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964796AbWFNJox (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 05:44:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FqRvY-0005e1-Hz
	for git@vger.kernel.org; Wed, 14 Jun 2006 11:44:44 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 11:44:44 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 11:44:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21838>

Johannes Schindelin wrote:

> On Wed, 14 Jun 2006, Jakub Narebski wrote:
> 
>> I wonder if 'sparse clone' idea described below would avoid the most
>> difficult part of 'shallow clone' idea, namely the [sometimes] need to
>> un-cauterize history. See: (<7vac8lidwi.fsf@assigned-by-dhcp.cox.net>).
> 
> I do not think that is the hardest problem. The hardest thing is to tell 
> the server in an efficient manner which objects we have.
> 
> Example:
> 
> A - B - C - D
>     ^ cutoff
>         ^ current HEAD
> 
> Suppose B is your fake root, C is your HEAD, you want to fetch D. Now, 
> make it a difficult example: both A and D contain a certain blob Z, but 
> neither B nor C do. You have to tell the server _in an efficient manner_ 
> to send Z also.
> 
> And by efficient manner I mean: you may not bring the server down just 
> because 5 people with shallow clones decide to fetch from it.

Nah, that I think is solved. Check the mentioned post by Junio C Hamano
in the "Re: Figured out how to get Mozilla into git" post:

 http://permalink.gmane.org/gmane.comp.version-control.git/21603

(although it would need extension to the git protocol). Client and server 
do graft exchange both ways, limiting the commit ancestry graph the both
ends walk to the intersection of the fake view of the ancestry graph both
ends have. Then server uses those virtual grafts to calculate which objects
to send.

The rest is done (or should be done) by history grafting code.

>>  * merge bases for all commits in full, and in the sparse part,
>>    _including_ merge bases themselves
> 
> Hmmm. You cannot know _all_ merge bases beforehand, because you do not 
> decide where other people fork off.

By all merge bases I mean merge bases for all commits in full part, merge
bases for all commits in full part and commits pointed by tags in sparse
part, merge bases for all commits in full part and tagged in sparse part
and merge bases in sparse part etc. recursively.
 
>>  * all roots
> 
> Why?

Just in case, as an ultimate merge bases.
 
> P.S.: I think the problems of a lazy clone are much easier to solve...

I still think that the correct idea for the lazy clone is to have soft
grafts, so you have to solve at least part of shallo clone/sparse clone
problems first.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
