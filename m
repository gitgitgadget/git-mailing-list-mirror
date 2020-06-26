Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A8C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 06:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3420768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 06:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1U6VMlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgFZGeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgFZGep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 02:34:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1BC08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 23:34:45 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so6074166edz.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 23:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/deyneOFVg2ByrjICyo5cdtQKOsXxo7mOdCQ1CuQgXE=;
        b=N1U6VMlDmTUaG+T5QDQuOQXcQbiWcmu54PDCm9DLYkG+Ctqsyhy4zgw/Ntq1wOFfkn
         FCw9vv1vxL2VwAzk4EPLBcs5MnTrQUwAFTcVruopgJTrLENkYYorC001MhLHWlSAHbfZ
         +gRGzTph/OOq+mOw/Qioobo038KGWOOHFvjBJNcR4ZvHSO1bPnyqowp5hTSTwCQXKXu6
         C+YeHH+IiWfnK6Q2RTPwkS0dmuL5cnSyBwa0W+/v6bZhaaaIU0oo33TN+b3qclcyGQ6m
         C7K2yVBI6+5etqd8rkVrfNdYiueey4LMP3gqqZyoK1idWpvN/kkmMehXzvFmfH5pF2Vd
         GM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/deyneOFVg2ByrjICyo5cdtQKOsXxo7mOdCQ1CuQgXE=;
        b=AHoELd8llb5VNwHmvmH9Wu1k0IjT8BtT6u9GmmkiWlrtIDCvm5Diwap7SmObZ18zLq
         uZxKeMokbP7z3jw/YS31DFwnyBiqMQpXTGlKNNEAIdkc8+wOm99y1AK44EbTL/P2ppB8
         YMeVkyGdSic3VTuDDLRvMIrrXDnk7PIRJOVt3J5gkp+o4oV6VCykQ8Q8q46/px0m8V8C
         nI8fyaWYn/zzhMlBkMQLhtX48CZ3lDP8HcrxoRjgTqxzS5SWsdjUdIp75CNoWQ4Ascyc
         uiOoF4rm/AztRQWW8PeCo+pL897DkrxCPxGB0l0P/By+U7B30cj17aMd+gpqzY22J4Ub
         GXkA==
X-Gm-Message-State: AOAM5326sAnx6B3ZH+013vWi9TjEOpi+8X4claWBvMVvdGB0EFq1MSkb
        fD0fXfCHiHl1tdHg+PwY44z/hjfB
X-Google-Smtp-Source: ABdhPJwVThqgSPbIYBV03Du/4BojTGGgAuRLpr9joBtBIWQn6rSJm2sJnbJj4GanCAxVrSIHvTo9fw==
X-Received: by 2002:a50:8143:: with SMTP id 61mr1877673edc.202.1593153283829;
        Thu, 25 Jun 2020 23:34:43 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id w8sm20119972eds.41.2020.06.25.23.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 23:34:42 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:34:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 10/11] commit-graph: check all leading directories in
 changed path Bloom filters
Message-ID: <20200626063436.GA11341@szeder.dev>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <9c2076b4ce46918fce8f05e609b057611ec56e13.1592934430.git.gitgitgadget@gmail.com>
 <8d8b1763-bbf3-682e-0649-f5a0885399e6@web.de>
 <0fe96c75-2946-8160-2ced-3d9781dca8c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fe96c75-2946-8160-2ced-3d9781dca8c0@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 25, 2020 at 11:05:04AM -0400, Derrick Stolee wrote:

> >> +	while (p > path) {
> >> +		if (is_dir_sep(*p))
> >> +			fill_bloom_key(path, p - path,
> >> +				       &revs->bloom_keys[path_component_nr++],
> >> +				       revs->bloom_filter_settings);
> >> +		p--;
> >> +	}
> > 
> > This walks the directory hierarchy upwards and adds bloom filters for
> > shorter and shorter paths, ("deepest first").  Good.
> > 
> > And it supports all directory separators.  On Windows that would be
> > slash (/) and backslash (\).  I assume paths are normalized to use
> > only slashes when bloom filters are written, correct?  Then the lookup
> > side needs to normalize a given path to only use slashes as well,
> > otherwise paths with backslashes cannot be found.  This part seems to
> > be missing.
> 
> Yes, that's a good point. We _require_ the paths to be normalized
> here to be Unix-style paths or else the Bloom filter keys are
> incorrect. Thankfully, they are.

Unfortunately, they aren't always...

Path normalization is done in normalize_path_copy_len(), whose
description says, among other things:

   * Performs the following normalizations on src, storing the result in dst:
   * - Ensures that components are separated by '/' (Windows only)

and the code indeed does:

        if (is_dir_sep(c)) {
                *dst++ = '/';

Now, while parsing pathspecs this function is called via:

  parse_pathspec()
    init_pathspec_item()
      prefix_path_gently()
        normalize_path_copy_len()

Unfortunately, init_pathspec_item() has this chain of conditions:

        /* Create match string which will be used for pathspec matching */
        if (pathspec_prefix >= 0) {
                match = xstrdup(copyfrom);
                prefixlen = pathspec_prefix;
        } else if (magic & PATHSPEC_FROMTOP) {
                match = xstrdup(copyfrom);
                prefixlen = 0;
        } else {
                match = prefix_path_gently(prefix, prefixlen,
                                           &prefixlen, copyfrom);
                if (!match) {
                        const char *hint_path = get_git_work_tree();
                        if (!hint_path)
                                hint_path = get_git_dir();
                        die(_("%s: '%s' is outside repository at '%s'"), elt,
                            copyfrom, absolute_path(hint_path));
                }
        }

which means that it doesn't always calls prefix_path_gently(), which,
in turn, means that 'pathspec_item->match' might remain un-normalized
in case of some unusual pathspecs.

The first condition is supposed to handle the case when one Git
process passes pathspecs to another, and is supposed to be "internal
use only"; see 233c3e6c59 (parse_pathspec: preserve prefix length via
PATHSPEC_PREFIX_ORIGIN, 2013-07-14), I haven't even tried to grok what
that might entail.

The second condition handles pathspecs explicitly relative to the root
of the work tree, i.e. ':/path'.  Adding a printf() to show the
original path and the resulting 'pathspec_item->match' does confirm
that no normalization is performed:

  expecting success of 9999.1 'test': 
          mkdir -p dir &&
          >dir/file &&
          git add ":/dir/file" &&
          git add ":(top)dir/file" &&
          test_might_fail git add ":/dir//file" &&
          git add ":(top)dir//file"
  
  orig:  ':/dir/file'
  match: 'dir/file'
  orig:  ':(top)dir/file'
  match: 'dir/file'
  orig:  ':/dir//file'
  match: 'dir//file'
  fatal: oops in prep_exclude
  orig:  ':(top)dir//file'
  match: 'dir//file'
  fatal: oops in prep_exclude
  not ok 1 - test

This is, of course, bad for Bloom filters, because the repeated
slashes are hashed as well and commits will be omitted from the output
of pathspec-limited revision walks, but apparently it also affects
other parts of Git.

And the else branch handles the rest, which, I believe, is by far the
most common case.

> Let's make that clear in-code by
> using '/' instead of is_dir_sep().
> 
> Thanks,
> -Stolee
