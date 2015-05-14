From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Thu, 14 May 2015 10:29:34 -0700
Message-ID: <CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
 <1431508136-15313-2-git-send-email-pyokagan@gmail.com> <xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
 <xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:30:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswxP-0003Gw-V6
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134AbbENR34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:29:56 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36506 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbbENR3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:29:55 -0400
Received: by igbpi8 with SMTP id pi8so173195527igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P56S+BtngfHjOdKiFKxWFx9+dj5+EO+RJXtvZ4bivnc=;
        b=ESufoQOcSPOYNiN1ysa8oxHny/106l6ijCDZWPE8oLQwFicXUYTqRtOVbefZQYnFk+
         GjJfohpXSE2UBMqu2v11jlwBGXf/Wndg+3eB1nlvFWfkB6YBTGGyJS3orxcxh0X6HDMX
         E5pMesPW0SDbYhJEiMRcNGHKFWstbrDToJ+AM7x1qq1VC6tJah9QycDcsP7uyBvg7hYx
         ZPEtrYQPLzn//hV2VCpJt5mSt34lQ73P7JRpSs6Ld41f7gik8I5TZv+AFikLGOihtFgz
         dZ2WSLAJ7M9Cy+/1wNno4Hr4k5i6tP6SRqZmwDyoiq82hInLDHKr1bKG9/SRfNrhf/Q9
         dNrA==
X-Received: by 10.42.233.142 with SMTP id jy14mr15952439icb.55.1431624595266;
 Thu, 14 May 2015 10:29:55 -0700 (PDT)
Received: by 10.64.224.172 with HTTP; Thu, 14 May 2015 10:29:34 -0700 (PDT)
In-Reply-To: <xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269052>

On Wed, May 13, 2015 at 7:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Paul Tan <pyokagan@gmail.com> writes:
>>
>>> Replace the above 2 forms with:
>>>
>>>      verbose test "$(cat file)" = expected
>>
>> Quoting is very much a good idea, but I am not enthused by the
>> vision of having to write verbose everywhere in our script.
>>
>> After seeing a script fail, you can run it again with -i -x options;
>> wouldn't it be sufficient?
>
> Just to avoid misunderstanding, I am unhappy if we have to keep
> writing "verbose test" in that exact form.
>
> Just like we invented to help debugging by wrapping "cmp" with
> "test_cmp" (i.e. we want to see if the file contents are the same,
> but a person who debugs can be helped by seeing the differences when
> the expectation is not met), I do not mind if we had a shorter and
> cleanly-named wrapper that we can use consistently.  E.g. I do not
> mind something like this in test-lib-functions.sh
>
>         test_file_contents () {
>                 if test "$(cat "$1")" != "$2"
>                 then
>                         echo "Contents of file $1 is not $2"
>                         false
>                 fi
>         }
>
> and used like so:
>
>         test_file_contents file expected_string
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

My build starts breaking from this commit, I'm on a mac.


expecting success:
    (cd dst &&
     test_must_fail git pull --rebase &&
     verbose test 1 = "$(find .git/rebase-apply -name "000*" | wc -l)"
    )

First, rewinding head to replay your work on top of it...
Applying: Modified Change 4
Using index info to reconstruct a base tree...
M    stuff
Falling back to patching base and 3-way merge...
Merging HEAD with Modified Change 4
Merging:
814f1c3 Change 4
virtual Modified Change 4
found 1 common ancestor:
virtual e369e858ec1aa73d497d02c4f23e5cf4ae2d3c3b
Auto-merging stuff
CONFLICT (content): Merge conflict in stuff
Failed to merge in the changes.
Patch failed at 0001 Modified Change 4
The copy of the patch that failed is found in:
   /Users/michael.blume/workspace/git/t/trash
directory.t5520-pull/dst/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

command failed:  'test' '1' '=' '       1'
not ok 33 - git pull --rebase does not reapply old patches
#
#        (cd dst &&
#         test_must_fail git pull --rebase &&
#         verbose test 1 = "$(find .git/rebase-apply -name "000*" | wc -l)"
#        )
#
