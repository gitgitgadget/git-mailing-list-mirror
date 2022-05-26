Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40EDC4332F
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiEZSyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiEZSyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:54:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36011C5DBD
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:54:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c65so1843942pfb.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=on+7Zv5Bdr7ji9pczx56UgkobjPGJi367R+0UUAk5vE=;
        b=X14EleU/jhOavKRQQ04wDlYL21aIMkFMmMpAgiEDmrr+UzIVHZMdtug1XsNt9aNcAW
         LHfO4U/2yc2cH9Nlxe3xprUv1IKkm2XvF2jvxg5AwPzoO1sFnVus9462ewcYoV51gd/c
         EPUaDcaJAdhbiYR8rXpNwy5asIWJyuP8MUjrjHLE28vQrPIIDLFit1y6+R5OLwhlxdqg
         Dq7ObuPqHiENrskIgY6wxQFDqpKhOvZdFotkoiscQ4U/bz03070jHN6TMDN0Q+H5BWrl
         TGH8DxrL05nxdV2fEZyjmim52ud199ASK54x5PQHQH5UJudA1LyEYGnqWskJO3A1axCX
         TjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=on+7Zv5Bdr7ji9pczx56UgkobjPGJi367R+0UUAk5vE=;
        b=wFIrEP9DPFIm238K4fRo8vw0VWFtILM5YhPVg5ljx7o+mxltLmoR5ilrRM/IEYZ3Of
         y3xlYBi4ZnLOv37gYlcbUNzzITYm1hXYYskNHJxeJ6f9JOTqSjqVL8Wf+eOwvkxr1h1C
         DSH+zgEET0VJnYFE4Ri1Z0MOPdQ3zA31blR24rfkkLgNGEQSbw8oVSrsnnHn19lzwX9E
         W0RxZxRJ5VSCU1ggJW1cGCufnASIjQyLBTqk7cIWPf71pU39uPnbtdiuJ9iUGUHLn5f9
         i09pJekGkt1excGlWOBjiCtUfjLYhdy6boe0mSNCatEwWRgd7ul+26XLK5zapIzS0FNU
         ldRg==
X-Gm-Message-State: AOAM5321O2V0BWKnjgs8/zu7dcwN7oqv9eUbhP1X6y7ijg4qI4+PuX+/
        1SKZieygNf4Xn0VZeWej32PCLQ==
X-Google-Smtp-Source: ABdhPJyIy/6rNWHHWpVQ+MfVACyaJvhYtrTcSdnzW9P2vaI7sx+ZLbaza1EGKYbTItI3NSgnRNXObA==
X-Received: by 2002:a63:de01:0:b0:3fa:1a35:36e0 with SMTP id f1-20020a63de01000000b003fa1a3536e0mr21186671pgg.92.1653591288417;
        Thu, 26 May 2022 11:54:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:dcef:8d9b:c712:c6ca])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902e8d500b00163506d51e7sm1917171plg.125.2022.05.26.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:54:47 -0700 (PDT)
Date:   Thu, 26 May 2022 11:54:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 8/8] hook API: fix v2.36.0 regression: hooks should be
 connected to a TTY
Message-ID: <Yo/M86Y5jo/Yc7Nj@google.com>
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
 <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
 <Yo+3gmtbaARan23V@google.com>
 <220526.86h75c5f01.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220526.86h75c5f01.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 26, 2022 at 08:23:23PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, May 26 2022, Emily Shaffer wrote:
