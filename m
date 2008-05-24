From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sat, 24 May 2008 16:50:24 -0500
Message-ID: <5d46db230805241450w71b0c587o4767becc0058ee0a@mail.gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	 <5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
	 <20080524195957.GC3745@dpotapov.dyndns.org>
	 <200805242247.07565.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 23:51:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K01eN-000853-Dp
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 23:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764908AbYEXVuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 17:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764890AbYEXVuj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 17:50:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:43871 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764603AbYEXVug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 17:50:36 -0400
Received: by yw-out-2324.google.com with SMTP id 9so720616ywe.1
        for <git@vger.kernel.org>; Sat, 24 May 2008 14:50:25 -0700 (PDT)
Received: by 10.151.142.2 with SMTP id u2mr26316ybn.141.1211665824962;
        Sat, 24 May 2008 14:50:24 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Sat, 24 May 2008 14:50:24 -0700 (PDT)
In-Reply-To: <200805242247.07565.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 0bd6321c100ab522
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82832>

On Sat, May 24, 2008 at 3:47 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 24 May 2008, Dmitry Potapov wrote:
>> On Sat, May 24, 2008 at 12:16:17AM -0500, Govind Salinas wrote:
>>> On Fri, May 23, 2008 at 8:07 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> "Govind Salinas" <blix@sophiasuchtig.com> writes:
>>>>
>>>>> 1) Reduce the number of commands.
>>>>>
>>>>> I am currently at 30 total commands, and while I have some more to go, I
>>>>> think there are some ways that I can get rid of some of them by
>>>>> combining them.  Do we really need a clone, branch and checkout?  Don't
>>>>> these all mean the same thing in the end?  They mean get me a working
>>>>> directory of the repository starting at X.  For clone, you start
>>>>> with 'master'. For checkout, you tell it what to get you.  Branch
>>>>> will help you manage things you can locally get.  So perhaps we can
>>>>> do something like the following...
>>>>
>>>> Note that you sometimes want to make a branch without checking it out.
>>>> Also note that git-branch is overloaded to get a list of branches
>>>> available.
>>>>
>>>
>>> Sure, removing commands is not about removing features, its about
>>> reducing the learning curve and reducing confusion.
>>
>> I don't see how hiding creating branch functionality behind some other
>> command will help with learning curve or reduce confusion. If I started
>> to use any new SCM and had to create a new branch, I would look for the
>> "branch" command. If there is something wrong with the git-branch then
>> it is that this command does not checkout the newly created branch by
>> default. So, I usually create branches using git-checkout, which is
>> counterintuitive.
>

If you will allow me to respond to both items in this mail...

In bzr both clone and branch are in the 'branch' command because every
branch is its own clone.  Hg defaults to a similar way of doing things and
You clone into a new directory to get a new branch.

>From the bzr user reference:

Branch:
...

  Aliases:
     get, clone
...


In truth, the git notion of a branch is pretty unique among SMCs.  In old
systems a branch was just a copy of a set of files at a certain point.  In
other DSCMs it is more likely to be a new copy of the repo.

To answer your question a little better, I am looking at it like this:
The predominant action is, as you say, going to be "I want to create a
branch so that I can start working on something."  While I respect that
you might want to create a branch and not start doing something
*right away*, I think this is less likely.  So...

pyt co
  this lists stuff you can checkout by which we mean local branches.

pyt co -r
  this lists remote stuff you can check out, such as remote tracking
  branches and the remotes themselves.

pyt co -a
  lists both of the above, maybe tags too.

pyt co <branch>
  checkout the branch, looking at refs

pyr co <uri> <remote-name> <branch>
   the user wants to checkout something that isn't local.  So we do
   a git remote add -t <branch> -f <remote-name> <uri> followed by
   checkout <remote-name>/<branch>
   There would probably be variations/flags to get different functionality.

pyt co -n mynewbranch [start=HEAD]
  creates and checks out a new branch.

pyt co [something=HEAD] [--] <files>...
  should be obvious

The following are a little less intuitive, because they don't actually
result in new stuff being put in the working directory.  These things are
not really a checkout activity, I will stipulate that.  However, I don't think
we need one interface to do stuff with branches and remotes, one to
manage branches and one to mange remotes.  And I think that users
will be able to grasp this pretty quickly.

pyt co --create-only mynewbranch
  just creates without switching, it is a long option because this is not
  a normal function and the user needs to understand what they are
  doing.

pyt co -d [-f] <branch-name> | <uri> | <remote>
  delete a branch or stop tracking a remote.

> That of course depends on the point of view [1].  Branches in git
> are "growth point" pointers to DAG of revisions.  git-branch lists
> and creates branches, and can be used to rename and delete branches
> as well, and to enable reflog for branch.  It does not touch working
> area; separation of domains.  (Note that sometimes you want to create
> branch without checking it out).
>
> git-checkout on the other hand is used to bring working area to given
> state, usually from given branch (switching branches) or arbitrary
> revision (detaching HEAD), but in some cases (with filename/pathspec)
> from index.
>
> Now, the seqence of
>  $ git branch <newbranch>
>  $ git checkout <newbranch>
> could be written as
>  $ git checkout -b <newbranch>
> but could have been done as
>  $ git branch -c <newbranch>

Exactly!  My first draft of the pyt branch command had a -c option
just like that.

> instead.  I think it is largely matter of priorities, taste... and
> of course historical reasons and backwards compatibility.
>
>> I don't think any commonly used SCM unites 'clone', 'branch', and
>> 'checkout' functionality under the same name. This approach seems
>> to be more confusing than helpful.
>
> This is also my opinion.  Perhaps 'clone' and 'init', or 'clone' and
> 'import' could be the same command... hat might make sense...
>
See above, they in fact do.  It struck me as odd too, because I had
started with git.  After thinking about it for a while, I saw advantages
to it.

-Govind
