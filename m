Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA924C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 03:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB13207BB
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 03:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p50Y/iUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505121AbgJ0DfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 23:35:22 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55592 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410256AbgJ0DfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 23:35:21 -0400
Received: by mail-pj1-f68.google.com with SMTP id c17so58305pjo.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vOfzDrc3Qt3Htr5RId2c/uO0FOtH89dFcsxM/EXrU88=;
        b=p50Y/iUBgyA2h+LSnFFKiSLTsPyQ8dgmEWkcNHh722yHNRJM4TArpI6zKZbueqEGqL
         FZt+/eyMO/g50/nVrnuVQJS2F89X17t2kH6t2DVDVH65N8LT9bXtCrs3C1SUriIePVTi
         GeX8x0tLShE7wEw54ZnM0H+cYBpc2VewHElprI7885cI0w2AqHzKj/H9WsVG0ojKPtTl
         wq6ksyHHup9J0ZomOWFeA2Q4OdTKm1CLD7TUzcDr9Fd2gqc92iedLjpJLR6KZdMedjMo
         5MHacJO/yOI3W6MaYcdCIjqRSF/WfEFdjTodIfoSpEmp9yz7DgYMCFgBu8nOsV+Pwban
         fQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOfzDrc3Qt3Htr5RId2c/uO0FOtH89dFcsxM/EXrU88=;
        b=UGZRf2geV1CmCqTl3WSHE3YU6rgF5XdKbOp0b+ASCj/YEI+26VDkPG+2Jo241AOxxQ
         Mw1KPgA+ZpA86Jidi3xdaS1+JMxuivNPYk0Y7f3AJT1GuKnrTHoTOG+Q/xmrNhy4+HgE
         9v1owYt+CJgNRAZij4IwOjMTpWRdALaB9yTUjnnFdynjRTg3Ve3trkbOOKBSt6wQ5wmr
         xddrkkC++v03sMDCXeKNQnMzPIXfFFihVhfllGPIyO+3Pmf7yl+dDLLOkP3OTQBcWZUk
         aVn/mkF9pb3JeuIcD9hdnV1pLtJZLPgNtIjWTrAVTHFMNIrV0B9aHNoD7xSP8/4OkYPB
         wEhg==
X-Gm-Message-State: AOAM530jTCBth/BWA6ut5YYVZpDlKkOl2cPRh90MCIeoXte0O1iGt8X4
        wyhL6+iMdt7djRZoulvDjrKJDvdzX/4=
X-Google-Smtp-Source: ABdhPJxF8ZeJkwJ2kzGHgazgvBaOtmHsEWo6pD2X2RHGtGntSm3oKCmJPeR29RSRzyXwvBV7cMiohg==
X-Received: by 2002:a17:902:6b84:b029:d5:ef85:1a79 with SMTP id p4-20020a1709026b84b02900d5ef851a79mr486201plk.32.1603769721091;
        Mon, 26 Oct 2020 20:35:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id ch21sm197660pjb.24.2020.10.26.20.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 20:35:20 -0700 (PDT)
Date:   Mon, 26 Oct 2020 20:35:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] verify_path(): disallow symlinks in
 .gitattributes and .gitignore
Message-ID: <20201027033518.GH2645313@google.com>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
 <20201005121645.GG2907394@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005121645.GG2907394@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> However, it's still a reasonable idea to forbid symlinks for these
> files:
>
>   - As noted, they can still be used to read out-of-repo files (which is
>     fairly restricted, but in some circumstances you can probe file
>     content by speculatively creating files and seeing if they get
>     ignored)
>
>   - They don't currently behave well in all cases. We sometimes read
>     these files from the index, where we _don't_ follow symlinks (we'd
>     just treat the symlink target as the .gitignore or .gitattributes
>     content, which is actively wrong).
>
> This patch forbids symlinked versions of these files from entering the
> index. We already have helpers for obscured forms of the names from
> e7cb0b4455 (is_ntfs_dotgit: match other .git files, 2018-05-11) and
> 0fc333ba20 (is_hfs_dotgit: match other .git files, 2018-05-02), which
> were done as part of the series touching .gitmodules.

Thanks again for this.  Since this patch has been in "next", we've
gotten a little experience of it at Google.

We've been running with the fsck check for a while (more than a year),
but not the verify_dotfile check.  The verify_dotfile check didn't
trigger for anyone with .gitattributes, but it hit several people for
.gitignore.  Some examples that users have mentioned:

Before https://android-review.googlesource.com/c/platform/tools/test/connectivity/+/1462771/
Android used a .gitignore symlink for two directories that had similar
gitignore requirements.  Diagnosing the error was confusing for them,
especially because the "repo" wrapper tool produced messages like

	error.GitError: Cannot initialize work tree for platform/tools/test/connectivity

Eventually someone manually ran

	$ git add --a
	error: invalid path 'acts_tests/.gitignore'
	error: unable to add 'acts_tests/.gitignore' to index
	fatal: adding files failed

which helped them realize it was a git issue and helped me point them
to the need to replace the symlink with a plain file.

As another example, a user working with the
https://github.com/bakerstu/openmrn.git repository noticed "git
checkout" commands failing.  In this user's case, the checkout failed
part-way through, producing confusing behavior ("git status" showing
entries missing from the index).  When I tried to reproduce this, I
wasn't able to clone the repository at all because it failed fsck;
after disabling transfer.fsckObjects, I still wasn't able to check out
HEAD.

Observations:

- since some widely used repositories have .gitignore symlinks, I
  think we can't forbid it in fsck, alas

- it would be useful to be able to check whether these symlinks would
  not escape the worktree, for a more targeted check.  It might be
  nice to even respect these settings when they would not escape the
  worktree, but not necessarily

- we could use a clearer error message than "invalid path".  There's
  some room for improvement in "git checkout"'s error handling, too
  --- I think my ideal would be if the operation would fail entirely,
  with an advice message describing a checkout command that would
  succeed (But how do I checkout another commit while excluding some
  files? Should it suggest a sparse checkout?).

That's all I have time for today --- will revisit again tomorrow.

Thoughts?

Thanks,
Jonathan
