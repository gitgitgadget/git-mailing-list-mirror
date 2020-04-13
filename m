Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D82C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5313720732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 15:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML5vfkiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgDMP0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgDMP0E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 11:26:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13BBC0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:26:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m12so12418606edl.12
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5pXEZsTitKKDlz6P3zzQIbQ0ooN9HQNUsTQDtxpAe34=;
        b=ML5vfkiBYbiIJUaC+iBPGMYxE82uPU4CdOZK8G88MZDoAGvSkTvWALmIa20M5mzn44
         FBurtqLLpBm/0zqSIA8c/yOsG7QCnra2ZpMgc+lsbC6V63ZOpJog86ArAOJRIreT53AL
         i5ExS1S6aRspuYJpRca6UnzUSc3JSp9E/Xc6W3NETm3jZEFii2hLbcrLLpSeUUYmXvGQ
         mZZhtpVoMlwy5V2zBDzJH9AIDljg807H+FEcNQRUcidiPC3vKSkz0KroTIKj1+NCk+1A
         5DjEQsWpF44zmALuckefswzYVIAntVx9qojk2CA0nIqCKs+3TQUy6lFN/jZYgAyRclUZ
         8B0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5pXEZsTitKKDlz6P3zzQIbQ0ooN9HQNUsTQDtxpAe34=;
        b=idJekiwhuFyNRi9ankhSm+ypVcjnFwTmfssyhvneQzyDQ5Rd3euj+101RIeg2UTuxS
         DipFZOaba05IWLwlRj8hwS3IvYxefHl1qWYCzndE6w/8WtIl5GyMUgakRFjjQRSgpB1C
         o3YocEk27XUt5aquhB1GMqIrxGryxsKkbMBMf6piBWclroTrT3sYiNbPZ6bQYzQciril
         D95QUtNASCHj8mSHmXlxOjmr6nkkDmupRO91Rg3LJpkYclqK1GLYvraJkr98XRhSDXWm
         mBsfoh62USIp9/CHN5l9t/EqUoy1G4vlNm3RxieIV9pL1P3dD9V1NROHYwpzgdflqXzF
         DI6Q==
X-Gm-Message-State: AGi0PuZBVO9kaqGBAcxtWl73ZS4UxAEa19BqbSIlqrkxvHWVw9nWUsjV
        1Mlb6bbsF7IaPSTvmGlErUazzk5h
X-Google-Smtp-Source: APiQypIadqXkZyklHxWLvgwQJHib1kzVKNz+iO0EVvGAR/JgycI2plH0oXMLq2q4IJ2OvMIS5EsCLw==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr16190855edv.344.1586791562043;
        Mon, 13 Apr 2020 08:26:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm102572edq.16.2020.04.13.08.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 08:26:01 -0700 (PDT)
Message-Id: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
From:   "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 15:25:57 +0000
Subject: [PATCH v2 0/3] clone: document partial clone section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Partial clones are created using 'git clone', but there is no related help
information in the git-clone documentation during a period. Add a relevant
section to help users understand what partial clones are and how they differ
from normal clones.

The section briefly introduces the applicable scenarios and some precautions
of partial clone. If users want to know more about its technical design and
other details, users can view the link of git-partial-clone(7) according to
the guidelines in the section.

Derrick Stolee (2):
  partial-clone: set default filter with --partial
  clone: document --partial and --filter options

Dyrone Teng (1):
  clone: document partial clone section

 Documentation/git-clone.txt   | 87 ++++++++++++++++++++++++++++++++++-
 list-objects-filter-options.c | 18 ++++++++
 list-objects-filter-options.h |  8 +++-
 t/t5616-partial-clone.sh      | 42 +++++++++++++----
 4 files changed, 143 insertions(+), 12 deletions(-)


base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v2
Pull-Request: https://github.com/git/git/pull/745

