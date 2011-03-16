From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git stash: add --index-only, or --keep-index should not stash
 index?
Date: Wed, 16 Mar 2011 12:57:08 -0500
Message-ID: <4D80F9F4.9090304@gmail.com>
References: <4D7A6E37.8080104@gmail.com>	<4D7E9502.4060502@gmail.com> <AANLkTikU0xCBzDya3vyfoH4PwzmRi6qmotxNoVc61b=W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:57:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzuyG-0008Gz-Cu
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 18:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab1CPR5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 13:57:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46040 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1CPR5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 13:57:14 -0400
Received: by gyf1 with SMTP id 1so763572gyf.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Fnxu5qiUjgcNAGBaEMpjKhzuA7C1vb+rwAUYYvS6L3o=;
        b=hrF8mp6PC1m/bmwMis0I6kHS00g8vVM/aCDfNaH77PyqLikHvAIUH/IgGqGJTOZRAF
         H6CKOtGmUR9ie25SZXi8JuE+2+zhiHJqjEQzsS1k7bUiqnwgy73b14I8u3JsHqOmvoPW
         zLEV37ZuDpTyUiJZ1BirgpYTWItR8cdtMOIT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=fLSkCwkBbhcErvqU6kdXOcWJKfUNl51DAorFciAOGNNhKKx61YjnDGElOAVjHmnPyD
         C3DiRBz9js/XJQa5nPZ2f4pvZIjszUqCXljdCfY1Afq7Eo/FTZ91brak88x0iRWfhuQA
         Fw9Cx2Dt6SOpVIj+JM+XC07+i6JqPdLZP5vt0=
Received: by 10.236.53.74 with SMTP id f50mr219282yhc.380.1300298233242;
        Wed, 16 Mar 2011 10:57:13 -0700 (PDT)
Received: from [172.25.2.144] ([67.63.162.200])
        by mx.google.com with ESMTPS id x75sm734781yhn.24.2011.03.16.10.57.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 10:57:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTikU0xCBzDya3vyfoH4PwzmRi6qmotxNoVc61b=W@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169178>

On 3/15/2011 2:48 PM, Piotr Krukowiecki wrote:
> On Mon, Mar 14, 2011 at 11:21 PM, Neal Kreitzinger
> <nkreitzinger@gmail.com>  wrote:
>> On 3/11/2011 12:47 PM, Piotr Krukowiecki wrote:
>>>
>>> Hi,
>>>
>>> I wanted to do something like "Testing partial commits" described in
>>> git-stash documentation (see end of mail for reference). I think this
>>> is a common scenario: you start working on some feature, then discover
>>> a bug, start fixing it, but realize it needs more work. So now you have
>>> two features that needs more work (both are not ready for committing).
>>>
>>> The documentation says to use --keep-index in this case.
>>>
>>> The problem is that --keep-index leaves changes in index intact, but at
>>> the same time it saves them in stash. So if I edit those changes I'm
>>> likely
>>> to get conflicts when applying the stash.
>>>
>>> For example:
>>>
>>> $ git init&&    echo a>    a&&    git add .&&    git commit -m a
>>> $ echo x>    a&&    git add a&&    git stash save --keep-index
>>> $ echo y>    a&&    git add a&&    git commit -m y
>>> $ git stash pop
>>> Auto-merging a
>>> CONFLICT (content): Merge conflict in a
>>>
>>> Maybe --keep-index should not stash staged changes? This would fix this
>>> problem. And I can't  think of a situation when would want to stash
>>> changes
>>> and at the same time keep them.
>>>
>>> If --keep-index works correctly maybe a new option, for example
>>> --index-only
>>> (or --cached-only?) could be introduced?
>>>
>>>
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Testing partial commits::
>>>
>>> You can use `git stash save --keep-index` when you want to make two or
>>> more commits out of the changes in the work tree, and you want to test
>>> each change before committing:
>>> +
>>> ----------------------------------------------------------------
>>> # ... hack hack hack ...
>>> $ git add --patch foo            # add just first part to the index
>>> $ git stash save --keep-index    # save all other changes to the stash
>>> $ edit/build/test first part
>>> $ git commit -m 'First part'     # commit fully tested change
>>> $ git stash pop                  # prepare to work on all other changes
>>> # ... repeat above five steps until one commit remains ...
>>> $ edit/build/test remaining parts
>>> $ git commit foo -m 'Remaining parts'
>>> ----------------------------------------------------------------
>>>
>>>
>> behind-the-scenes, git stash saves your working tree as a commit and your
>> index as another commit.  "git-stash apply" and "git-stash pop" only apply
>> your stashed-index if you do "git-stash-apply --index".  The default is to
>> only apply your stashed-work-tree.  You can create new branches from your
>> stashes with "git-stash branch".  You may find that much better to deal with
>> for managing your work.  Stashes aren't really intended to be the primary
>> way to manage your work, but instead are a supplement.  Branches are a
>> better main tool for managing work.  You can create a branch from your stash
>> and when the branch is ready you can merge it into your other branch.
>
> Thanks for explanation, I understand there is not much pressure on improving it.
>
> But it still does not explain how leaving code in index (with
> --keep-index) while
> still stashing it might be helpful?
>
> I would understand the use of --index-only (I gave an example of use case),
> or even --workdir-only, but not --keep-index. If I'm missing something please
> correct me.
>
>
Keep in mind that a key to his workflow is "git-add --patch" method 
(which you did not include in your example).  The workflow of the 
manpage assumes you will have to resolve conflicts in such a case.  If 
you look at the "Pulling into a dirty tree" workflow of the same manpage 
its obvious that this workflow will almost always get conflicts, but 
they don't explicitly include conflict resolution in the example.  You 
could resolve the conflicts for "Testing partial commits" in this way:

Neal's Version of Testing partial commits::
----------------------------------------------------------------
# ... hack hack hack ...
$ git add --patch foo            # add just first part to the index
$ git stash save --keep-index    # save all other changes to the stash
$ edit/build/test first part
$ git commit -m 'First part'     # commit fully tested change
$ git stash pop                  # prepare to work on all other changes
    (conflict resolution)
    $ edit conflicted file        # keep new version of the hunk already
                                  # committed in prior iteration
    $ git reset HEAD -- foo       # clear conflict from index
    $ git reset HEAD -- foo       # (again) reset index to match HEAD
# ... repeat above five (or eight) steps until one commit remains ...
$ edit/build/test remaining parts
$ git commit foo -m 'Remaining parts'
----------------------------------------------------------------

Maybe there's a better way to do this.  Hope this helps.

v/r,
neal
