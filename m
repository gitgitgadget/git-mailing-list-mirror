Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FB8C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136AB60EB4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhJ0Hvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbhJ0Hvk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:40 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44971C061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so1551942wmz.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RSdU9DJFlH7vliL4kz5T6hQn3DepJH1sHcoDRQCYL8Y=;
        b=Qg0x7buadbtrVw6SCMM23NrdUhAEiqFCzc2f9BcImBni7zoVo0kolSmZPTkJtwtxsz
         q6hOGoaR6ColvYP7+JhakozAlIAD2+ORgKjbytuMGl2IamoSxdf6Pwv6B1OuLeeviCnA
         N8kSRNBvLzHzjNSr230AGu0H+kpfgDxmzVTVsCKecWtHDbct0vVHa8/qQ3ZyXKZX1zUc
         XgE1shw95GzBoaSFeM/Y56UwlCnOoAYKKaxFglafWau1LAcUJLVZKf2qhHIcRplMJjWh
         qJzwnBRdm9oLtryswAsyS+J8LtQH4HuAPK02LlN2YT+T9ju/8G36XbinkJAdw8ti/2Ol
         KX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RSdU9DJFlH7vliL4kz5T6hQn3DepJH1sHcoDRQCYL8Y=;
        b=oboKWCE5Uefb25SFmDQM7/pq+58I9OYdRPX37BPh8piYaYQXCiHz7WdOO8x74M7eB0
         82QtVhJArYI36h36e6h9Qpk4NLEmltc/jHuodVWfv3xxD65Lbyn9WDtsPvAOF247VNIi
         LwA/haPmw8zpSfKen32QHXfWnbZFPxUiTJNjtSHRAh7Vf6quWElBWQwtCxGVmf5v9vMh
         Abe/KMfMiWsIzRdCx67qfBnOJpbMAKsgdvSb1+TuPC2xuRjd6XybKvTvqMTkZjcKRDvo
         /ueSMerO+TTpcRBuK1JcFKWLePsj13ApVIlvoLNf+aP5g8pX0o6oEGNqSIwuaAemvff/
         e0lw==
X-Gm-Message-State: AOAM533DDGg+1jreM2ov1IhMEUThnXCMALWKXuRcfpecU7wOMNL3/8Jh
        zgD/NnqGu0zn4uG4snyG3aGRA1VM/fI=
X-Google-Smtp-Source: ABdhPJwyfxNHom+Sdl1/dtrYadtjNGuRVhzXWWGFrI8lHBhy1Pe0vheyl2f6rLpxS3Iv+vHhviQcHw==
X-Received: by 2002:a1c:c4:: with SMTP id 187mr4136882wma.61.1635320953940;
        Wed, 27 Oct 2021 00:49:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm2150503wms.40.2021.10.27.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:49:13 -0700 (PDT)
Message-Id: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 07:49:07 +0000
Subject: [PATCH 0/5] Allow clean/smudge filters to handle huge files in the LLP64 data model
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series came in via the Git for Windows fork
[https://github.com/git-for-windows/git/pull/3487], and I intend to merge it
before v2.34.0-rc0, therefore I appreciate every careful review you gentle
people can spare.

The x86_64 variant of Windows uses the LLP64 data model, where the long data
type is 32-bit. This is very different from the LP64 data model used e.g. by
x86_64 Linux, where unsigned long is 64-bit.

Most notably, this means that sizeof(unsigned long) != sizeof(size_t) in
general.

However, since Git was born in the Linux ecosystem, where that inequality
does not hold true, it is understandable that unsigned long is used in many
code locations where size_t should have been used. As a consequence, quite a
few things are broken e.g. on Windows, when it comes to 4GB file contents or
larger.

Using Git LFS [https://git-lfs.github.io/] trying to work around such issues
is one such a broken scenario. You cannot git checkout, say, 5GB files. Huge
files will be truncated to whatever the file size is modulo 4GB (in the case
of a 5GB file, it would be truncated to 1GB).

This patch series primarily fixes the Git LFS scenario, by allowing clean
filters to accept 5GB files, and by allowing smudge filters to produce 5GB
files.

The much larger project to teach Git to use size_t instead of unsigned long
in all the appropriate places is hardly scratched by this patch series.

Side note: The fix for the clean filter included in this series does not
actually affect Git LFS! The reason is that Git LFS marks its filter as
required, and therefore Git streams the file contents to Git LFS via a file
descriptor (which is unaffected by LLP64). A "clean" filter that is not
marked as required, however, lets Git take the code path that is fixed by
this patch series.

Johannes Schindelin (1):
  git-compat-util: introduce more size_t helpers

Matt Cooper (4):
  t1051: introduce a smudge filter test for extremely large files
  odb: teach read_blob_entry to use size_t
  odb: guard against data loss checking out a huge file
  clean/smudge: allow clean filters to process extremely large files

 convert.c                   |  2 +-
 delta.h                     |  6 +++---
 entry.c                     |  8 +++++---
 entry.h                     |  2 +-
 git-compat-util.h           | 25 +++++++++++++++++++++++++
 object-file.c               |  6 +++---
 packfile.c                  |  6 +++---
 parallel-checkout.c         |  2 +-
 t/t1051-large-conversion.sh | 22 ++++++++++++++++++++++
 9 files changed, 64 insertions(+), 15 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1068%2Fdscho%2Fhuge-file-smudge-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1068/dscho/huge-file-smudge-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1068
-- 
gitgitgadget
