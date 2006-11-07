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
Date: Tue, 07 Nov 2006 20:05:38 +0800
Message-ID: <45507692.7050100@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <454F3BED.9010401@op5.se> <454FFCE6.70408@gmail.com> <4550522D.9060503@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 12:07:39 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=i6jopAURFxJ1MCutjrEJFkMcbpAiEIPF821owDUbOpfOr+JQ5p54rBoAYgj7PfjUGu+Hzw2p5zB0z5W6tg2thOjgaFbgJbH5ee7/qPSThpDGcWvwrDYtu0VuLFn2k1A/247Ka7hu5VWUAWYKQEveICKlEFkRRSdNZuldjwcdEtI=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <4550522D.9060503@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31065>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhPjj-0000oy-71 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 13:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754206AbWKGMGn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 07:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbWKGMGn
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 07:06:43 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:40586 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1754206AbWKGMGm
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 07:06:42 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1380647wxc for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 04:06:41 -0800 (PST)
Received: by 10.70.21.10 with SMTP id 10mr7029394wxu.1162901201386; Tue, 07
 Nov 2006 04:06:41 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 33sm7197499wra.2006.11.07.04.06.38; Tue, 07 Nov 2006 04:06:40 -0800 (PST)
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft wrote:
> Liu Yubao wrote: 
> But in that situation you and Alice now have different actual history
> DAG's in your repositories.
> 
> Alice sees:
> a---b---c---d-----------h
>              \         /
>               e---f---g
> 
> Bob sees:
> a---b---c---d-----------h
>              \         / \
>               e---f---g---i
> 
> 
> If bob now adds a new commit 'j' and alice pulls it back we either have
> to then accept 'i' at alice's end or forever lose the identicality of
> the commit DAG.  At which point our primary benefit of the SHA1 ==
> parent == same commit for everyone is gone.  We can no longer say "this
> commit is broken" and everyone know which commit that is.
> 
Alice and bob have their own branch scope view respectively, they have two
different branches, their DAGs in *branch scope view* can
be different because they trace the history from different points.

In branch scope view, you see only one HEAD, it merges changes from
other branches. Each branch has its own commit DAG.

In global scope view, you see many HEADs, they fork and merge frequently,
here is only one big commit DAG, but you can never see the whole as branches
can be distributed over the world.

Fake commit doesn't break the DAG in global scope view, it has parents
as normal commit although the trees pointed by fake commit and its parent
are same. In fact, git has suck commit already:

   a (tree_1) -------  b (tree_2)  ---- d (tree_2) ---> master
    \                                    /
     `---------------  c (tree_2) ------' -----> test

If you don't pull from other, you can get different global DAG, it's normal 
obviously. It doesn't matter you get different DAG in branch scope, of course
they are different.

The problem is you can't get branch *track* from global scope view in git, you
can't tell which commits a branch has *referred to*. Note following HEAD^1 
isn't right as Junio pointed out 
(http://marc.theaimsgroup.com/?l=git&m=116279354214757&w=2).

Branch track is useful as people have requested reflog feature (realized, but
only for local purpose) and "note" extension in commit object.

If you have a commit A that I haven't pulled, I can't know what you
refer to when you say "Commit A introduced a bug". I must know where
to get this commit. After I pull it from other branch, We can say "this
commit is broken" and everyone know which commit that is.

>> We create a fake commit for fast forwarding style merge, this fake commit
>> is used to record the track of a branch, so we can always follow HEAD^1
>> to travel through the history of a branch. In fact, git pays more attention
>> to the history of *data modification* than history of *operation*, that is
>> right the subtle difference between content tracker and VCS, latter's
>> branch has more information(useful information, I think).
> 
> Any VCS is concerned with data modification and how its tracked.  There
> are two ways you can record history.  A series of snapshots (git) or a
> series of operations (eg cvs and svn).  Each has its trade offs,
> operations like diff on snapshots is O(number of files), on diffs they
> are O(number of files * number of deltas).
> 
> The difference here is all about the interpretation of the word
> 'branch'.  In CVS and others there is the hard concept of a mainline --
> here is the master copy when something is added here it is "the one",
> branches are temporary places which contain 'different' history such as
> a patch branch.  You want something on both branches you commit the
> change twice once to each.  In git they are more separate future
> histories.  When they are merged back together the new single history
> contains the changes in both, neither is more important than the other
> both represent forward progress.  People tend to draw as below giving a
> false importance to the 'line' from d->h:
> 
> a---b---c---d-----------h
>              \         /
>               e---f---g
> 
> We probabally should draw the below, h's history contains all history
> from both 'up' and 'down' histories.  Which is more important?  Neither.
>  h is made up of a,b,c,d from alice and e,f,g from bob merged by alice.
> 
>               ---------
>              /         \
> a---b---c---d           h
>              \         /
>               e---f---g
> 
> 
If fake commit is introduced, a possible revision graph is like this:

   a - * -- c  ------- * ---> branchA
    \ /      \         /
     b ------ * ---- d ---> branchB      ('*' stands for fake commit)

It's indeed not pretty as a linear revision graph that git's fast forwarding
style merge creates, but it can record the tracks of two branches by following
HEAD^1.
