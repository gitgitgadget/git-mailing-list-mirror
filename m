Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79612C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4196C2074B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 20:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbmS1kCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGUeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:34:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41316 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGUeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 16:34:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id m13so2266802pgd.8
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4qRPQAWoQBwTFaKXHIS1ZoU4A8SXSbMwChf5++06k8=;
        b=PbmS1kCQMBAT+waEPPZP2ohiRxrBB0U+nauaP4zDFqCt4vgQAw1Bh3YVZRCUbza39+
         2kpVwtcLkpCNUIlQBKrXOonz+gNXJ3GjkLOCmJqYtB6SH0NSkugftskwLkSCgxkiSZ7f
         R6+JIbrCkN2mlvbGhTTQi1xNk85sKPtv+u6y41kyd3bkGCCAPrRyL+ap9S1dTxkU6dnN
         S8HU3LZqnvN+rI2Xh+did0TZx3g0nzWJQ3U4HlkZ+ajy5HulSq5Id+BUlrM0BAoERVF9
         +BR2XqS582/vj03K1t63iotWl4RUNMB6O/1you8yaOBGpuuMq4ac+xZxHNc3kZvMNPM8
         QIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4qRPQAWoQBwTFaKXHIS1ZoU4A8SXSbMwChf5++06k8=;
        b=MB8nOSYIwJx/QE028+rJv0yurbF/R9wDJy3PzOYxqEUjj+BqP9Vl99BpTAuzYK7MIj
         WtVIDA8MPHJ6fd2f0x5oV1vdOE7UyH0GaUWsvzOavWfXWFRApgIAge1wFrwnHjTveQD6
         uQcasYxjDeUgYHqiU1DM0IqPqIicCBXi28bCD9tS6mrKqBg+gcQRa7Lu/RZyAd/c/UW5
         QOcIqaTHVbx6JMYJDPGrfm18CAhVx8FxSvT4+CUcoshf/rkSjRdUTlb1hWyV/KSsqR2s
         tBm5xltqaco679ueauExvDkNHc5oXKC83+mapBAHjN5rScJglMCy/ghV4HtOMi/1bHt+
         0lfQ==
X-Gm-Message-State: AGi0PuYm78xT9J/w6pwf5lDsodSEXfalPFwot63y4ne6pS6AyMLy/fG+
        j2PImZRrKGQOxu/QAPzxCPd+vJuYu4g=
X-Google-Smtp-Source: APiQypJaggnrIRi6oUqHf3YgvL1pSxwPZpHlCA5zj/Iz9Ejmoz2FeDcPTTHZN9kHWQZGEL0tzrix0w==
X-Received: by 2002:a63:ea4e:: with SMTP id l14mr3726881pgk.431.1586291663513;
        Tue, 07 Apr 2020 13:34:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g4sm14852811pfb.169.2020.04.07.13.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 13:34:22 -0700 (PDT)
Date:   Tue, 7 Apr 2020 13:34:18 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v12 3/5] bugreport: gather git version and build info
Message-ID: <20200407203418.GC137962@google.com>
References: <20200406224526.256074-1-emilyshaffer@google.com>
 <20200406224526.256074-4-emilyshaffer@google.com>
 <xmqqeet0urts.fsf@gitster.c.googlers.com>
 <20200407184240.GB137962@google.com>
 <xmqq4ktvt635.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ktvt635.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 01:05:02PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > To be clear, do you want me to include the output of get_compiler_info()
> > in "git version --build-options" when I do that change, too?
> 
> In the endgame, there are two kinds of information we'd want to
> gather and report, I would think.
> 
> Ones that can be different per-binary are things like:
> 
>  - what version of the source code the binary was compiled from
>  - with what compiler options
>  - using which compiler and
>  - linking with what libraries,
>  - where in the filesystem is the binary located
> 
> The others are various properties of the system the user is using,
> and having trouble using, Git on:
> 
>  - how many CPUs do we have,
>  - how much free memory,
>  - is the repository's filesystem case sensitive,
>  - what version of 'wish' is being used.
> 
> We'd want the former to be reported for each binary that matters, so
> "git version --build-options" would want to say it, "git remote-curl
> --build-options" would want to say it, and being different binaries,
> they may say different things.
> 
> There is not much point in duplicating the latter that are not
> binary specific, so it probably makes sense to gather them inside,
> and report them from, "git bugreport" itself.

Sure. Sounds great. Thanks for laying it out, this is very clear.

 - Emily
