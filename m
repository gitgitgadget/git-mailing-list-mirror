From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 10:53:07 -0700
Message-ID: <CAGZ79kYaqFRPfRORbknTyez5u0d6_BD0d5wBtAnjSkb4sUBUBA@mail.gmail.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 19:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoEO-0006pj-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 19:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbbIWRxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 13:53:13 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35751 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbbIWRxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 13:53:08 -0400
Received: by ykdz138 with SMTP id z138so49388955ykd.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1jpiwdZGPrjOLrvGuPCK/q4iAcbabgx7R3k+5bqDSRg=;
        b=Bsrg+0BBptPN3b8ort8/IyMn6j+IiAqnonQG9ohXrpjxsrFEno1yA2VcK15IoJt1nF
         1Al/RU/TFYyNQyiyEC3Lus/TbXFrFDbcD52lkySDJYbOcL+l6w5go6ZDNJ8OFsNC4ggW
         C3VumxPl+zMdqsVxM73bJXqsdVUUt2OX49G1WNQaUQQ6m6xxb8L3zclPuDWSimKxO849
         80M4QwdzmjVpxQH2hyt98mlY78hc+di3B4LCOTexVXv/UOyeEw68YnYHp46WDMiVf0GX
         jSYGPk/+rN1Scd1wyU1ExqZ17YPNPP+drwDCLVFgL8nFe8EiCtl64w64vSnwtt099XUr
         uzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1jpiwdZGPrjOLrvGuPCK/q4iAcbabgx7R3k+5bqDSRg=;
        b=F1+VoBCCgUPbLh0G+FEXkIg1fxSeHKs0YATfwcyY79zC1jNIy0hw6alpzakAwj502+
         vV7eHhomweL9ClaA5Zc+HxgS3b3PG9d9z4u51/42kRTJ+YlxnnD+/T52u0AART9Ldu2+
         2GNQYyFEDGKv0NSaXIgcB9FmZJl7ut7y6MfhBJziNV6IsARaC0s+6gtQpnjgEdstyyur
         G5Tw4bJ0Tmi2Pkqa2J1tgF6fFEoH4i8XGBNlNJJZXEGwzdz3CrM8iJviz6Km6hILBKIy
         b2C5YqbniK08es8ZUqlPRbPQEBQCUnN1agg/ugjbr6VpS3l4ARvcRzp1ISEtxRh7mucA
         4N7A==
X-Gm-Message-State: ALoCoQmXpDpldKuinkls3fRLc/5nhKnTDQQ/q9a86quxmRl0P5eirvdRogeQ8feT7Nl+95nNYXE1
X-Received: by 10.13.211.135 with SMTP id v129mr10450535ywd.129.1443030787676;
 Wed, 23 Sep 2015 10:53:07 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 23 Sep 2015 10:53:07 -0700 (PDT)
In-Reply-To: <xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278490>

On Tue, Sep 22, 2015 at 11:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> And this one, when get_next_task() says "nothing more to do", is
> clearly "we returned without starting anything", so according to the
> comment it should be returning 0, but the code returns 1, which
> looks incorrect.
>
>> +     if (start_command(&pp->children[i].process))
>> +             pp->start_failure(pp->data,
>> +                               &pp->children[i].process,
>> +                               &pp->children[i].err);
>
> What should happen if start_failure returns without dying?
> Shouldn't this function return something, without doing the
> remainder of it?  i.e.
>
>         if (start_command(...)) {
>                 pp->start_failur(...);
>                 return SOMETHING;
>         }

Right, I forgot about that code path as I was blinded by the obviousness
("If you cannot start a process, of course we'll die").

So for this SOMETHING we need to decide if it should signal
that an immediate retry can be done. But then we could perform the
immediate retry ourselves:

startnewtask:
    if (!pp->get_next_task(pp->data,
                   &pp->children[i].process,
                   &pp->children[i].err))
        return 0;

    if (start_command(&pp->children[i].process)) {
        pp->start_failure(pp->data,
                  &pp->children[i].process,
                  &pp->children[i].err);
        goto startnewtask;
    }

But this could result in an endless loop.
Even if we would decide to return to the caller run_processes_parallel
and let them decide to try again, this version of the patch may produce an
infinite loop there.

