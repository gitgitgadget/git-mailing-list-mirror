From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 11:28:31 -0700
Message-ID: <CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
	<xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:28:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSJ0-0002EQ-7G
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934082AbbIVS2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:28:35 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33010 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933528AbbIVS2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:28:33 -0400
Received: by ykft14 with SMTP id t14so18434792ykf.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OtpHZZNWK0W5ANOF6SDBTk3Z6YryLm+fcX649DqE5DM=;
        b=YT/vD7DA1gsR5aHUiGpQUzd2f2nVaTbIRYNHXFjwy1IFv/3R79Skj3MM3RuRoZHFlA
         5ZoZBW2M+wnpkAryL7sGNP9xs1/yT2imwFwDZRa0yOfpC01+erRQXG2hAx6yxEoJyG0p
         0LvrWC/DMJPk+gIjHSQJMdGUC4DSgWsN+YgCQzt3D6UUwbKkLiNsy5Woxh9iS+bOqQLu
         TczfmyLe4J5nmhYHZvET1dsdnKt1ukhIgM0+khaDLCOyBX2bcDy4vjMqDCjeLWRuPGDS
         +AHrPSCK/b6Z6EnOnJShyLYCFjG1JwPqHV5kEIuV6KgflKEngYtEIjnPwEtouHcayJyF
         aNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OtpHZZNWK0W5ANOF6SDBTk3Z6YryLm+fcX649DqE5DM=;
        b=fjzSq6p1PTyJixUSQrCTub+ZmpKdCIugujLDTrFRLoVRogxmWzZkYMdr7BwgBZk44g
         apgZuh5fnChH4F6xPYkd0g2kNccIahfzCCu2jPKoEqQ8KeuuIdvfjCQph2srZe2fRHdi
         gSIn1V1h/Q/LZj+U5oEhHd2lTMtylE2UXsE7YUCruXG65jucjKqOKwWsL5FhHVhv4kNH
         Oc0GnsoSHlaq/QxX/Vs3EOJT9eKfmCpwW6vaDuz4xc3/EcNBRsAx2NfXzCeku9g64poK
         /cg1Z6YdEfzbRakP2NlyDspGkBfqT4bI9cjZmGNjQkfmlP60aTrugXEVRvMmhhlauUJO
         OVcg==
X-Gm-Message-State: ALoCoQm0c/Ruv1TuIMIKL8azYIgpR/tC5ZqkNhejkXWcyntc44MbZRTyIJtmK0xzybQ3BTqwfq9r
X-Received: by 10.170.210.65 with SMTP id b62mr21143343ykf.10.1442946512048;
 Tue, 22 Sep 2015 11:28:32 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 11:28:31 -0700 (PDT)
In-Reply-To: <xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278409>

