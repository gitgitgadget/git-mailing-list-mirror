Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C5CC35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB812067D
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaJSSF1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgBOAqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:46:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37495 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBOAqM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:46:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so5679670pfn.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=24GT5QohhIegRESW0yzt8xifXPhSJUOrf/jEdPymOug=;
        b=gaJSSF1k98APqYb6hhcXf7d8n6Tc9ZmUUyRFhVNy3VXZDPiZ1GmnQQY1SCBpLgU5x7
         Hc5zaG372Q76CjbZt/lpgqkPJjI5JPmZ2r4CfOgUjjGe6rcj1xA5ZI7BelEne9AVXu29
         w/wGjgb2k6o28BWVU5/XIcj2k7OpQd+X91tlXBVvIX2x0RyDf/PRmBA9c7osnJ++AVCd
         c7A9e8vZE46VLjEUfIWimLW4XSKD+64nKq+zlR7hsSEaQ/VYXmh9BNBS6E4Yeux0/tkr
         qoR2tYftaGAS9hkHO5/hz47M0t2ZhM5ls2U/T173akvpGONrtdag2L7e8V4/e5c9+6X4
         o/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24GT5QohhIegRESW0yzt8xifXPhSJUOrf/jEdPymOug=;
        b=pbbnwwpeL5XhqxBtDr6kCf6Lg1+E9BUiPJijeE7qoUOfp27CvueRLAI1f+9EsHNF3p
         18S5Eslv25tFGfJPs1rploZNfum9ptySUkUOF8/d8YJR7iZUS3G8/QLQBZAA9ARjsDq4
         QXSyHYbKoGwPhUx9nXF12bVIHChLHlc+CBjhyjcdt2CCaKXyaHdGKNsU+sA/AooZ/0sz
         EpeWBtTFDMzbumwcJaXE+xQG+28yK82M0J/I276rXiotYElYm2g0/xSKv6QQc+v4EdJN
         DkZGyPpxd0l5OHvLMCq0CO0Y7o9bS0UBneFNewMaGN15goDL/HxjW7LFg/EE9BpqI6wf
         ueSA==
X-Gm-Message-State: APjAAAXG7uyV0WKyhXVDAc3KIxZ5F6NlbHxsFuou6KjD+9UcBSHe/gu5
        OjEN+i0WguZaywbS/FX/HtTG5tmKn2g=
X-Google-Smtp-Source: APXvYqwHprrsV2c9IAZmEUHLGo0oJWjLdAAI4LadfinmJln323/m+pImghhjhTrWoQQ+lcjawKxhGQ==
X-Received: by 2002:a63:6285:: with SMTP id w127mr2657357pgb.305.1581727571802;
        Fri, 14 Feb 2020 16:46:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 5sm8387431pfx.163.2020.02.14.16.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:46:11 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:46:06 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] prefix_path: show gitdir when arg is outside repo
Message-ID: <20200215004606.GM190927@google.com>
References: <20200214232933.243520-1-emilyshaffer@google.com>
 <20200215000230.GA6134@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215000230.GA6134@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 15, 2020 at 12:02:30AM +0000, brian m. carlson wrote:
> On 2020-02-14 at 23:29:33, emilyshaffer@google.com wrote:
> > From: Emily Shaffer <emilyshaffer@google.com>
> > 
> > When developing a script, it can be painful to understand why Git thinks
> > something is outside the current repo, if the current repo isn't what
> > the user thinks it is. Since this can be tricky to diagnose, especially
> > in cases like submodules or nested worktrees, let's give the user a hint
> > about which repository is offended about that path.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > This one comes from a user feature request. This user is running some
> > Git client commands on a build machine somewhere and finding it hard to
> > reason about the cause of the "outside repo" error.
> > 
> > I see two arguments:
> > 
> > For:
> >  - A user checking their own `pwd` might still not come to the same
> >    conclusion Git does about the current repo, if their filesystem is in
> >    some weird state
> >  - This warning is intended for human eyes (die(), stderr) so it's reasonable
> >    to give some info to make the human's life easier
> > 
> > Against:
> >  - It's chatty, especially given the absolute directory. This may be a
> >    pretty common mistake ('git add' with thumbfingers?) so it could be
> >    chatty, frequently - not great.
> >    (Sidebar: Just including the relative directory is really not very
> >    useful - since you're still left thinking, "relative to where?")
> 
> I'm very much in favor of this patch.  I recently ran into a similar
> problem with Git LFS with path canonicalization and having both paths in
> the error message made it immediately obvious what the problem was.
> 
> > diff --git a/pathspec.c b/pathspec.c
> > index 128f27fcb7..5d661df5cf 100644
> > --- a/pathspec.c
> > +++ b/pathspec.c
> > @@ -439,7 +439,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
> >  		match = prefix_path_gently(prefix, prefixlen,
> >  					   &prefixlen, copyfrom);
> >  		if (!match)
> > -			die(_("%s: '%s' is outside repository"), elt, copyfrom);
> > +			die(_("%s: '%s' is outside repository at '%s'"), elt,
> > +			    copyfrom, absolute_path(get_git_dir()));
> 
> Do we want the top level directory in these two spots instead of the git
> directory?  I suspect that might be more helpful, since it looks like
> we're dealing with working tree files.

I had considered it, and thought .git directory was less ambiguous,
primarily for the first bullet in the "For" list above - "for some
reason, the .git dir I see isn't the one that Git is coming up with".
The .git dir does have a pointer to the worktree ('gitdir' in the
worktree case and 'config' in the submodule case). Conversely, in both
the submodule and worktree cases the worktree contains a ".git" file
with the path to the gitdir.

I also tried the following:

  $ git clone --separate-git-dir=explicit-gitdir https://github.com/git/git
  explicit-worktree
  $ cd explicit-gitdir
  $ grep -Rn "explicit-worktree"
  <no results>
  $ cd ../explicit-worktree
  $ cat .git
  <absolute path to explicit-gitdir>

So it looks like in the clone with --separate-git-dir case, there's no
way to identify the worktree from the gitdir.

All this to say, on second thought, I think you're right. From the
worktree's top level, the gitdir is consistently findable. From gitdir,
the worktree is not consistently findable.

I'll send a reroll.

 - Emily

> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204


