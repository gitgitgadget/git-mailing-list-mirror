Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB92E1F462
	for <e@80x24.org>; Wed, 22 May 2019 00:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfEVAWC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:22:02 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:49800 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVAWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:22:02 -0400
Received: by mail-yw1-f74.google.com with SMTP id y144so433346ywg.16
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NL+TzYMSYWr/pSycuoX4Xiay/0BwEXLwexrECVFYZts=;
        b=MInUQAtOyvWVQku18bclgs2JirF3GcX1/OrsWvxmUgv9n1JaWv57y9snNVne1ecYCA
         wn/xu2reOReUTYQXUpZWV87yfU3nmH+dRGQJeabKk3Cvhxtfbu+uFshkU21eMqRMbkKK
         +SyG3/o/XoTp8Y0J2JPXC02bzLoaOuLOajoOFjontuGb5BEIWM1Ls2ZUE6qrSWxuIgDp
         t3cRfOCT7pa6x5rIuptiu/l9s3vapFXOfPiPzGNiYCywhLvVCTsduQU/AWIDwiWTVD3s
         bf5ulHdQJ0Ewc6iRfdaBdf3QlUBC8qpoYvFBzrXQrluIR3UOjlOSdKDa1qESoOmZ87Y4
         M0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NL+TzYMSYWr/pSycuoX4Xiay/0BwEXLwexrECVFYZts=;
        b=eTW0Jh50jUvOamYl5i0EY5Pj+3X3K5YnGBt/5C3W3uQu9T9qHE48fHHpwuSBEB8D6h
         8PHb6DMxY3gFwYyNFYUogTLfAGew9mxrYQCDWs/12gCtuL2bUc6dpg/xQjLAfFDaX+Fo
         XWfIz9be7DrDc2Z7H7ghmdTl/AFKtOBCSfrHB5hw1mS75EHxGrd0EQws0saZsHtgVwL/
         q3DprCzcus70pTZ3bKXstk9zqn9zd+LnUJpjUvlVuaEoyM0DUQFbUGT5zkfnNGPAHAoW
         p9BoBrzYTd8WyAa5qZRvR2JzRdDWcEKHVwh/jWUY85A2aDZna6hP2YyNXPfi71YFM9HU
         QPew==
X-Gm-Message-State: APjAAAVyRkCziHPhlwaxPdWuItPK15IPTPsUGK8z/8qGGWhdp4cjGkKp
        gZnyX4NAsz6ZaM6UxtaPXqSr0h9bK20=
X-Google-Smtp-Source: APXvYqwxVC7LHheXKAyJqMIZ9fQzRYvSyY+XC/0bt56sXrobkMTyXD6nMUh0RgjyEgcvjKodNP91GdIW8Z+L
X-Received: by 2002:a81:2715:: with SMTP id n21mr40314268ywn.252.1558484521426;
 Tue, 21 May 2019 17:22:01 -0700 (PDT)
Date:   Tue, 21 May 2019 17:21:49 -0700
Message-Id: <cover.1558484115.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v1 0/5] Filter combination
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This implements combining of filters. In any command which accepts the --filter
flag, this patch allows specifying multiple filter flags or using the
"combine:..." filter-spec form.

Combining filters means that only objects which are accepted by all filters get
shown or included.

Compared to the RFC version of this patch set, the following notable changes
and additions were made:

 - Simplification of the logic to execute combined filters.
 - Addition of test cases for existing logic and new logic.
 - Allowing to specify multiple --filter flags rather than requiring the
   combine: filter-spec form.
 - Require escaping a large number of reserved characters in "combine:..."
   filter specs in case we decide to do anything interesting with the filter
   language later.

Thank you,

Matthew DeVore (5):
  list-objects-filter: refactor into a context struct
  list-objects-filter-options: error is localizeable
  list-objects-filter: implement composite filters
  list-objects-filter-options: move error check up
  list-objects-filter-options: allow mult. --filter

 Documentation/rev-list-options.txt     |  14 ++
 builtin/fetch-pack.c                   |   5 +-
 builtin/rev-list.c                     |   5 +-
 contrib/completion/git-completion.bash |   2 +-
 fetch-pack.c                           |   5 +-
 list-objects-filter-options.c          | 252 +++++++++++++++++++++--
 list-objects-filter-options.h          |  17 +-
 list-objects-filter.c                  | 270 ++++++++++++++++---------
 list-objects-filter.h                  |  31 ++-
 list-objects.c                         |  45 ++---
 t/t5616-partial-clone.sh               |  19 ++
 t/t6112-rev-list-filters-objects.sh    | 193 +++++++++++++++++-
 transport.c                            |   5 +-
 upload-pack.c                          |  10 +-
 14 files changed, 708 insertions(+), 165 deletions(-)

-- 
2.21.0

