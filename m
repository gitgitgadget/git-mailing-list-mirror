Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CFBC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 01:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiDZB4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 21:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiDZB4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 21:56:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437236B0B5
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 18:52:54 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b189so12204257qkf.11
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gIIsZjTrRwucIDG50fQGskyRBww5KLqlJx9nOwWDMVU=;
        b=bXLzllSnb2SbhMKw20HFCp1MWWzRmtffYACEMS3CBnUxz913KRXYY93199+a68ELfN
         XZ045ulRvlvViDN7qLhMAFCtlsXPBr/kDHlW1o7tmMp5j+REDiqLcyXCjgIqMhGIjJvc
         CW8QC/3cQlgfPcjFcVpvfQki/RAOAQ7k1WflU6g4lbGyJUcA5eq/qfrbhbBMV4C0vLn8
         jxnyQUdiE40po6nfzgQ5WiGE6lU/s3+a4dv3fwLOqsfBp4AXSVMHHVqbdYSdiur9io3t
         38jiubxs5IKzQa6d7nMxURYQlXorHIhzJvxXpGhrqgbfmi2x8Nc+G/HPa8fxaTnCa1+g
         aabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gIIsZjTrRwucIDG50fQGskyRBww5KLqlJx9nOwWDMVU=;
        b=NkSzfIHhbpbnYEFS4nJYfAL+lpsj8R15RHN83CaWvfq47jRJK4OkKynXQkXJq/dpGj
         7MQUqh/bVLCo3AfrkJ8h2pVwjQOUFRLUasbliUkZ4lwPWQFWSJ0OodM8JV8OUbH+tKho
         nyyh0dyrs/2efQtp1oNI7pzvOVh5NO470zBB39YiBR4xZcspGR3OVCAUo30CLFPDqQ65
         tq2PWbsy4rLZsb8qJw8psRgPgRBW5Ro+IZz0VeLFJhvWaAuzNZDhbW4TlzW+f9a+Ulj3
         wGSuASNrdCAm00TYf9eJUBPKS/h8eZfquG1lYew0LFK8ALt4B0xThVg8+c1mmBxSZELN
         tMjw==
X-Gm-Message-State: AOAM530g7sN4E0RWwoCpMmUyYbvLMj9bDVFl5j5Fw7zT0JvW3vPaQ8Pq
        xDRR+T5ZwryiJjK+WkrZfQTXeaMvfT0+YgtD
X-Google-Smtp-Source: ABdhPJzin/6n0y1LemDoB7ArNjAEMhnPsS1NsIO8h/GCqcOAnB1ik1fEODsNPKOk6fjCWG8g+pU/Mw==
X-Received: by 2002:a37:9d5:0:b0:69e:13e1:d28e with SMTP id 204-20020a3709d5000000b0069e13e1d28emr11809909qkj.168.1650937973390;
        Mon, 25 Apr 2022 18:52:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18-20020a05622a1a9200b002f36470c4f1sm3949890qtc.56.2022.04.25.18.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 18:52:52 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:52:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <YmdQcrl/uu7HFBlc@nand.local>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczh73hns.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 09:09:59AM -0700, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
> >> guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
> > ...
> > There has also been added an escape hatch of allowing "*" for the
> > permitted safe directories. but do check the updated manuals, and the
> > git mailing list archive (update the search in the above link).
>
> In this particular case, I do not think '*' is needed, but you need
> to be careful here.  Whose configuration are you suggesting to add
> such an entry?  Yourself?  ~root/.gitconfig?
>
> I wonder if we should loosen "the same owner" check somewhat to
> cover this situation better.  I expect people also run the
> installation in repositories they own with "sudo make install",
> and complaining "euid does not own that repository" when it is
> merely because they are running as root (and their real identity
> is still in ruid) feels a bit too strict to be useful.

I was thinking about this today and realized that my original train of
thought along the lines of "ignore the new safety check when the current
user has higher permissions than the user who owns the repository we're
working in" was misguided.

What about loosening the check in a different way? Instead of causing
Git to abort early, what if we:

  - skipped reading the repository's configuration and hooks (unless
    safe.directory includes $CWD)
  - emit a warning (which goes away when safe.directory contains $CWD)
  - otherwise continue executing as normal

That would unbreak the case of $(git describe ...) in our Makefile in
this instance, without opening ourselves up to execution-via-config.

Though I think we'd have to be slightly more careful than that, since
we definitely _do_ want to read repository format extensions.

I'm hesitant to recommend reading some parts of the configuration
without others, though this is slightly different than that. Instead of
saying "read every entry of config except core.editor, core.pager,
core.alternateRefsCommand, core.fsmonitor" and so on, this says "when
operating in a repository not owned by the current user (or the
repository is in our global safe.directory list) only read repository
format extensions, but ignore everything else in config and hooks".

> Dscho, what do you think?

I'd be curious to hear what Johannes thinks of your original mail as
well as my own.

Thanks,
Taylor
