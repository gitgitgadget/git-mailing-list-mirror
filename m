Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF5C2D0C3
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF77A206CB
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 00:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSK6BDZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfLaAjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 19:39:09 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:36398 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfLaAjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 19:39:09 -0500
Received: by mail-pj1-f73.google.com with SMTP id m61so695725pjb.1
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 16:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FgTVLAJ0ntFimf8xGI6a4SU4z62zve3iWl85h6W+zP8=;
        b=OSK6BDZ4zizn+g76TGqzg0Khj1X3L1Zh2Ks8kENHXp2qZoJ2whXhxvkyXJXmSHUqhn
         643fUV5YqENp4QdS9MBB9XAt/99gN7HQ0rZhUD5tMWExsKdx9HBISkcwPrPc0Xu5IZXU
         rfUU/5ANkeDGWENhIBTI6Ce5HkAtRh7uCkdcoKhwXrdHtE2ebPRGrTExNvBbyf4j3f50
         0W+tQsTHFT/unnR63WIR6qRLCtgYHLv1M7nayiR/yYWpzlu/Qg0M9J8se9Co6ylKByu9
         YoK1qU2x1GDtkaB4pT13lzfFlNj4XAWBEEhtb2HJBt8SeHHaazS+WteyHIERXirxg879
         NqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FgTVLAJ0ntFimf8xGI6a4SU4z62zve3iWl85h6W+zP8=;
        b=f9Vjj+BxWQxR6IzsooA4en5HRFfQJBkRJLaxrughQU8k1moiRWU0mBVaKkYtDOqrxR
         j4aL5+dC70Uhx/fyl8+R6r9TRnrjuWv2kA18ZvBYLTaphs7FlpqEAI9vNnfs6kbG3YVA
         dgL8d1Siw4a4cZr6dLkQFEL2MPz8jxTjsR0DrTSHon987xDqhoHhrrxNv8j7o5I//NRJ
         vFj2AoW9RyvCoQpvGVJ/buoWCI0BKJpRiEv7OXJVh7tyOASxgFFNaavx3Whi2w6JhMFs
         7Zm9WjtJh3UywG6y7TqkRFuSU+OTkd6IISsdOD7XH3361WuyNZtBvntaHtpkdyBwE7s8
         EbPA==
X-Gm-Message-State: APjAAAW8g/pi/aOsZDSC4P10LOiWzvXhV8EBjPTd2rRpelxpN+ZXWQ/N
        QtVJ8uX5Ndy5nVgtPwTxxdPp/OIKeo3duaBEh4Wk
X-Google-Smtp-Source: APXvYqwbGwvQC0NRNl691gCO1fWG/R3RJu7w+uWv31C1/Yl3jyPo3acvy0BkYBXb0e886+yigI5sf0eHwmqMK6artU59
X-Received: by 2002:a63:dc41:: with SMTP id f1mr77164788pgj.119.1577752746959;
 Mon, 30 Dec 2019 16:39:06 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:39:03 -0800
In-Reply-To: <20191230220155.GF57251@google.com>
Message-Id: <20191231003903.36486-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191230220155.GF57251@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH] sha1-file: remove OBJECT_INFO_SKIP_CACHED
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ooh, I think there's something subtle hiding in this paragraph.
> 
> When I first read it, I thought you meant that the repositories are
> not self-contained --- that they contain references to the empty tree
> but do not fulfill "want"s for them.  I don't believe that's what you
> mean, though.
> 
> My second reading is the repository genuinely doesn't contain the
> empty tree but different Git server implementations handle that
> differently.  I tried to reproduce this with
> 
> 	empty_tree=$(git mktree </dev/null)
> 	git init --bare x
> 	git clone --filter=blob:none file://$(pwd)/x y
> 	cd y
> 	echo hi >README
> 	git add README
> 	git commit -m 'nonempty tree'
> 	GIT_TRACE=1 git diff-tree "$empty_tree" HEAD
> 
> and indeed, it looks like Git serves the empty tree even from
> repositories that don't contain it.  By comparison, JGit does not do
> the same trick.  So we don't need to refer to a specific repository in
> the wild to reproduce this.
> 
> All that said, having to fetch this object in the first place is
> unexpected.  The question of the promisor remote serving it is only
> relevant from the point of view of "why didn't we discover this
> sooner?"

Yes, that's true. I'll reword it to emphasize the spurious fetching (and
mention some implementations like JGit not serving those, which
exacerbates the problem).

I think we didn't discover this sooner because not many people directly
enter the empty tree on the command line :-) (but this is a problem that
we should solve, most certainly).

> > There are 2 functions: repo_has_object_file() which does not consult
> > find_cached_object() (which, among other things, knows about the empty
> > tree); and repo_read_object_file() which does.
> 
> Hm, where does this dichotomy come from?  E.g. is the latter a
> lower-level function used by the former?

I don't know the reason for the dichotomy - perhaps it was an oversight.
The relevant commits are:

d66b37bb19 ("Add pretend_sha1_file() interface.", 2007-02-05)
Adds a way to pretend that some objects are present by including them in
a cache - empty-tree-pervasiveness is built on top of this later. Only
read_sha1_file() was updated to make use of this; has_sha1_file() and
sha1_object_info() were already present at this time, but were not
updated. (Maybe the latter 2 had no need for pretending?)

346245a1bb ("hard-code the empty tree object", 2008-02-13)
Empty tree pervasiveness built on top of the cache.

c4d9986f5f ("sha1_object_info: examine cached_object store too",
2011-02-07)
sha1_object_info() was updated to use the cache. has_sha1_file() is
never mentioned.

> > as an optimization to avoid reading blobs into memory,
> > parse_object() calls repo_has_object_file() before
> > repo_read_object_file(). In the case of a regular repository (that is,
> > not a partial clone), repo_has_object_file() will return false for the
> > empty tree (thus bypassing the optimization) and repo_read_object_file()
> > will nevertheless succeed, thus things coincidentally work.
> 
> This might be easier to understand if phrased in terms of the
> intention behind the code instead of the specific call stacks used.
> See f06ab027 for an example of this kind of thing.  For example:
> 
>   Applications within and outside of Git benefit from being able to
>   assume that every repository contains the empty tree as an object
>   (see, for example, commit 9abd46a347 "Make sure the empty tree
>   exists when needed in merge-recursive", 2006-12-07).  To this end,
>   since 346245a1bb (hard-code the empty tree object, 2008-02-13), Git
>   has made the empty tree available in all repositories via
>   find_cached_object, which all object access paths can use.
> 
>   Object existence checks (has_object_file), however, do not use
>   find_cached_object.  <describe reason here>
> 
> When I state it this way, it's not obvious why this particular caller
> of has_object_file is more relevant than others.  Did I miss some
> subtlety?

This particular caller is what caused us to notice this problem.

> Indeed.  Can we justify the change even more simply in those terms?
> 
>   Object existence checks (has_object_file), however, do not use
>   find_cached_object.  <describe reason here>
> 
>   This makes the API unnecessarily difficult to reason about.
>   Instead, let's consistently view the empty tree as a genuine part of
>   the repository, even in has_object_file.  As a side effect, this
>   allows us to simplify the common 'has_object_file ||
>   find_cached_object' pattern to a more simple existence check.

OK, let me see if I can rewrite it to emphasize the reasoning-about-API
part. I still want to include the user-facing part that caused us to
observe this problem, but I can deemphasize it.

This might be a moot point, but what do you mean by the
"'has_object_file || find_cached_object' pattern"?
