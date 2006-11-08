X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote
 branches?
Date: Wed, 08 Nov 2006 08:40:45 -0800
Message-ID: <4552088D.6040709@saville.com>
References: <20061107172450.GA26591@spearce.org> <455169D1.8060408@saville.com> <eis0v9$vug$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 16:41:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <eis0v9$vug$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31142>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhqTm-00045f-VT for gcvg-git@gmane.org; Wed, 08 Nov
 2006 17:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161254AbWKHQkn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 11:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWKHQkm
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 11:40:42 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:43709 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1161254AbWKHQkm (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 11:40:42 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 03DDA57A6F; Wed,  8 Nov 2006 08:37:24 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Could you word-wrap your messages at some reasonable column, for example at
> 72 or 76-columns wide?

done

> Wink Saville wrote:
> 
>> As a newbie I'm confused, recently I attempted to get Andrew Morton's
>> -mm "tree".
> 
> Which is unusual git usage, as Andrew Morton uses Quilt/his own patch tools,
> and not git, if I remember correctly.
> 
>> It turns out the instructions were incorrect and Junio was 
>> kind enough to correct the mistake. But I for one am still confused.  
>>
>>   git-fetch is; "Download objects and a head from another repository"
>>
>> Fair enough and that make sense, but where does it go? Apparently it just
>> gets stored in the object database and a reference to it in "FETCH_HEAD".
>> Now what? Ok the documentation says:  
> 
> Objects gets stored into object database. Then (using FETCH_HEAD) heads
> of tracking branches gets updated (i.e. if there were some changes on
> branch 'master' in remote, the objects are downloaded, then head of local
> tracking branch corresponding to remote branch 'master', e.g. 'origin',
> gets updated with the value in 'master'; so called fast-forward case).
>  

OK, so fetch does more than just fetching, it also merges, confusing 
especially given the that the Description says otherwise.

I just searched git-fetch documentation and I see it mentioned under the 
<refspec> documentation. I read the words but why do I have to tell it 
what the source & destination. From my perspective the source is the url 
and the destination is my repository. So refspec doesn't make sense, of 
course it's my problem I'm not blaming git or the documentation. But as 
a newbie I'm confused.

As I continue to investigate the <refspec> documentation it mentions in 
the first "Note" that ".. rewound and rebased frequently, the a pull .." 
. OK, so why is "pull" mentioned here I'm not pulling I'm fetching. Of 
course if you go to the git-pull documentation we see the <refspec> 
repeated. Which maybe isn't surprising since pull is a fetch+merge. So I 
guess the confusing part is that fetch does do merging, even though it 
says it implies it doesn't.

>>   'The information is left for a later merge operation done by "git
>>   merge"' 
> 
> Or done by git pull. The information in FETCH_HEAD is for commit message
> in later merge (for example due to pull).
>  
>> Now in the case of fetching -mm apparently you don't do a merge, instead
>> the instructions now read: 
>>
>>   $ git-fetch \
>>     git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git \
>>     tag v2.6.16-rc2-mm1  
>>   $ git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1
> 
> Are you sure that it is 'tag' there?
> 

Yes, this is directly from Junio.

> BTW. you are actually encouraged to use "git fetch" and "git checkout",
> unless in scripts.
>
>> The git-fetch apparently gets "linux-trees.git" and places a reference to
>> it in a tag named 'v2.6.16-rc2-mm1'. Then the git-checkout, check's out
>> this tag to a new branch, there was no merge! This is confusing and makes
>> no sense to this newbie.   
> 
> The git-fetch fetches _from_ linux-trees.git repository. It fetches tag
> v2.6.16-rc2-mm1 (and its lineage, i.e. everything pointed by this tag,
> transitively) and stores it as local tag v2.6.16-rc2-mm1. You cannot
> checkout tag (you can't commit to tag), so you have to create new branch
> for your changes (or for checkout).
>  
>> Now lets take a quick look at the git-merge documentation "HOW MERGE
>> WORKS": 
>>
>> "A merge is always between the current HEAD and one or more remote branch
>> heads, and the index file must exactly match the tree of HEAD commit (i.e.
>> the contents of the last commit) when it happens. In other words, git-diff
>> --cached HEAD must report no changes."   
> 
> That's a bit untrue, because merge can happen between local branches too.
>  
>> Sorry, there is basically no information in those two sentences that makes
>> any sense to me. Take the first part, "between the current HEAD and one or
>> more remote branch heads". So apparently merges occur against the current
>> checkout branch, but I would guess the origin is also involved somehow? 
> 
> Current HEAD is current checked out branch. You merge current HEAD and one
> or more [remote] branch heads (in the pull case, those not marked
> not-for-merge in FETCH_HEAD), and place result in current branch.
> 
>> Secondly, what is the relationship between "remote branch heads" and
>> FETCH_HEAD? I see no mention of FETCH_HEAD or how it might be used
>> anywhere in the git-merge documentation.
> 
> FETCH_HEAD is low-lewel, not to be used by end-user (unless he/she wants to
> do something unusual).
> 

Then why mention it at all?

>> Then we come to "the index file 
>> must exactly match the tree HEAD commit", sorry but my question is how
>> could it not match? 
> 
> For example if you git-add'ed some files, but not committed the addition.

But if I've added some files, it would seem perfectly reasonable that 
git could still "merge" unless the new files conflicted with new files 
in the fetch.

> 
>> Obviously I don't understand how the index file is 
>> used, but I can say that adding "git-diff --cached HEAD must report no no
>> changes" adds nothing to the explanation, yet I'm sure it does mean
>> something to an expert.          
> 
> It adds command which you can use to check _why_ merge failed to run.
> 
>> It then goes onto say "it may fetch the objects from remote" I thought
>> that is what "fetch" does. 
> 
> IIRC this explanation is in git-pull(1). Pull in git is _fetch_ + merge.
>  

So a source of confusion is fetch also does merging/fast-forwarding, 
this is confusing. Fetch should fetch, merge should merge, pull should 
do both.

Another source of confusion is we start out with two branches after 
cloning _master_ & _origin_. Now if I create my own branch and check it 
out and then do a pull, what is going to be merged where and when?

I need to read, re-read and actually understand git-merge the "Grand 
Unified Merge Driver", I can see it's very powerful but with that power 
comes confusion.

At the moment my current situation is that I've cloned 2.6.19 done some 
pulls created some of my own branches and done a git-fetch on Andrew 
Morton's "tree". In .git/remotes I only have the file origin.

git-branch shows:

wink@winkc2d1:~/linux/linux-2.6$ git-branch
* ace
   local-2.6.19-rc4-mm2
   master
   origin
   w8

In tags I have:

wink@winkc2d1:~/linux/linux-2.6$ ls .git/refs/tags
ace-0.0.1     v2.6.13-rc3  v2.6.15-rc1  v2.6.16-rc5  v2.6.18-rc3
v2.6.11       v2.6.13-rc4  v2.6.15-rc2  v2.6.16-rc6  v2.6.18-rc4
v2.6.11-tree  v2.6.13-rc5  v2.6.15-rc3  v2.6.17      v2.6.18-rc5
v2.6.12       v2.6.13-rc6  v2.6.15-rc4  v2.6.17-rc1  v2.6.18-rc6
v2.6.12-rc2   v2.6.13-rc7  v2.6.15-rc5  v2.6.17-rc2  v2.6.18-rc7
v2.6.12-rc3   v2.6.14      v2.6.15-rc6  v2.6.17-rc3  v2.6.19-rc1
v2.6.12-rc4   v2.6.14-rc1  v2.6.15-rc7  v2.6.17-rc4  v2.6.19-rc2
v2.6.12-rc5   v2.6.14-rc2  v2.6.16      v2.6.17-rc5  v2.6.19-rc3
v2.6.12-rc6   v2.6.14-rc3  v2.6.16-rc1  v2.6.17-rc6  v2.6.19-rc4
v2.6.13       v2.6.14-rc4  v2.6.16-rc2  v2.6.18      v2.6.19-rc4-mm2
v2.6.13-rc1   v2.6.14-rc5  v2.6.16-rc3  v2.6.18-rc1
v2.6.13-rc2   v2.6.15      v2.6.16-rc4  v2.6.18-rc2

In remotes I have:

wink@winkc2d1:~/linux/linux-2.6$ ls .git/remotes
origin

So it would seem that I have no _remote_ connection to AM's tree and 
when I did the fetch it added objects which, from the perspective of 
linus's tree, is just a branch that I could have created by hand.

Now when I do my next git-pull from linu's tree what is going to happen 
with regards to my various branches if we assume that *ace is currently 
checked out.

Here is the current state:

origin			unchanged
master			unchanged
ace			locally modified and currently checked out
w8			locally modified
local-2.6.19-rc4-mm2	unchanged just a checkout of tag v2.6.19-rc4-mm2

Thanks,

Wink