The other alternative would be to make SOMETHING signal to not
immediately try again. ("We failed to start a child process, give it some time
by doing the poll/output and try again")

This however could not finish all workloads reliably as we may fail to start
the first child, such that there are 0 children processes running and the
control loop in run_processes_parallel shuts down the whole parallel processor.

So for now I'd lean on having the SOMETHING be the same boolean as
a successful start (failure -1, successful start 1, no more pending work 0)
and the difference between -1 and 1 can be sorted out in a later patch, which
introduces workloads with failing children.

>> +
>> +     while (1) {
>> +             while (pp.nr_processes < pp.max_processes &&
>> +                    !pp_start_one(&pp))
>> +                     ; /* nothing */
>> +             if (!pp.nr_processes)
>> +                     break;
>
> This inner loop is why I think "did we or did we not spawn a new
> process?" is not a great interface.

Right, we actually need to return whether we have nothing more to do
("Don't even try to call me again") or if we did something useful and expect
to do more useful things in the next call. (Either starting anew command or
finding out it failed).

This would be indicated by the -1/1/0 return signals.

>
> The reason why it is not a great interface is because there are two
> possible reasons why pp_start_one() does not spawn a new process,
> and this caller wants to behave differently depending on why it did
> not spawn a new process.  They are:
>
>  * get_next_task() truly ran out of things to do.
>
>  * get_next_task() gave us a task, but it did not start, and
>    start_failure was set not to die (e.g. the function can be used
>    to tell the next_task machinery that it needs to return a
>    replacement task for the one that failed to run.  That way, upon
>    next call to get_next_task, a replacement task can run instead of
>    the old one that failed).
>
> For the former, we want to stop looping, for the latter, we
> definitely do want to keep looping, as we want to make another call
> to get_next_task() to grab the replacement task for the one that
> just failed.
>
> So I think it makes more sense to define the meaning of the return
> value from pp_start_one() differently from the way this patch
> defines.  "Return 0 when we truly ran out of things to do, otherwise
> return non-zero", for example, would make more sense.

ok, we have the same opinion. I just documented poorly.

>  The return
> value does not tell you if the call resulted in one more process,
> but that is not any loss, as you can look at pp.nr_processes
> yourself if you really cared.
>
> With that, the above caller could be updated, with optional gradual
> ramp_up, like so:
>
>         #define RAMP_UP_LIMIT 2
>
>         while (1) {
>                 int ramp_up;
>                 int no_more_task;
>
>                 for (no_more_task = 0, ramp_up = RAMP_UP_LIMIT;
>                      !no_more_task && ramp_up && pp.nr_processes < pp.max_processes;
>                      ramp_up--)
>                         if (!pp_start_one(&pp))
>                                 no_more_task = 1;

I would not have the no_more_task variable, but just reuse
ramp_up and set it to zero in case of !pp_start_one(&pp).

I am not sure if the ramp up machinery is really needed.
I modified the test-run-command test function to start up to 400 processes.
(Most people will use less than 400 processes in the next 5 years), and run
just as in t0061:

    ./test-run-command run-command-parallel-400 sh -c "printf
\"%s\n%s\n\" Hello World"

The output felt immediate (not slowed down or anything). The numbers seem to
support that

    real 0m0.110s
    user 0m0.045s
    sys 0m0.366s

Any delay below 0.1 second cannot really be perceived by a human. You
can sure tell
a difference of 0.1 second in say 2 acoustic signals or light flashes,
but you cannot
tell that the output "was slow". So IMHO the ramp up machinery doesn't
have a high
priority for now.


>
>                 if (!pp.nr_processes && no_more_task)
>                         break;
>
> If you prefer to swamp the system with a thundering herd at the
> beginning, you can define RAMP_UP_LIMIT to really a high value
> instead, e.g. "#define RAMPUP_LIMIT pp.max_processes".  I however
> would not recommend it because doing so would hurt the perceived
> latency at the beginning.
>
> After the system goes into a steady state, how you set RAMP_UP_LIMIT
> would not make that much difference, as your slots should be almost
> always full and you will be replenishing an open slot with a single
> task as each running task finishes, and you would not be running
> more than one pp_start_one() at a time anyway.

Yeah there we could have a simple

    if (pp->nr_processes == pp->max_processes)
        poll_timeout = 5 seconds
    else
        poll_timeout = 10..100 milliseconds

>
>> +             pp_buffer_stderr(&pp);
>> +             pp_output(&pp);
>> +             pp_collect_finished(&pp);
>> +     }
>> +
>> +     pp_cleanup(&pp);
>> +
>> +     return 0;
>> +}
