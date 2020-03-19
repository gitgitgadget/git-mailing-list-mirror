Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862A2C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4740C20772
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 21:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAgA7m6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCSVjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:39:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40445 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCSVjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 17:39:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id l184so2117049pfl.7
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7PH5ORg1GuWVBAKz3Gl9sQfi5/+Hp6KhdVuYu1rHRw=;
        b=OAgA7m6wkT0tLrcx4oPy0DklwMwRbiYZ5WjjEj96klkmt3ZLGm0JPXjab4uW/6J66R
         43UmgJGYiaKGB2B3GAQA6v4/PYaGhTHWUU33hAcDknI6cXsCUk6CsTEY3luQSgluufCM
         Lx5XYDolinC/Cs4tCgdgv2EirR/v6eh5WVl1c1kGalSU2WtgpFU7HFQ5gsJ1mSMkF1AX
         WNZ6zjj4dgBU+UzIjTzoVheOQ0CS4r2YIREvnW6jxfwUGytblGzaIjMhqSwGtvpK8+ZY
         8LX0c91o+RWolv1wySgQfBnVmx+xV9ZA3/+Qx7FVMqlCx6wZQ78pZWlaSQaRShncZrvd
         zUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7PH5ORg1GuWVBAKz3Gl9sQfi5/+Hp6KhdVuYu1rHRw=;
        b=Hrva/EzGWn0zbsu0AtIEa5/vg1s6NJcqE0FxikAXj4/CXCrgT2WB86Pr8TL+YCjt2X
         /KnMIzsa4MpQWqrdqBptNoXUOT7zTy+Vbbc1R5jb0b3DN0zpE4TKbaPq9WtyusXRPSjN
         xhU0TDPQn9Yb+jMcRLwPEZKvKXRHR+V5AYkMHfrGXMV7bGxsc1ahf/0bVuxVDJ5hSFNt
         Q3rgTmigxZuQaQmIQFr1RNRz8ExS32HfR9G6Oh+A3lBdeFEtgjkJ7Ap7V3hpfa4j1Nhe
         VzKXgpX5flgqmsvwIJE7hAG5MzvCpdswqTavuSdPegueohNVBzAiGku4GKibyi0ZnhyZ
         7dCQ==
X-Gm-Message-State: ANhLgQ30nq4t2AmqxigeeIqOAwD+rH4bA8g8PorkONVgV7ntE0zINUgo
        73ppIYQBCtbrKDZ0NlpawpXl+s5AnkUrmQ==
X-Google-Smtp-Source: ADFU+vvIkJ6NfTLIRV7j06je42yKASoYSrOBTeKT6b+YGkxrR+oc9j2g6pPAgnx2BfrgjtzOXQbO7g==
X-Received: by 2002:a63:195a:: with SMTP id 26mr5008714pgz.400.1584653948637;
        Thu, 19 Mar 2020 14:39:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c9sm2752114pjr.47.2020.03.19.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 14:39:07 -0700 (PDT)
Date:   Thu, 19 Mar 2020 14:39:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
Message-ID: <20200319213902.GB45325@google.com>
References: <20200302230400.107428-1-emilyshaffer@google.com>
 <20200302230400.107428-3-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 04, 2020 at 10:35:04PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 2 Mar 2020, Emily Shaffer wrote:
> 
> >  .gitignore                      |   1 +
> >  Documentation/git-bugreport.txt |  46 ++++++++++++++
> >  Makefile                        |   5 ++
> >  bugreport.c                     | 105 ++++++++++++++++++++++++++++++++
> >  command-list.txt                |   1 +
> >  strbuf.c                        |   4 ++
> >  strbuf.h                        |   1 +
> >  t/t0091-bugreport.sh            |  61 +++++++++++++++++++
> >  8 files changed, 224 insertions(+)
> >  create mode 100644 Documentation/git-bugreport.txt
> >  create mode 100644 bugreport.c
> >  create mode 100755 t/t0091-bugreport.sh
> 
> Hmm. I am still _quite_ convinced that this would be much better as a
> built-in. Remember, non-built-ins come with a footprint, and I do not
> necessarily think that you will want to spend 3MB on a `git-bugreport`
> executable when you could have it for a couple dozen kilobytes inside
> `git` instead.

This is the kind of stuff I really wanted to get straightened out by
sending the smaller changeset, so I'm glad to be having this
conversation (again, and hopefully for the last time). I read the
replies to this mail, which I'm truncating as I think many of them are
distracting rather than discussion-worthy, and have tried to summarize:

Builtin:
+ Don't have to call out-of-process to identify 'git version --build-options'
+ Better assurance that we aren't shipping a broken bugreport alongside a new
  version
- Binary bloat, possible startup time hit
? Libraries will behave identically to where the user is seeing issues
  (This point is a possible pro but also a possible con; see similar point in
  standalone list)

Standalone:
+ Could investigate libraries who aren't behaving the way they should.
  (This seems like it'd be better addressed by regression tests, and if we're so
  sure that git-bugreport is working with the info at hand correctly, why don't
  we just write the git binary that way too?)
+ Avoid binary bloat in the main executable.
- Have to ship a big standalone binary instead.
- To get accurate version/build info, need to query the Git executable in a new
  process

Of course if I missed capturing something, please add/correct. Some of
these concerns are quantifiable - binary size and overhead, for example
- so I'm planning on doing some experiments in the coming days. I plan
put together the handful of patches in the latest version of the topic
in both standalone and builtin mode, and then gather the following info:

 - Binary size of 'git'
 - Binary size of 'git-bugreport' when applicable
 - Time for "make" following clean
 - Time for 'git status' on an identical real-world repo (I'll use ours,
   without touching the repo state e.g. changing branch or fetching in
   between)
 - Time to editor for 'git bugreport' with the same setup as previous
 - Peak memory footprint during 'git status'

And of course, if there's more to compare that I can quantify, please
let me know that too. I expect I'll be ready to run the experiments by
Monday (taking some time off tomorrow) so there's time for me to hear
about other concerns.

I'll hold off on sharing my own preference until after we've got some
benchmarking to look at, so I can understand the whole picture.

 - Emily
