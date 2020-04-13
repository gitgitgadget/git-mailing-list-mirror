Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA7C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5025F20735
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cJNppIul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbgDMRXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732579AbgDMRXV (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 13:23:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3434BC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 10:23:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r4so4732574pgg.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y1EW52Zw0IZw/l1caOMbhQSTQVcM3gSZtJJJPzZvGqI=;
        b=cJNppIulhNaRJM86SIIdc7WcPuOd8BmQy1nmovTl5edzVeeXM+INjFL9mMDZ4kLnCX
         GYhQGxV13XK5cWJ+lDrPW8n6IdMZjJUlbSHigydfdT7b+6TRgU7+MawLGmyCPQ6s7xd+
         62tT7OYD4tOg0P/vUZ0wF0gHEBKXlePMxzDElwb5nUNlLBNSjRkO4yFL2PXR/VgEhRun
         lgwLb9mYl53bmEP5KvJ1yUZJv/9BGfya3p3v9gcb6TAByI40ZlOlIPiDP0TBAlh9vC4V
         K6IKKWJb8G0FAAPC3Z+JMf/ZqxHkGUJgEvr3FfsgfCKJoDJ2UxcmZU3LFUcqib7XbugW
         SgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y1EW52Zw0IZw/l1caOMbhQSTQVcM3gSZtJJJPzZvGqI=;
        b=TSh6ZW8xWw7SMLlwgLaMu5fVdJmbzt8LVkGhGckpunLF6+SQct/TuHk+loeAezfFCA
         oNOOCpS2C/3e4il7EEHOdWwNkgaJzhrPw+eVmD0MXhJpOB+K8hXqTX75qxsoAHRaKsaE
         Solh/ZAMXUOvmRRE3FuJSP3ldf/lnXwYxAM/6tMjQ2alKcnFUlGH1TsALpQkQMo8MgYx
         hMC7fwJU6eBpOevy18QqNjxGgZ3DaJSbha0y68RptkGc774kiAuLUXkwK4C0B0suLdCU
         Wo7rOiNwc2chmQWT8VTMBqiiywZh6mSVInCIxclpofEYrv87Gyz7jILcQ10PSJEepOpZ
         W7Nw==
X-Gm-Message-State: AGi0PuZIN6zUDr1nTd0+OGp39tRj17bOgskQI6gH7AfUuzTPT7eqNtY3
        NF+pJbwZftAinP1YN1Movhgl8Q==
X-Google-Smtp-Source: APiQypLGZY+XssuPXc/IJ5hfd/Nr6mEo97IA92ndHKmW6XFXmlqWd8Y9nNgG9lojU+hlLkIpM2MLHg==
X-Received: by 2002:a65:6250:: with SMTP id q16mr18743399pgv.9.1586798598489;
        Mon, 13 Apr 2020 10:23:18 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q131sm4197096pfq.115.2020.04.13.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:23:18 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:23:16 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff.Hostetler@microsoft.com
Subject: Re: Git pull stuck when Trace2 target set to Unix Stream Socket
Message-ID: <20200413172316.GA63249@syl.local>
References: <CAL3xRKceuniEOq+PqN15FC4-mxsWJd4+e2fu1Ku9q_+8JmR9pw@mail.gmail.com>
 <20200413160051.GB59601@syl.local>
 <D350F464-61DE-4EB6-BBE1-514A0C051F38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D350F464-61DE-4EB6-BBE1-514A0C051F38@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 07:19:03PM +0200, Son Luong Ngoc wrote:
> Hi Taylor,
>
> Thanks for the swift reply.
>
> > On Apr 13, 2020, at 18:00, Taylor Blau <me@ttaylorr.com> wrote:
> > I doubt that this is important (for a reason that I'll point out below),
> > but it looks like your invocation here is malformed with the trailing
> > pipe character.
> >
> > Did you mean to redirect the output of rm away? If so, '2>&1 >/dev/null'
> > will do what you want.
> It was an emailing mistake. I meant to write
> > rm /tmp/git_trace.sock || true

For what it's worth, 'rm -f' would suffice, too, but it doesn't matter.

> So that the command is reproducible on repeated run.
> I must have deleted the remaining part by mistake.
>
> > Odd. From my memory, trace2 will give up trying to connect to the socket
> > (disabling itself and optionally printing a warning) if 'socket(2)' or
> > 'connect(2)' set the error bit. My guess above is that you don't have a
> > listening socket (because your shell is waiting for you to close the
> > '|'), so there's no connection to be made.
> There is definitely connection still, as I can still receive more events after interupting the stuck git command by Ctrl-C.
>
> > Odd. What version of Git are you using? Your description makes it
> > sound like it may be a bug, so I'd be curious to hear Jeff's
> > interpretation of things, too.
> 2.26.0 built from Master git/git
>
> For more info, I have created a paste to demonstrate the bug
> https://gist.github.com/sluongng/e14563e4ce3cc9545781ecd5a95169f6
> In which, I run `git pull origin` and `git version` on a relatively stale https://gitlab.com/gitlab-org/gitlab.git local copy.
>
> You can get more information from the trace in that paste.
> I have annotated the moment which the stuck happened with `It stucks HERE` phrase so look for it.

Hmm. It sounds like maybe there is a bug. If Jeff doesn't have time to
take a look, I'll try to figure out what's going on here.

> Cheers,
> Son Luong.

Thanks,
Taylor
