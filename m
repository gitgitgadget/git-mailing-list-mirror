Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F4C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438BD206F1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTcLci/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgFVJg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgFVJgz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 05:36:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA798C061794
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 02:36:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so8169861pfc.5
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ifdcSAZlJfBJoZlWkYr3SNJR0+rUDJKaE9hywyWCu5o=;
        b=tTcLci/B1I28EL5L/fzyl56D+iaJ/BUMk3kH0Vr4HTpAElg+PTG3pobE86F20Pkxj+
         86i8p5buHG9GsFKo4EEi4kOs7+6I99/EQHxWs3TnNjas/36ejrJKf9U/nZmtW8T+/HBY
         8I4LvQ8NbxUnuC6G6PcZs72DNEexSIDGGmRDuZrsHhw9KjXT74Sm7arSUbLIKAWiCIBe
         wDdOYqma4ShI7J5qK8hV/cnTc4CNff0Yw9/UPbVK44adETsF25LeoBS1E8dcYfb3Pq6K
         JbAsXkVmmrocYlGJB+NdnHPvygNpMTvdJM5EN7Z/9yEu7bho7wq/wjEGoqpxXsaglKjY
         9Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ifdcSAZlJfBJoZlWkYr3SNJR0+rUDJKaE9hywyWCu5o=;
        b=qHk4GHVYhLB2Cu72t226WAuEyf7PwexIIZ00wsYHWY5Ll4W+eJ9biaXlq+bi04a13d
         QrtS/OCb7gkM2h8FBIi7If6cpkHsW81DhZO/7FNC9InI1uBEc+cBZMyMct3s2/ARLHQp
         tfeSJ21LEwbRkSGhd975sYhQ4Uen/Zs/yj/3DBr9tg9utz3yB0Af6Xk/FuEaGK5vBsim
         rDxQncaGnXrQ7sK/YsUukqIjG3zPxFYU3EG1IF776rqHypF/5fxfFjh7pio5ErfWgtFv
         EaBJictblmeOGFgkwX5ff0Y/utArZ/tC1CAD7TkdB+YoHf7kHWLsJVcuuMlVB3ix8HV6
         zcOQ==
X-Gm-Message-State: AOAM532iBNKOnOBccKsqWqPPG0aEzCY1vDmp4RqFPUmP0Q4gqtEx1CJO
        RmpPvI2N8OASrwhFEb9nB7g5eDXk
X-Google-Smtp-Source: ABdhPJzloGjblhu0f49gzoBCYsmqKjSDgcmlEGoRSeqjZjTK71Vqjkw8091WCwt2kp1XCssK1I2H8Q==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr12073545pgr.418.1592818614741;
        Mon, 22 Jun 2020 02:36:54 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:2000:fc5a:4d80:dab6:77a0:3c64])
        by smtp.gmail.com with ESMTPSA id d7sm13704960pfh.78.2020.06.22.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:36:52 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:04:51 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [RFC] Metadata vs Generation Data Chunk
Message-ID: <20200622093451.GA1719@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the remaining pre-requisites for implementing generation number
v2 was distinguishing between corrected commit dates with monotonically
increasing offsets and topological level without incrementing generation
number version.

Two approaches were proposed [1]:
1. New chunk for commit data (generation data chunk, "GDAT")
2. Metadata/versioning chunk

Since both approaches have their advantages and disadvantages, I wrote
up a prototype [2] to investigate their performance.

[1]: https://lore.kernel.org/git/86mu87qj92.fsf@gmail.com/ 
[2]: https://github.com/abhishekkumar2718/git/pull/1

TL;DR: I recommend we should use generation data chunk approach.

Generation Data Chunk
=====================

We could move the generation number v2 into a separate chunk, storing
topological levels in CDAT and the corrected commit date into a new,
"GDAT" chunk.  Thus, old Git would use generation number v1, and
new Git would use corrected commit dates from GDAT.

Using generation data chunk has the advantage that we would no longer
be restricted to using 30 bits for generation number. It also works
well for commit-graph chains with a mix of v1 and v2 generation numbers.

However, it increases the time required for I/O as commit data and
generation numbers are no longer contiguous.

Note: While it also increases disk space required for storing
commit-graph files by 8 bytes per commit, I don't consider it relevant,
especially on modern systems. A repo of the size of Linux repo would be
larger by a mere 7.2 Mb.

Metadata / Versioning Chunk
===========================

We could also introduce an optional metadata chunk to store generation
number version and store corrected date offsets in CDAT. Since the
offsets are backward compatible, Old Git would still yield correct
results by assuming the offsets to be topological levels. New Git would
correctly use the offsets to create corrected commit dates.

It works just as well as generation number v1 in parsing and writing
commit-graph files.

However, the generation numbers are still restricted to 30 bits in CDAT
chunk and it does not work well with commit-graph chains with a mix of
v1 and v2 generation numbers.

Performance
===========

| Command                        | Master | Metadata | Generation Data |
|--------------------------------|--------|----------|-----------------|
| git commit-graph write         | 14.45s | 14.28s   | 14.63s          |
| git log --topo-order -10000    | 0.211s | 0.206s   | 0.208s          |
| git log --topo-order -100 A..B | 0.019s | 0.015s   | 0.015s          |
| git merge-base A..B            | 0.137s | 0.137s   | 0.137s          |

- Metadata and generation data chunks perform better than master on
  using commit-graph files since they use corrected commit dates.

- The increased I/O time for parsing GDAT does not affect performance as
  much as expected.

- Generation data commit-graph takes longer to write since more
  information is written into the file.

As using the commit-graph is much more frequent than writing, we can
consider both approaches to perform equally well.

I prefer generation data chunk approach as it also removes 30-bit length
restriction on generation numbers.

Thanks
Abhishek
