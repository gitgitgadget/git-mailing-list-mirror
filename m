From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] wt-status: give better advice when cherry-pick is in progress
Date: Mon, 17 Jun 2013 21:29:04 +0200
Message-ID: <CAN0XMOJhUA7Uut-jpnpSRW_E2xHARCyP_8FUmebNjBkm59v0JA@mail.gmail.com>
References: <1371443306-3073-1-git-send-email-ralf.thielow@gmail.com>
	<7vppvkczqu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Lucien.Kong@ensimag.imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uof72-0004Ew-15
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab3FQT3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:29:07 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:43213 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab3FQT3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:29:06 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so2696385wgh.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bVmphE5EBDu4sVKuRn9czD2weXmGG4qnefX24DiPpRc=;
        b=0n9xvgiSNBZSeE8pmnP0U/Y7FoHoYmKzSrz6oswkyhApO2QWts+0UeNpZREnAu8eBA
         F/YW7RRqQfCrSGrFdY82a+1ew+OnFZTje0wyQj3jSFgslkVm9cN3SIQggma1YQSjzxKI
         2+vn3lifuNBBB02VQxnUAsjg8gt4Bv001VYBKyh8U2+ZoRTKMcFP4K3Xi46gjxmoKw5D
         Q9dCIuEXQwwQFVYv2Zg/Fch/dPGJyRhjN09CrO71ZN4QqJYjtUWPQ1QK6Nu67J+MQXQa
         hhEGp+QgZUeZYO7bybDJ2CMRyLXH5b/T9r8fGhbHg56kr3kle88SavdR7GP0PUellDes
         juDA==
X-Received: by 10.194.173.37 with SMTP id bh5mr8908017wjc.30.1371497344655;
 Mon, 17 Jun 2013 12:29:04 -0700 (PDT)
Received: by 10.194.20.229 with HTTP; Mon, 17 Jun 2013 12:29:04 -0700 (PDT)
In-Reply-To: <7vppvkczqu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228101>

2013/6/17 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> When cherry-pick is in progress, 'git status' gives the advice to
>> run "git commit" to finish the cherry-pick. However, this won't continue
>> the sequencer.
>> "git status" should give the advice of running "git cherry-pick --continue"
>> or "git cherry-pick --abort".
>
> Is the above _always_ the case, or does the updated advice message
> only apply when you are cherry-picking a range of commits with "git
> cherry-pick A..B"?  In other words, when "git cherry-pick $it" (a
> single commit) stops, waiting for your help to resolve it, would
> "git cherry-pick --continue" conclude it?
>

Yes, both "--continue" and "--abort" works with a single commit.

> If that works then this definitely is a good change (the user only
> needs to know "cherry-pick --continue").
>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  t/t7512-status-help.sh | 6 ++++--
>>  wt-status.c            | 6 ++++--
>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
>> index bf08d4e..4f09bec 100755
>> --- a/t/t7512-status-help.sh
>> +++ b/t/t7512-status-help.sh
>> @@ -632,7 +632,8 @@ test_expect_success 'status when cherry-picking before resolving conflicts' '
>>       cat >expected <<-\EOF &&
>>       # On branch cherry_branch
>>       # You are currently cherry-picking.
>> -     #   (fix conflicts and run "git commit")
>> +     #   (fix conflicts and run "git cherry-pick --continue")
>> +     #   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
>>       #
>>       # Unmerged paths:
>>       #   (use "git add <file>..." to mark resolution)
>> @@ -655,7 +656,8 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
>>       cat >expected <<-\EOF &&
>>       # On branch cherry_branch
>>       # You are currently cherry-picking.
>> -     #   (all conflicts fixed: run "git commit")
>> +     #   (all conflicts fixed: run "git cherry-pick --continue")
>> +     #   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
>>       #
>>       # Changes to be committed:
>>       #
>> diff --git a/wt-status.c b/wt-status.c
>> index bf84a86..438a40d 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -955,10 +955,12 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>>       if (advice_status_hints) {
>>               if (has_unmerged(s))
>>                       status_printf_ln(s, color,
>> -                             _("  (fix conflicts and run \"git commit\")"));
>> +                             _("  (fix conflicts and run \"git cherry-pick --continue\")"));
>>               else
>>                       status_printf_ln(s, color,
>> -                             _("  (all conflicts fixed: run \"git commit\")"));
>> +                             _("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
>> +             status_printf_ln(s, color,
>> +                     _("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
>>       }
>>       wt_status_print_trailer(s);
>>  }
