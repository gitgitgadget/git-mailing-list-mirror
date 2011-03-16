From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git stash: add --index-only, or --keep-index should not stash
 index?
Date: Wed, 16 Mar 2011 18:06:36 -0500
Message-ID: <4D81427C.1020603@gmail.com>
References: <4D7A6E37.8080104@gmail.com>	<4D7E9502.4060502@gmail.com>	<AANLkTikU0xCBzDya3vyfoH4PwzmRi6qmotxNoVc61b=W@mail.gmail.com>	<4D80F9F4.9090304@gmail.com> <AANLkTing5ZQKF4PXtX1peynx2uuc8s+aeBP=fbJWXvWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 00:06:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzznm-0000uQ-4f
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 00:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab1CPXGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 19:06:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64354 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab1CPXGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 19:06:42 -0400
Received: by gwaa18 with SMTP id a18so879488gwa.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=769yr5VDV0ZdCJ92B34kZYR4r415YoYE4yA8HFbNJ9s=;
        b=lwxKqVT8VIm48SdbkGzYltldZs/HEZmDTfHeKQkq7nDac36S40h3O8IvRtAe4nvjxb
         LHQ4RFsYh62Kmo0pDPc+jTcbvNpJCkyctLXKm2+S1bTz5fPbLt8KZmlY14aLR6i3lJSa
         WqvKXIv4zIofq/MJYDEv9eFp6guhQ19ZVBXog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=uW2wQmYQ3w8rbxYGgjlxwccCV2Mn33bAtfPwCYOy4u0tHjkl93CkwJOHXi+bSbkXL7
         QgtpSqksUDb5piZAkl5qajADJORMdSxQgpN1I7nMLciw6v+2O05BADA7kxdFtfxsRSyG
         kqTc9Mp7/Eo7oW6iyKvQPkIOjCaXJPr+j8GeA=
Received: by 10.236.139.233 with SMTP id c69mr617648yhj.141.1300316801154;
        Wed, 16 Mar 2011 16:06:41 -0700 (PDT)
Received: from [172.25.2.144] ([67.63.162.200])
        by mx.google.com with ESMTPS id z10sm875409yhc.47.2011.03.16.16.06.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 16:06:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTing5ZQKF4PXtX1peynx2uuc8s+aeBP=fbJWXvWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169207>

