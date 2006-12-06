X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull and merging.
Date: Wed, 06 Dec 2006 10:31:29 +0100
Organization: At home
Message-ID: <el62hi$esu$1@sea.gmane.org>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 09:30:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 85
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33409>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grt6F-00041i-8Y for gcvg-git@gmane.org; Wed, 06 Dec
 2006 10:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760366AbWLFJ34 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 04:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760372AbWLFJ34
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 04:29:56 -0500
Received: from main.gmane.org ([80.91.229.2]:49927 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760366AbWLFJ3z
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 04:29:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Grt5z-0001Z1-0A for git@vger.kernel.org; Wed, 06 Dec 2006 10:29:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 10:29:42 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 10:29:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Aneesh Kumar wrote:

> On 12/6/06, Junio C Hamano <junkio@cox.net> wrote:
>> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>>
>>> I have a git.git clone using --use-separate-remote. That means i have
>>> the master branch created by default. Now i need to build git from the
>>> pu branch too. So i created git branch pu remotes/origin/pu.
>>>
>>>
>>> How how do i track the pu branch using git pull. What i mean is the
>>> master local branch is tracked by default using git pull. Is there a
>>> way to track the local pu branch too.
>>
>>         $ cat>.git/remotes/origin <<\EOF
>>         URL: ...kernel.org/pub/scm/git/git.git
>>         Pull: refs/heads/master:refs/remotes/origin/master
>>         Pull: refs/heads/next:refs/remotes/origin/next
>>         Pull: +refs/heads/pu:refs/remotes/origin/pu
>>         EOF

Or you can do .git/config equivalent:

$ git repo-config remote.origin.url ...kernel.org/pub/scm/git/git.git
$ git repo-config remote.origin.fetch  refs/heads/master:refs/remotes/origin/master
$ git repo-config remote.origin.fetch  refs/heads/next:refs/remotes/origin/next
$ git repo-config remote.origin.fetch +refs/heads/pu:refs/remotes/origin/pu

>> Then you would checkout 'pu' by having a matching local branch:
>>
>>         $ git branch pu remotes/origin/pu
>>         $ git checkout pu ;# this is your refs/heads/pu
>>         $ make
>>
>> Hacking on it can be done in this branch as usual.  When you are
>> interested in the latest 'pu' from me:
>>
>>         $ git checkout pu ;# this is your refs/heads/pu
>>         $ git fetch ;# most of the time git pull would also be fine...
>>
>> and then:
>>
>>         $ git rebase remotes/origin/pu
>>
>> The 'rebase' in the last step is because my 'pu' rewinds freely;
>> otherwise you would do "git merge remotes/origin/pu" instead.
>>
> 
> Okey what i was looking for was a .git/config that will imply as a
> part of git pull origin that local
> 
> master is to track remotes/origin/master
> pu  should track remotes/origin/pu.
> 
> I almost felt the branch.<name>.merge was for that.
> 
> What is this git-repo-config used for. I am trying to understand
> 
> branch.<name>.remote and branch.<name>.merge usage.

Yes it is what branch.<name>.merge is for... and it would work for
any branch _except_ pu, which rewinds frequently, and you should
rebase your changes on top of current version instead of merging.

Still it is useful to add branch.<branch>.remote for pu:

  $ git repo-config branch.refs/heads/pu.remote origin

so you can do just "git fetch" on pu to fetch from origin (well,
"git fetch" would fetch from origin as it is the default even in
absence of branch.<branch>.remote).

If it were any other branch, for example next, you could add

  $ git repo-config branch.refs/heads/next.remote origin
  $ git repo-config branch.refs/heads/next.merge refs/remotes/origin/next

for "git pull" on next branch fo fetch from origin and merge
next branch from origin. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

