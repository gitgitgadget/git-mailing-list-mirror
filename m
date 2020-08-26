Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A26CC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A232080C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMSnn0vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgHZL5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgHZL45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 07:56:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F6C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:56:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t2so1478495wma.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7lDROWz4PAGQhag4J5HjOqKix+Be3yOLacIp4LAcLQU=;
        b=BMSnn0vEgUT+5RDxyy3+2v/XWlnOKOg8Xy2IdzDW68wp09lZdNddWquS+4uEHPikQ/
         8eLoC9tycbujx21W8Q5Q3cKWnTaEnRZ1ZvuKjmZH0/nbvPTV/rmf+N8C0ow/9JcZiH73
         fNHgNUYOj2n3yNNJRTnb10qh4spLTtMj0bhNKizpg4zUBIKlvb2dr61n2nCOyzfAf/ue
         SPvC+oAArGcoTceHKUJeVxO5QJL3MW5304p5WsDanfl7XCnCGlIOuBIbTF3REqlO1iTj
         qhT8RwMeTC0eQUqFZ+s3aFuuHjKl5i36TA5ANJ3/iCSJrw54XWFRvOfEPTji+2eH0xWL
         VBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7lDROWz4PAGQhag4J5HjOqKix+Be3yOLacIp4LAcLQU=;
        b=Uo0MyAoKloqVvppgHQvsfDPMQ1ICRsdd9x2xSjMb4fvgy69ocpDYcnE8+S5NW51TJh
         3IAg22dlIVY1wx7RhHmAOAwguRsh6w2hDNtDiwqERmkUJ1e8zydwgVU1dLTHo5hWxczG
         qhV+5Nn6fBpx1x7XQZ6TDzs8pbWnUmzhN4S6BLS4C6UExuAGgNrbV4z7NeHUYqy0Y4VD
         9pSBhK7nO0XCW2LH04GilxuSRiSUwjxJbBgmDkxnXtt4jWFuuojzN2eCiYDEjbEtAt3y
         3kq/U7plN+R8Xs0BTm7Kz+bcQGpUdN+AZzDps+MDRghRwLvHp446nfjDTQ+guk0vmt7Q
         5HnQ==
X-Gm-Message-State: AOAM532kCj4FzwK8T050ONFr2FfoR2LlHiMFgdBnsFqM/oSrj/vD8rAW
        TRY2KnFJnVeP+5jxQlNvHDuqZU7cNFY=
X-Google-Smtp-Source: ABdhPJwYnevEWt8AxyNMsY1VIVxxiu/AbCNQJz576cGpobIEL5tMiYttL1g2BHMreoy6gUYwPqo5Qg==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr4876507wmc.122.1598443015213;
        Wed, 26 Aug 2020 04:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g62sm4629526wmf.33.2020.08.26.04.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:56:53 -0700 (PDT)
Message-Id: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 11:56:49 +0000
Subject: [PATCH v3 0/3] Optionally skip linking/copying the built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dashed form of the built-ins is so passé.

