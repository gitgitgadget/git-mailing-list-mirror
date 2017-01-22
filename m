Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D8E20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdAVT0B (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:26:01 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36292 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdAVTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:25:59 -0500
Received: by mail-qt0-f176.google.com with SMTP id k15so90455750qtg.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QoBbCarnvZ3tEyRplUmgCaN68SQAnnrwZX6wS+FQLC0=;
        b=YzhLacDXoYC7Cocn9jgjZ69biHqtdUBLc0DcQDK8kVU1G8bLGj8mkgYPyw9QAj82j2
         WXtfQWzavAJbZXmhwCODoFfRNLPUG9cAyMms2F+YFu49P6SQbdtKhmsvwiI+SNF9Vy/M
         FF6JnPqyNkQPm1WY5UJrm7MJpVMHCUwHKL5Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QoBbCarnvZ3tEyRplUmgCaN68SQAnnrwZX6wS+FQLC0=;
        b=IAtG7Ar/FYprt36tV+PWcpb8vFacr5yp7qoYsKOj7Ru8Ihj+Vc9rc5u+MlLAbX/kUQ
         AScTmEFymDWQLp6l1ioRpkFmtZ7hPzBPyVXIrSTK5VkWLbIiOMGp7BfR7k72stYEpBjk
         UNj7SoxQ/eCqET5jklb/fmk/wRiOVLy1ZoJl0B474oPdEr4VwvEPErZm8fSJM2+u5n5I
         v7tnxdCYu9pdqtOmV+Z2UIFb8s8/S+Fdnuva5VZjou+Y+9ys+7Bjk0eslY30CM2Xcn1s
         J9K6ZF5Jf1MIvVCw8RW3NYr/0DvLvVfIa3rVFbbu/fxF6VecZ0RguarggJNz/Td0SiuS
         yzSQ==
X-Gm-Message-State: AIkVDXLqT/LVIBNdhDWiogVNEO4VFhT3jvd52R/9ozvvKG3yPUHdLgJDbUEQLIw7SOf1Xzt3VEpWFfBs1X7lOE0G
X-Received: by 10.55.128.71 with SMTP id b68mr22281677qkd.197.1485113158988;
 Sun, 22 Jan 2017 11:25:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.103 with HTTP; Sun, 22 Jan 2017 11:25:58 -0800 (PST)
X-Originating-IP: [45.37.53.252]
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Sun, 22 Jan 2017 14:25:58 -0500
Message-ID: <CAHnyXxRx_iagZhki1rmVEpw+GZPWBRx7mNmahs3pruy57L3h-Q@mail.gmail.com>
Subject: Re: [RFC] Case insensitive Git attributes
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies for the delayed bump. I think because we're talking about
affecting the behavior of .gitattributes that it would be better to
have a distinct .gitattributes option, whether or not you also have a
similar config option.

Since .gitattributes is versioned and config options are not, I think
this takes it out of the realm of personal preference. It's already
too easy for somebody to screw up and not have a "required" filter
driver (e.g. git lfs) configured and damage a repo by getting
unnoticed and unfiltered content committed.

I would love a .gitconfig option I could set that would let me stop
manually ignoring case in globs for git commands, but this might
actually make things worse for people if it were included as a config
option only -- suddenly attributes could be applied to different files
for different people.

Of course, if git supported a subset of config options you could
actually version and ensure everybody else has, this wouldn't be a
problem ;)

So, I think the correct (for today) solution is to have two options.
One for .gitattributes globs and one for everything else. I realize
that this might be somewhat controversial, so I wanted to see what
everybody thought.
