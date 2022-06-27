Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41483C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiF0SUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiF0SU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:20:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291EFEE26
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:20:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s131-20020a254589000000b0066cb1230608so3545989yba.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=QS9UD9fxEyn79A/M2iTECtIvyooDA8Tn8t9nkMqLfSY=;
        b=KJ5oO9zeVwgeupmMcPaONx+BYbJLJVmViDTmvq1eM/T9yXjAzzXJsHY6Ec1thfXCof
         VXzlYQernyGpGvD3IWeM3MJXcOKyvEhSqN6pRCnYHx9TBDATpcOZ5q3BL6UHUKaKpj1W
         0YHztj4+RvbZkS9sULr1X/QDgUM4+rgR+ErQBCndQIY1HGnodggU6LcTVIzs8KQTh0ne
         ohNs6GmYOaOvRwdgZJThTIdtel38cwZ2FBR4UwgkiDnl1MdpGG0TEPtBUFeA77Q9eTrn
         qZ+FvzOKOHGRjneR6YWIkFqWSQlOS5lJow4G/0R9H9XLlkrQBOHXvNBfvvADo9Bi0nO/
         6TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=QS9UD9fxEyn79A/M2iTECtIvyooDA8Tn8t9nkMqLfSY=;
        b=hdua99zRq2j5x5GdnsA5z+Nx7XGawNYhVoLMe2+ZJm4/SYroaRq6bBQYc4nVSliY40
         30Ob64FFgBqQB9cY7h5/yjxhSTMWW08SNY4e8JBq8EWeBdzWcXoM4/qQfJKznCIzGIrg
         YpIGnatvOcMSMkwsG/n9/0htC0+leipRzh+CWZ6s9yQrnoq+2pVHxi9APNG9FQLMoXFL
         J+v7twN6/TcDtUWT+g77wMYFZkVy1Uls7vkAZOCyHnOpMp2qYcX9IYYJRjlxniOWYUXr
         TXEZskTHdDMO0dDI6l0HHRXvrekEb+yqm2J7ZrVPLwauFXxY7QP1lFTGMETQC3bqwDTE
         mgKg==
X-Gm-Message-State: AJIora88j7a0Xcziu0eaUjseQ4wlj4A3Pm8Nw4WrZsvtXQxEHoUZ0ALR
        3gc3jzoIHJ62FB6FaZ4QSBvWIHboIwg+yBdBFJ47
X-Google-Smtp-Source: AGRyM1spZdUvL8qyimOYoULdlDmq1FSsp3ciKCnBHYZQsjlMEBu1cB4f2auByxHxJoppBgXohnRCmlcg1ww6M80EyCev
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:134e:b0:66c:8d89:6fd with
 SMTP id g14-20020a056902134e00b0066c8d8906fdmr13488567ybu.199.1656354027417;
 Mon, 27 Jun 2022 11:20:27 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:20:23 -0700
In-Reply-To: <69d6204184363e491acb68f744ded0991be63a47.1655871652.git.gitgitgadget@gmail.com>
Message-Id: <20220627182024.1358144-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH 1/3] t6423: add tests of dual directory rename plus
 add/add conflict
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
> 
> This is an attempt at minimalizing a testcase reported by Glen Choo
> with tensorflow where merge-ort would report an assertion failure:
> 
>     Assertion failed: (ci->filemask == 2 || ci->filemask == 4), function apply_directory_rename_modifications, file merge-ort.c, line 2410

First of all, thanks for this fix - I've verified with Glen Choo's test
cases and it does fix it.

> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
> index 479db32cd62..296c04f8046 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -5199,6 +5199,108 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
>  	)
>  '
>  
> +# Testcase 12l, Both sides rename a directory into the other side, both add
> +#   a file with after directory renames are the same filename
> +#   Commit O: sub1/file,                 sub2/other
> +#   Commit A: sub3/file,                 sub2/{other, new_add_add_file_1}
> +#   Commit B: sub1/{file, newfile}, sub1/sub2/{other, new_add_add_file_2}
> +#
> +#   In words:
> +#     A: sub1/ -> sub3/, add sub2/new_add_add_file_1
> +#     B: sub2/ -> sub1/sub2, add sub1/newfile, add sub1/sub2/new_add_add_file_2
> +#
> +#   Expected: sub3/{file, newfile, sub2/other}
> +#             CONFLICT (add/add): sub3/sub2/new_add_add_file

The "expected" might need to be updated. After all patches are applied,
this is the tree I get (note that it's "sub1/sub2/new_add_add_file, not
"sub3/sub2/new_add_add_file"):

  .
  |-- sub1
  |   `-- sub2
  |       `-- new_add_add_file
  `-- sub3
      |-- file
      |-- newfile
      `-- sub2
          `-- other

Also, at first glance, "newfile" shouldn't belong in a minimal
reproduction, but it somehow changes the output. When I apply this diff
(to the state after all patches are applied):

  diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
  index 4286ae987c..9472fb7233 100755
  --- a/t/t6423-merge-rename-directories.sh
  +++ b/t/t6423-merge-rename-directories.sh
  @@ -5237,7 +5237,6 @@ test_setup_12l () {
   
                  git checkout B &&
                  echo dissimilar >sub2/new_add_add_file &&
  -               echo brand >sub1/newfile &&
                  git add sub1 sub2 &&
                  git mv sub2 sub1 &&
                  test_tick &&
  @@ -5255,14 +5254,14 @@ test_expect_merge_algorithm failure success '12l (B into A): Rename into each ot
                  test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 &&
   
                  git ls-files -s >out &&
  -               test_line_count = 5 out &&
  +               test_line_count = 4 out &&
   
                  git rev-parse >actual \
  -                       :0:sub3/file :0:sub3/newfile :0:sub3/sub2/other \
  +                       :0:sub3/file :0:sub3/sub2/other \
                          :2:sub1/sub2/new_add_add_file \
                          :3:sub1/sub2/new_add_add_file &&
                  git rev-parse >expect \
  -                       O:sub1/file  B:sub1/newfile O:sub2/other \
  +                       O:sub1/file  O:sub2/other \
                          A:sub2/new_add_add_file \
                          B:sub1/sub2/new_add_add_file &&
                  test_cmp expect actual &&

I get:

  .
  |-- sub1
  |   `-- sub2
  |       |-- new_add_add_file
  |       `-- other
  `-- sub3
      `-- file

(Note the path to "other".) I haven't figured out what's going on,
though.
