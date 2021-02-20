Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5450FC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201A064E67
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBTRI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 12:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBTRI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 12:08:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23271C061574
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 09:07:48 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o15so9729250wmq.5
        for <git@vger.kernel.org>; Sat, 20 Feb 2021 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VOpe4ch5s24wxGLbmFtuqETtJFjJcHUu08CZW9Yi+zc=;
        b=LQLOUgC225tRQe4ED7HPDENKOStoExf3PT+24ZL10SbEW//Wu/bGFxiUuTjW35uhVP
         glGp7HS+HP3UJPxcLqjb+rkZNCxQ4Eo5cRDN+CCMlPjxH68CUXbfLWCvQbLzOvImvSIy
         RfkphC7WYhDkGBNTMQtOXLrdOqM1Bq6l7bXtwwtpfSrajy2dlUvRqq28m5A2kKX/EPcI
         ltdgXGhD7pyOhBBV9Kef5faR8lG70jYQjhgfwkvYuFGFoIqb0sv2TDsf/mHD2m5UeD0s
         ttCtk8motlezB0R4c/9FPJRZCd2IYZmcJuyBnawhkmFYbgzB8/m7ELjPjz2siwod6WkF
         SNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VOpe4ch5s24wxGLbmFtuqETtJFjJcHUu08CZW9Yi+zc=;
        b=mpcRoKLut9eGuv11eLLz9gPmGTsnlHVgsA/i9AvuWKZUhyeBTPBVkdWOEUScwBdpvd
         IPSe0vza4h6nYW4h5DxFT0Ft5zuByY2opQ7vTF/wVKAaLde5xdxTQHCAQ41lEZUDj/2/
         HT/4kVDaPt8EtqPRrMryx/Im6mrt2OxGJSj20l17MwRj6xz/hi8pxzdH0MKBpjeZl8Ib
         ffUl3INmUiLjZ19f3lOhTqkgiGd6bur7/oa9aIQeSSAbFHnUOkbdM9hYmMtNnYpauKs0
         61JgyFhjhPQEwhzO6FoUzk+q6d/JNUlo0A02aOF8Vldhv3d/Tp2cYViMuH2pOyHgSXPD
         KxIg==
X-Gm-Message-State: AOAM532CxwW6ys9GL7C/UyUFAy1zZSGXYLt2g8LAVGzbfKtBATppiFcw
        FnOsLFM7TndYkytYWncndoUcV/dciwA=
X-Google-Smtp-Source: ABdhPJzVT2awNz8ZSsB3q3QMuYQBxh5FJiMMW0h6OSFmxT3dlKbpfoVPqdu1arj9pYzMUnYyZW0q+g==
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr3467613wmm.113.1613840866709;
        Sat, 20 Feb 2021 09:07:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z190sm13225838wme.15.2021.02.20.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 09:07:46 -0800 (PST)
Message-Id: <pull.880.v2.git.1613840865.gitgitgadget@gmail.com>
In-Reply-To: <pull.880.git.1613758333.gitgitgadget@gmail.com>
References: <pull.880.git.1613758333.gitgitgadget@gmail.com>
From:   "Andrej Shadura via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Feb 2021 17:07:43 +0000
Subject: [PATCH v2 0/2] Add --no-filters option to git-add
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible for a user to disable attribute-based filtering when
committing by doing one of the following:

 * Create .git/info/attributes unapplying all possible transforming
   attributes.
 * Use git hash-object and git update-index to stage files manually.

Doing the former requires keeping an up-to-date list of all attributes which
can transform files when committing or checking out. Doing the latter is
difficult, error-prone and slow when done from scripts.

Instead, similarly to git hash-object, --no-filter can be added to git add
to enable temporarily disabling filtering in an easy to use way.

The use case here is mostly non-interactive use in scripts creating Git
trees that need to exactly correspond to a working directory regardless of
whether or not they have any .gitattributes files.

For example, for git-buildpackage or dgit, which facilitate Git workflows
with Debian packages, want to ensure the contents of the packages can be
exactly reproduced, which is difficult if the upstream’s tarball has
.gitattributes. It is possible to "defuse" the attributes as demonstrated
above, but this will break if the user modifies the .git/i/a file or if Git
adds more attribute-based conversions. This is what dgit currently does, and
this is what git-buildpackage will soon do too.

