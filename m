Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE71E784BE
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbjJBPVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbjJBPV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:21:29 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236AA6
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:21:25 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-65d5a6230fcso26743576d6.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696260085; x=1696864885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVfh8xNbCAa3lKuMA0QomQqQKkiP9siVdVbcssWnEzg=;
        b=OTWd42HnvCovyjTwRawXeI7HxltkDSEKVx/O+Jaj1HHxwdwwh9enwfHwSp98dZiDJ6
         KVNS6puQu5peoD+1zbleDTSd6zOVTW3jErAkb5EUmPNjK9UleU556y0dX3Ea3lnIAQiB
         h9poGoiwE0F9dhsYa6TpI94GbEYf/4AX/5RzjXAtwEW6CwMlPsbY+IJVkGRg+xO3pwW5
         8khT2+D4b0WOMPLdA9yU/34OO4NQnYTY52r/At5fq+TxbSUfR7YAWsrdgvvWkKVv53h2
         9Vj6AKAzSi73E1z9hpU3n+vkMZAKwM3nKJz5uMl4XrLXXjqGh2+p0TPxKbuKbCjdUxwG
         mEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260085; x=1696864885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVfh8xNbCAa3lKuMA0QomQqQKkiP9siVdVbcssWnEzg=;
        b=Y+azawX9hjKhmQMEtU9syNEWu6jwu9HyQqIdYl9PegZEn7sYzTiQQ5uqyhuHqChYgl
         XBRUGGwI7VP18JkdbMLp6ChyZDtbzHq2J9bMHHnc3RtQo2QCgRlP+XJ8aHFhuyPulbAn
         BixPMsKUaJjggQvIPUitb0e2i37v5VS6Ilc0C/xeSyLECUV4tRkbMZ8hiJdXIBP7ZL1w
         7/De2mgPivHrktYOV0r/5JqVBCoHtnOXEotkMsWSyzgAvnMIamMSsc9RyDYp+3Kxx3Si
         A7nWPMWy5NbrcbffvzNxCZc2vbLhD5K7WPHA6uZxWpS3jIqIhLXxscLJfrfD4VXDwcRl
         5FhQ==
X-Gm-Message-State: AOJu0Yxz2Vig449ySBuO0zzMrjdl8sCXyAKFmmDEA1h8kGGdNpeOgTkA
        vUQ0ncUikFvfL4XCB2D24W7B1/xAzouskazSVndg9g==
X-Google-Smtp-Source: AGHT+IH0ts+Pi/hihgj2KrxGVSlaHqb5OqYGsq0ipJ46qLoXr+Z83xCBDBJGrXAN6Nj9DYb2mmXtJw==
X-Received: by 2002:a05:6214:3f92:b0:65b:239f:351b with SMTP id ow18-20020a0562143f9200b0065b239f351bmr12549003qvb.42.1696260084708;
        Mon, 02 Oct 2023 08:21:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l2-20020a0c9782000000b0064f3b0d0143sm7595669qvd.142.2023.10.02.08.21.24
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:21:24 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:21:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [TOPIC 8/12] Update on jj, including at Google
Message-ID: <ZRrf8zmU5hucarsx@nand.local>
References: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRregi3JJXFs4Msb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Presenter: Martin von Zweigbergk, Notetaker: Glen Choo)

