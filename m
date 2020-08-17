Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E10C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B6B20658
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKsNXeT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgHQSKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgHQSKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86EAC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r2so15892129wrs.8
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XTDCwANxgEbHsFVUQZRJPZDGwGf8qj+5ABsrdHpyod0=;
        b=aKsNXeT1djrJE0N5byjNLclKdXp4C4+zseP1EI13lJmzgt89CoSCPzLAjY4hV1h5Mg
         nzQkMi5ocXuU2ksAzxlME3r6KQv04qPkVzRXshMgcaCwwoybIaXuBN3sYdK/fzA30k0B
         Ml5sgFqI9dzy8sHHaFZ9L2cB7iJmrjw+R3viXfArLzNa/E4jrwKyoEYRnyWInsJX2S/t
         WgZAaYMBDq+J6QVhmMm+qtlOD3izk2nmS4q0IQMB5b3R1WOFlJnFFB9MvLv/PT/J7fnL
         wL7UAsP0rOJ4esauV/UDFIdwrgoADXDmtyvPpxFW5CaXZbpM2Z08MI40OSlYL3f64xvV
         Cewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XTDCwANxgEbHsFVUQZRJPZDGwGf8qj+5ABsrdHpyod0=;
        b=tvceYaROujQVLnoERfF14aoq5VSyifp5b0ZhIj8vljFgkTsWm2MnK+zAtGXOa5W4o9
         4B/wfUgoNp7znoiKHK2r08xgH4hP5xg1BGq2xw5n0HHTN2vI+w1Pt8IqjAuidxjmGSrG
         6AM9dCp8ZNICIL2PfIxS6YIkk40Zuq+XaewjEnInYUHk8BVYDe2oOVuLUh2Kio2l11Ut
         wSOGXrN0BhuiLH/+vxw6oB8P9TqX6RLeD37s8APxYGrN6IaZgkez+hezgE/yfrNN/rJc
         +73HWvTn3K0sSDDuunOinNRqDtFuv3LMhkG/Bq8Vau7+4RNz8orlsCqvGpcBur7K1gDE
         jouA==
X-Gm-Message-State: AOAM532LwKJHoZlOFan/rVLnJntoh1siCcmTxUVi6/ebJB/MPL7UVelP
        XWVfBOB4XqbbQW0YO7Tad4H0ZczOQ6E=
X-Google-Smtp-Source: ABdhPJxjgCMZwfKJPpWcHr80DR0k9e2kdj2vlW720goAjOQgyaS+ibSum/kBWKxbSDrh29t6JsFh5g==
X-Received: by 2002:adf:f151:: with SMTP id y17mr17512122wro.179.1597687823271;
        Mon, 17 Aug 2020 11:10:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k204sm30909275wma.21.2020.08.17.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:22 -0700 (PDT)
Message-Id: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:13 +0000
Subject: [PATCH v3 0/9] [Resend][GSoC] Improvements to ref-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first patch series that introduces some improvements and
features to file ref-filter.{c,h}. These changes are useful to ref-filter,
but in near future also will allow us to use ref-filter's logic in pretty.c

I plan to add more to format-support.{c,h} in the upcoming patch series.
That will lead to more improved and feature-rich ref-filter.c


----------------------------------------------------------------------------

I just rebased the branch with master and fixed some merge conflicts. Only
the version number has been incremented, there are no changes in the
patches. Original patch series: 
https://public-inbox.org/git/pull.684.v2.git.1596664305.gitgitgadget@gmail.com/#t

Hariom Verma (9):
  ref-filter: support different email formats
  ref-filter: refactor `grab_objectname()`
  ref-filter: modify error messages in `grab_objectname()`
  ref-filter: rename `objectname` related functions and fields
  ref-filter: add `short` modifier to 'tree' atom
  ref-filter: add `short` modifier to 'parent' atom
  pretty: refactor `format_sanitized_subject()`
  format-support: move `format_sanitized_subject()` from pretty
  ref-filter: add `sanitize` option for 'subject' atom

 Documentation/git-for-each-ref.txt |  10 +-
 Makefile                           |   1 +
 format-support.c                   |  43 ++++++++
 format-support.h                   |   6 ++
 pretty.c                           |  40 +-------
 ref-filter.c                       | 159 +++++++++++++++++++----------
 t/t6300-for-each-ref.sh            |  35 +++++++
 7 files changed, 202 insertions(+), 92 deletions(-)
 create mode 100644 format-support.c
 create mode 100644 format-support.h


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-684%2Fharry-hov%2Fonly-rf6-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-684/harry-hov/only-rf6-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/684

Range-diff vs v2:

  1:  78e69032df =  1:  3e6fc66a46 ref-filter: support different email formats
  2:  b6b6acab9a =  2:  5268b973da ref-filter: refactor `grab_objectname()`
  3:  65fee332a3 =  3:  4a12ff8210 ref-filter: modify error messages in `grab_objectname()`
  4:  976f2041a4 =  4:  d53ca56778 ref-filter: rename `objectname` related functions and fields
  5:  dda7400b14 =  5:  fd4ed82e80 ref-filter: add `short` modifier to 'tree' atom
  6:  764bb23b59 =  6:  7a039823de ref-filter: add `short` modifier to 'parent' atom
  7:  95035765a0 =  7:  0ad22c7cdd pretty: refactor `format_sanitized_subject()`
  8:  1c43f55d7c =  8:  7a64495f99 format-support: move `format_sanitized_subject()` from pretty
  9:  feace82752 !  9:  1ab35e9251 ref-filter: add `sanitize` option for 'subject' atom
     @@ ref-filter.c
      @@
       #include "worktree.h"
       #include "hashmap.h"
     - #include "argv-array.h"
     + #include "strvec.h"
      +#include "format-support.h"
       
       static struct ref_msg {

-- 
gitgitgadget