On 3/16/2011 4:37 PM, Piotr Krukowiecki wrote:
> On Wed, Mar 16, 2011 at 6:57 PM, Neal Kreitzinger
> <nkreitzinger@gmail.com>  wrote:
>> On 3/15/2011 2:48 PM, Piotr Krukowiecki wrote:
>>>
>>> On Mon, Mar 14, 2011 at 11:21 PM, Neal Kreitzinger
>>> <nkreitzinger@gmail.com>    wrote:
>>>>
>>>> On 3/11/2011 12:47 PM, Piotr Krukowiecki wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I wanted to do something like "Testing partial commits" described in
>>>>> git-stash documentation (see end of mail for reference). I think this
>>>>> is a common scenario: you start working on some feature, then discover
>>>>> a bug, start fixing it, but realize it needs more work. So now you have
>>>>> two features that needs more work (both are not ready for committing).
>>>>>
>>>>> The documentation says to use --keep-index in this case.
>>>>>
>>>>> The problem is that --keep-index leaves changes in index intact, but at
>>>>> the same time it saves them in stash. So if I edit those changes I'm
>>>>> likely
>>>>> to get conflicts when applying the stash.
>>>>>
>>>>> For example:
>>>>>
>>>>> $ git init&&      echo a>      a&&      git add .&&      git commit -m a
>>>>> $ echo x>      a&&      git add a&&      git stash save --keep-index
>>>>> $ echo y>      a&&      git add a&&      git commit -m y
>>>>> $ git stash pop
>>>>> Auto-merging a
>>>>> CONFLICT (content): Merge conflict in a
>>>>>
>>>>> Maybe --keep-index should not stash staged changes? This would fix this
>>>>> problem. And I can't  think of a situation when would want to stash
>>>>> changes
>>>>> and at the same time keep them.
>>>>>
>>>>> If --keep-index works correctly maybe a new option, for example
>>>>> --index-only
>>>>> (or --cached-only?) could be introduced?
>>>>>
>>>>>
>>>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> Testing partial commits::
>>>>>
>>>>> You can use `git stash save --keep-index` when you want to make two or
>>>>> more commits out of the changes in the work tree, and you want to test
>>>>> each change before committing:
>>>>> +
>>>>> ----------------------------------------------------------------
>>>>> # ... hack hack hack ...
>>>>> $ git add --patch foo            # add just first part to the index
>>>>> $ git stash save --keep-index    # save all other changes to the stash
>>>>> $ edit/build/test first part
>>>>> $ git commit -m 'First part'     # commit fully tested change
>>>>> $ git stash pop                  # prepare to work on all other changes
>>>>> # ... repeat above five steps until one commit remains ...
>>>>> $ edit/build/test remaining parts
>>>>> $ git commit foo -m 'Remaining parts'
>>>>> ----------------------------------------------------------------
>>>>>
>>>>>
>>>> behind-the-scenes, git stash saves your working tree as a commit and your
>>>> index as another commit.  "git-stash apply" and "git-stash pop" only
>>>> apply
>>>> your stashed-index if you do "git-stash-apply --index".  The default is
>>>> to
>>>> only apply your stashed-work-tree.  You can create new branches from your
>>>> stashes with "git-stash branch".  You may find that much better to deal
>>>> with
>>>> for managing your work.  Stashes aren't really intended to be the primary
>>>> way to manage your work, but instead are a supplement.  Branches are a
>>>> better main tool for managing work.  You can create a branch from your
>>>> stash
>>>> and when the branch is ready you can merge it into your other branch.
>>>
>>> Thanks for explanation, I understand there is not much pressure on
>>> improving it.
>>>
>>> But it still does not explain how leaving code in index (with
>>> --keep-index) while
>>> still stashing it might be helpful?
>>>
>>> I would understand the use of --index-only (I gave an example of use
>>> case),
>>> or even --workdir-only, but not --keep-index. If I'm missing something
>>> please
>>> correct me.
>>>
>>>
>> Keep in mind that a key to his workflow is "git-add --patch" method (which
>> you did not include in your example).
>
> I did - in my first mail.
>
>
>> The workflow of the manpage assumes
>> you will have to resolve conflicts in such a case.  If you look at the
>> "Pulling into a dirty tree" workflow of the same manpage its obvious that
>> this workflow will almost always get conflicts, but they don't explicitly
>> include conflict resolution in the example.
>
> ok, for this workflow, when you stash away your changes to do a pull,
> you can't do anything to avoid conflicts.
>
> I mean this case:
>
>> You could resolve the conflicts
>> for "Testing partial commits" in this way:
>>
>> Neal's Version of Testing partial commits::
>> ----------------------------------------------------------------
>> # ... hack hack hack ...
>> $ git add --patch foo            # add just first part to the index
>> $ git stash save --keep-index    # save all other changes to the stash
>> $ edit/build/test first part
>> $ git commit -m 'First part'     # commit fully tested change
>> $ git stash pop                  # prepare to work on all other changes
>>    (conflict resolution)
>>    $ edit conflicted file        # keep new version of the hunk already
>>                                  # committed in prior iteration
>>    $ git reset HEAD -- foo       # clear conflict from index
>>    $ git reset HEAD -- foo       # (again) reset index to match HEAD
>> # ... repeat above five (or eight) steps until one commit remains ...
>> $ edit/build/test remaining parts
>> $ git commit foo -m 'Remaining parts'
>> ----------------------------------------------------------------
>>
>> Maybe there's a better way to do this.  Hope this helps.
>
> How about following workflow?
>
>     # ... hack hack hack ...
>     $ git add --patch foo
>     $ git stash save --keep-index
>     $ build/test first part         # note I have removed the "edit" part
>
> There are two possibilities now:
>
> 1. You're happy with the result - you commit your changes:
>
>     $ git commit -m 'First part'
>     $ git stash pop
>
> Important: there will be no conflicts in this case, and committed
> changes won't be reverted/applied/conflicted, because you have
> not edited them!
>
> I wasn't fully aware of this before (looks like I'm still new to git).
>
>
> 2. You're not happy with the result - maybe something does not
> build and you need to stage more changes, or maybe fix is not
> working yet.
>
> You should first pop your stashed changes! This way you'll avoid
> conflicts, you'll be able to stage/modify other changes. So the
> next steps are like this:
>
>     $ git stash pop
>     $ edit/add -p
>     $ git stash save --keep-index
>
> and now you're back to the "build/test" part.
>
>
>>    (conflict resolution)
>>    $ edit conflicted file        # keep new version of the hunk already
>>                                  # committed in prior iteration
>>    $ git reset HEAD -- foo       # clear conflict from index
>>    $ git reset HEAD -- foo       # (again) reset index to match HEAD
>
> I'm not really sure why/how this works :/
>
example:
(1) I've added this code:
if me then
   echo me
endif
if you then
   echo you
endif
if them then
   echo them
endif

(2) via git-add --patch I only add the first "if" to the index:
if me then
   echo me
endif

(3) git stash --keep-index:
puts all 3 "if" statements in stash, but keeps only the first "if" in my 
working-tree and index.

(4) I test the first "If" and decide to modify it:
if me or mine then
   echo "all mine"
endif

(5) I add and commit this change.

(6) git stash pop: generates conflict on the first "if".

(7) I edit the file and keep the new version of the first "if" and 
delete the old version of the first "if":
if me or mine then
   echo "all mine"
endif
if you then
   echo you
endif
if them then
   echo them
endif

(8) git status still shows this file as conflicted, because I haven't 
"added" it yet.  However, I don't want to add the whole thing, but just 
a patch of the second "if".  I'm not ready for the 3rd "if" yet.  I 
can't do git-add --patch on a conflicted item.  So I clear the conflict 
with "git reset HEAD --foo".

(9) the first git reset only cleared the conflict -- it did not actually 
reset the foo in index to match the foo in HEAD.  therefore, git status 
still shows foo as being modified.  therefore, i do another git-reset to 
reset the index foo to match the HEAD foo.

(10) now i can do git-add --patch and add the second "if":
if me or mine then
   echo "all mine"
endif
if you then
   echo you
endif

(repeat steps 3 thru 10)

If you are new to git then maybe some clarification about the index will 
be helpful.  In a nutshell, the index is the staging area in-between 
your working-tree and the object-store.  Changes in your working-tree 
first go to the index and then to the commit (object store).  The index 
holds what is going to be committed.  It also is the go-between in the 
opposite direction.  In order to get an object from the object-store to 
your work-tree it goes from the object-store to your index and then to 
your worktree.  when you checkout out a commit from the object-store it 
goes into your index and then from the index into the working tree.  The 
main thing to remember is that you have to put stuff in the index before 
you can commit it.  Another thing to remember is that in order to put 
stuff from the object-store into your working-tree, git first has to put 
in in the index.  the index is the middle-man between the work-tree and 
object-store, AND between the object-store and the work-tree.

v/r,
neal
