Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A811F453
	for <e@80x24.org>; Thu,  4 Oct 2018 23:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJEF5U (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:57:20 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:49458 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJEF5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:57:19 -0400
Received: by mail-vs1-f74.google.com with SMTP id x199so2780232vsc.16
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 16:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1o3OT8CiRTUeR8IRETSHQRTkWUCwOKktCpso5gindl0=;
        b=LaGEbpJyuv0DnFPOCmCOitgooPiJ1GKewczLGEudm2CUHWAaGpRke+asIT7VwAKUqo
         0pSTQf6m9lsbG2QgXzd/RV3QuJmtelwzeb7JyQf1dgLg7HYCyc5ItGCTl7NBDvBnl6oS
         BqiJVs2wnEQx570Oe4hRDxy6lx/B8APPWoE7oecqUi99cRPrS8Ul4RFcbPLKruE5+M1i
         4grgMZSDnw4yVMYIyfHiqDiVvrMeXbYT5LVFpcAKjlDD9BYHt6M5N+iKq4dkkbYYbuQb
         MckNeiivaAD6v2gJRV3F3ioDlUnNw+Rln7nBz4LJCclWh5RSFymMUtSv0Q2EW6Tu6AgN
         vCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1o3OT8CiRTUeR8IRETSHQRTkWUCwOKktCpso5gindl0=;
        b=VdDgpSQsg7NKjveGPdaE89HwDPJvL6pWeACXnMB/kfn5eDx+srUgkwJrO2U0/ucB8c
         7LNCvjXNjTubjwAL2l7PuZyE1HBuh5SdnulqdHE1ljFJ6hkc43jduIvu2KKk1epVXxJd
         y3imndQ2d9t4Wa7ila1BdXPw+q/nS78Ef9IFjrDy0EmHxbAHcum5DestTd1zVuExhTR1
         QyFYWW4/Nz0jNnp+x6rqy6fFACZoL+FvMRVV0zB6Sl2JqrWqQDqpegA3Orx6+a1y2LAx
         VGOAFRx9ILMxtAyrJR/pUkn2vIOGVxZu3iT2BkhHzuO3VwlFcH1QN2Yi0cx7CRIA5yH2
         8/pw==
X-Gm-Message-State: ABuFfojxTa1tS4mVlFZOnoHuKpiYU2G3+ZR0VFj/nOMjBKIm9RfPfc8U
        45bVQw6AN18WkSK7laP/GfAHUN+OgyMtvEOpCQ8M8BuowC1cX0n93IsURyNNUTHHHrcStsL908Z
        T/wL9mb0Be5grucbzDU1LHChVw79kaZGCjgBMahwWTa8f4SW3liVe+pN1tOdw8fE=
X-Google-Smtp-Source: ACcGV61d02WqO+eW0KkVtxlwFvPTEv0xGRYtNy31BCtE1yZSi5grgj7K6JS0KIZ0IIdW3qri9297DHTABnPa6g==
X-Received: by 2002:a67:7691:: with SMTP id r139-v6mr7720209vsc.33.1538694099628;
 Thu, 04 Oct 2018 16:01:39 -0700 (PDT)
Date:   Thu,  4 Oct 2018 16:01:27 -0700
Message-Id: <cover.1538693039.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH 0/2] add fuzzing targets for use with LLVM libFuzzer
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

libFuzzer[1] is a fuzzing engine included in recent versions of LLVM. It
is used by OSS-Fuzz[2] for continuous fuzzing of OSS projects.

This series adds two basic fuzzing targets covering packfile header and
index code. It is not particularly portable, and requires the use of
LLVM v4.0 (the latest version available on my workstation). I would
particularly appreciate advice on how to make the Makefile more
portable.

[1]: https://llvm.org/docs/LibFuzzer.html
[2]: https://github.com/google/oss-fuzz

Josh Steadmon (2):
  fuzz: Add basic fuzz testing target.
  fuzz: Add fuzz testing for packfile indices.

 .gitignore          |  3 +++
 Makefile            | 33 ++++++++++++++++++++++++++++++++-
 fuzz-pack-headers.c | 14 ++++++++++++++
 fuzz-pack-idx.c     | 13 +++++++++++++
 packfile.c          | 44 +++++++++++++++++++++++++-------------------
 packfile.h          | 13 +++++++++++++
 6 files changed, 100 insertions(+), 20 deletions(-)
 create mode 100644 fuzz-pack-headers.c
 create mode 100644 fuzz-pack-idx.c

-- 
2.19.0.605.g01d371f741-goog

