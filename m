From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: Convenient shortcut to push delete current branch?
Date: Fri, 2 Oct 2015 09:33:50 -0400
Message-ID: <CANoM8SWkunV5Z1w9CsqfK2fGmrnghC2HdL5hZBDU7WkXz4aB6w@mail.gmail.com>
References: <CAHd499C3n8DGuhxwajQbFrH+Fr8zHRA7sVjhG3yfSD5kKPSZsA@mail.gmail.com>
 <CA+P7+xpWXoNiK67xCepoChr8rqX-Z5EcNb-Bs3xhC+Uot2ruYg@mail.gmail.com> <CAHd499C7r+Xd1+4Sn5WdXrEHv5yp0=jbnMUvLBHHJ-1s1sJ4gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 15:34:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi0Ta-0006PK-F6
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 15:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbbJBNeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 09:34:13 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36273 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbJBNeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 09:34:11 -0400
Received: by vkfp126 with SMTP id p126so59825075vkf.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sWdp62CzTHyl2sX6q2MvQq7LGP3pSCBb1vJye7MFdEo=;
        b=BCEPFaWakODHneMtWAduAKfHKjwzVSuMJkOAmz0q3z1GjlFeKzjwoYG2LslxZK1EzK
         QdPicUaM+brJx2twAoJVR7zTCIkPphxppadELvNTUE7kgV8uqA8zZdLhArxG5joerGw2
         143XzXl8Sr1SdgDUhE7yCEMmrEuyY6PmwazzLOansrgTPaQwojdAjjwzfbBn/jntHjpY
         Kjb6AlUqnk6pWN338eF9dTSzfs8c/nZtmTM/T3N8d8p4teHux1D8g2fAtHF4GOQ3OAKk
         KKfKJu0OrDz80Yo0FUr+gEFA1w3T7giMGxl+mx8FozO4YD34mg0iStxDjyzbaPqrKNxl
         MtKg==
X-Received: by 10.31.2.193 with SMTP id 184mr9210401vkc.126.1443792850231;
 Fri, 02 Oct 2015 06:34:10 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Fri, 2 Oct 2015 06:33:50 -0700 (PDT)
In-Reply-To: <CAHd499C7r+Xd1+4Sn5WdXrEHv5yp0=jbnMUvLBHHJ-1s1sJ4gQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278921>

On Thu, Oct 1, 2015 at 2:37 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Thu, Oct 1, 2015 at 1:22 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Oct 1, 2015 at 9:43 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>> For convenient pushing of current branch, git supports this syntax:
>>>
>>> $ git push origin HEAD
>>>
>>> This will push your current branch up. However, is there such a
>>> shortcut for *deleting* the branch? The only goal here is to avoid
>>> having to type the branch name in the push command. Normally I rely on
>>> tab completion but we have tons of branches, all which start with some
>>> prefix mixed with numbers, so it becomes cumbersome to rely on tab
>>> completion. Ideally I'd like to be able to do:
>>>
>>> $ git push --delete origin HEAD
>>> $ git push origin :HEAD
>>>
>>> Is there a syntax like this available?
>>
>> You can do
>>
>> git push origin:<branchname>
>>
>> but I don't believe HEAD is supported. It might be valuable to extend
>> push to have a --delete option which would maybe be useful for those
>> who didn't learn the full refspec syntax.
>
> Push already has a --delete option.
>

I could see adding an option for --delete-upstream that would use the
upstream remote and ref of the current branch (if they exist).
External to git you could script this from the config (completely
untested):

    if branch=$(git symbolic-ref --short HEAD); then
        if remote=$(git config branch.$branch.remote); then
            if remote_ref=$(git config branch.$branch.merge); then
                git push $remote --delete $remote_ref
            fi
        fi
    fi

>> I don't think git push origin :HEAD makes too much sense, since that's
>> on the remote side of a refspec, and you want it interpreted
>> locally... I suppose it makes sense somewhat, but other refspecs with
>> HEAD on the remote side of the refspec don't really make sense, where
>> as HEAD always makes sense on the local side of the refspec.
>
> HEAD makes sense on the remote side if you think of it like an alias:
>
> HEAD -> branch-name -> SHA1
>
> HEAD simply points to branch-name. It makes sense for git to assume
> that we should never do anything with real HEAD ref on the remote
> side, and instead treat it as a substitution for the remote name. My
> assumption may not be correct, but at the very least it should be a
> niche case.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
