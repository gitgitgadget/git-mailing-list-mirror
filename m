Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEADC282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 15:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728CC2067D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 15:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoaERp36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgAIPDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:03:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39683 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbgAIPDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 10:03:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so3195822wmj.4
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FAsx1IHYMk7UKzzJnZJHZLcqy7DfHDSwtNsb7E+7/s=;
        b=VoaERp36oVcz5ZU6NuP4rxeeRtcspTgG3BTdeevbnDBXFpFRIV6u3EEKKqGiBKI3C4
         a9ThEb07u3rCn7ZFjXXVG+vB4wnOwYs5FqDU10F0xfBnt+BW3oSr7LxcgNhMb+9ZCD+4
         zjhXKVJSSUI3ZiyAtpUtv1tEF89ejK8iayeMRISK+UUNd5swfCKDA+8POcEKEOToNLV9
         /D++JyeacpzhHaYu8adIOo9im+rgOESjoNLczOZ56moepO0+2GwOoGwegVQi4Kgdd36M
         nJNBp/0TFVIduqGcMQTGw1eI2D0CJcR0RRx6i09aPTr4hLJsQ4ORPasuEscJH0uy2y65
         TkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FAsx1IHYMk7UKzzJnZJHZLcqy7DfHDSwtNsb7E+7/s=;
        b=hNOEhRQOxNzZb4ZIJyCk6Sx6FVb8mvqFg71UydS4XnTraqcngTWBS1/N6MQHFN0kBZ
         yAs3+sJDeYYdvZw1BbiK4wx/s6eCyiPBqnWwMsVs5ULl8dcGGTpsJ1fp0OEkaQ6va9Sv
         wEdEYsnD2Zz72aT+EJvqJdhhrsZ/zP9qry7KzE8h7gykJL/1V+WVwMDtKn9ZpXEVTrWu
         TyklfRybYd89YurYC1Lfzhnm8lR06vdtZQa2HMWt8k5a6U2JoEMYNUlczSWYiUaH6x/7
         EtTnxVWSECuPHDcAznl+e2ug9WRBdfPRKl0KbUOh8sROPmBemjMdGSGcaMqFbzKlVB/h
         Bcaw==
X-Gm-Message-State: APjAAAVoU3LprUoEf2g+gy0JEjgnygQUe5Iat5h4d1+X2xvLMe9PRvQS
        Z+A8LTutSTdgzHVcyO+Pguty5sd/
X-Google-Smtp-Source: APXvYqxTxTl4RkPjnEJ3jfdHS61rdieZt9Fx6mqMGHWd5eyU4+8SGnjmqTrD8YDOxJ7bGQO3COeqbA==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr5370716wmg.170.1578582216692;
        Thu, 09 Jan 2020 07:03:36 -0800 (PST)
Received: from szeder.dev (x4db434fd.dyn.telefonica.de. [77.180.52.253])
        by smtp.gmail.com with ESMTPSA id l15sm7917437wrv.39.2020.01.09.07.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jan 2020 07:03:35 -0800 (PST)
Date:   Thu, 9 Jan 2020 16:03:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
Message-ID: <20200109150332.GF32750@szeder.dev>
References: <20200108214349.GA17624@lxhi-065.adit-jv.com>
 <20200108223557.GE32750@szeder.dev>
 <CABPp-BHsy75UGm4wTOP2_AYik_dZi-_BxtAn-hyi-ZrNRRWGuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHsy75UGm4wTOP2_AYik_dZi-_BxtAn-hyi-ZrNRRWGuw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 08, 2020 at 04:55:46PM -0800, Elijah Newren wrote:
> > Alas, there is unexpected bad news: with that commit the runtime of
> > your 'git rebase --onto' command goes from <1sec to over 50secs.
> > Cc-ing Elijah, author of that patch...
> 
> I see slowdown, but not nearly as big as you report:

The linux repo is big, my notebook is small, the poor thing :)

> $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
> warning: inexact rename detection was skipped due to too many files.
> warning: you may want to set your merge.renamelimit variable to at
> least 7216 and retry the command.
> Successfully rebased and updated detached HEAD.
> 
> real 0m13.305s
> user 0m9.644s
> sys 0m3.620s

> Interestingly, turning off rename detection only speeds it up a little bit:
> $ time git rebase -m -Xno-renames --onto v4.18 463fa44eec2fef50~
> 463fa44eec2fef50
> Successfully rebased and updated detached HEAD.
> 
> real 0m11.955s
> user 0m8.732s
> sys 0m3.424s
> 
> 
> This is an interesting testcase; I'm going to try to find some time to
> dig in further.

The culprits are two seemingly unnecessary back-and-forth checkouts.

I didn't realize I could use 'git rebase -m', so ran some tests with
it, and turns out that the slowdown started with 68aa495b59 (rebase:
implement --merge via the interactive machinery, 2018-12-11), where
the runtime suddenly went from <1.5s to 45+s.

Running 'git rebase -i --onto <those-same-commits>' is just as slow,
and it appears that it has always been (the oldest I tried was
v1.8.0), and it spends a long time both before and after popping up
the editor for the rebase instructions.  That's highly suspicious, so:

  $ git log --oneline -1
  94710cac0ef4 (HEAD, tag: v4.18) Linux 4.18
  $ git rebase -i --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
  hint: Waiting for your editor to close the file... 
  # Hit ctrl-z in the editor
  $ git log --oneline -1
  463fa44eec2f (HEAD) Input: atmel_mxt_ts - disable IRQ across suspend

Oh.

So 'git rebase -i' apparently checks out the tip commit of the
to-be-rebased revision range before invoking the editor for the rebase
instructions, only to check out the --onto commit (i.e. the commit
we've started from!) to apply the selected commit on top.

And indeed those two checkouts account for all the wasted runtime:

  $ time { git checkout 463fa44eec2fef50 && git checkout v4.18 ; }
  Updating files: 100% (49483/49483), done.
  Previous HEAD position was 94710cac0ef4 Linux 4.18
  HEAD is now at 463fa44eec2f Input: atmel_mxt_ts - disable IRQ across suspend
  Updating files: 100% (49483/49483), done.
  Previous HEAD position was 463fa44eec2f Input: atmel_mxt_ts - disable IRQ across suspend
  HEAD is now at 94710cac0ef4 Linux 4.18
  
  real    0m48.801s
  user    0m13.963s
  sys     0m5.114s

