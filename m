Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F766C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 01:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221AF2081E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 01:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6yCPt1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBOB5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:57:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55196 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgBOB5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 20:57:35 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so4580226pjb.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 17:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ut5Kh8bVmeSViS1XtD9M4Auj6axFxmAV8IZMcllLcFU=;
        b=C6yCPt1toLemRF+dpnmTU6odkJRF8iH8l6xQ7kcMcyBAtY1vOtumXn8U1mIQljauJ5
         OxzYdBwrHn4b/SlNXYNR2I1VSEBRKwk3RRW72sRsw0nZpIaUFOtArJo4RxfNZHHgEWWp
         8Zoqdovh5QzfqLgOUspwF8uaz/P6uCL7k3qKgiRIlrAZrZcAQGSyBZeM0NHUkaOdxXOi
         FKvu9F9E2LoJhuLLPN+bQbWufDM1EwCL2+00y1tMFAdOhfaoXot43zEEL474VcE5KEIB
         zw91XzDgMS6Qpz4FD/NrfJHfxEIvyPWvQ+I81a2yVCaVxk+2ttLPFfN82FE7rPoITHKP
         rdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ut5Kh8bVmeSViS1XtD9M4Auj6axFxmAV8IZMcllLcFU=;
        b=lMT/B1VamD/Mn31oNJi7bfAQetZ03DNgrkbphPTtjbvvgi8aq/xmpKcYFiiQ6y5eS+
         47KZcinhPRQGPBhO0ZFtZ9N/y1N3Z06IqW5sge7ceoU1BUVPIYNRlB4QPuCJdDBhvBes
         ISB9oZ61uRmNdGl82xwRRMnl5KJ6AELceZ+hGSfkKHr6Y6fAo0nJ9Nh7Fz9CjxYkMQ74
         0lFMSq4g5BmTWRntp4ovnUYSVVMfzkbldWUuojNCH018cyEQhQIYbCwbJh66Cnw6Qx1I
         u/AZePD8Ftl6ONFHSWwx3iuhMv7pJKryC00OFDo1NHn4OgKZ6sdzIYxTfG9Rr6Ay3APZ
         Oamw==
X-Gm-Message-State: APjAAAX2Ki84vTRNW5qdVeYOhg1rieBE4ZgxjY5GykAGBf+oCplW37eN
        IR+1D8FKM3YJ77RXt6PyAJwJlw==
X-Google-Smtp-Source: APXvYqzNoci+/+drZEhzHQvfpQTrhbIlV3DMKKXD6jgMPNHIe4Eoo6iniipYDd+ryzAT2EE61DTHYg==
X-Received: by 2002:a17:902:b583:: with SMTP id a3mr5944068pls.180.1581731854449;
        Fri, 14 Feb 2020 17:57:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id x28sm8355004pgc.83.2020.02.14.17.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 17:57:33 -0800 (PST)
Date:   Fri, 14 Feb 2020 17:57:29 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200215015729.GN190927@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-4-emilyshaffer@google.com>
 <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 09:25:12AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > +	switch (safe_create_leading_directories(report_path.buf)) {
> 
> This helper is about creating paths in the working tree and Git
> repository,

It's also used by cmd_format_patch() with --output-directory specified,
which is how I found it. My usual workflow is to run format-patch with
-o ~/mailed-patches/topic/ specified so I don't clutter my repo, so I'm
surprised to hear the intent of safe_create_leading_directores() is for
paths in the working tree or repo.

> hence it has a call to adjust_shared_perm() which in
> turn calls get_shared_repo(), i.e. requiring a repository.

Hmmm. I was able to run it pretty happily from a nongit dir:

  emilyshaffer@podkayne:~$ tg bugreport -o other/very/deep/path/
  Created new report at 'other/very/deep/path/git-bugreport-2020-02-14-1721.txt'.
  emilyshaffer@podkayne:~$ cat other/very/deep/path/git-bugreport-2020-02-14-1721.txt
  Thank you for filling out a Git bug report!

> I thought I read somewhere that this tool is meant to be usable
> outside a repository?  If that is not the case, then the use of this
> helper is OK.  If not, we may want to make sure that it will stay to
> be safe to use the helper (I think it happens to be OK right now,
> but if the reason why the user is trying to run the tool is because
> the user broke Git by writing garbage into .git/config, we may
> die("your configuration file is broken") before this helper returns).

Can you explain a little more about what you mean? A broken local
.git/config seems to be preventing git.c from dispatching the
'bugreport' subcommand (lots of other Git commands are broken) at all -
breakpoints in cmd_main() right after the variable declarations are not
being hit.

With junk in the .git/config, I can't run bugreport from within that
repo. With junk in ~/.gitconfig, I can't run bugreport anywhere.

(To make the configs invalid, I leaned on my keyboard and added a line
'garbaghe~*~$%)%)(@' to the bottom of the config file. Most commands
terminate early with "fatal: bad config line 37 in file .git/config".)

Do you mean there's some specific config that could be misconfigured and
prevent that utility from working?

 - Emily
