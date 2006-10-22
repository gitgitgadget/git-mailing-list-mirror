From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 02:14:58 +0200
Message-ID: <200610220214.59368.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610212248.37935.jnareb@gmail.com>
	<453AAFBD.7020009@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 02:14:56 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQzO-0006T3-TF
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 02:14:55 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbQzJ-0001P5-Rm; Sun, 22 Oct 2006 01:14:49 +0100
Received: from hu-out-0506.google.com ([72.14.214.228])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GbQzI-0001P0-Cs
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 01:14:48 +0100
Received: by hu-out-0506.google.com with SMTP id 27so697256hub
	for <bazaar-ng@lists.canonical.com>;
	Sat, 21 Oct 2006 17:14:48 -0700 (PDT)
Received: by 10.67.100.17 with SMTP id c17mr4618709ugm;
	Sat, 21 Oct 2006 17:14:47 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id c1sm1732457ugf.2006.10.21.17.14.46;
	Sat, 21 Oct 2006 17:14:47 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453AAFBD.7020009@utoronto.ca>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29697>

Aaron Bentley wrote:
> Jakub Narebski wrote:
>> Aaron Bentley wrote:

>>> A Bazaar branch is a directory inside a repository that contains:
>>>  - a name referencing a particular revision
>>>  - (optional) the location of the default branch to pull/merge from
>>>  - (optional) the location of the default branch to push to
>>>  - (optional) the policy for GPG signing
>>>  - (optional) an alternate committer-id to use for this branch
>>>  - (optional) a nickname for the branch
>>>  - other configuration options
>> Erm, wasn't revno to revid mapping also part of bzr "branch"?
> 
> It's not part of the conceptual model.  The revno-to-revid mapping is
> done using the DAG.  The branch just tracks the head.
> 
> The .bzr/branch/revision-history file is from an earlier model in which
> branches had a local ordering.  Nowadays, it can be treated as:
>  - a reference to the head revision
>  - a cache of the revno-to-revid mapping

In git DAG is DAG od parents. There are no "child" links. So it is natural
to refer to n-th ancestor of given commit (in git <ref>~<n>, in bzr -<m>).

To have incrementing (from 1 for first revision on given branch) revision
numbers you either have to have links to "children", which automatically
means that revisions cannot be immutable to allow for branching at
arbitrary revision, or to transverse DAG here and back again (perhaps
with cache of revno-to-revid mapping to help performance).

Additionally to have incrementing revision numbers you have to remember
which part of DAG is our branch; which parent in merge to chose to follow.
Bazaar-NG decides here to distinguish first parent; to have first parent
immutable it doesn't use fast-forward and always use merge, sometimes
giving empty-merge. If you use "pull" numbers change.
 
>>> This layout is an imitation of Git, as I understand it:
>>> Repository:
>>> ~/repo
>>>
>>> Branches:
>>> ~/repo/origin
>>> ~/repo/master
>>>
>>> Workingtree:
>>> ~/repo
>>
>> Workingtree:
>> ~/
>>
>> if I understand notation correctly.
> 
> The notation was that ~/repo would contain the .git directory for the
> repository.

The default layout of "clothed" repository is

 Repository:
 ~/repo/.git/

 Branches:
 ~/repo/.git/refs/heads/

 Workingtree:
 ~/repo/

>>> While "bzr merge ../b" is a minor inconvenience, I think that "bzr merge
>>> http://bazaar-vcs.org/bzr/bzr.dev" is a big win.
>>
>> Gaah, it's even more inconvenient. Certainly more than using name
>> of branch itself, like in git.
> 
> Of course if you have a copy of bzr.dev on your computer, you don't need
> to type the full URL.  it's just like the 'merge ../b' above.
> 
> But how can you use the branch name of a branch that isn't on your
> computer?  I suspect git requires a separate 'clone' step to get it onto
> your computer first.

No, as it was said in other messages in this thread, you can fetch
a branch (branches), even from other repository that the one you cloned
from, into given branch (branches). For git it would be
  $ git fetch <URL> <remotebranch>:<localbranch>
You probably would want to save above info in remotes file or in config.
For cg (Cogito) it would be
  $ cg branch-add <localbranch> <URL>#<remotebranch>
  $ cg fetch <localbranch>

In git you always use names like 'master', 'next', 'HEAD' (meaning current
branch) and also HEAD^, next~5 when comparing branches, viewing history,
merging branches, switching to branch etc. Not '../master'...