Of course, this patch set only addresses staging files. While working on a
patch to git-buildpackage to reproducibly import the contents of tarballs, I
realised that the only realistic way seem to do that is to use hash-object +
update-index manually, which is likely to come with a performance drop
compared to git add (which is what gbp currently uses). A workaround might
be to use Dulwich (which would allow to do hash-object without fork/exec) or
perhaps GitPython (which I haven’t really looked into), or maybe to use git
fast-import, but all of these alternatives are quite complex and don’t
guarantee the same performance.

Adding a new option to git add allows to keep the performance without having
to ensure attributes are set to the right values. The attributes will likely
have to be adjusted anyway for user’s convenience, but at least if they
modify them afterwards, the tools won’t break.

These patches:

 * Add new flag ADD_CACHE_RAW to add_to_index()
 * Add new flag HASH_RAW to index_fd()
 * Make git hash-object use the new HASH_RAW flag for consistency
 * Add tests for the new git-add option.
 * Update the git-add manpage describing the new option and pointing out
   it’s tricky to use.
 * Expand the relevant FAQ entry adding --no-filters as yet one more reason
   for perpetually modified files to appear.

Changes since v1:

 * Removed an extra space left in the option definition. Jessica Clarke on
   GitHub pointed out the inconsistent formatting, but contrary to the
   suggestion I updated the style to the more widespread variation: "(0,"
   occurs at least 689 times across the codebase, while "( 0" only at most
   23.
 * Expanded the option description to warn users about potentially confusing
   situations (pointed out by brian m. carlson)
 * Expanded the FAQ entry to mention the new option as one of the cause of
   perpetually modified files.

Andrej Shadura (2):
  add: add option --no-filters to disable attribute-based filtering
  hash-object: use the new HASH_RAW flag instead of setting path to NULL

 Documentation/git-add.txt | 10 ++++++++-
 Documentation/gitfaq.txt  |  7 ++++++
 builtin/add.c             |  3 +++
 builtin/hash-object.c     | 17 ++++++---------
 cache.h                   |  2 ++
 object-file.c             |  2 +-
 read-cache.c              |  3 +++
 t/t2205-add-no-filters.sh | 46 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 78 insertions(+), 12 deletions(-)
 create mode 100755 t/t2205-add-no-filters.sh


base-commit: 2283e0e9af55689215afa39c03beb2315ce18e83
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-880%2Fandrewshadura%2Fgit-add-no-filters-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-880/andrewshadura/git-add-no-filters-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/880

Range-diff vs v1:

 1:  cf8eb886a1e2 ! 1:  1d84503fff48 add: add option --no-filters to disable attribute-based filtering
     @@ Documentation/git-add.txt: for "git add --no-all <pathspec>...", i.e. ignored re
      +--no-filters::
      +	Add the contents as is, ignoring any input filter that would
      +	have been chosen by the attributes mechanism, including the end-of-line
     -+	conversion.
     ++	conversion. Note that this option is not intended for interactive use,
     ++	since files added this way will always show up as modified if Git were
     ++	to apply transformations to them, making the situation potentially
     ++	very confusing.
      +
       --chmod=(+|-)x::
       	Override the executable bit of the added files.  The executable
       	bit is only changed in the index, the files on disk are left
      
     + ## Documentation/gitfaq.txt ##
     +@@ Documentation/gitfaq.txt: following on an otherwise clean working tree:
     + ----
     + $ git add --renormalize .
     + ----
     +++
     ++Another situation where perpetually modified may appear on any platform is when
     ++a file has been committed without running any filters (including the end-of-line
     ++conversion), but the `.gitattributes` file states that this file requires a
     ++conversion.  In this case, you can either renormalize the files if this happened
     ++by mistake, or modify `.gitattributes` or `$GIT_DIR/info/attributes` as described
     ++above to exempt the file from the conversion if this was intentional.
     + 
     + [[recommended-storage-settings]]
     + What's the recommended way to store files in Git?::
     +
       ## builtin/add.c ##
      @@ builtin/add.c: static const char * const builtin_add_usage[] = {
       static int patch_interactive, add_interactive, edit_interactive;
 2:  0e113e958b35 ! 2:  810d4005fe8f hash-object: use the new HASH_RAW flag instead of setting path to NULL
     @@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const ch
       		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
       		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
      -		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
     -+		OPT_BIT(0 , "no-filters", &flags, N_("store file as is without filters"),
     ++		OPT_BIT(0, "no-filters", &flags, N_("store file as is without filters"),
      +			HASH_RAW),
       		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
       		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),

-- 
gitgitgadget
