Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE86FC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC562173E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 18:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUNtYDRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgA3Swf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:52:35 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37185 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgA3Swc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 13:52:32 -0500
Received: by mail-oi1-f171.google.com with SMTP id q84so4628001oic.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jU7bh4O7KE7iVLkihf74RkJBpkjaErwKYX5h/HnPe58=;
        b=jUNtYDRj+1Ngrgsf1fhu5wEeo+aUHldByDyShdhqZ1CXYKzXpS6BQrkGdvQtZTZetZ
         yFmVTYqOZQWbHus+oAuv6qMVyq+fXLJVrOGWxM0C74MVjEpW3R7ESubgo6Sy5VOUso2K
         djRO9DaU8iazaeGceAxLVn5298OmINWL3ckIKbY6il9r2KMVEV8RZjJCp18ulMJPDY+5
         hvYO1m55KOjHS6wsbcv6KDzo75HMmk1ntsXroFjG02VTcJDsUBqjm7YRbKUELBsH8crV
         WPlPG5lIXQ29S5iKMTq9uBz0an8TKy6MVixW3uo8YyXFM/uUjgR5/KAuIUS51wVf1+uL
         Wv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jU7bh4O7KE7iVLkihf74RkJBpkjaErwKYX5h/HnPe58=;
        b=EErZXYC0E5p8oodq3jJksPILjzlz1qJkC57TFyXNlMvjdsvZd2CbBO4EKPRgonjklA
         iat+AR3mxrneaCjK7y4CFc3vxmYQBBGbaUiEPl1xBanfTB8enACA/Jv7w17ty8ZsvQwf
         brf/OzJIYBr1et1EaDbz9+EF3nXRKTVOa5eQFqhXjbHvp9B3TnIjOjVFdAHYoo8+4mCz
         H3Nq66b0oW2Vt/CVM/Yp5pLmUGhg5KkMchG9aqCk9u8oIsntmpQQdRFzvp0xlDF4o5yj
         UAaHVvRuOqLx/XPNalOR6BLtVll6aGU6y6Mpsml9XenzSg99Pzyf//Zb/wfgDfRu7+73
         VMpw==
X-Gm-Message-State: APjAAAUzAw0/Ow2LQuBs3txjh2GO/osfJWwslY9rn6l3Wc0FWuSdJexI
        Bnag9TgRq5Wg4GMRjWGzxcU=
X-Google-Smtp-Source: APXvYqztGoMmXaRiloWZ8C/A5smN923DQwKTxzt8cYpaPMv77d0oaTLydD5oaT3OlAv/MZ9XexEEfA==
X-Received: by 2002:a9d:da2:: with SMTP id 31mr4557204ots.319.1580410351217;
        Thu, 30 Jan 2020 10:52:31 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f22sm2096183otf.50.2020.01.30.10.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:52:30 -0800 (PST)
Subject: Re: Sparse checkout inconsistency with non-folder paths between cone
 mode and full matching (2.5.0)
To:     finnbryant@gmail.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ef39f8c5-ce0b-a48b-940d-821df563b292@gmail.com>
Date:   Thu, 30 Jan 2020 13:52:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <CADSBhNbbO=aq-Oo2MpzDMN2VAX4m6f9Jb-eCtVVX1NfWKE9zJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 10:25 AM, Finn Bryant wrote:
> Hi,

Hello! Thanks for chiming in with feedback.

> With cone mode enabled for a sparse checkout, a pattern like the
> following is accepted:
> 
> /*
> !/*/
> /a_file_or_folder/

As you mention below, you say this path is a file OR a directory.
However, the trailing slash means _only_ match directories with this
name. This is a specific choice made in creating cone mode to restrict
only by directories.

> My suspicion is that cone mode is supposed to be a pure subset of full
> pattern matching, such that if cone mode is ever disabled, the
> sparseness of the worktree will be unchanged. Clearly, this scenario
> is breaking that pattern.

By "pure subset" you must mean "strict subset". Cone mode is definitely
a smaller set of patterns.

