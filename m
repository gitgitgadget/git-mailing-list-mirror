From: Stefan Beller <sbeller@google.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 13:48:16 -0700
Message-ID: <CAGZ79kbD6hHSnjoQa5Ls0Zo35XLCVQA=XoS9xynfhJrR4qXFWg@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:48:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6kP-0006qI-Hm
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbcCUUsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:48:18 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38333 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbcCUUsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:48:17 -0400
Received: by mail-ig0-f180.google.com with SMTP id ig19so77052547igb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Ggh2FNFMoQbiSR5Y6LUbnppi3aGwcLko3Dlk044b89U=;
        b=HL13LBDZdap4AlF5ERJGhZNC3PjJtUtt7T0Z+zPmkwncB2zhhILyj8c6oab0+rbkfr
         QcxuYsm02Zr9QievfEiExO4HIy13mua73u/S8O9udItl9ssNamsX6rFFOTwsFWmwlKiH
         tAGqNxfsHmV7AP4CJCrP+oVZq1uReTZnJBvxaBySDO0bKwb0SMoKZvkE9Jq8WG+9vlXU
         aJ0UYZMwxkqJf4QL1UXE8+2Gf7FajSrX5//mznCL5Ks/YPoyMHLrLLID0F3jlywHkCNN
         iE9kVARkt6Du+5OU/dFnOeY8RbQKZ0RWTO6TxaODT6IbqWDBaPzxyvdHuFaRJNO98gMK
         DCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Ggh2FNFMoQbiSR5Y6LUbnppi3aGwcLko3Dlk044b89U=;
        b=NeissFuSwPXDa19Jaj1AcEwv5XTivnO3HVFmBlvmcjDp+NutcO99SjFvUUytv3fzQk
         f4C7ZIems1Sn/JnnUSFwyto3fxHr9W/xm+RE1tFXixWSrVnqfZLdUgwCRmIkd7FDXIXr
         7D+ckAEAK/o601hxut9bVDvJqgBHwSUS6GkYylU/yx4IE6eRQHhQ97W6u1RiP8HMxxs0
         EMUrv9S38EPO6KA5sGuIzSpuLn6C9sA7v2G7iihl/GIp5gFiqwtEaSgGUvikAYwI6uRS
         B0FUohlCG+lmUfuTRb7FrruYv7MhIcphYwSuKHUZRhiKMryaI8JATqPtpevwLWsV+oDZ
         HGDw==
X-Gm-Message-State: AD7BkJLkIqCbr/88JnfHlQuPUi90WomyNnS7ofMEsWPw+ZSXPSZ+R/5fJRMJcjPXjVZEYdVYT1fAKUgR+7nbvbDT
X-Received: by 10.50.13.34 with SMTP id e2mr8625939igc.85.1458593296182; Mon,
 21 Mar 2016 13:48:16 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 21 Mar 2016 13:48:16 -0700 (PDT)
In-Reply-To: <20160321202810.GD32071@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289457>

On Mon, Mar 21, 2016 at 1:28 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 21, 2016 at 08:21:46PM +0000, Thomas Adam wrote:
>
>> Something I've seen a few times of late (although I doubt that's any
>> indication that the code has changed in Git) is the reporting of
>> branch-X being uptodate with origin/branch-X when it isn't.
>>
>> When does git check to see if branch-X has a remote tracking branch
>> and that it has changes on it?  Only, the output below is misleading:
>>
>> % git checkout master
>> Switched to branch 'master'
>> Your branch is up-to-date with 'fvwmorg/master'.
>>
>> [fvwm-cvs-to-git/docs]{10345}[0][master] % git pull
>> remote: Counting objects: 26, done.
>> remote: Compressing objects: 100% (12/12), done.
>> remote: Total 26 (delta 18), reused 22 (delta 14), pack-reused 0
>> Unpacking objects: 100% (26/26), done.
>> From github.com:fvwmorg/fvwm
>>    c029868..36cc898  master     -> fvwmorg/master
>>    4f0c7ec..36cc898  ta/git-docs -> fvwmorg/ta/git-docs
>> Updating c029868..36cc898
>> Fast-forward
>> [...]
>>
>> Clearly, it's obvious that "Your branch is up-to-date with
>> 'fvwmorg/master'." is misleading.  Note that in this case, there's no
>> passwords or other hindrances to Git being able to work out that a
>> branch is behind another.
>
> The message from checking is looking only at your local
> refs/remotes/fvwmorg/master branch, which is essentially a cache of what
> is in the actual remote repository.
>
> We never contact other repositories unless explicitly asked to by
> fetch, pull, push, etc. If you want to have the most up-to-date value
> without merging, you can just "git fetch" to update the tracking
> branches.

To elaborate on that:

If you do "git fetch" instead of "git pull" and then followed by
"git status" it should tell you something like:

    Your branch is behind 'origin/master' by 73 commits, and can be
fast-forwarded.

The origin/ (or in your case fvwmorg/) is a local "cache" on what
we think the remote is at. the remote may change of course.

Stefan

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
