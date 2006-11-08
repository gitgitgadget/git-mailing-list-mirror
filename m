X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote branches?
Date: Wed, 8 Nov 2006 18:36:22 +0100
Message-ID: <200611081836.22779.jnareb@gmail.com>
References: <20061107172450.GA26591@spearce.org> <eis0v9$vug$1@sea.gmane.org> <4552088D.6040709@saville.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 17:36:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cYs8e4ANvLKVNIya9iCidC3dknWMHOFoD74BezTAw14n8Pxmji0YxUxlaNx0SDYywrfoGpZkOIGacalwd+xmave1aAVRz0mUVZq825T2d9r/p235N3TY5VRXRV04PPEvKBDZT+6OMf7NcHwPuspQLfctNyiCndSqLUzXGw7qqlM=
User-Agent: KMail/1.9.3
In-Reply-To: <4552088D.6040709@saville.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31147>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhrLI-0007UH-S6 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 18:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754609AbWKHRf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 12:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbWKHRf6
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 12:35:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4489 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754609AbWKHRf5
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 12:35:57 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1587162ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 09:35:55 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr11267847ugm.1163007347498; Wed,
 08 Nov 2006 09:35:47 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id i39sm8092352ugd.2006.11.08.09.35.46; Wed, 08 Nov
 2006 09:35:47 -0800 (PST)
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org

Please leave only the parts you are replying to when replying.
Thanks in advance.

Wink Saville wrote:
> Jakub Narebski wrote:
>> Wink Saville wrote:
>> 
>>> It turns out the instructions were incorrect and Junio was 
>>> kind enough to correct the mistake. But I for one am still confused.  
>>>
>>>   git-fetch is; "Download objects and a head from another repository"
>>>
>>> Fair enough and that make sense, but where does it go? Apparently it just
>>> gets stored in the object database and a reference to it in "FETCH_HEAD".
>>> Now what? Ok the documentation says:  
>> 
>> Objects gets stored into object database. Then (using FETCH_HEAD) heads
>> of tracking branches gets updated (i.e. if there were some changes on
>> branch 'master' in remote, the objects are downloaded, then head of local
>> tracking branch corresponding to remote branch 'master', e.g. 'origin',
>> gets updated with the value in 'master'; so called fast-forward case).
>>  
> 
> OK, so fetch does more than just fetching, it also merges, confusing 
> especially given the that the Description says otherwise.

No, git-fetch just (for each head/each branch) download the changes,
_and_ updates head i.e. pointer to the downloaded changes. Without updating
head you wouldn't be able to access downloaded changes. git-fetch doesn't
do merge: it does only fast-forward.

For example, if you have on your branch 'next':

  [local]   A---B---C <-- next

and the repository you fetch from has few more commits:

  [remote]  A---B---C---D---E <-- next

git-fetch downloads the objects (see that graoh for [local] is subgraph
of graph for [remote] - this is fast-forward case)

  [local]   A---B---C---D---E
                    ^
                    \--- next

and then updates next, but only in fast-forward case (the exception being
that you can demand fetch also for non-fast forward case)

  [local]  A---B---C---D---E <-- next

> I just searched git-fetch documentation and I see it mentioned under the 
> <refspec> documentation. I read the words but why do I have to tell it 
> what the source & destination. From my perspective the source is the url 
> and the destination is my repository. So refspec doesn't make sense, of 
> course it's my problem I'm not blaming git or the documentation. But as 
> a newbie I'm confused.

The confusion seems to descend from the fact, that there can be multiple
branches in git repository. When fetching, you must provide the URL to the
repository, which remote branches do you want to download, and what those
tracking branches should be named in your repository. You can create shortcut
name which contains all those info: the URL of repository and the <refspecs>,
i.e. mapping from remote branches (which you want to download) names to the
local branch names (what you want to save them as...) either as so called
'remotes' file (file in .git/remotes) or, in latest version of git, in the
repository config. git-clone (or git-clone --use-separate-remotes)
creates remote file called 'origin', so you can use "git fetch origin" to
fetch the changes made since the time you cloned the repository or fetched
from it.
 
