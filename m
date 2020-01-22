Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FCCC32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 23:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7A0205C9
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 23:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfTzb432"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAVXxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:53:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 18:53:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so1049063wrl.13
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 15:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1+bHlPJAIgPIrZ/Pm/xVQbNUA3MfX3dBt/4rn3C8dM8=;
        b=kfTzb432zt7i16Q7blItvpOkXJUjELluN4yTV3K3M5TZUiX58lSAG1qJxuFiFgirtS
         pz53el3V+Rqmnp/Rl3g3kjVxhTpXcZL82qZNysOnjF4OHJaIXwAy0rBhvIj16vnOW1Yd
         L8JqMgNAdS7dX9YYNTeOQ0xFH7ukQtAoJnIlTGaoKzWaA4se2N1DS4PpDyY6Pz5Xf2oC
         wwIXcujZPmi3lm1HmfOD3yY7hyqea1fvdef18NZFf5YB6P5fidbMFixOdb3SrjjNICnN
         TE52BjFmAEU+esSMP1trERGyueTzPTzuZ+besotOEx4ik3s9bjEmS5ixtM/1DIlqgb2l
         d6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+bHlPJAIgPIrZ/Pm/xVQbNUA3MfX3dBt/4rn3C8dM8=;
        b=BkKNdDqY0KTE1UvglPk9no8yMiw3oFc6nsCRVJHgi+EUa0YMu8cj4K98Y0CbqbaUmC
         O/N6nbYRVgD0YHz+jNkz377OPv5Xa+dYUlNlSpyTWf6nShOccenLYOtS+ypIYDCHP2Ax
         X7rnchQ7vMlF1vvkiqYrmrJNJtdd4SxHfxf+df4WyZCFIneBVM1TfZGI/u5Ts4bObaOu
         PhMgnQbHOLGl6IuVbsjQDjPwDmFHyrFKmXwNuHRmjdCkmk0LODQ8+ptfcCvPVOkkJ3ud
         biuK1RtXAq4D6Kx1jzOAJN7T/BZonzqswzEg1K178CM88mD49SpiabonRJMCpA9APhbc
         nj4Q==
X-Gm-Message-State: APjAAAUjtgYhtFyyJeY4ELMz4KOJ9QTAQYid5RjE8BSoiUr+9TUh6h3T
        7SNbqSednCp9cKkAqWn+jqQ=
X-Google-Smtp-Source: APXvYqwlrTW/mmllRz47Q1C6N89sZhBPtPz9iPGgt4hWUc06FPlm4Ay6pppcbTMnjaQZmola7nN5dQ==
X-Received: by 2002:a5d:5487:: with SMTP id h7mr13807407wrv.18.1579737219686;
        Wed, 22 Jan 2020 15:53:39 -0800 (PST)
Received: from szeder.dev (x4d0c4530.dyn.telefonica.de. [77.12.69.48])
        by smtp.gmail.com with ESMTPSA id l15sm541791wrv.39.2020.01.22.15.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 15:53:38 -0800 (PST)
Date:   Thu, 23 Jan 2020 00:53:33 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200122235333.GA6837@szeder.dev>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 22, 2020 at 02:18:05PM -0800, Junio C Hamano wrote:
> * yz/p4-py3 (2020-01-15) 14 commits
>  - ci: also run linux-gcc pipeline with python3.5 environment

I still think that this last patch needs to be reworked before this
series is merged any further.

The only Python script we have is 'git p4', so the Python version is
only relevant for 'git p4' tests ('t98*'), while the rest of Git and
the test suite couldn't care less [1].  This patch, however, not only
builds Git and runs the full test suite for each of the two Python
versions, but, worse, runs the full test suite _twice_ for each, first
as a "regular" test run and then again with all the GIT_TEST_* knobs
enabled.  Consequently, it adds ~50mins to every build's runtime.

That's just too wasteful.


[1] Well, there is 'contrib/svn-fe/svnrdump_sim.py' as well, but
    that's contrib, though it is used in 't9020-remote-svn.sh'.

>  - git-p4: use python3's input() everywhere
>  - git-p4: simplify regex pattern generation for parsing diff-tree
>  - git-p4: use dict.items() iteration for python3 compatibility
>  - git-p4: use functools.reduce instead of reduce
>  - git-p4: fix freezing while waiting for fast-import progress
>  - git-p4: use marshal format version 2 when sending to p4
>  - git-p4: open .gitp4-usercache.txt in text mode
>  - git-p4: convert path to unicode before processing them
>  - git-p4: encode/decode communication with git for python3
>  - git-p4: encode/decode communication with p4 for python3
>  - git-p4: remove string type aliasing
>  - git-p4: change the expansion test from basestring to list
>  - git-p4: make python2.7 the oldest supported version
> 
>  Update "git p4" to work with Python 3.
> 
>  Will merge to 'next'.

