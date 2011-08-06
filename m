From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Cleaning up history with git rebase
Date: Sat, 06 Aug 2011 23:59:50 -0000
Message-ID: <7b4a0f436505467fa042739da159e0f4-mfwitten@gmail.com>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
            <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
            <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
            <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
            <7af8ef40e0034e81a63f1d4a53bf082e-mfwitten@gmail.com>
            <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
            <80e62eb56a83a138a79e112e382da4ae@linea.gov.br>
            <b3e1c29767984546a61e2d10fb180188-mfwitten@gmail.com>
            <ad9fe99851b7a4650e739e2e13b6a7c9@linea.gov.br>
Cc: Ricky Egeland <rickyegeland@linea.gov.br>, <git@vger.kernel.org>
To: Patricia Egeland <pbegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Sun Aug 07 02:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qpqq8-0005Uk-Au
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 02:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756570Ab1HGABU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 20:01:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41421 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab1HGABT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 20:01:19 -0400
Received: by eyx24 with SMTP id 24so2009444eyx.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=akB2u+gtFNGwaQ2yMwhF6zYYBpkphIOlplda6oH5b+Y=;
        b=oc6J3evgxfUDU07Q+bahXzVNZXyBreAQz6BHFdQqeyzacerER8IqcFl1mBQJd+wNIf
         UO4nAHtxJHov44bZ5HnDAC8pBG49DrDPX0kYjqxgPppu0IeMWYZraHQkvpSm97Y67GJS
         lEKip71T+aK0+i5DjGdNTi8LobK8FC4tGA5E4=
Received: by 10.213.110.204 with SMTP id o12mr1234711ebp.40.1312675278114;
        Sat, 06 Aug 2011 17:01:18 -0700 (PDT)
Received: from gmail.com (tor-proxy.vm.31173.se [193.138.216.101])
        by mx.google.com with ESMTPS id b13sm1841303een.65.2011.08.06.17.01.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 17:01:16 -0700 (PDT)
In-Reply-To: <ad9fe99851b7a4650e739e2e13b6a7c9@linea.gov.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178893>

On Fri, 05 Aug 2011 18:26:27 -0300, Patricia Egeland wrote:

