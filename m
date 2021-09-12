Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC5DC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0313561056
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhILN3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhILN3P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:29:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18346C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:28:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 9so9976511edx.11
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B120+1HJh4Q7dWuE+xnU0Vy6APrgmMVDX+swgbjxNj0=;
        b=m8PXe1/fARMkYLsU7Wef4J6WdUPVxFNhQ7KjSQHF7LYmnxrCN77w1llV+DCowF+wGC
         WPeYPLkN6p6wQWZmBSSsgjyhF3UcuNTkz3bY6w5kn7Va9+8KDk6gsj/u6nDvVxZrs3re
         aiUGAobwOheDcM/CQKr9FGLTV17yINAjHBgFgQKkrHO3a7L3NZrjO64GLlX+tyR7fQrV
         1v2a/+hR6xpXmf2LzwWJb7ZUSJLgM4JviIPRPAaEWoX6F9i+nVPTCosJZci0qcwEZ7kZ
         BMQYjCNH/qhIu9rUg5Srp1epQ8YvVmuADWDbHlD0Fvihm3qRDz1uaHkVRZFmwzx4jAvM
         JRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B120+1HJh4Q7dWuE+xnU0Vy6APrgmMVDX+swgbjxNj0=;
        b=AWA8aQ+sa1P25+zJT9Vh2pCCqv/eRy1QCPsbPYGEm87iz1XoflTaevLeG2qeSSCQmu
         wnMQabDjhu78j+2vpnP9xiy2yTAMITejoWhRFBUb6aKMySaWt3w8R5qbBxXh+xUb+ZXi
         fy/zQvsjOw0RrfiPLFaP+WGc9DZ0TeLNB3MLQmhAjwwJpC1UICSW/A/lS33MT4+ZM6qT
         IaQNK/UVSe1DyRlN0xkNiE6XGw7Hh10sidHt6BSBesAQBGsHXkP7f3MD+1el39kCRQkU
         97LQE8/Cv6hKKrVAg0JPf0zYE12+kTxW3YBfdcFkFOIgxF3TokKQEfuRLsKlK84ew8JX
         ChSw==
X-Gm-Message-State: AOAM5317za28aGo+L+8wQwg1mlQ4/7T/d9lrexsU8Qfa5MoCNydNYNoA
        mUTQA8npatBitYk8rt96uN8=
X-Google-Smtp-Source: ABdhPJxmEw1v0lojIIgyNKbeQfZQZRrkAC307QDKmlsS7Wz7OgnAFmzysczHHiHGimUu31Ti5LYcJA==
X-Received: by 2002:a05:6402:424e:: with SMTP id g14mr8011999edb.372.1631453279710;
        Sun, 12 Sep 2021 06:27:59 -0700 (PDT)
Received: from szeder.dev (94-21-23-21.pool.digikabel.hu. [94.21.23.21])
        by smtp.gmail.com with ESMTPSA id s18sm2058100ejc.52.2021.09.12.06.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:27:59 -0700 (PDT)
Date:   Sun, 12 Sep 2021 15:27:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jakub Wilk <jwilk@jwilk.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag -h fatal error with global tag.sort config
Message-ID: <20210912132757.GC76263@szeder.dev>
References: <0daf6907-b472-a756-1240-4c78f8f4d37e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0daf6907-b472-a756-1240-4c78f8f4d37e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 06:28:54PM +0700, Bagas Sanjaya wrote:
> I stumbled on Debian bug report [1], and I can reproduce the bug.
> 
> In global config (~/.gitconfig), I set:
> 
> ```
> [tag]
> 	sort = creatordate
> ```
> 
> When I run `git tag -h` inside a Git repository (such as git.git), instead
> of usage summary, I got:
> 
> ```
> fatal: not a git repository, but the field 'creatordate' requires access to
> object data
> ```
> 
> But plain `git tag` works fine.
> 
> This bug occurs on v2.33.0 as well as version in the original bug report
> (v2.26.0-rc2) and v2.25.1.
> 
> [1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954811

Interesting.  It bisects to 47bd3d0c14 (ref-filter: don't look for
objects when outside of a repository, 2018-11-14), which, based on the
error message, kind of makes sense, because 'git tag' uses the general
ref-filter sorting facility.  Now, even if 'git tag -h' is executed in
a repository, since 99caeed05d (Let 'git <command> -h' show usage
without a git dir, 2009-11-09) run_builtin() special-cases the '-h'
option and does not call setup_git_directory(), so cmd_tag() and
everything invoked from within will mistakenly think that there is no
repository.  And cmd_tag() parses the config before parsing the
options (of course, otherwise command line options couldn't override
the config), so it hits this die() before parse_options would get a
change to act on the '-h' option.

Now, 'git branch' uses the same ref-filter sorting, but the equivalent
'git -c branch.sort=creatordate branch -h' command does show the usage
as expected.  The relevant difference between cmd_branch() and
cmd_tag() is that the former special-cases the '-h' option as well
just before it would call git_config().  Doing the same in cmd_tag()
like in the patch below seems to fix this issue, but I'm not sure that
this is the right fix.


  ---  >8  ---

diff --git a/builtin/tag.c b/builtin/tag.c
index 065b6bf093..31b8cc4600 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -485,6 +485,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(git_tag_usage, options);
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));

