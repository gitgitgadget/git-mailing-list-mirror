Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684081F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeB1BGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:06:16 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35551 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeB1BGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:06:15 -0500
Received: by mail-pl0-f66.google.com with SMTP id bb3-v6so502639plb.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BTjWt1u+ytvMOwStnefJ1Xy0H09yw6zMq77nrsLBnCQ=;
        b=rX2+ECQOCZDoZX8UFaRIwu9RM2n/p7MwolgM6jIkXlh01HkY6ZzHPMMYyNYV8DtIiU
         0BRKdhb91DFmjlUWci2qFlA30WlR/qB2PNjK+/J2mfgPkz3jIxqDcMEXXnfHAeumyv3u
         zJeN+Zr1tJSYH+YFyGkGrUtejScHlUtyASDBntAafpOA1LGg/RbSFOL+yDQbhow9D4Jh
         b10vSLI/igVTnUdjfLNULbfqDAlj4TnhTDdwbi1zTEZeE4/0TvttFjDTrtb3jz2xwK/q
         Nh8Ors4vW4GAOYxbHxDni8AsAu5bKxFDbw2vVgrjBDU5nn0eJC0QvU+WdVt7aeG/RC5m
         H1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BTjWt1u+ytvMOwStnefJ1Xy0H09yw6zMq77nrsLBnCQ=;
        b=dL5zkwrLoyr5RZ+2EP6ufA9Z+GGpIE+Xe6q3SSwawMm+EWF/Q+igaA4f7ZE8BpRgHF
         GlOIcRi/l82yjnUKnECrdiF2CCUahOK2gBUbKRJFPw78xx0qlc030uMK1MTojsbyI2zx
         MHL1Nj+T9YFuZDjLJnXcj0HVn/3rl/gsoXxbS9is/2PleRG3bk4HcOxW/iGB94nOprbc
         LqwoCvG5gXBfgxgEMYOlyU6VNVQ84Hm3Dw5HntXcYhFK2smO1HY8qQRCB8jms1MCmPB3
         OuXvRQ510HSwM6FFyAxr/EvsJlwRnkh/+ilQnjrlWNXGb2MRWsFen6q4op8N+cZa/h75
         SqXQ==
X-Gm-Message-State: APf1xPC7OSPhyXiic07SW6l948CDY7qggIrWTKrFKH8OvLknTiZXYDW8
        RriD05lrzOyzU4uW90mt0BMK9E06Ptw=
X-Google-Smtp-Source: AG47ELudZnRUvVpO/+L33T4mYzO/dHYRF01pWjo9FKROPTRnZRZndX/4klYN8iswbYXcq0Vob9sH5g==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7-v6mr9802841pll.150.1519779973986;
        Tue, 27 Feb 2018 17:06:13 -0800 (PST)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id r29sm477675pfj.99.2018.02.27.17.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:06:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/11] Moving global state into the repository object (part 2)
Date:   Tue, 27 Feb 2018 17:05:57 -0800
Message-Id: <20180228010608.215505-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies on top of origin/sb/object-store and is the continuation of
that series, adding the repository as a context argument to functions.

This series focusses on packfile handling, exposing (re)prepare_packed_git
and find_pack_entry to a repository argument.

Looking at the diffstat of "Delete ignore_env member in struct repository"[1]
and "Fix initializing the_hash_algo"[2], which also build on origin/sb/object-store, 
this series looks rather orthogonal to those, so I would not a lot of merge
conflicts.

[1] https://public-inbox.org/git/20180227095846.9238-1-pclouds@gmail.com/
[2] https://public-inbox.org/git/20180225111840.16421-1-pclouds@gmail.com/

The third series (after this one) will focus on object replacement,
such that we can migrate sha1_object_info_extended at the end of the
third series.

Thanks,
Stefan

Stefan Beller (11):
  packfile: allow prepare_packed_git_mru to handle arbitrary
    repositories
  packfile: allow rearrange_packed_git to handle arbitrary repositories
  packfile: allow install_packed_git to handle arbitrary repositories
  packfile: add repository argument to prepare_packed_git_one
  packfile: add repository argument to prepare_packed_git
  packfile: add repository argument to reprepare_packed_git
  packfile: allow prepare_packed_git_one to handle arbitrary
    repositories
  packfile: allow prepare_packed_git to handle arbitrary repositories
  packfile: allow reprepare_packed_git to handle arbitrary repositories
  packfile: add repository argument to find_pack_entry
  packfile: allow find_pack_entry to handle arbitrary repositories

 builtin/count-objects.c  |  2 +-
 builtin/fsck.c           |  2 +-
 builtin/gc.c             |  4 +--
 builtin/pack-objects.c   |  2 +-
 builtin/pack-redundant.c |  2 +-
 builtin/receive-pack.c   |  3 +-
 bulk-checkin.c           |  3 +-
 fast-import.c            |  4 +--
 fetch-pack.c             |  3 +-
 http-backend.c           |  2 +-
 http.c                   |  2 +-
 pack-bitmap.c            |  2 +-
 packfile.c               | 72 +++++++++++++++++++---------------------
 packfile.h               | 12 ++++---
 server-info.c            |  2 +-
 sha1_file.c              |  8 ++---
 sha1_name.c              |  4 +--
 17 files changed, 66 insertions(+), 63 deletions(-)

-- 
2.16.2.395.g2e18187dfd-goog

