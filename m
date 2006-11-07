X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 11:26:30 +0800
Message-ID: <454FFCE6.70408@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <454F3BED.9010401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 03:27:58 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qaHpsTT7GqH5/Q6R/qSEGumeDJhKTcmiVWEmzYHWCuch1kmnj2RmDh6DR5ar/pu2Q2oApIogokk/+XcAzjqDgB30N7mHOAnewF/FLId9WotjX4HOw50JSLHOrTrEN3MPciMCpLwsBHNxFiLptmi+KfmRZuiSVuiLCdfXSwx639w=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <454F3BED.9010401@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31042>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhHcu-0005Tf-Pt for gcvg-git@gmane.org; Tue, 07 Nov
 2006 04:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753968AbWKGD1e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 22:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbWKGD1e
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 22:27:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:11152 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1753957AbWKGD1d
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 22:27:33 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1261802wxc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 19:27:32 -0800 (PST)
Received: by 10.70.76.13 with SMTP id y13mr6188274wxa.1162870052693; Mon, 06
 Nov 2006 19:27:32 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id h37sm9690449wxd.2006.11.06.19.27.30; Mon, 06 Nov 2006 19:27:31 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:
> Liu Yubao wrote:
> 
> If "fake" commits (i.e., commits that doesn't change any content) are 
> introduced for each merge, it will change the ancestry graph and the 
> resulting tree(s) won't be mergable with the tree it merged with, 
> because each such "back-merge" would result in
> * the "fake" commit becoming part of history
> * a new "fake" commit being introduced
> 
> Consider what happens when Alice pulls in Bob's changes. The merge-base 
> of Bob's tip is where Alice HEAD points to, so it results in a 
> fast-forward, like below.
> 
> a---b---c---d               <--- Alice
>              \
>               e---f---g     <--- Bob
> 
> 
> If, we would have created a fake commit instead, Alice would get a graph 
> that looks like so:
> 
> a---b---c---d-----------h   <--- Alice
>              \         /
>               e---f---g     <--- Bob
> 
> 
> Now, we would have two trees that are identical, because the merge can't 
> cause conflicts, but Alice and Bob will have reached it in two different 
> ways. When Bob decides he wants to go get the changes Alice has done, 
> his tree will look something like this:
> 
> a---b---c---d-----------h          <--- Alice
>              \         / \
>               e---f---g---i        <--- Bob
> 
> 
> He finds it odd that he's got two commits that, when checked out, lead 
> to the exact same tree, so he asks Alice to get his tree and see what's 
> going on. Alice will then end up with this:
> 
> a---b---c---d-----------h---j      <--- Alice
>              \         / \ /
>               e---f---g---i        <--- Bob
> 
> 
> Now there's four commits that all point to identical trees, but the 
> ancestry graphs differ between all developers. In the case above, 
> there's only two people working at the same project. Imagine the amount 
> of empty commits you'd get in a larger project, like the Linux kernel.
> 
Oh, you remind me, but I have a naive solution for this problem: print
a hint and don't merge commits that contain fake commit, then I know I have
reached a stable merge point and have same tree with others.

We create a fake commit for fast forwarding style merge, this fake commit
is used to record the track of a branch, so we can always follow HEAD^1
to travel through the history of a branch. In fact, git pays more attention
to the history of *data modification* than history of *operation*, that is
right the subtle difference between content tracker and VCS, latter's branch 
has more information(useful information, I think).

Even if no fake commit is created as git does now, there can be multiple
commits with identical tree object, and git can't prevent you from merging
two commits with identical tree object, it just creates an ancestry relation
to remember the merge point.

As git(7) says:
         The "commit" object is an object that introduces the notion
         of history into the picture. In contrast to the other objects,
         it doesn't just describe the physical state of a tree, it
         describes how we got there, and why.

So it's clearer to describe a revision graph with nodes for tree
objects and edges for commit objects(multiple edges for a merge
commit object, I know this will break your habit:-).

> Fast-forward is a Good Thing and the only sensible thing to do in a 
> system designed to be fully distributed (i.e., where there isn't 
> necessarily any middle point with which everybody syncs), while scaling 
> beyond ten developers that merge frequently between each other.
> 
>> If we throw away all compatibility, efficiency, memory and disk 
>> consumption
>> problems,
>> (1) we can get the track of a branch without reflog because HEAD^1 is
>> always the tip of target branch(or working branch usually) before 
>> merging.
>>
>> (2) with the track, branch mechanism in git is possibly easier to 
>> understand,
>> especially for newbies from CVS or Subversion, I really like git's 
>> light weight, simple but powerful design and great efficiency, but I 
>> am really
>> surprised that 'git log' shows logs from other branches and a side 
>> branch can become part of main line suddenly.
>>
>> A revision graph represents fast forwarding style merging like this:
>>
>>             (fast forwarding)
>>  ---- a ............ * ------> master
>>        \            /
>>         b----------c -----> test         (three commits with three trees)
>>
>> can be changed to:
>>
>>  ---- a (tree_1) ----------- d (tree_3) ------> master
>>        \                    /
>>         b (tree_2) ------- c (tree_3) ----> test
>> (four commits with three trees, it's normal as more than one way can 
>> reach Rome :-)
>>
> 
> That's where our views differ. In my eyes, "d" and "c" are exactly 
> identical, and I'd be very surprised if the scm tried to tell me that 
> they aren't, by not giving them the same revid.
It doesn't matter, they have same tree, and it's normal too in git
multiple commits have same tree, if you use nodes for tree state,
that graph will be simple to understand:

           a              d
         -----tree_1 -------------- tree_3 ----> master
                  \                    / \
                   \ b               d/c  `-----> test
                    \                /
                     `--- tree_2 ---'

This is the familiar way we used in CVS, I believe there are more
than one people confused by fast forwarding style merge and 'git log'
