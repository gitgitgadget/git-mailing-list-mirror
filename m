From: Knut Eldhuset <knut@3d-radar.com>
Subject: Re: Different svn-id URLs in history
Date: Fri, 10 Oct 2008 10:56:32 +0200
Message-ID: <48EF18C0.3050200@3d-radar.com>
References: <48EB40E1.40506@3d-radar.com> <48EB79D8.6090908@drmicha.warpmail.net> <48EC546F.7060106@3d-radar.com> <48EC7022.7030707@drmicha.warpmail.net> <48EC7B52.4000100@3d-radar.com> <48EE132E.1040407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: "git@vger.kernel.org >> Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 11:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoDot-00077A-8P
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 10:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbYJJI4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 04:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbYJJI4s
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 04:56:48 -0400
Received: from epost.nunatak.no ([193.200.93.202]:37349 "EHLO epost.nunatak.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbYJJI4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 04:56:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by epost.nunatak.no (Postfix) with ESMTP id 3AEE2121C9B5;
	Fri, 10 Oct 2008 10:56:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.427
X-Spam-Level: 
X-Spam-Status: No, score=-2.427 tagged_above=-10 required=6.6
	tests=[AWL=0.072, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from epost.nunatak.no ([127.0.0.1])
	by localhost (epost.nunatak.no [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmoDUJUrozwt; Fri, 10 Oct 2008 10:56:32 +0200 (CEST)
Received: from [192.168.169.42] (unknown [194.19.26.200])
	by epost.nunatak.no (Postfix) with ESMTP id B8BF0121C96E;
	Fri, 10 Oct 2008 10:56:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48EE132E.1040407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97916>

Michael J Gruber wrote:
> Knut Eldhuset venit, vidit, dixit 08.10.2008 11:20:
>> Michael J Gruber wrote:
>>> Knut Eldhuset venit, vidit, dixit 08.10.2008 08:34:

<snip>

>>> So, in order to help you, we would need to know
>>>
>>> - the layout of your svn repo: where are trunk, branches and tags, how
>>> did you create branches and tags in svn, are "projects" entirely separate
>> https://server/trunk
>> https://server/branches
>> https://server/tags
>>
>> We really only have one "project" source tree at 
>> https://server/trunk/some_folder/project/src
>>
>> However, once the sources were at
>> https://server/trunk/some_folder/project/old_source
> 
> That may be the source of the trouble. In fact, the log below indicates
> that it is more like the following two paths:
> 
> https://server/trunk/project/old_source
> https://server/trunk/project/src/client
> 

I think my description is correct, but these particular log messages may 
not be the best examples. We did have files and folders in "old_source" 
that moved to "src".

>> Therefore we have the following:
>>
>> $ svn log -v -r4871 https://server/
>> ------------------------------------------------------------------------
>> r4871 | nn | 2007-09-25 13:36:25 +0200 (Tue, 25 Sep 2007) | 3 lines
>> Changed paths:
>>     M /trunk/project
>>     D /trunk/project/old_source/some_file
>>     A /trunk/project/src/client/some_file (from 
>> /trunk/project/old_source/some_file:4795)
>>
>>   commit-message
>> ------------------------------------------------------------------------
>>
>> $ svn log -v -r4869 https://server/
>> ------------------------------------------------------------------------
>> r4869 | nn | 2007-09-25 13:14:34 +0200 (Tue, 25 Sep 2007) | 3 lines
>> Changed paths:
>>     M /trunk/project
>>     A /trunk/project/src
>>     A /trunk/project/src/client
>>
>>   commit-message
>>
>> ------------------------------------------------------------------------
>>
>> $ svn log -v -r4868 https://server/
>> ------------------------------------------------------------------------
>> r4868 | nn | 2007-09-25 13:14:28 +0200 (Tue, 25 Sep 2007) | 3 lines
>> Changed paths:
>>     M /trunk/project
>>
>>   commit-message
>>
> 
> That one is funny. A modified directory but no paths modified
> underneath. Was this a propset?
> 

These give identical output:

svn log -v -r4868 --xml https://server

and

svn log -v -r4868 --with-all-revprops --xml https://server

I don't understand what happened there. It was a commit made with svk, 
so maybe that had something to do with it.

>> ------------------------------------------------------------------------
>>
>> $ svn log -v -r4867 https://server/
>> ------------------------------------------------------------------------
>> r4867 | nn | 2007-09-25 12:04:58 +0200 (Tue, 25 Sep 2007) | 3 lines
>> Changed paths:
>>     M /trunk/project
>>     A /trunk/project/some_file
>>
>>   commit-message
>> ------------------------------------------------------------------------
> 
> Maybe you're trying too hard to disguise things. Are you really adding
> some_file right under project here and under project/src/client in r4871?
> 

No, those were different files... I'm sorry I can't share the repo publicly.

>> r4868 appears twice in git. One commit is on master/trunk and has parent 
>> and child, while the other is on a branch and has no parent.
>>
>>> - your incarnation of git-svn
>>>
>> # git --version
>> git version 1.6.0.2
> 
> I actually meant incantation, I guess I should brush up on my little
> latin, uhm ;)
> 
> So, did you use something like
> 
> git svn init -s https://server/
> 
> or
> 
> git svn init -T trunk/project/src/client -t 'tags/*/project/src/client'
> -b 'branches/*/project/src/client' https://server/
> 

I used

git svn clone -s https://server/

initially. Then I tried

git svn clone -T trunk/project/src -r tags -b branches https://server/

which gave better results. Then I settled on using "-r4869:HEAD".

> My suggestion would to use two svn sections (option "-R") with different
> configs for different repo structures, and to fetch the first one with
> "-r1:4866" and the second one with "-r4871:HEAD". Reorganising the svn
> repo layout can confuse git-svn quite a bit (and understandably so).
> Using different configs for different "epochs" helps. grafts are your
> friend when it comes to connecting the two.
> 
> Michael

Good suggestion. I didn't realize one could do it that way.

Regards,
Knut