> As I continue to investigate the <refspec> documentation it mentions in 
> the first "Note" that ".. rewound and rebased frequently, the a pull .." 
> . OK, so why is "pull" mentioned here I'm not pulling I'm fetching. Of 
> course if you go to the git-pull documentation we see the <refspec> 
> repeated. Which maybe isn't surprising since pull is a fetch+merge. So I 
> guess the confusing part is that fetch does do merging, even though it 
> says it implies it doesn't.

Again: fetch does not do merging. It's historical that the fetch refspecs
are called "Pull:" lines.

>>> Now in the case of fetching -mm apparently you don't do a merge, instead
>>> the instructions now read: 
>>>
>>>   $ git-fetch \
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git \
>>>     tag v2.6.16-rc2-mm1  
>>>   $ git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1
>> 
>> Are you sure that it is 'tag' there?
> 
> Yes, this is directly from Junio.

Ooops, I haven't read git-fetch(1) carefully enough:

  Some short-cut notations are also supported.

  * tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>;  it
    requests fetching everything up to the given tag.

>>> Secondly, what is the relationship between "remote branch heads" and
>>> FETCH_HEAD? I see no mention of FETCH_HEAD or how it might be used
>>> anywhere in the git-merge documentation.
>> 
>> FETCH_HEAD is low-lewel, not to be used by end-user (unless he/she wants to
>> do something unusual).
> 
> Then why mention it at all?

Obsolete documentation? It's agreed that git-merge is neither fish nor fowl,
neither plumbing (engine) command, nor truly porcelain (UI) command.

You should rather use git-pull, than run git-merge by hand. git-pull uses
git-merge, with FETCH_HEAD as one of arguments.
 
>>> Then we come to "the index file 
>>> must exactly match the tree HEAD commit", sorry but my question is how
>>> could it not match? 
>> 
>> For example if you git-add'ed some files, but not committed the addition.

Or git-update-index some file, or you are in the middle of resolving
merge conflict, or you removed some files...
 
> But if I've added some files, it would seem perfectly reasonable that 
> git could still "merge" unless the new files conflicted with new files 
> in the fetch.

In which case it would be too late. Git detects possibility of conflict
(not clean index), and aborts early.

>>> It then goes onto say "it may fetch the objects from remote" I thought
>>> that is what "fetch" does. 
>> 
>> IIRC this explanation is in git-pull(1). Pull in git is _fetch_ + merge.
>>  
> 
> So a source of confusion is fetch also does merging/fast-forwarding, 
> this is confusing. Fetch should fetch, merge should merge, pull should 
> do both.

Fetch without updating refs would mean no access to downloaded objects.
Refs updating happend only (unless forced) in fast-forward case, i.e.
in the case of merge which is not a merge.

> Another source of confusion is we start out with two branches after 
> cloning _master_ & _origin_. Now if I create my own branch and check it 
> out and then do a pull, what is going to be merged where and when?

Use --use-separate-remotes if master/origin confuses you. In short:
 
without --use-separate-remotes:

   local branch    | remote branch   | can commit  | should commit
   ----------------------------------------------------------------
   master          | ----            | Yes         | Yes
   origin          | master          | Yes         | No
   next            | next            | Yes         | No

Master branch is for _your_ work. When you are on master branch, and do
'git pull', git does fetching and the merges _topmost_ branch in remotes
file ('origin') into current branch ('master').

with --use-separate-remotes

   local branch          | remote branch | can commit | should commit
   ------------------------------------------------------------------
   master                | ----          | Yes        | Yes
   remotes/origin/master | master        | No         | No
   remotes/origin/next   | next          | No         | No

> I need to read, re-read and actually understand git-merge the "Grand 
> Unified Merge Driver", I can see it's very powerful but with that power 
> comes confusion.

Don't use git-merge. Use git-pull. If you want merge local branches, use
'.' as the name of repository (means here: local repository).
 
Yes, this is confusing. Historical reasons, most probably.

[...]
-- 
Jakub Narebski
