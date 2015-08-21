From: Stefan Beller <sbeller@google.com>
Subject: Re: [WIP/PATCH 3/3] submodule: helper to run foreach in parallel
Date: Fri, 21 Aug 2015 13:21:32 -0700
Message-ID: <CAGZ79kYxYawAtATAoTmgG42w7E+2fEPfHek5bpbMgZ32wya5Zw@mail.gmail.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-3-git-send-email-sbeller@google.com>
	<xmqq7foo5tty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsol-0003M7-QC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbHUUVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 16:21:35 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36497 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbbHUUVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 16:21:33 -0400
Received: by ykfw73 with SMTP id w73so81993915ykf.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DeUDuXPpPSIXzMVEymFjicQbsczE/rTAMppjbhvVrY0=;
        b=B8COa5cnIMD0yCXFbgnDdvbVZTYbs8Am8mRLfO1DNMy/bG1L0e6RmY0AwVZjCXizS4
         hcw47vj5Zg199g2bVrqXRS49ToOK5a3gwY6UY2fyPIjii3jUeYznBpS6BCXBpRP3A6lX
         jCSZvK212Y5U86gJZwT1gC/XsW6nARjMGVb0YeqXwArtIE44nH9Wnvx3ZzBpd6S/2PbY
         px5M7Gmc4VDesXn+mifHqh5QMfJqeU2UhNZw/8GSqq02neQTsTGS09T/q5yeb1jHUyZn
         +5o5XbSQGf8bZouhHi+taJ6eLwRsn6PXghrFFB0izMhnhJoSkUHouq9vTrWsKXblbeQ3
         eXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DeUDuXPpPSIXzMVEymFjicQbsczE/rTAMppjbhvVrY0=;
        b=cuVKimHQsN0FMdxTZkUj263e4wG02Ia+Uifjg5zVyJAvQ0WSztvBF/v0dm9/hJoxRq
         X79xXOqNuX1mHplvNwaKtT1EzKkb1wRDpmXXaH4O4kOYip437PkHhyeaav1mTTEfvCpE
         qZwWny2VOiC3GpyieYijSNX459DmErK/yZm6wmA3IWAMTKiX2Uo8KOJzQwNTOcUW4ZPt
         nIHUCVccTvfxSR6TF6GAMkqjvMqzAnoLMDCOsjlE+q3Huoa1rGq3dfXITGwxxpAnJC0D
         4FOp5+Lp3LR0pJMF+z6+luv8N/DSY+TVis7ijo14pRZttFicYTE1XTeOKd7ANi8k2O/P
         36rw==
X-Gm-Message-State: ALoCoQkO9wqVSdqpLPyRQrhKnmNqQMOEV/sgON0rrbyjBC3CYL4nExpEWyWbFoZVZyC8V21WN7yM
X-Received: by 10.13.218.131 with SMTP id c125mr14547561ywe.129.1440188492395;
 Fri, 21 Aug 2015 13:21:32 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 13:21:32 -0700 (PDT)
In-Reply-To: <xmqq7foo5tty.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276328>

On Fri, Aug 21, 2015 at 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +struct submodule_args {
>> +     const char *name;
>> +     const char *path;
>> +     const char *sha1;
>> +     const char *toplevel;
>> +     const char *prefix;
>> +     const char **cmd;
>> +     struct submodule_output *out;
>> +     sem_t *mutex;
>> +};
>
> I do not see what submodule_output looks like in the patch, but I
> guess you are capturing _all_ output from a task and emitting
> everything at the end, after the task is done?

It was a leftover and will be removed. Sorry for wasting your time.
So jrnieder and me had a discussion on how to do get the output right.

And we had 2 designs:

1) The worker thread acquires a mutex to be allowed to write to
  stdout. This makes early output easy for each thread in case of
  error messages. It also requires less resources than 2).
  Also the expected code complexity is lower as the decisions
  are made locally.

2) Have a single handler which deals with all output of all tasks.
  This handler would `select` on a huge number of pipes from
  all the tasks, (so we would require a lot of pipes). And this central
  handler (which would be submodule_output in this case) would
  take care of having no intermingled racy output from tasks, with
  prefixes and all bells and whistles. This handler could also
  give a progress meter (300 out of 500 submodules updated already)
  for all threads, or when the last task is running switch to piping
  the output of that task to stdout in real time, so you'd get progress
  of the last task as you're already used to.

The outcome of the discussion was to split the worker pool/load
distribution from the output handling in any case as there is no need
to couple them. In my very first designs I had the output handling
as part of the asynchronous worker pool.

This RFC implements 1), that's why there is only the mutex.
I plan on enhancing this to let the last task output in real time (no buffering)
as well as another counter "task n/m completed" after each task
is done.

>
> I have to wonder if that is what people would expect and more
> importantly if that is the most useful.  I am sympathetic to the
> desire to avoid the output totally mixed up from different processes
> emitting things in an uncoordinated manner, and "slurp everything
> and then show everything in one go" is certainly _one_ way to do so,
> but early feedback also counts.  Besides, because the order in which
> tasks are dispatched and completed is unpredictable, you cannot
> expect a machine parseable output _without_ assuming some help from
> the command invoked by each task (e.g. by prefixing the task's output
> with some string that identifies which submodule the output is about).

I was very focused on the "submodule foreach" output, which (in case of
no -q given), displays a

    "Entering %s"

as the first line for each finished task. I suspect that is not enough to
make it a good machine parseable output. So I will prefix each
line with a running number of the task. Maybe like this:

  [001/500] Entering 'foo/bar'
  [001/500] Here goes the text for task foo/bar
  [001/500] Here goes another text for task foo/bar
  [002/500] Entering 'foo/baz'
  [002/500] Here goes the text for task foo/baz
  [002/500] Here goes another text for task foo/bar
  [003/500] Entering 'foo/bla'
  ...

This will make the output for each task distinguishable from
other tasks as well offering some sort of progress meter.
(The fewer submodules you have the less fine grained
the progress bar becomes)

Jonathan suggested to add a capability to the git protocol for a
machine readable progress meter in another channel. so we do not
need to parse the current output Counting/Compressing/Transfer/etc

>
> Once you assume that the command is _aware_ that it needs to help
> the foreach-parallel infrastructure so that the user can sift their
> collective outputs to make sense of them, wouldn't a line-buffered
> intermixing also acceptable, and wouldn't it be a much lower impact
> approach to solve the same problem?
