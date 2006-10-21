From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 22:48:37 +0200
Message-ID: <200610212248.37935.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <87irie1wvv.wl%cworth@cworth.org> <453A7D7E.8060105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 22:48:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbNlg-00088q-By
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 22:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWJUUs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 16:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWJUUs3
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 16:48:29 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:54848 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751748AbWJUUs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 16:48:28 -0400
Received: by qb-out-0506.google.com with SMTP id p36so292146qba
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 13:48:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Zy3P/oHcXon/4drON6PSAfDRvT9wGydlT/i7UVLSG81nD1bRdfzI7va/MIqODJnoNuAJKutMOiylSVeCEVllu4tl9xw6nU2BTPEZz5984sLSLYIVQvpFCR1u5H7tq18m4kZbfd9/4F5SKYJR0iRKcEDf+k+0BQ/fV9qsvLsPSps=
Received: by 10.66.216.6 with SMTP id o6mr4443202ugg;
        Sat, 21 Oct 2006 13:48:27 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id w40sm296560ugc.2006.10.21.13.48.26;
        Sat, 21 Oct 2006 13:48:26 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453A7D7E.8060105@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29672>

Aaron Bentley wrote:
> Carl Worth wrote:

>> I'm noticing another terminology conflict here. The notion of "branch"
>> in bzr is obviously very different than in git. For example the bzr
>> man page has a sentence beginning with "if there is already a branch
>> at the location but it has no working tree". I'm still not sure
>> exactly what a bzr branch is, but it's clearly something different
>> from a git branch, (which is absolutely nothing more than a name
>> referencing a particular commit object).
> 
> I got the impression there was also a local ordering of revisions.  Is
> that wrong?

No, there is no such thing like local ordering of revisions.

Each revision (commit) has link to its parent(s). Branch technically
is just a reference to a particular commit object. The commit itself
gives us sub-DAG of DAG of whole history, the DAG of all parents of
said commit. Such lineage of commit pointed by branch is conceptually
a branch; i.e. branch is DAG of development (not line of development,
as there is no special meaning of first parent).

You can have (in git repository) also reflog, which records values
of branch-as-reference, or branch tip of branch-as-named-lineage.
But for example fetch and fast-forward 5 commits in history is
recorded as single event, single change in reflog.
 
> A Bazaar branch is a directory inside a repository that contains:
>  - a name referencing a particular revision
>  - (optional) the location of the default branch to pull/merge from
>  - (optional) the location of the default branch to push to
>  - (optional) the policy for GPG signing
>  - (optional) an alternate committer-id to use for this branch
>  - (optional) a nickname for the branch
>  - other configuration options
Erm, wasn't revno to revid mapping also part of bzr "branch"?

We store configuration per repository, not per branch, although
there is some branch specific configuration.

[...]
> This layout is an imitation of Git, as I understand it:
> Repository:
> ~/repo
> 
> Branches:
> ~/repo/origin
> ~/repo/master
> 
> Workingtree:
> ~/repo

Workingtree:
~/

if I understand notation correctly.

>> One, it intrudes on my branch namespace, (note that
>> in many commands above I have to use things like "../b" where I'd like
>> to just name my branch "b".
> 
> While "bzr merge ../b" is a minor inconvenience, I think that "bzr merge
> http://bazaar-vcs.org/bzr/bzr.dev" is a big win.

Gaah, it's even more inconvenient. Certainly more than using name
of branch itself, like in git.
 
>> Two, it prevents bzr from having any
>> notion of "all branches" in places where git takes advantage of it,
>> (such as git-clone and "gitk --all").
> 
> No, it doesn't.  Bazaar can easily list all the branches in a
> repository, just by starting with the repository root, and recursing
> through all the subdirectories, looking for branches.

Is there a command to list all branches in bzr? Is there a command
to copy (clone in SCM jargon) whole repository with all branches?
 
> That said, we do have mentality that branches, not repositories, are
> what's important to users in day-to-day use.

Thats opposite to git view. In git, working area is associated with
repository (clone of repository), not branch. We copy whole repositories
(sometimes only part of repository), not branches.

>>> What's nice is being able see the revno 753 and knowing that "diff -r
>>> 752..753" will show the changes it introduced.  Checking the revo on a
>>> branch mirror and knowing how out-of-date it is.
>>
>> With git I get to see a revision number of b62710d4 and know that
>> "diff b62710d4^ b62710d4" will show its changes, though much more
>> likely just "show b62710d4". I really cannot fathom a place where
>> arithmetic on revision numbers does something useful that git revision
>> specifications don't do just as easily. Anybody have an example for
>> me?
> 
> My understanding is that ^ is treated as a special metacharacter by some
> shells, which is why bzr revision specs are more long-winded.

Which shells? If I understand it '^' was chosen (for example as
NOT operator for specify sub-DAG instead of '!') because of no problems
for shell expansion. And considering that many git commands are/were
written in shell, one certainly would notice that.

-- 
Jakub Narebski
Poland