On Mon, Sep 21, 2015 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +void default_start_failure(void *data,
>> +                        struct child_process *cp,
>> +                        struct strbuf *err)
>> +{
>> +     int i;
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>> +     for (i = 0; cp->argv[i]; i++)
>> +             strbuf_addf(&sb, "%s ", cp->argv[i]);
>> +     die_errno("Starting a child failed:\n%s", sb.buf);
>
> Do we want that trailing SP after the last element of argv[]?
> Same question applies to the one in "return-value".

done

>
>> +static void run_processes_parallel_init(struct parallel_processes *pp,
>> +                                     int n, void *data,
>> +                                     get_next_task_fn get_next_task,
>> +                                     start_failure_fn start_failure,
>> +                                     return_value_fn return_value)
>> +{
>> +     int i;
>> +
>> +     if (n < 1)
>> +             n = online_cpus();
>> +
>> +     pp->max_processes = n;
>> +     pp->data = data;
>> +     if (!get_next_task)
>> +             die("BUG: you need to specify a get_next_task function");
>> +     pp->get_next_task = get_next_task;
>> +
>> +     pp->start_failure = start_failure ? start_failure : default_start_failure;
>> +     pp->return_value = return_value ? return_value : default_return_value;
>
> I would actually have expected that leaving these to NULL will just
> skip pp->fn calls, instead of a "default implementation", but a pair
> of very simple default implementation would not hrtut.

Ok, I think the default implementation provided is a reasonable default, as
it provides enough information in case of an error.

>
>> +static void run_processes_parallel_cleanup(struct parallel_processes *pp)
>> +{
>> +     int i;
>
> Have a blank between the decl block and the first stmt here (and
> elsewhere, too---which you got correct in the function above)?

done

>
>> +     for (i = 0; i < pp->max_processes; i++)
>> +             strbuf_release(&pp->children[i].err);
>
>> +static void run_processes_parallel_start_one(struct parallel_processes *pp)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < pp->max_processes; i++)
>> +             if (!pp->children[i].in_use)
>> +                     break;
>> +     if (i == pp->max_processes)
>> +             die("BUG: bookkeeping is hard");
>
> Mental note: the caller is responsible for not calling this when all
> slots are taken.
>
>> +     if (!pp->get_next_task(pp->data,
>> +                            &pp->children[i].process,
>> +                            &pp->children[i].err)) {
>> +             pp->all_tasks_started = 1;
>> +             return;
>> +     }
>
> Mental note: but it is OK to call this if get_next_task() previously
> said "no more task".
>
> The above two shows a slight discrepancy (nothing earth-breaking).

I see. Maybe this can be improved by having the
run_processes_parallel_start_as_needed call get_next_task
and pass the information into the run_processes_parallel_start_one
or as we had it before, combine these two functions again.

>
> I have this suspicion that the all-tasks-started bit may turn out to
> be a big mistake that we may later regret.  Don't we want to allow
> pp->more_task() to say "no more task to run at this moment" implying
> "but please do ask me later, because I may have found more to do by
> the time you ask me again"?

And this task would arise because the current running children produce
more work to be done?
So you would have a
    more_tasks() question. If that returns true
    get_next_task() must provide that next task?

In case we had more work to do, which is based on the outcome of the
children, we could just wait in get_next_task for a semaphore/condition
variable from the return_value. Though that would stop progress reporting
end maybe lock up the whole program due to pipe clogging.

It seems to be a better design as we come back to the main loop fast
which does the polling. Although I feel like it is over engineered for now.

So how would you find out when we are done?
* more_tasks() could have different return values in an enum
  (YES_THERE_ARE, NO_BUT_ASK_LATER, NO_NEVER_ASK_AGAIN)
* There could be yet another callback more_tasks_available() and
   parallel_processing_should_stop()
* Hand back a callback ourselfs [Call signal_parallel_processing_done(void*)
  when more_tasks will never return true again, with a void* we provide to
  more_tasks()]
* ...

>
> That is one of the reasons why I do not think the "very top level is
> a bulleted list" organization is a good idea in general.  A good
> scheduling decision can seldom be made in isolation without taking
> global picture into account.
>
>> +static void run_processes_parallel_collect_finished(struct parallel_processes *pp)
>> +{
>> +     int i = 0;
>> +     pid_t pid;
>> +     int wait_status, code;
>> +     int n = pp->max_processes;
>> +
>> +     while (pp->nr_processes > 0) {
>> +             pid = waitpid(-1, &wait_status, WNOHANG);
>> +             if (pid == 0)
>> +                     return;
>> +
>> +             if (pid < 0)
>> +                     die_errno("wait");
>> +
>> +             for (i = 0; i < pp->max_processes; i++)
>> +                     if (pp->children[i].in_use &&
>> +                         pid == pp->children[i].process.pid)
>> +                             break;
>> +             if (i == pp->max_processes)
>> +                     /*
>> +                      * waitpid returned another process id
>> +                      * which we are not waiting for.
>> +                      */
>> +                     return;
>
> If we culled a child process that this machinery is not in charge
> of, waitpid() in other places that wants to see that child will not
> see it.  Perhaps such a situation might even warrant an error() or
> BUG()?  Do we want a "NEEDSWORK: Is this a bug?" comment here at
> least?
>
>> +             if (strbuf_read_once(&pp->children[i].err,
>> +                                  pp->children[i].process.err, 0) < 0 &&
>> +                 errno != EAGAIN)
>> +                     die_errno("strbuf_read_once");
>
> Don't we want to read thru to the end here?  The reason read_once()
> did not read thru to the end may not have anything to do with
> NONBLOCK (e.g. xread_nonblock() caps len, and it does not loop).

right.

>