> I think the correct behaviour is that recursive matches for a
> potential directory do not have any effect on a non-directory file
> with the same name. Alternatively, you could forbid any patterns which
> match non-directory files instead (and downgrade to full pattern
> matching), though I'd not be a fan of this, since it'd mean the
> validity of a cone-mode sparse configuration file is dependent on the
> contents of the repo, and is thus much harder to ascertain (scripts
> can't simply prove if it's a valid cone mode file by parsing it,
> they'd need to have access to any repo it may be applied to, and
> inspect the type of any matching file/folder paths, and its validity
> could be changed simply by replacing a folder with a file in the
> repo).
> 
> If matching behaviour with full pattern mode is a non-goal for cone
> mode, I'd still question the logic of this behaviour, though I suppose
> it does have the benefit of (accidentally?) adding support for
> excluding individual files from a sparse checkout, which I imagine
> some could find useful. Personally I'd prefer that was instead added
> with a more sane syntax, if needed.

Cone mode is specifically designed for performance using a hashset-based
pattern matching. This naturally restricts the possible patterns since
we cannot match the full pattern set [1] this quickly. This means there
are some trade-offs that are required, but they were made with some
information of real-world repositories organized in a way that they
could take advantage of this pattern set.

[1] https://git-scm.com/docs/gitignore#_pattern_format
 
> $ git sparse-checkout init --cone
> $ git read-tree -mu HEAD
> $ ls -1
> a_file_or_folder
> some_file
> $ git sparse-checkout set a_file_or_folder
> $ git read-tree -mu HEAD
> $ ls -1
> some_file
> $ cat .git/info/sparse-checkout
> /*
> !/*/
> /a_file_or_folder/

This is an interesting test, because I would expect the /a_file_or_folder/
pattern to not cause the _file_ to not match. It does match the first two
patterns, and just because it doesn't match the third pattern shouldn't
remove it.

This is actually a bug in the hashset-based pattern-matching algorithm,
since setting core.sparseCheckoutCone=false does not have this behavior.
I'll make a patch to fix this.

> Right now I'm trying to integrate cone mode with my company's existing
> manifest infrastructure, which doesn't differentiate between files and
> folders, so this is forcing me to perform a lot of repo checks to
> confirm we aren't accidentally excluding files we were supposed to
> include. Just in case you needed another example of why this behaviour
> is unhelpful.

I apologize that this wrong behavior is causing you some issues. If you
are able to identify which paths are files instead of directories, then
you can remove the filename from the path to include its parent directory.
This is only a workaround until the bug is fixed, but the end-result will
be the same: you'll have all sibling files in your working directory as
well as the files you specified.

This is important: if you have a directory with many large files, but
intend to include only a subset of those files, then you will be
disappointed by the size of your working directory.

This requirement of specifying directories instead of files is part
of the cone mode design for two reasons: one philosophical and another
more practical:

Philisophical: Filenames change more often than directories.

That is, as users are interacting with your repo, the overall directory
structure at a high level is typically static. If new cross-component
dependencies are introduced, then those are usually big architecture-level
changes. However, at an individual file level dependencies change at
a higher rate, causing users to react by changing their sparse-checkout
definition more frequently.

Practical: How do we specify if an input is a directory or a file?

As you mentioned, if you run "git sparse-checkout set X" then you get
a sparse-checkout file containing:

	/*
	!/*/
	/X/

But if X is actually a _file_, then we should write this pattern:

	/*
	!/*/
	/X

So the input does not provide enough information to say which pattern
should be written.

The other concern about this second set of patterns is that "/X" is
only a _prefix_ match, not an exact path name match. That means we
cannot use the existing hashset matching to result in the same
pattern matching as non-cone-mode.

Now, there is perhaps a way to decide between the two: inspect the
current index or tree for whether the input corresponds to a directory
or a file. This adds a layer of complexity that is not currently in
the sparse-checkout builtin, but it is not insurmountable. The only
thing to consider is what happens when the input path is not in the
index/tree at all! It may be that we want to specify the patterns
before moving HEAD to a commit that _does_ contain the path, and then
we would do the wrong thing at this point.

So I'll put out a question to the community: is this practical issue
something worth overcoming? Is my concern about a non-existent path
a true problem, or something more?

Thanks,
-Stolee


