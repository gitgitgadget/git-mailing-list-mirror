Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D91BC352A2
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328D4214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK0TW8kM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBGLuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:50:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40906 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgBGLuA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 06:50:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2394491wmi.5
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 03:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NK1l3i2sLhZ9OqKYeB0ogUyQgJznCbclnyZgHx91FkU=;
        b=SK0TW8kM9fSaBL4Q95X/2KJuh+Nqdy5hvQuR6drYGtiwBmg2N8Dcu0SOvj4nFUUvOG
         fB37M9/7bBEhN9vGfQVgCGXbkm3fF0WuaUk9/RgD2MFWkVwvP3Ul9lN9m0kHR3RSxnm7
         mvY7HtPlY4c/H3JKzBRnW92CmTV9lL1bfT9Khr59eSgz0jNznIMRFh0DO4A7W0dftVRi
         BcdQUFKnyxgjO8JsumpWsEwZ98VPbPqSkuOk3JBLtPlHzcrmDVhnEwEujTiJsTY5YkOS
         1Ot07dJaaW2NjO1+cFdYWhKAb8fWb1iOSf33qmZkJ1CTi6uaAWFHT8x3YO1DYEvu1r2G
         eGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NK1l3i2sLhZ9OqKYeB0ogUyQgJznCbclnyZgHx91FkU=;
        b=oCY02Tb9mx+rSnGpVi8GY42UkkAXDhRk804SZFclimKtwYnXMHX533Dq6eGeDeeFvb
         K24ITaD6dyp79p4PMeo+bU8jJ3Qm1LI+4m7viBzu/tyBK7kQEylZyaLjK8tIRsNHDZEX
         ayrZgR1CGkc7qw8NqtvIyAqtqTg0eHGuwRv5kQfSH+jb9ouEi6He2cFUyODQUw75yW/5
         ecHI3mK05Me/XOjoXF/hMBh8FQGQdiG7lOAsMXLs7u3qU05RZh+JqTpmHixu4akb0Uw1
         qmpkJSTtWHoYZT0NyZbYBK7vkAR6vBcmXepj0HNQeYj4pmRbvgtXzqRUyvPXEunGmAVS
         MIXg==
X-Gm-Message-State: APjAAAUhE+yh/iU7fy08eK+c/AcJzFef7H2nfiLEmId6cSxQ2gYlHGGS
        dANXwLQ27/8+P/lHnwx4/k9SVdPo
X-Google-Smtp-Source: APXvYqzh2+UtXYm0xmBhxgOgEMVEFiojLpAi5k8PGqciMI51wSVFW4ZVzf9fNwm9q20fz9K4J7rNVw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr4307790wmk.68.1581076196925;
        Fri, 07 Feb 2020 03:49:56 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id z3sm3025410wrs.32.2020.02.07.03.49.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 03:49:56 -0800 (PST)
Date:   Fri, 7 Feb 2020 12:49:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG?] 'git rebase --abort' couldn't abort aborted rebase
Message-ID: <20200207114954.GB2868@szeder.dev>
References: <20200207111008.GA2868@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207111008.GA2868@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 12:10:08PM +0100, SZEDER Gábor wrote:
> That's a good subject, isn't it? :)
> 
> So, to clarify: apparently it is possible to abort an ongoing 'git
> rebase' process with ctrl-C in just the right moment that a subsequent
> 'git rebase --abort' will refuse to clear it up.
> 
> I somehow messed up the upstream and branch parameters of 'git
> rebase', and ended up trying to rebase a fairly recent (post v2.24.0)
> branch on top of v2.22.0.  Upon seeing the unexpectedly large number
> of patches I realized that something is wrong, hit ctrl-C right away,
> and this is what happened:
> 
>   $ git rebase v2.22.0 <a-branch-on-top-of-2.24.0>
>   First, rewinding head to replay your work on top of it...
>   Generating patches: 100% (1108/1108), done.
>   Applying: send-email: move the read_config() function above getopts
>   Applying: send-email: rename the @bcclist variable for consistency
>   Applying: send-email: do defaults -> config -> getopt in that order
>   Using index info to reconstruct a base tree...
>   M       git-send-email.perl
>   M       t/t9001-send-email.sh
>   Falling back to patching base and 3-way merge...
>   Auto-merging t/t9001-send-email.sh
>   Auto-merging git-send-email.perl
>   ^C
>   ((5f07da12ac...) *|REBASE 3/1108)$ git rebase --abort 
>   error: could not read '/home/szeder/src/git/.git/worktrees/WT/rebase-apply/head-name': No such file or directory
>    
> "Fortunately" it was in a separate worktree, so I could easily get out
> of the situation by forcibly deleting that worktree.  Unfortunately,
> that was exactly what I did, instead of securing the failed state for
> later analysis...  sorry.

> All this is with a git built from current 'next', with a bunch of
> unrelated (none of them touches rebase or the sequencer) patches on
> top.

Trying to reproduce it is a hit or miss... well, mostly miss :)

There is a rather short window when 'git rebase' applies patches
before hitting a first merge conflict.  If the ctrl-C arrives before
'git rebase' starts applying patches, then it cleans everything up,
and we are not rebasing, so there is no need for 'git rebase --abort'.
Once 'git rebase' stops because of the merge conflict we get our shell
back, and 'git rebase --abort' works as it should.  But after a good
couple of tries I managed to hit ctrl-C while 'git rebase' was
applying patches:

  $ ./BUILDS/v2.25.0/bin/git rebase v2.22.0 v2.24.0^{commit}
  First, rewinding head to replay your work on top of it...
  Generating patches: 100% (1049/1049), done.
  Applying: send-email: move the read_config() function above getopts
  ^C
  ((v2.22.0) +|REBASE 1/1049)$ ./BUILDS/v2.25.0/bin/git rebase --abort
  error: could not read '.git/rebase-apply/head-name': No such file or directory

Note that I'm using v2.25.0 here, so the problem is not with 'next' or
with my patches.  Also note that I reproduced the error in the main
worktree, and only using commits that are present in git.git.


Finally, note the 'v2.24.0^{commit}' parameter, in particular the
'^{commit}' part.  That's important, because without it we stumble
upon _another_ bug:

  $ git rebase v2.22.0 v2.24.0
  error: Object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 not a commit
  First, rewinding head to replay your work on top of it...
  Generating patches: 100% (1049/1049), done.
  Applying: send-email: move the read_config() function above getopts
  < ... applying further patches and hitting a merge conflict ... >
  Resolve all conflicts manually, mark them as resolved with
  "git add/rm <conflicted_files>", then run "git rebase --continue".
  You can instead skip this commit: run "git rebase --skip".
  To abort and get back to the state before "git rebase", run "git rebase --abort".
  (detached HEAD *+|REBASE 7/1049)$ git rebase --abort 
  error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object 1cc4bc0fcd93f816d514d77c29f2cc9ffdd8ae09 to branch 'HEAD'

So 'git rebase' shows an error right at the beginning when rebasing a
tag, but then continues anyway.  However, 'git rebase --abort' can't
restore the original state.

