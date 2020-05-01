Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EDAC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05B52166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 22:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0zdv1Q/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgEAWNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 18:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgEAWNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 18:13:36 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA0C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 15:13:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w65so2142272pfc.12
        for <git@vger.kernel.org>; Fri, 01 May 2020 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=giqiie9QcagB/WH0BWazSlXPTrNynsgnVBOwSOlGRwM=;
        b=0zdv1Q/56WP9NVx40Y+bcE+fyCbTBNOTtRliPES0FA0j3RDc3e/L7WcMBPq/zbdXjM
         o5y/8TcDdFkUfa2H/WYF9ZnoWHF2HcXwhUPMmItl2WhXLWxtoKYoyY6pEkjVUXSoU7Ex
         DQBuaU5BBKGAnVWfqo+Uu+1B/cWKrmjqIWCKcUooSJKUGPfRsYA8ttSnXAzm9Bl/wrct
         dFdlZvxdFrqYozsj5aBIeVLmJIInZ0w5omnhcUViBYVLF6VQCmToJcUMxqw48tTVe5OO
         UqGSyZyt+z8zKqXAkPr/Tg+KSE1vH3SWSAesC0dktEd8EyqfRNJQBjzFEVGVd0K/k6jS
         t8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=giqiie9QcagB/WH0BWazSlXPTrNynsgnVBOwSOlGRwM=;
        b=cth45b2gbosU0Q2O8gYZOCa31Q57bANdgSyBHbbJf10kb3AuRQG0wJwauzFMAVnyg2
         JvKJcGupxbct8Ih3Ucd97ntJJuJFKxADY3+pIl/8QzsbBnyJsU8Ty8dSuwff1Db2DbQm
         IWYdylsYcsp39yHFfRUGWRms6P7aYa6xAAuvFZGic8oLENM3nggtzHGjXX7LM65rPNJH
         CvYqHRtMP/wkyCtqWFVGV7H2duJ3R9pjNTzBYdXukIHpz7kBPd45xf5daGZuDBHUju7K
         QMCZhjTsvd1QKB2+RNL5Qm4+dBB/+bBDNATD1cYCfyTgQDQFALvsvw6YG5st/Y7qpeIV
         4Nqg==
X-Gm-Message-State: AGi0PubNqKSQBe4dLNTp8LO/QMUddYGIku4q9SoXQLUgD5Eo5mv8LN7e
        /CSfqFGSWUZB7DgaJ6yCWHbJDA==
X-Google-Smtp-Source: APiQypIsfmY0c8ZkJJmmOeqA2mLfml+/yt6p9QfFdRY2gCiHdCjhZxKmAL86kXliedYlTB7edb57Jw==
X-Received: by 2002:a62:81c6:: with SMTP id t189mr6038322pfd.174.1588371213935;
        Fri, 01 May 2020 15:13:33 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id fy21sm528160pjb.25.2020.05.01.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:13:33 -0700 (PDT)
Date:   Fri, 1 May 2020 16:13:32 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Seg Fault on git fetch with fetch.negotiationAlgorithm=skipping
Message-ID: <20200501221332.GB41612@syl.local>
References: <450D5CC7-113A-40D8-9CD4-53786198526D@gmail.com>
 <20200430202014.GB2014@syl.local>
 <BFB84B3B-FB39-4217-A6C6-7599F6F755E2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BFB84B3B-FB39-4217-A6C6-7599F6F755E2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 10:13:43AM +0200, Son Luong Ngoc wrote:
> Hi Taylor,
>
> > On Apr 30, 2020, at 22:20, Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Are you able to share a core file? If not, it would be very helpful for
> > you to 'git fast-export --anonymize ...' and see if you can reproduce
> > the problem on an anonymized copy of your repository.
>
> I played a bit with --anonymized yesterday but export/import is slow and I still need to review
> the history to see whether it could be released.
>
> It might take more time than just a few days.

That's OK. Please let us know when you have it by responding in the
sub-thread here, and I will be happy to take a look.

> > I can speculate about the cause of the crash from your strace above, but
> > a core file would be more helpful.
>
> I have added perf trace2 in https://gist.github.com/sluongng/e48327cc911c617ed2ef8578acc2ea34#file-perf-trace2-L52
> (git version is 2.26.2)
>
> I think this trace is a lot cleared than the strace log.
>
> > Thanks,
> > Taylor
>
> Cheers,
> Son Luong.

Thanks,
Taylor
