Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FEC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8320679
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Yl8GYsL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgFASB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbgFASB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 14:01:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08DDC05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 11:01:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h185so2830046pfg.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QXJbnCeFTrhvjfVnAga/mSxG+hLj5j0TBX0GbYIzDO4=;
        b=Yl8GYsL5jMpDHlZcdtauzSyqSU+tIRGIEsxDpjoY0FbMYB+aNTfWONM4oTePcECZNZ
         ILySWvVxd5rWJ5YmOX3VhK8Zb4EanQJ6FJc1iVScyPGhOhRyA/mMItnLjJ8MTEUJMPyB
         yaW2PgVHJVQ6Xd5fqQgJqVVxptccH3IqqQea6MLlblg3xu5MSzMDqLP0ejEYuqVpuuZo
         KNhkieHUZe4K+9Ed9AZHDB2MEoCQU0UQHMsamp+0tD+9meJfLk0GLX2KQXlS144SsVJt
         kGnwfgDoGhwbpl4dFnFDMCHzUWbZLdkD+ulU+kCfPAiFE5PWt/Ch40iasABSdGvPIwhE
         FzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QXJbnCeFTrhvjfVnAga/mSxG+hLj5j0TBX0GbYIzDO4=;
        b=VPf30zmd7nwyLFPtfyVilx7qpb8f6pyXPyar6bfm9nzXhdK1JR4bNghfUFT4IR/1dN
         PDgN2pbHLpxp/Vm/zK8GEFGzFQyfsEsBE20CEflw69ezKEMFG80FF/Vb8ij70KvkgK3C
         vLSOxNXkMCckQsRepc+/ev/RIiA0xzUURBKOyq1r2QzhLvvDhJE9NSN4wyprPGC18p5C
         Y9TxH9B9Y6j7k72syFUFfM0jTrMiB5Jao4XVrQ/iACPC5U0lVAR/HXY4sQYwgzR+ye4K
         IPgpqBtKBgq7MsPtfEe9oQ/arClYitvJgJJ+tIuULuE+RCiDdceHX9iNT7Oh1Egj+Zhq
         3mSg==
X-Gm-Message-State: AOAM531Ils3J/8OEqBTqAP1VS6ahC8DOOW9EFqPt9qS4ACczdxHgN5SF
        gH9VF3auisZWKah5sJphpAMZOYdfvLc=
X-Google-Smtp-Source: ABdhPJyi4xDRWPnH9ynjmfeuTWE/WcDo0R6msPGQpubp7W+64mOctHvlU5O8lSdSSYzIAYps/VZAKA==
X-Received: by 2002:a63:7453:: with SMTP id e19mr19984878pgn.139.1591034485505;
        Mon, 01 Jun 2020 11:01:25 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o25sm116922pgn.84.2020.06.01.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:01:24 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:01:23 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com
Subject: [PATCH 0/2] t5318: test '--stdin-commits' with '--[no-]progress'
Message-ID: <cover.1591034353.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a short pair of patches that I wrote this morning after looking
at Stolee's most recent coverage report.

The first patch is just cleanup, and the second patch is the real
change. It would have been nice to parameterize these tests over the
arguments to 'git commit graph' (ie., have three tests for 'write',
'verify', and 'write --stdin-commits'), but '--stdin-commits' is special
since it requires input.

These patches are based off the tip of 'next', but really only need my
changes from 'tb/commit-graph-no-check-oids'.

Taylor Blau (2):
  t5318: use 'test_must_be_empty'
  t5318: test that '--stdin-commits' respects '--[no-]progress'

 t/t5318-commit-graph.sh | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--
2.26.2.1052.gcc6b3749ab
