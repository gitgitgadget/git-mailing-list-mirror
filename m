From: Tom Anderson <thomasanderson@google.com>
Subject: Re: [PATCH] git-stash: add flag to skip "git reset --hard"
Date: Mon, 2 May 2016 12:13:35 -0700
Message-ID: <5727A6DF.5020204@google.com>
References: <57267BBE.9010707@google.com>
 <xmqqeg9kti6x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:13:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJHp-0000fO-EK
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbcEBTNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:13:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34905 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbcEBTNh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:13:37 -0400
Received: by mail-pa0-f51.google.com with SMTP id iv1so77873933pac.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6UxITYV+56/s7UwR6DVlLZsN4ZpejDMHIeCeUtgyL88=;
        b=CmPNjplre5IpyLreRri5Tvk2saXInoQ1eW+nK9+VlB2c2dGFHaj9xYZ7XDJPjgSjEf
         miSw8SAD7tiyihilac4C8KS3V4LbsmfBENnE7oujmpL5BlqWdcxbjZ0vaI418+gOm8pP
         t7vxhNvVRx0TNbI1raV7h+mUWEmt6L3stMdaupPxPypwjbEUuo9qjffn1LzQndfoeNTi
         xsMJNmzhM3Iduk2gaAUCnSCmXZJTjydWTYkIfEwnLGzUBDOEaCpRJU522FQFzo5Q7Ii5
         E6KduoWttTrQwr8geePfYyKSZPdXtTyfgc5xeLiCALK2nEIRllVWkVa8IWMvxaU0EMvB
         cXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6UxITYV+56/s7UwR6DVlLZsN4ZpejDMHIeCeUtgyL88=;
        b=SXvVoIhpdoLxl6hsJ4Hnnfz3nPUUMwaVjyUR9EvvCTYyAwshA1GCHhkLZ6MJvB50MU
         p4zAuJE9mE0vmoWGcBHL2OZLTq6EvhjcafL+WhqANwzh8hgSvX+Bu4Geru00eqW4Qwhv
         PujJfIAKt9NecXfD4tTW5hueYlCYLZsXfDeqSLP724Mi04m4QAIckxpeCWKsJp+u2+ep
         b0KVGFxgDhjfwOp36m4Y1ADeNwoyC/IXmAwumjeF88ERhMGUUh0sg+qgozp1Ty65TQtg
         JZxd6kTuGaImc/6yER6QQrLuPqhD7FogX/vSEHMmT/uQj7YGXxYvx5ZcFGsR8e3xE3/l
         7rSg==
X-Gm-Message-State: AOPr4FVCeJ98517H91gDGpAUycyKxqNQGVv7GqWLyjMfGFU6a6Sfqt5vxRew5cMlK4Q+Qa6S
X-Received: by 10.66.149.194 with SMTP id uc2mr54917039pab.116.1462216416664;
        Mon, 02 May 2016 12:13:36 -0700 (PDT)
Received: from thomasanderson.mtv.corp.google.com ([2620:0:1000:1600:a583:4c30:2a15:2c83])
        by smtp.gmail.com with ESMTPSA id yp9sm47573255pab.42.2016.05.02.12.13.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 12:13:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqeg9kti6x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293271>


On 05/02/2016 11:42 AM, Junio C Hamano wrote:
> Tom Anderson <thomasanderson@google.com> writes:
>
>> @@ -61,6 +61,9 @@ stashed and then cleaned up with `git clean`,
>> leaving the working directory
>>   in a very clean state. If the `--all` option is used instead then the
>>   ignored files are stashed and cleaned in addition to the untracked files.
>>   +
>> +If the `--no-reset` option is used, `git reset --hard` is skipped and the
>> +`--[no-]keep-index`, `--include-untracked`, and `--all` flags are ignored.
>> ++
> I am afraid that a reader who does not read git-stash.sh script
> would not know what you are talking about.  They do not know (or
> particularly care) where "git reset --hard", how often and for what
> purpose.  They can tell that this option affects only "save",
> because that is where it is described, but they would not know what
> it means to "skip reset --hard", other than that they cannot use the
> three features listed there.
The man page for git-stash unfortunately already makes a reference to
git reset --hard:

        save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked]
        [-a|--all] [-q|--quiet] [<message>]
            Save your local modifications to a new stash, and run git reset
            --hard to revert them
>
> It is unclear what problem you are trying to solve from this text,
> and the log message's mention of mtime and rebuilding makes it
> sound like an X-Y problem.
>
> It could very well be that what you are trying to implement makes
> perfect sense and the new option is named with a stress on a wrong
> aspect (i.e. named after what it uses to achieve things, rather than
> saying what you are trying to achieve).
Perhaps it would be better to rename --no-reset to something more
appropriate?
> The workhorse used in "git stash save" (which is what you are
> touching) is "git stash create", and that is only responsible for
> recording a new stash entry without touch the working tree.  Is that
> what you are after, perhaps?
>
Yes, but I like my stashes to be saved in the ref namespace. Maybe an
alternative if it's a bad idea to add this new flag to "git stash save" is
to add a new flag to "git stash create"?  Or make a new git-stash command
entirely?
