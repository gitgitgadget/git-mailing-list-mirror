X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote branches?
Date: Wed, 08 Nov 2006 08:29:29 +0100
Organization: At home
Message-ID: <eis0v9$vug$1@sea.gmane.org>
References: <20061107172450.GA26591@spearce.org> <455169D1.8060408@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 8 Nov 2006 07:29:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 105
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31125>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghhrn-00015Y-Dq for gcvg-git@gmane.org; Wed, 08 Nov
 2006 08:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754410AbWKHH25 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 02:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbWKHH24
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 02:28:56 -0500
Received: from main.gmane.org ([80.91.229.2]:25015 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754410AbWKHH24 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 02:28:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Ghhrg-00014I-Pk for git@vger.kernel.org; Wed, 08 Nov 2006 08:28:52 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 08:28:52 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 08 Nov 2006
 08:28:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Could you word-wrap your messages at some reasonable column, for example at
72 or 76-columns wide?

Wink Saville wrote:

> As a newbie I'm confused, recently I attempted to get Andrew Morton's
> -mm "tree".

Which is unusual git usage, as Andrew Morton uses Quilt/his own patch tools,
and not git, if I remember correctly.

> It turns out the instructions were incorrect and Junio was 
> kind enough to correct the mistake. But I for one am still confused.  
>
>   git-fetch is; "Download objects and a head from another repository"
> 
> Fair enough and that make sense, but where does it go? Apparently it just
> gets stored in the object database and a reference to it in "FETCH_HEAD".
> Now what? Ok the documentation says:  

Objects gets stored into object database. Then (using FETCH_HEAD) heads
of tracking branches gets updated (i.e. if there were some changes on
branch 'master' in remote, the objects are downloaded, then head of local
tracking branch corresponding to remote branch 'master', e.g. 'origin',
gets updated with the value in 'master'; so called fast-forward case).
 
>   'The information is left for a later merge operation done by "git
>   merge"' 

Or done by git pull. The information in FETCH_HEAD is for commit message
in later merge (for example due to pull).
 
> Now in the case of fetching -mm apparently you don't do a merge, instead
> the instructions now read: 
> 
>   $ git-fetch \
>     git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git \
>     tag v2.6.16-rc2-mm1  
>   $ git-checkout -b local-v2.6.16-rc2-mm1 v2.6.16-rc2-mm1

Are you sure that it is 'tag' there?

BTW. you are actually encouraged to use "git fetch" and "git checkout",
unless in scripts.

> The git-fetch apparently gets "linux-trees.git" and places a reference to
> it in a tag named 'v2.6.16-rc2-mm1'. Then the git-checkout, check's out
> this tag to a new branch, there was no merge! This is confusing and makes
> no sense to this newbie.   

The git-fetch fetches _from_ linux-trees.git repository. It fetches tag
v2.6.16-rc2-mm1 (and its lineage, i.e. everything pointed by this tag,
transitively) and stores it as local tag v2.6.16-rc2-mm1. You cannot
checkout tag (you can't commit to tag), so you have to create new branch
for your changes (or for checkout).
 
> Now lets take a quick look at the git-merge documentation "HOW MERGE
> WORKS": 
> 
> "A merge is always between the current HEAD and one or more remote branch
> heads, and the index file must exactly match the tree of HEAD commit (i.e.
> the contents of the last commit) when it happens. In other words, git-diff
> --cached HEAD must report no changes."   

That's a bit untrue, because merge can happen between local branches too.
 
> Sorry, there is basically no information in those two sentences that makes
> any sense to me. Take the first part, "between the current HEAD and one or
> more remote branch heads". So apparently merges occur against the current
> checkout branch, but I would guess the origin is also involved somehow? 

Current HEAD is current checked out branch. You merge current HEAD and one
or more [remote] branch heads (in the pull case, those not marked
not-for-merge in FETCH_HEAD), and place result in current branch.

> Secondly, what is the relationship between "remote branch heads" and
> FETCH_HEAD? I see no mention of FETCH_HEAD or how it might be used
> anywhere in the git-merge documentation.

FETCH_HEAD is low-lewel, not to be used by end-user (unless he/she wants to
do something unusual).

> Then we come to "the index file 
> must exactly match the tree HEAD commit", sorry but my question is how
> could it not match? 

For example if you git-add'ed some files, but not committed the addition.

> Obviously I don't understand how the index file is 
> used, but I can say that adding "git-diff --cached HEAD must report no no
> changes" adds nothing to the explanation, yet I'm sure it does mean
> something to an expert.          

It adds command which you can use to check _why_ merge failed to run.

> It then goes onto say "it may fetch the objects from remote" I thought
> that is what "fetch" does. 

IIRC this explanation is in git-pull(1). Pull in git is _fetch_ + merge.
 
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

