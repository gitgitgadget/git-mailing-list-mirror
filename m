X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ben Greear <greearb@candelatech.com>
Subject: Re: Question on multi-level git repository heiarchy.
Date: Wed, 15 Nov 2006 16:43:04 -0800
Organization: Candela Technologies
Message-ID: <455BB418.80402@candelatech.com>
References: <45419529.3010207@candelatech.com> <20061027052517.GB29057@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 00:43:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061027052517.GB29057@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31535>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkVLm-0003Ij-Jj for gcvg-git@gmane.org; Thu, 16 Nov
 2006 01:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162123AbWKPAn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 19:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162125AbWKPAn1
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 19:43:27 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:8375 "EHLO
 ns2.lanforge.com") by vger.kernel.org with ESMTP id S1162123AbWKPAn0 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 19:43:26 -0500
Received: from [192.168.100.224]
 (static-71-121-249-218.sttlwa.dsl-w.verizon.net [71.121.249.218])
 (authenticated bits=0) by ns2.lanforge.com (8.13.4/8.13.4) with ESMTP id
 kAG0hL7Y023065; Wed, 15 Nov 2006 16:43:22 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Ben Greear <greearb@candelatech.com> wrote:
>> I want to create an intermediate level..something like:
>>
>> kernel.org git tree
>>       |
>> my git master tree
>> /                          \
>> work-station-1   work-station-2  ....
>  
>> I then did a git  checkout -f master on the
>> pub server and did a pull from the upstream kernel.
>> This seemed to work fine.
> 
> Ah, what you really want here is to make your "my git master tree"
> a bare repostiory and use fetch instead of pull.  This way you
> don't need to maintain a working directory of files associated
> with that repository.  So assuming you have "mygitmastertree"
> as the directory do:
> 
> 	mv mygitmastertree/.git mygitmastertree.git
> 	rm -rf mygitmastertree
> 
> and update your workstation .git/remotes/origin files such
> that the URL line reads ".../mygitmastertree.git" rather than
> ".../mygitmastertree/.git".
> 
> Then to update "mygitmastertree" with recent changes you can use
> git fetch rather than git pull:
> 
> 	git --git-dir mygitmastertree.git fetch
>  
>> Then, on the work-station, I did a git checkout -f master, and also did 
>> a pull.
>> In this case, it seems that it is trying to merge with changes in the 
>> lf_v2.6.18 branch
>> instead of the the main 'master' tree (see below).
> 
> When you use "git pull" with no additional arguments the first
> branch listed in a Pull: line of .git/remotes/origin will be the
> branch merged into the current branch.  I don't know what that
> branch is listed as in your workstation tree but from what you
> described it sounds like it may be that lf_v2.6.18 branch, which
> is why its trying to merge it.

I have been using a variation of this with some success.  (I didn't rename the .git directory
on the master tree, but the directory only contains a .git directory so I assume that
I'm using a bare tree....)

I have been able to do 'git pull origin' and 'git push origin master' to
sync and commit my lf_v2.6.18 branch from my work-station repositories (per this page's instructions:
http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html

Now, I would like to fetch down all of the changes from kernel.org to my master
tree and then update my work-station branches.  On the master,
I ran 'git fetch'.  It took a while and seemed to do the right thing.
There is still nothing other than .git in the directory, and subsequent
'git fetch' calls return quickly w/out doing anything.

However, I cannot find an incantation on the work-station machines to
pull down the changes and sync up with kernel.org.

I did a 'git fetch' on the work-station, but gitk still does not show anything
new in 'master' or 'lf_v2.6.18

I tried checking out master and running:  git pull . master
but it said Already up-to-date.

I tried checking out the master branch on the work-station and doing a 'git pull' there.
It got a lot of conflicts from the changes that I had made in the lf_v2.6.18 branch.

I want to have some local branch contain only official kernel patches, and
then fork my own branches off to track my individual changes.  My assumption
was that I could do something like:

git checkout master
git pull

and have master updated with (only) the latest tree from kernel.org and have
lf_v2.6.18 un-touched.

Any pointers are welcome.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
