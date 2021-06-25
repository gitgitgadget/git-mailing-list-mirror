Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC8C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8207161963
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFYQEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYQEt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D94C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g7so6516149wri.7
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=THF6e1x/5jhz9LwJJKu9bxsDIsacwLUN6rcqg+xeuns=;
        b=aAaiLvc+okoT+w5L3hfOTo85r28VI1yYVTqygH5u0edOOFTa2PYmgtpKT9STa/T/2J
         pUb/73vEqJouXN0cNg9NBXhGpztruJ1XEOpHbz4yJOVJpq4hJnP6cj2+WeKwTbvQNsC4
         Qb1IYwlY2ExWUHKG9Hy36pK1uzNBAz7tQwx4Mz6vH/lL4Gztkt8tAZMb/RllKPnJk4G/
         BuqldrUmSlzXacZld8582c4472Ba8VT7Z7uyUDaQfdRYkDgRc+W4h0Z2+qlj7GLRiWDV
         jr+k8RKWhyLmYBmo92NAID2txdFmIB+cFgU2TGpkModd/D5MeYIs/JPe6gYTmBffTFU1
         kpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=THF6e1x/5jhz9LwJJKu9bxsDIsacwLUN6rcqg+xeuns=;
        b=EWCdH0fUDrsXUgjWan9x46pFPj0uBEeT9SFElwsxu/7CmW/l5n2uvomSMMkw5f3XJH
         9pn0hGSuWAq46XaOnL2NYHwgY/AZVtDFOQY8w08FCt7W4dMnI1C/kV18d/gjiuqQfXgy
         PlSr5YakclIHtCZVOn8TuAXSTXpxEKUT0hbUYwdPZyKAY9rMI17A5APRt+O/PNwbcdvT
         3c6RHBWToUs+9oZYQIycBPSLdgXR8LmvJsAC1eI2tL88ZyCvCiCXFN7Bfbus09+do6S2
         BJ7A3R+bcYEnB3JE3ifuZkuIflynIOxoSg8TlgEogz6QL8R4mTOTQ3xHCr+GQvkRpquR
         DjdQ==
X-Gm-Message-State: AOAM530xcidk4mDIT3TPNPHrKYOWs2+kgphIf+Tl7b7UWy7S576CvGRk
        IqJd7isACxWJuNHHEWYbrGbRv1BBoR4=
X-Google-Smtp-Source: ABdhPJyDp7BEUliJTK/UoP6iYuRZTusey/Gz3D8TS2CDT/RQHZoB5C2q0vS6zLprakVXW+z7NViWRQ==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr12040520wrm.298.1624636947000;
        Fri, 25 Jun 2021 09:02:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm6280431wrs.64.2021.06.25.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:26 -0700 (PDT)
Message-Id: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:10 +0000
Subject: [PATCH v5 00/15] [GSOC][RFC] cat-file: reuse ref-filter logic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series make cat-file reuse ref-filter logic.

Change from last version:

 1. At the suggestion of Bagas Sanjaya, modified the expression of submitted
    information.
 2. Remove grab_oid() function in ref-filter to reduce repeated checks.

ZheNing Hu (15):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] ref-filter: add cat_file_mode in struct ref_format
  [GSOC] ref-filter: modify the error message and value in get_object
  [GSOC] cat-file: add has_object_file() check
  [GSOC] cat-file: change batch_objects parameter name
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options
  [GSOC] ref-filter: remove grab_oid() function

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 277 ++++++----------------
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 357 ++++++++++++++++++++++-------
 ref-filter.h                       |  14 +-
 t/t1006-cat-file.sh                | 252 ++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 +++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 14 files changed, 888 insertions(+), 296 deletions(-)


base-commit: 1197f1a46360d3ae96bd9c15908a3a6f8e562207
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-980%2Fadlternative%2Fcat-file-batch-refactor-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-980/adlternative/cat-file-batch-refactor-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/980

Range-diff vs v4:

  1:  f72ad9cc5e8 =  1:  f72ad9cc5e8 [GSOC] ref-filter: add obj-type check in grab contents
  2:  ab497d66c11 !  2:  4e473838b9d [GSOC] ref-filter: add %(raw) atom
     @@ Commit message
          can help us add raw object data to the buffer or compare two buffers
          which contain raw object data.
      
     -    Beyond, `--format=%(raw)` cannot be used with `--python`, `--shell`,
     -    `--tcl`, `--perl` because if our binary raw data is passed to a
     -    variable in the host language, the host language may not support
     -    arbitrary binary data in the variables of its string type.
     +    Note that `--format=%(raw)` cannot be used with `--python`, `--shell`,
     +    `--tcl`, and `--perl` because if the binary raw data is passed to a
     +    variable in such languages, these may not support arbitrary binary data
     +    in their string variable type.
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
  3:  b54dbc431e0 =  3:  765cf08a108 [GSOC] ref-filter: --format=%(raw) re-support --perl
  4:  9fbbb3c492f =  4:  d2aeafd0ef3 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  5:  08aa44e5e57 =  5:  1ca3a42f041 [GSOC] ref-filter: add %(rest) atom
  6:  05682bccf9f !  6:  67f1a3cca9a [GSOC] ref-filter: pass get_object() return value to their callers
     @@ Metadata
       ## Commit message ##
          [GSOC] ref-filter: pass get_object() return value to their callers
      
     -    Since in the refactor of `git cat-file --batch` later,
     +    Because in the refactor of `git cat-file --batch` later,
          oid_object_info_extended() in get_object() will be used to obtain
          the info of an object with it's oid. When the object cannot be
          obtained in the git repository, `cat-file --batch` expects to output
  7:  06db6cd6f1f =  7:  2a48a48e81c [GSOC] ref-filter: introduce free_ref_array_item_value() function
  8:  b0d9e139935 =  8:  be55005be75 [GSOC] ref-filter: add cat_file_mode in struct ref_format
  9:  db7dd8b042c =  9:  937f88b7837 [GSOC] ref-filter: modify the error message and value in get_object
 10:  6b577969734 = 10:  45657499c55 [GSOC] cat-file: add has_object_file() check
 11:  069aa203666 ! 11:  bf5c0a017ad [GSOC] cat-file: change batch_objects parameter name
     @@ Metadata
       ## Commit message ##
          [GSOC] cat-file: change batch_objects parameter name
      
     -    Since cat-file reuses ref-filter logic later will add the
     -    formal parameter "const struct option *options" to
     -    batch_objects(), the two synonymous parameters of "opt"
     -    and "options" may confuse readers, so change batch_options
     -    parameter of batch_objects() from "opt" to "batch".
     +    Because later cat-file reuses ref-filter logic that will add
     +    parameter "const struct option *options" to batch_objects(),
     +    the two synonymous parameters of "opt" and "options" may
     +    confuse readers, so change batch_options parameter of
     +    batch_objects() from "opt" to "batch".
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
 12:  258ec0a46c5 = 12:  370101ba65f [GSOC] cat-file: reuse ref-filter logic
 13:  bda6aae9a6c = 13:  69eef47065d [GSOC] cat-file: reuse err buf in batch_object_write()
 14:  d1114a2bd74 = 14:  a7ac037a946 [GSOC] cat-file: re-implement --textconv, --filters options
  -:  ----------- > 15:  843de8864a9 [GSOC] ref-filter: remove grab_oid() function

-- 
gitgitgadget
