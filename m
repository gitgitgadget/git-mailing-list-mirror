From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/8] run-command: add an asynchronous parallel child processor
Date: Wed, 30 Sep 2015 11:28:47 -0700
Message-ID: <CAGZ79kbp5v-bMXGJh1KcXTb=Umb_2G_2taPRXhoPs0y_0cdUzw@mail.gmail.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
	<1443482046-25569-7-git-send-email-sbeller@google.com>
	<xmqqa8s4a9cw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:28:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhM7d-0005UC-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbbI3S2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:28:53 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36258 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932670AbbI3S2s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:28:48 -0400
Received: by ykdt18 with SMTP id t18so53018345ykd.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MTdIHXR+K9waTA6eVGhn6pkS5IPkLjtxN6fHp1RyMKo=;
        b=dEzme+udDY6vEJ9Fy2mkA1ptIMs+XNlNofMry8ViDD2/Gwd8HWKK+crUBT4KQjH4J7
         glFX2BTfDowl473bA2IL1XiApfRQrMUBxfMTxQbDawG/5ke9v+dZKa6labnoTR4gXyMB
         bFwWNIsduurlQjPcEOFwps0OQBpckt4FNT7umX88i9qPM5Q1IVyieohFS8EFKK7WGidL
         7Yfczu9l8nrnTY8D5EXIQ4SML5QDJcca+RDTWXoOpjbMsfwUdbzjKI/4ZmcLKW7RcbRD
         Uyz3s3e/55QdvsZsVf4tbV7fqDaLyItUZY8pIYMkHQLbXwqdPbqoWpE+11pEEiJna8ox
         QovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MTdIHXR+K9waTA6eVGhn6pkS5IPkLjtxN6fHp1RyMKo=;
        b=BbwL6s+PLqaogNkNyKKpFdaNwL9JP2bB/9QcQ6KiBn+gKTjbneAQhH5Z2LBwN2O4Gd
         AB/M3FsGm/wCmfFa3smA9rSdFaJoGFiyjXwA6LWoHURPNH9tJhSr7Qrd9ecMoJ1vNem5
         fsI/Nnc/srU8zXgEqWPENxe3AWwl2qW/RsgniDz1tmoITRmoQr7zuy0JfoHxbXHZaSzw
         UClFUOSpl3KCVTCFhl1FQXRhztkugf1wOBhiG6mCdYuZDh4pEyuh2As68p/7TyybgW5t
         g3YJ5Ge3UQcgkAoLER+zrXntHfa/sOrsW6MYn8T0oXz2I8wQDTKnww+qccUecfRh88Yn
         bwxQ==
X-Gm-Message-State: ALoCoQnnL8mHxG0+NlwY++deWXKcd0F2IFwAY82+fRlz9mg7Xdirg7hK4hYKVgC3GN0ihfl8p+KX
X-Received: by 10.13.255.4 with SMTP id p4mr4481525ywf.88.1443637727263; Wed,
 30 Sep 2015 11:28:47 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 30 Sep 2015 11:28:47 -0700 (PDT)
In-Reply-To: <xmqqa8s4a9cw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278851>

On Tue, Sep 29, 2015 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +     while (1) {
>> +             int i;
>> +             int output_timeout = 100;
>> +             int spawn_cap = 4;
>> +
>> +             if (!no_more_task) {
>> +                     for (i = 0; i < spawn_cap; i++) {
>> +                             int code;
>> +                             if (pp->nr_processes == pp->max_processes)
>> +                                     break;
>> +
>> +                             code = pp_start_one(pp);
>> +                             if (!code)
>> +                                     continue;
>> +                             if (code < 0) {
>> +                                     pp->shutdown = 1;
>> +                                     kill_children(pp, SIGTERM);
>> +                             }
>> +                             no_more_task = 1;
>> +                             break;
>> +                     }
>> +             }
>> +             if (no_more_task && !pp->nr_processes)
>> +                     break;
>
> I may have comments on other parts of this patch, but I noticed this
> a bit hard to read while reading the end result.
>
> Losing the outer "if (!no_more_task)" and replacing the above with
>
>         for (no_more_task = 0, i = 0;
>              !no_more_task && i < spawn_cap;
>              i++) {
>                 ... do things that may or may not set
>                 ... no_more_task
>         }
>         if (no_more_task && ...)
>                 break;
>
> would make it clear that regardless of spawn_cap, no_more_task is
> honored.
>
> Also I think that having the outer "if (!no_more_task)" and not
> having "no_more_task = 0" after each iteration is buggy.  Even when
> next_task() told start_one() that it does not have more tasks for
> now, as long as there are running processes, it is entirely plausible
> that next call to next_task() can return "now we have some more task
> to do".
>
> Although I think it would make it unsightly, if you want to have the
> large indentation that protects the spawn_cap loop from getting
> entered, the condition would be
>
>         if (!pp->shutdown) {
>                 for (... spawn_cap loop ...) {
>                         ...
>                 }
>         }
>
> That structure could make sense.  But even then I would probably
> write it more like
>
>         ...
>         int spawn_cap = 4;
>
>         pp = pp_init(...);
>         while (1) {
>                 int no_more_task = 0;
>
>                 for (i = 0;
>                      !no_more_task && !pp->shutdown && i < spawn_cap;
>                      i++) {
>                         ...
>                         code = start_one();
>                         ... set no_more_task to 1 as needed
>                         ... set pp->shutdown to 1 as needed
>                 }
>                 if (no_more_task && !pp->nr_processes)
>                         break;
>                 buffer_stderr(...);
>                 output(...);
>                 collect(...);
>         }

That is indeed better to read.
Though if we reset `no_more_task` each iteration of the loop by
having its declaration inside the loop, the condition for exiting the
loop needs to be:

    if ((no_more_task || pp->shutdown) && !pp->nr_processes)
        break;

for correctness.

When looking at that condition, I realized that I implicitly assumed
the workflow, where get_next_task returns 0 intermittently, to be a
second class citizen. I reworded the documentation as well there.

>
> That is, you need to have two independent conditions that tell you
> not to spawn any new task:
>
>  (1) You called start_one() repeatedly and next_task() said "nothing
>      more for now", so you know calling start_one() one more time
>      without changing other conditions (like draining output from
>      running processes and culling finished ones) will not help.
>
>      Letting other parts of the application that uses this scheduler
>      loop (i.e. drain output, cull finished process, etc.) may
>      change the situation and you _do_ need to call start_one() when
>      the next_task() merely said "nothing more for now".
>
>      That is what no_more_task controls.
>
>  (2) The application said "I want the system to be gracefully shut
>      down".  next_task() may also have said "nothing more for now"
>      and you may have set no_more_task in response to it, but unlike
>      (1) above, draining and culling must be done only to shut the
>      system down, the application does not want new processes to be
>      added.  You do not want to enter the spawn_cap loop when it
>      happens.
>
>      That is what pp->shutdown controls.
>
