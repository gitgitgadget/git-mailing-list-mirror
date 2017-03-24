Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70FD31FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965496AbdCXS3H (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:29:07 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35491 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdCXS3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:29:06 -0400
Received: by mail-pf0-f182.google.com with SMTP id 20so4305038pfk.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nf6cXsDLGV2kyi+wC8l+5W770I2QetOf2zhMW3d1dfM=;
        b=wObgbbTJRnws8PtO1rDtbfBPDhh/YQUyPrkpK6sdzZDD3PVuspjUq1qsxXs+QLbu4m
         AsqSLSavrhtD2LSEKjkCnf6+zTJs7g+2CV8v2m59sDejGS8nu04tWaJ24mi8kJoHpvIy
         edU9v6AIpl46sjczemajVZ+siiSk9kZ0RkgZOqS2slO7+kwTbpsYYhdGkxZIircX4lR7
         uVDbSbc5L0gyrlqBnq7AwIsBeV6Szxg0/vkNfRyyrdC+XgI1hnrbgrhIaoyOmSbj6rvZ
         y5d6gK6NU1zIdr7Dw+EL+LCIR0mFoj60H81hEIdCkCXYIMbcwioXWQFbRqrNX6EsPqtX
         lj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nf6cXsDLGV2kyi+wC8l+5W770I2QetOf2zhMW3d1dfM=;
        b=bAf20pOb0dx9DNA+HyFWE1y1/LmUCLAyFJUgb4AncWyJgnYW8YII0pboIdw3cWD/NG
         HB/sH2iXzj8X1nADo+PWO77nDkHwrNx+Y1QRyhu4wh/0hFFYtr319TqQ6xjZJ4N5OUgu
         OUfVq1CQqr3FHRrbdlek6GJ3Gs0zAPFH+eT7h2HtQNYiBhQLKOmQL2yXJBvj39SQ4moT
         +ZXhIS9vP12IwomKcxbrjfseMPaaRfnEZUjVOeVYxCvemHRz/Jc7cALJlrAWNUzXiquW
         4o4fvO4n4xvzeNp34FroQUNfFnOyQq4j/W90dFvhFbWVkDnOzddNykR2pLu5+/fVWjhC
         KMmg==
X-Gm-Message-State: AFeK/H0+Jpb/VL+n1a/dzK3KhzVsmM+emkX1P3FyhO1aJg+R2dBWigPKTj1jsDM7wTo8Ut59
X-Received: by 10.99.126.76 with SMTP id o12mr10406621pgn.1.1490380144908;
        Fri, 24 Mar 2017 11:29:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3d58:2a6c:e6ff:8de9])
        by smtp.gmail.com with ESMTPSA id h71sm6054180pfj.65.2017.03.24.11.29.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:29:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v6 0/7] short status: improve reporting for submodule changes
Date:   Fri, 24 Mar 2017 11:28:55 -0700
Message-Id: <20170324182902.19280-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.437.g2b7623d507
In-Reply-To: <20170323223338.32274-7-sbeller@google.com>
References: <20170323223338.32274-7-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6:
* kill the child once we know all information that we ask for, as an optimization
* reordered the patches for that
* strbuf_getwholeline instead of its _fd version.

v5:
* fixed rebase error in the first 2 patches
* the last 3 patches introduce behavior change outside the scope of is_modified_submodule
  whereas the first 4 ought to just be local changes.
  
Thanks,
Stefan

v4:
* broken down in a lot of tiny patches.

Jonathan wrote:
> Patch 1/3 is the one that gives me pause, since I hadn't been able to
> chase down all callers.  Would it be feasible to split that into two:
> one patch to switch to --porcelain=2 but not change behavior, and a
> separate patch to improve what is stored in the dirty_submodule flags?

This part is in the latest patch now.

Thanks,
Stefan


v3:
This comes as a series; first I'd like to refactor is_submodule_modified
to take advantage of the new porcelain=2 plumbing switch to check for changes
in the submodule.

On top of the refactoring comes the actual change, which moved the
rewriting of the submodule change indicator letter to the collection part.

Thanks,
Stefan

Stefan Beller (8):
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: use argv_array in is_submodule_modified
  submodule.c: convert is_submodule_modified to use
    strbuf_getwholeline_fd
  submodule.c: port is_submodule_modified to use porcelain 2
  submodule.c: factor out early loop termination in
    is_submodule_modified
  submodule.c: stricter checking for submodules in is_submodule_modified
  short status: improve reporting for submodule changes
  submodule.c: correctly handle nested submodules in
    is_submodule_modified

 Documentation/git-status.txt |  9 +++++++
 submodule.c                  | 56 ++++++++++++++++++++-----------------------
 t/t3600-rm.sh                | 18 ++++++++++----
 t/t7506-status-submodule.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 13 ++++++++--
 5 files changed, 116 insertions(+), 37 deletions(-)

-- 
2.12.1.438.gb674c4c09c