Range-diff vs v1:

 -:  ----------- > 1:  6f340d9aadf partial-clone: set default filter with --partial
 -:  ----------- > 2:  9baf4c8ba38 clone: document --partial and --filter options
 1:  f063efa545b ! 3:  c1a44a35095 clone: document partial clone section
     @@ Commit message
          clone: document partial clone section
      
          Partial clones are created using 'git clone', but there is no related
     -    help information in the git-clone documentation during a period. Add
     -    a relevant section to help users understand what partial clones are
     -    and how they differ from normal clones.
     +    help information in the git-clone documentation. Add a relevant section
     +    to help users understand what partial clones are and how they differ
     +    from normal clones.
      
          The section briefly introduces the applicable scenarios and some
          precautions of partial clone. If users want to know more about its
          technical design and other details, users can view the link of
          git-partial-clone(7) according to the guidelines in the section.
      
     -    Signed-off-by: Teng Long <dyroneteng@gmail.com>
     +    Signed-off-by: Dyrone Teng <dyroneteng@gmail.com>
      
       ## Documentation/git-clone.txt ##
      @@ Documentation/git-clone.txt: or `--mirror` is given)
     @@ Documentation/git-clone.txt: or `--mirror` is given)
      +-------------
      +
      +By default, `git clone` will download every reachable object, including
     -+every version of every file in the history of the repository. The **partial clone**
     -+feature allows Git to transfer fewer objects and request them from the
     -+remote only when they are needed, so some reachable objects can be
     -+omitted from the initial `git clone` and subsequent `git fetch`
     -+operations. In this way, a partial clone can reduce the network traffic
     -+costs and disk space usage when git is working under a large repository.
     ++every version of every file in the history of the repository. The
     ++**partial clone** feature allows Git to transfer fewer objects and
     ++request them from the remote only when they are needed, so some
     ++reachable objects can be omitted from the initial `git clone` and
     ++subsequent `git fetch` operations.
      +
      +To use the partial clone feature, you can run `git clone` with the 
     -+`--filter=<filter-spec>` option. If the repository has a deep history
     -+and you don't want to download any blobs, the form `filter=blob:none`
     -+will omit all the blobs. If the repository has some large blobs and you
     -+want to prevent some large blobs being downloaded by an appropriate
     -+threshold, the form `--filter=blob:limit=<n>[kmg]` omits blobs larger
     -+than n bytes or units (see linkgit:git-rev-list[1]).
     ++`--filter=<filter-spec>` option. If you want to clone a repository
     ++without download any blobs, the form `filter=blob:none` will omit all
     ++the blobs. If the repository has some large blobs and you want to
     ++prevent some large blobs being downloaded by an appropriate threshold,
     ++the form `--filter=blob:limit=<n>[kmg]`omits blobs larger than n bytes
     ++or units (see linkgit:git-rev-list[1]).
      +
     -+When using a partial clone, Git will request missing objects from the
     -+remote(s) when necessary. Several commands that do not involve a request
     -+over a network may now trigger these requests.
     ++As mentioned before, a partially cloned repository may have to request
     ++the missing objects when they are needed. So some 'local' commands may
     ++fail without a network connection to the remote repository.
      +
      +For example, The <repository> contains two branches which names 'master'
      +and 'topic. Then, we clone the repository by
     @@ Documentation/git-clone.txt: or `--mirror` is given)
      +were downloaded previously.
      +
      +`git log` may also make a surprise with partial clones. `git log
     -+--<path>` will not cause downloads with the blob filters, because it's
     -+only reading commits. `git log -p -- <path>` will download blobs to
     -+generate the patch output and git log --raw will download all blobs
     -+that changed at recent commits in order to compute renames.
     ++-- <pathspec>` will not cause downloads with the blob filters, because
     ++it's only reading commits and trees. In addition to any options that
     ++require git to look at the contents of blobs, like "-p" and "--stat"
     ++, options that cause git to report pathnames, like "--summary" and
     ++"--raw", will trigger lazy/on-demand fetching of blobs, as they are
     ++needed to detect inexact renames.
     ++
     ++linkgit:partial-clone[1]
      +
       :git-clone: 1
       include::urls.txt[]

-- 
gitgitgadget