* (Martin) jj team at Google has been growing. The support for different commit
  "backends" has been expanding - we can now store "commits in the cloud" using
  the Google-internal backend.
   * "Revset" engine. Revset is a language for selecting commits (e.g. "select
     all commits by me"). We now have an implementation that scales to Google's
     millions of commits. Commit id prefixes are resolved against the "local"
     commits (not the full Google mainline).
   * Conflicts are now stored tree-level, instead of per-file level. Conflict
     detection is much faster since jj doesn't need to traverse the tree.
   * Exporting jj commits to internal code review tool (Critique).
* (Martin) What's left?
   * Renames: do we track renames? Do we detect them?
* (Elijah) If conflicts are tree-level, can you store partially-resolved
  conflicts?
   * (Martin) Yes, we store trees for each side of the conflict and resolve the
     conflicts only when needed.
* (Jrnieder) Are there lessons from jj development that Git would benefit from?
  What can Git do to make jj's life easier, and vice-versa?
   * (Martin) Conflicts-in-code work extremely well. I think Git could adopt
     that, but it would be very messy to migrate the UX to that. The operation
     log (a global view of all of the refs at a given "operation") is also a big
     improvement over e.g. the reflog.
   * (Martin) jj uses libgit2 (with Rust bindings) under the hood, so we're
     missing functionality like partial clone.
   * (Taylor) do you shell out to git, or only use libgit2? If you did shell
     out, are there other missing Git functions that you'd want?
      * (Martin) Only libgit2. Can't think of other features jj would want.
      * Until merge-ort existed, worktreeless merge would be an example.
      * (Glen) When jj pushes things to a Git server, it loses information. If
        the server understood obsolescence markers, that would be a huge
        improvement for jj.
      * (Martin) Yes, jj uses a change-id to associate different amended
        versions of the same change, similar to Gerrit - it would be nice for
        Git to support the same thing.
* (Junio) Did you have to make any breaking changes that affect your users?
   * (Martin) We make many. We're a small project, and people accept that it
     needs to break to get a nicer UX, which is a nice thing about being early
     in a project.
   * Format-wise, we try not to break the repo format - in terms of newer
     versions of jj being able to work with older versions of repositories.
     Older versions of jj are not expected to always be able to read repos
     written to by a newer version.
      * (Jonathan) "svn upgrade" style?
      * (Martin) Yes, except we immediately do the upgrade automatically.
      * (Jonathan) So the moment you use the new version of jj, you lose the
        ability to roll back.
      * (Martin) Yes. Errors out (crashes) when reading the format it doesn't
        understand.
      * One of these was annoying for users, we may be at the point where we
        need something more formal.
   * (Junio) In 2005, we did two huge breaking changes in the repo format. There
     were lots of users, but we did it anyway. One was about object naming (used
     to compress first, then hash, which was a bad way of doing it - swapped the
     order to compress better and faster without changing object names).
* (Elijah) If we rewrote parts of Git in Rust, would we be able to share code?
   * (Martin) Possibly, but it would require a lot of rewriting to make that
     work.
* (Emily) Greenfield features in jj, e.g. preventing users from rewriting
  "public" commits/history. Are there other ideas would we like to try in jj
  that are harder to do in Git?
   * concept of https://wiki.mercurial-scm.org/Phases makes some things (like
     safe interactive rebase) easier
   * (Terry) The usual practice is to have policies on branches (some branches
     are more experimental, some have stringent quality requirements, etc), but
     those are implemented on the hosting provider, not the VCS.
* (Terry) jj has lots of glowing reviews! Power users are happy with it, using
  jj locally. If anything is not supported in jj, they can use Git instead. Is
  there a roadmap for simplifying the experience for non-power users, having it
  automatically take care of things like when to run gc, etc?
   * (Martin) Re: gc, jj doesn't implement it yet.
   * (Terry) More general UX. If I'm a developer using git repositories and want
     to use jj, when do I get to a place where I have a nice end-to-end
     workflow?
   * (Martin) I already use jj, I don't have the "colocated repo" so I only run
     jj commands, can't run git commands. For blame I fall back to the hosting
     provider's web UI. :) That's something to add.
   * (Jrnieder) My impression from the jj discord is that the UX is very
     dependent on their code review tool. Amending/rebasing and sending to
     GitHub seems to work OK. Losing the obsolescence information when pushing
     to Gerrit works quite poorly.
* (Minh) Does jj store commits in Git form? Can it translate between different
  commit representations?
   * (Martin) It can store commits in Git form. The demand for on-the-fly
     conversion has come up.
* (Taylor) How does jj represent non-Git concepts in Git format, like having
  multiple trees in a commit?
   * (Martin) It stores extra metadata outside of the Git commits, and also it
     stores its own shape in Git format, e.g. for multiple trees, each tree is
     its own directory.
* (Minh) How do you optimize searches like "commits written by me"? Full text
  index?
   * (Martin) It's implementation-specific. On local repos, it just iterates
     commits.
   * (Martin) The revset language is quite expressive, e.g. you can specify AND
     and OR. The language is also separate from implementation.
* (Jakub) There are other tools that implement a query language for Git. It
  could be worth considering implementing one natively. (See Git Rev News
  archives.)
