Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D54C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9A022400
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 15:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg5+4URg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773336AbgJZPuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:50:32 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:45997 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772231AbgJZPub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 11:50:31 -0400
Received: by mail-oi1-f172.google.com with SMTP id j7so10916781oie.12
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIYP9iVd1kH2Kc1bRJCBLYZ7ju/XAjgQv13wAMrYlR4=;
        b=dg5+4URgwxj4W4Rp4+o9PSSLrZl288cYvuX2zQRWXW6tysmDNg6QXsFfRfORuV3BUZ
         wUNHLj1z1nvnhHt86rR5FSrMtztW1qXvWzLBcVByDQVJem0H04lI3xx1rLl617u7vfQG
         bU3XDHbYlglHh8mGCV0grDms3bL+ujxVyV+4qLzN3WFVA1wqxaSis64N1WVCfnNlodRY
         6/YVjG2VgjakQvOIydp9/y51hqk4imoxRNrzeJArGxvMd1UT6P38lHBr56UAfDXHptYF
         WUoJhe3Q8/rF8ws/t1hlY2YNtmB7FL6Q0TRKAohcDTkZXNBsi3fvWSu4gknJWMr1JAz+
         fSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIYP9iVd1kH2Kc1bRJCBLYZ7ju/XAjgQv13wAMrYlR4=;
        b=rMQWIsrI4N+Qkj8ACPaYCLIH4WN+jJR08HzUunDB4FbmvVKapCdl+5h7uWWFnyQv2G
         +6bvSq1yKAJARIGni79iziTl40VMbmZbQMauEnkZs3WqAOEi6Z8Tr1E69kOnrC8ecWso
         Ql0lHxCieKrmM3oa+kjLXs8gN3WFA/Im/Zn+G0437hZ8OIKuJL17NFOh4Hm9Icqx288l
         xBCzkI2KyyfLN2LEXYADnBerd3JYI9W51BM/QmW4iiL6J6tuhGApxrZlBx3TWi5SuRrk
         DDr61AOf1XHwyTm178gjm7KE27bdju81CTvjZY+IvYlBNbL5Qg9pYY6Gwl5L072UH9vq
         6RDQ==
X-Gm-Message-State: AOAM531lLMetICMFj8Ve1zb/p+DNZ9OXLS/CMCxhSc15WEnLuih7ImQr
        sB3D1lxCImKWv0ZSEk+WAxos32lYlQ8H32DA/Wc=
X-Google-Smtp-Source: ABdhPJxOZ9AfFQ/ZwpeQG2aO5e6qNaiC8A9EDTQ3dFAQTDD/xdNNayUl9FBoe9uVAVwpBRrlnwLryTZTXz8y8FFyVtQ=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr14556404oia.167.1603727430268;
 Mon, 26 Oct 2020 08:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <120922f1-67a9-9ae2-2e9c-56e20935e0f9@gmail.com>
In-Reply-To: <120922f1-67a9-9ae2-2e9c-56e20935e0f9@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Oct 2020 08:50:19 -0700
Message-ID: <CABPp-BFju3vJYMRH8fXBcHu1sDkthWsdO9rJzSNKB7E3pfGiHQ@mail.gmail.com>
Subject: Re: Tracking a merge bug
To:     Ephrim Khong <dr.khong@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 8:11 AM Ephrim Khong <dr.khong@gmail.com> wrote:
>
> Dear All,
>
> I am trying to find the root cause for what I believe might be a strange
> bug in git merge.  I have a feature branch A which branched off master
> not too long ago, and want to bring it up to date with master:
>
>     git checkout A
>     git merge master
>
> which yields
>
>     Removing somefile
>     Removing anotherfile
>     error: add_cacheinfo failed to refresh for path 'c/d/e.sh'; merge
> aborting.

"add_cacheinfo failed to refresh"?  Wow, that's a new one.  Some years
back we had a "add_cacheinfo failed for path" corresponding to the
other error site within that function, but we fixed that one up long
ago.  I've never seen anything hit the refresh failure.

The fact that you're seeing this error message means you're using git
>= 2.18.0.  Could you verify the exact version?

Also, I suspect "somefile" and "anotherfile" are placeholders.  Any
chance we could see the real names?

> the offending file, c/d/e.sh, does not exist in my feature branch but
> was added to master since branching off. After aborting, the working
> directory is in an inconsistent state and c/d/e.sh exists with the
> correct content.

Is c/d a file or submodule or anything in the feature branch?  Do you
have any untracked files at the beginning of the merge named c/d or
c/d/e.sh?  I'm trying to guess at what might be weird about the paths
here.

> Below is a stacktrace - the merger handles the file as a rename
> (apparently there is a similar / identical file 'c/f/g.sh' that is
> renamed to 'c/d/e.sh'), but that fails because the file has MODE_CHANGED
> set. (Which appears strange - at the time where the merge is aborting,
> the file apparently was already written to the working directory. Is it
> renaming two different files to the same target file?).

What's the output of
  git ls-tree -r master | grep c/d/e.sh
  git ls-tree -r feature | grep c/d/f.sh
  git ls-tree -r $(git merge-base master feature) | grep c/d/f.sh
?

And, before the merge, what is the output of
  ls -l c/d/e.sh c/d/f.sh
?

> Any hint is appreciated, especially where to look: Is the root cause
> more likely to be at the filesystem level (the stat returns something
> off), or in the merge logic? What else could be wrong here?

Not sure; I've never hit this before.  I'm curious if you've got a
weird mode recorded for one of the files in your tree or something.
We might have to get someone who understands the index data structure
and read-cache.c to take a look.

> The stacktrace looks roughly as follows:
>
> -> read-cache.c, ie_modified(): ie_match_stat returned 63, which is
>                 MTIME_CHANGED   | CTIME_CHANGED | OWNER_CHANGED |
>                 MODE_CHANGED | INODE_CHANGED | DATA_CHANGED
>         and is_modified() returns 63 because MODE_CHANGED is set.
>
> -> read-cache.c, refresh_cache_ent(): at the call to ie_modified
>
> -> read-cache.c, refresh_cache_entry()
>
> -> merge-recursive.c, add_cacheinfo(), is in the refresh-path (i.e.
> make_cache_entry() worked, but refresh_cache_entry() will fail)
>
> -> merge-recursive.c, update_file_flags(), after the update_index: label
>
> -> merge-recursive.c, update_file()
>
> -> merge-recursive.c, handle_content_merge() is in the very last
> update_file() call, close to the end of the function
>
> -> merge-recursive.c, handle_rename_normal()
>
> -> merge-recursive.c, process_entry()
>         is in the RENAME_NORMAL / RENAME_ONE_FILE_TO_ONE block

RENAME_NORMAL / RENAME_ONE_FILE_TO_ONE means this is NOT a case of
renaming two files to one.  From just this information, it could be
that both sides renamed c/d/f.sh -> c/d/e.sh -- but you ruled that out
when you said c/d/e.sh didn't exist in your branch.  So, that
basically leaves us with a normal rename; i.e. c/d/f.sh existed in the
merge base and in your feature branch, but it was renamed to c/d/e.sh
in master.


Any chance this repository is available for others to access to try to
reproduce the problem?  If the repository has sensitive contents, are
the files c/d/f.sh and c/d/e.sh sensitive?  If the repository overall
is sensitive but those two files aren't, we might be able to get a
reproduction by cloning the repository and running
   git filter-repo --path c/d/e.sh --path c/d/f.sh
to filter the repository down to just these two files (after first
installing git-filter-repo; see
https://github.com/newren/git-filter-repo).