> 
> > On Wed, May 18, 2022 at 10:05:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> Fix a regression reported[1] in f443246b9f2 (commit: convert
> >> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
> >> using the run_process_parallel() API in the earlier 96e7225b310 (hook:
> >> add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
> >> stdout, and thus lose the connection to the TTY in the case of
> >> e.g. the "pre-commit" hook.
> >> 
> >> As a preceding commit notes GNU parallel's similar --ungroup option
> >> also has it emit output faster. While we're unlikely to have hooks
> >> that emit truly massive amounts of output (or where the performance
> >> thereof matters) it's still informative to measure the overhead. In a
> >> similar "seq" test we're now ~30% faster:
> >> 
> >> 	$ cat .git/hooks/seq-hook; git hyperfine -L rev origin/master,HEAD~0 -s 'make CFLAGS=-O3' './git hook run seq-hook'
> >> 	#!/bin/sh
> >> 
> >> 	seq 100000000
> >> 	Benchmark 1: ./git hook run seq-hook' in 'origin/master
> >> 	  Time (mean ± σ):     787.1 ms ±  13.6 ms    [User: 701.6 ms, System: 534.4 ms]
> >> 	  Range (min … max):   773.2 ms … 806.3 ms    10 runs
> >> 
> >> 	Benchmark 2: ./git hook run seq-hook' in 'HEAD~0
> >> 	  Time (mean ± σ):     603.4 ms ±   1.6 ms    [User: 573.1 ms, System: 30.3 ms]
> >> 	  Range (min … max):   601.0 ms … 606.2 ms    10 runs
> >> 
> >> 	Summary
> >> 	  './git hook run seq-hook' in 'HEAD~0' ran
> >> 	    1.30 ± 0.02 times faster than './git hook run seq-hook' in 'origin/master'
> >> 
> >> In the preceding commit we removed the "stdout_to_stderr=1" assignment
> >> as being redundant. This change brings it back as with ".ungroup=1"
> >> the run_process_parallel() function doesn't provide them for us
> >> implicitly.
> >> 
> >> As an aside omitting the stdout_to_stderr=1 here would have all tests
> >> pass, except those that test "git hook run" itself in
> >> t1800-hook.sh. But our tests passing is the result of another test
> >> blind spot, as was the case with the regression being fixed here. The
> >> "stdout_to_stderr=1" for hooks is long-standing behavior, see
> >> e.g. 1d9e8b56fe3 (Split back out update_hook handling in receive-pack,
> >> 2007-03-10) and other follow-up commits (running "git log" with
> >> "--reverse -p -Gstdout_to_stderr" is a good start).
> >> 
> >> 1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/
> >> 
> >> Reported-by: Anthony Sottile <asottile@umich.edu>
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  hook.c          |  5 +++++
> >>  t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 42 insertions(+)
> >> 
> >> diff --git a/hook.c b/hook.c
> >> index dc498ef5c39..5f31b60384a 100644
> >> --- a/hook.c
> >> +++ b/hook.c
> >> @@ -54,6 +54,7 @@ static int pick_next_hook(struct child_process *cp,
> >>  		return 0;
> >>  
> >>  	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
> >> +	cp->stdout_to_stderr = 1; /* because of .ungroup = 1 */
> >>  	cp->trace2_hook_name = hook_cb->hook_name;
> >>  	cp->dir = hook_cb->options->dir;
> >>  
> >> @@ -126,6 +127,7 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
> >>  		.tr2_label = hook_name,
> >>  
> >>  		.jobs = jobs,
> >> +		.ungroup = jobs == 1,
> >
> > I mentioned it on patch 5, but I actually do not see a reason why we
> > shouldn't do this logic in run_processes_parallel instead of just for
> > the hooks. If someone can mention a reason we want to buffer child
> > processes we're running in series I'm all ears, of course.
> >
> >>  
> >>  		.get_next_task = pick_next_hook,
> >>  		.start_failure = notify_start_failure,
> >> @@ -136,6 +138,9 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
> >>  	if (!options)
> >>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
> >>  
> >> +	if (jobs != 1 || !run_opts.ungroup)
> >> +		BUG("TODO: think about & document order & interleaving of parallel hook output");
> >
> > Doesn't this mean we're actually disallowing parallel hooks entirely? I
> > don't think that's necessary or desired. I guess right now when the
> > config isn't used, there's not really a way to provide parallel hooks,
> > but I also think this will cause unnecessary conflicts for Google who is
> > carrying config hooks downstream. I know that's not such a great reason.
> > But it seems weird to be explicitly using the parallel processing
> > framework, but then say, "oh, but we actually don't want to run in
> > parallel, that's a BUG()".
> 
> I can just drop this paranoia. I figured it was prudent to leave this
> landmine in place so we'd definitely remember to re-visit this aspect of
> it, but I think there's 0% that we'll forget. So I'll make it less
> paranoid.

Thanks. With that change the series looks good to me otherwise, although
if you're rerolling to drop it, maybe consider some of the other little
nits I left elsewhere. ;)

 - Emily