>> On Thu, 04 Aug 2011 14:35:19 -0000, Michael Witten wrote:
>>
>> [Put your reply text below the quoted text.]
>>
>> On Wed, 03 Aug 2011 17:58:26 -0300, Patricia Egeland wrote:
>>
>>> On Mon, 01 Aug 2011 01:07:33 -0000, Michael Witten wrote:
>>>
>>>> Michael Witten wrote:
>>>>
>>>>> On Sun, 31 Jul 2011 18:44:43 -0300, Ricky, Egeland wrote:
>>>>>
>>>>>> On Jul 31, 2011, at 6:33 PM, Michael Witten wrote:
>>>>>>
>>>>>>> On Sun, Jul 31, 2011 at 20:21, Michael Witten 
>>>>>>> <mfwitten@gmail.com>
>>>>>>> wrote:
>>>>>>>> Why are there conflicts anyway?
>>>>>>>
>>>>>>> Oh...
>>>>>>>
>>>>>>> I guess there were conflicts when the merge commit was made in
>>>>>>> the original repository, and these conflicts were resolved by
>>>>>>> the merge commit itself. Hence, when rebase tries to split up
>>>>>>> a merge by dealing with just the non-merge parents, you end up
>>>>>>> having to deal with the conflict again.
>>>>>>
>>>>>> Yes, I thought it was something like this going on, too. In the
>>>>>> pre-rebase history, when there is a commit with "Conflict:" and
>>>>>> listing file which is in the sub-repository history, this is a
>>>>>> point where rebase stops with a conflict.
>>>>>>
>>>>>>> Shouldn't rebase take this into account?
>>>>>>
>>>>>> Not sure.  Seems that it does not, it makes me resolve the 
>>>>>> conflict
>>>>>> =
>>>>>> again.
>>>>>
>>>>> I think git rebase should take this into account is what I'm 
>>>>> saying.
>>>>>
>>>>> The following implements what I think `git rebase' should be 
>>>>> doing;
>>>>> run it instead of `git rebase' in your repo:
>>>>>
>>>>>   git branch saved
>>>>>   git rev-list HEAD --reverse --first-parent --parents |
>>>>>   {
>>>>>     read root
>>>>>     git reset --hard $root
>>>>>     rebase_head=$root
>>>>>
>>>>>     while read commit first_parent other_parents; do
>>>>>
>>>>>       if [ -z "$other_parents" ]; then
>>>>>
>>>>>         git cherry-pick $commit
>>>>>         rebase_head=$commit
>>>>>
>>>>>       else
>>>>>
>>>>>         for parent in $other_parents; do
>>>>>
>>>>>           if ! git cherry-pick $parent; then
>>>>>
>>>>>             git reset --hard $rebase_head
>>>>>             git merge $other_parents
>>>>>             git rm -rf .
>>>>>             git checkout -- $commit
>>>>>             git commit -aC $commit
>>>>>             break
>>>>>
>>>>>           fi
>>>>>
>>>>>         done
>>>>>
>>>>>         rebase_head=$(git rev-parse HEAD)
>>>>>
>>>>>       fi
>>>>>
>>>>>     done
>>>>>   }
>>>>
>>>> Woops!
>>>>
>>>> This line:
>>>>
>>>>   git checkout -- $commit
>>>>
>>>> should be:
>>>>
>>>>   git checkout $commit -- .
>>>
>>>      I tried to run the script in my repo. However, seems like the 
>>> 'git
>>> merge $other_parents' process fails. In the script output I see some
>>> lines saying that files were not able to be merged, ie:
>>>
>>> warning: Cannot merge binary files:
>>> scienceportal/images/tabs/tabs-gray.png (HEAD vs.
>>> 84f6fc283861aa7c5798f58769789dd0b91a5e9d)
>>> warning: Cannot merge binary files: scienceportal/images/waiting.gif
>>> (HEAD vs. e033cbbf1e9d24b66cb55a04701c059dc945c1c3)
>>>
>>>      Do you have some suggestion?
>>
>> That's probably as expected; the script is coming across the 
>> conflict, but
>> it should be taking care of the conflict automatically.
>>
>> Unfortunately, though, the results probably end up being almost 
>> completely
>> similar to the original un-rebased branch because the original script
>> actually has ANOTHER mistake (sorry!). See the updated version here 
>> (or
>> in your inbox):
>>
>>   http://marc.info/?l=git&m=131246773005168&w=2
>>   Message-ID: <d62225a3cc5740cda7cb163a94d55892-mfwitten@gmail.com>
>
>
> Thanks for taking a look at it again.
> I tried to run the script with that update, but in the end I got more 
> merge messages than I had originally. (71 additional merges. From those 
> 71, I got 53 "Merge commit" messages. While in the saved repo I have 1 
> "Merge commit".). Do you see what may be causing that?
>
> Another thing I noticed is that the auto-merging is still failing:
>
> fatal: Commit b0596fce207735081b8aa9afdd9686b7d412f5d8 is a merge but 
> no -m option was given.
> HEAD is now at ac5eaa2 *Continue Last Commit*
> Auto-merging scienceportal/css/myprofile.css
> CONFLICT (content): Merge conflict in scienceportal/css/myprofile.css
> Auto-merging scienceportal/css/qc.css
> Automatic merge failed; fix conflicts and then commit the result.
> scienceportal/css/myprofile.css: needs merge
> rm 'scienceportal/css/des.css'
>
> Looking at this thread: 
> http://www.mail-archive.com/git-users@googlegroups.com/msg01046.html
> I thought that the attempt of removing the files was the step first 
> facing the conflicts as the one shown above. So that, I tried to iterate 
> through the files and in case the removal of any file failed, I added 
> the steps as suggested in the thread:
> git checkout --theirs $file
> git add $file
> git commit -m 'Fixing conflict during rebase'
>
> But that didn't work either.
>
> I'd be greatly appreciated if you are still willing to help.

Those error messages are expected, but my original script is
incredibly naive (to the point of being incorrect).

Fortunately, I've thought a bit more about it, and I have a much
better solution in the works, so please hold on just a bit longer
while I work out the kinks.
