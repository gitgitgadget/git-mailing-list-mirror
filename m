From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC] Disabling status hints in COMMIT_EDITMSG
Date: Wed, 11 Sep 2013 09:11:29 +1200
Message-ID: <CAFOYHZBiMNMeq4JKX1st0yTLJ8hm8aUNGPd0WA2uaLhOP44w6w@mail.gmail.com>
References: <vpq4n9tghk5.fsf@anie.imag.fr>
	<522EEC28.6020405@gmail.com>
	<vpqtxhtey4t.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJVDi-00073K-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab3IJVLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:11:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62786 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab3IJVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:11:30 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so8211514pab.20
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FXMlc3ti9oDm3LNT4N/vXrEcVa40H0FvGU2yGBXwIL4=;
        b=Iw7nNMfpGP/OZN3olKHiPv9VjY5CyHvpjKP6iHc6W9yvPt1JoCyep+Q44Qc2ESAnq7
         OEg9yCzIkKKA5yzLUFw/FbwOfZDSzU6Z7QG3gDY+hT7mqu/NEuKRyZIZbz7tXdnKbIhX
         DIhjiZgd0ZyG1yX5w5aGgKDkwzSqBcp85vXCcSBArdafWamvuOTRq5UHWjethWMDTk0Y
         oX8IqfQm6HyrOABPmPlkAOV8PWL2360/z8JbX3RN3jJn3k22WY4nsVemtGTWWONNPXLr
         r+EijcJznsNJUhXGiJ+wv9zrDJUUT/Y7DYYt5ZRXqeRS5p1+wCnKMTPcFWwvjLrrE7Ge
         qURw==
X-Received: by 10.68.41.10 with SMTP id b10mr27228099pbl.83.1378847489622;
 Tue, 10 Sep 2013 14:11:29 -0700 (PDT)
Received: by 10.70.35.205 with HTTP; Tue, 10 Sep 2013 14:11:29 -0700 (PDT)
In-Reply-To: <vpqtxhtey4t.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234483>

On Tue, Sep 10, 2013 at 11:04 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> On 10/09/13 21:19, Matthieu Moy wrote:
>>> Hi,
>>>
>>> I just noticed that the template COMMIT_EDITMSG was containing status
>>> hints, and that they were not particularty helpfull _during_ a commit. I
>>> think it would be sensible to ignore advice.statusHints and disable
>>> hints unconditionally when writting to COMMIT_EDITMSG.
>>>
>>> Any objection?
>>>
>>
>> I did recently find them useful/reassuring when I was committing a
>> merge. But I wouldn't consider that a strong objection.
>
> Just to make sure we're talking about the same thing: when commiting a
> merge, the template currently looks like:
>
>   Merge branch 'master' of /tmp/git
>
>   Conflicts:
>         foo.txt
>   #
>   # It looks like you may be committing a merge.
>   # If this is not correct, please remove the file
>   #     .git/MERGE_HEAD
>   # and try again.
>
>
>   # Please enter the commit message for your changes. Lines starting
>   # with '#' will be ignored, and an empty message aborts the commit.
>   # On branch master
>   # Your branch and 'origin/master' have diverged,
>   # and have 3 and 1 different commit each, respectively.
>   #   (use "git pull" to merge the remote branch into yours)
>   #
>   # All conflicts fixed but you are still merging.
>   #   (use "git commit" to conclude merge)
>   #
>   # Changes to be committed:
>   #
>   #     modified:   foo.txt
>   #
>
> What I'd like to remove are the parts between parenthesis :
>
>   (use "git commit" to conclude merge)
>   (use "git pull" to merge the remote branch into yours)
>
> The first part (It looks like [...]) would remain, of course.
>
> Actually, even the "All conflicts fixed but you are still merging." part
> is not really accurate when the commit is already started.

OK. I wouldn't miss that parts in parenthesis. If I chose to abort the
commit from the editor (e.g. :cq in vi) git status would still tell me
what I need to know.

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