Incidentally, this also handles the .pdb issue in MSVC's install Makefile
target that Peff pointed out in the context of the "slimming down" patch
series
[https://lore.kernel.org/git/20200813145719.GA891370@coredump.intra.peff.net/]
.

This addresses https://github.com/gitgitgadget/git/issues/406

Changes since v2:

 * Reworded and clarified the commit messages of the second and third patch.

Changes since v1:

 * Fixed check-docs under SKIP_DASHED_BUILT_INS
 * Renamed ALL_PROGRAMS_AND_BUILT_INS to ALL_COMMANDS_TO_INSTALL to reflect
   its purpose better.
 * Revamped the commit message of patch 2/3 and 3/3.

Johannes Schindelin (3):
  msvc: copy the correct `.pdb` files in the Makefile target `install`
  Optionally skip linking/copying the built-ins
  ci: stop linking built-ins to the dashed versions

 Makefile                  | 71 +++++++++++++++++++++------------------
 ci/run-build-and-tests.sh |  2 +-
 2 files changed, 40 insertions(+), 33 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-411%2Fdscho%2Foptionally-skip-dashed-built-ins-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-411/dscho/optionally-skip-dashed-built-ins-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/411

Range-diff vs v2:

 1:  1880a0e4bf = 1:  1880a0e4bf msvc: copy the correct `.pdb` files in the Makefile target `install`
 2:  166bd0d8fb ! 2:  52deafded5 Optionally skip linking/copying the built-ins
     @@ Commit message
          executable to the dashed name in `libexec/git-core/`), in practice, it
          is probably almost irrelevant.
      
     -    In fact, some platforms (such as Windows) only started gaining
     -    meaningful Git support _after_ the dashed form was deprecated, and
     -    therefore one would expect that all this hard-linking is unnecessary on
     -    those platforms.
     +    However, we *do* care about keeping people's scripts working (even if
     +    they were written before the non-dashed form started to be recommended).
     +
     +    Keeping this backwards-compatibility is not necessarily cheap, though:
     +    even so much as amending the tip commit in a git.git checkout will
     +    require re-linking all of those dashed commands. On this developer's
     +    laptop, this makes a noticeable difference:
     +
     +            $ touch version.c && time make
     +                CC version.o
     +                AR libgit.a
     +                LINK git-bugreport.exe
     +                [... 11 similar lines ...]
     +                LN/CP git-remote-https.exe
     +                LN/CP git-remote-ftp.exe
     +                LN/CP git-remote-ftps.exe
     +                LINK git.exe
     +                BUILTIN git-add.exe
     +                [... 123 similar lines ...]
     +                BUILTIN all
     +                SUBDIR git-gui
     +                SUBDIR gitk-git
     +                SUBDIR templates
     +                LINK t/helper/test-fake-ssh.exe
     +                LINK t/helper/test-line-buffer.exe
     +                LINK t/helper/test-svn-fe.exe
     +                LINK t/helper/test-tool.exe
     +
     +            real    0m36.633s
     +            user    0m3.794s
     +            sys     0m14.141s
     +
     +            $ touch version.c && time make SKIP_DASHED_BUILT_INS=1
     +                CC version.o
     +                AR libgit.a
     +                LINK git-bugreport.exe
     +                [... 11 similar lines ...]
     +                LN/CP git-remote-https.exe
     +                LN/CP git-remote-ftp.exe
     +                LN/CP git-remote-ftps.exe
     +                LINK git.exe
     +                BUILTIN git-receive-pack.exe
     +                BUILTIN git-upload-archive.exe
     +                BUILTIN git-upload-pack.exe
     +                BUILTIN all
     +                SUBDIR git-gui
     +                SUBDIR gitk-git
     +                SUBDIR templates
     +                LINK t/helper/test-fake-ssh.exe
     +                LINK t/helper/test-line-buffer.exe
     +                LINK t/helper/test-svn-fe.exe
     +                LINK t/helper/test-tool.exe
     +
     +            real    0m23.717s
     +            user    0m1.562s
     +            sys     0m5.210s
     +
     +    Also, `.zip` files do not have any standardized support for hard-links,
     +    therefore "zipping up" the executables will result in inflated disk
     +    usage. (To keep down the size of the "MinGit" variant of Git for
     +    Windows, which is distributed as a `.zip` file, the hard-links are
     +    excluded specifically.)
      
          In addition to that, some programs that are regularly used to assess
          disk usage fail to realize that those are hard-links, and heavily
          overcount disk usage. Most notably, this was the case with Windows
     -    Explorer up until the last couple of Windows 10 versions.
     +    Explorer up until the last couple of Windows 10 versions. See e.g.
     +    https://github.com/msysgit/msysgit/issues/58.
      
     -    To save on the time needed to hard-link these dashed commands, and to
     -    eventually stop shipping with those hard-links on Windows, let's
     +    To save on the time needed to hard-link these dashed commands, with the
     +    plan to eventually stop shipping with those hard-links on Windows, let's
          introduce a Makefile knob to skip generating them.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 3:  ea23ba5e26 ! 3:  99a5328492 ci: stop linking built-ins to the dashed versions
     @@ Commit message
          the dashed form, even if we deprecated that a _long_ time ago.
      
          For that reason, we just introduced a Makefile knob to skip linking
     -    them. TO make sure that this keeps working, teach the CI
     +    them. To make sure that this keeps working, teach the CI
          (and PR) builds to skip generating those hard-links.
      
     +    This is actually not such a big change: e4597aae6590 (run test suite
     +    without dashed git-commands in PATH, 2009-12-02) made sure that our test
     +    suite does not require dashed commands. With this Makefile knob, the
     +    commitment is just a little stronger (running tests with `--with-dashes`
     +    would _still_ not see the dashed form of the built-ins).
     +
     +    There is a subtle change in behavior with this patch, though: as we no
     +    longer even _build_ the dashed executables, running the test suite would
     +    fail if any of Git's scripted commands (e.g. `git-request-pull`) still
     +    This would have succeeded previously (and would have been unintentional,
     +    of course) because `bin-wrappers/git` sets `GIT_EXEC_PATH` to the
     +    top-level directory (which would still have contained, say,
     +    `git-rev-parse`).
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## ci/run-build-and-tests.sh ##

-- 
gitgitgadget
