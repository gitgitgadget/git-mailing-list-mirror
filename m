Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EBB020248
	for <e@80x24.org>; Sat, 16 Mar 2019 20:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCPUbG (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 16:31:06 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:41377 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfCPUbF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 16:31:05 -0400
Received: by mail-io1-f45.google.com with SMTP id v10so11171035iom.8
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=K+AwtP2ce0tnG7c5wmNdYeElWaBNJeA4EWMU/zMkXvA=;
        b=q3GQkm+Iiyl3HvCBM6V+sVtTGIlqQGTXcor0WwPjekZ3OqNrawuVGfo4lYvMb2GPsr
         GqkB9fz/Kj/eRRmtXFSaliZ1sQLbwAbIxnykbDlVmdut68W6kd6noJXK0z5LyjG5HNu9
         n5MpW0dF+5bFl/MOmv9fR3GzDB9jVu8j88Nwq6mgjEuB8KAunCTHJ6GqSQjDAgicChEb
         WuAEXw0BOicsB1Am5J5uWmB7Ttt0MYZVLmVkxoJZMtASGftXQXy+i2+ROiaNfKVNwiER
         M+G2zwnUPgmAsQRQIT0sngkHiWjpGASl7I9HKoPdLIZITkkxcCfPYRUVPSymAfaZZxxa
         whpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=K+AwtP2ce0tnG7c5wmNdYeElWaBNJeA4EWMU/zMkXvA=;
        b=cefPB9gjf9O3wZQQmco+x9JjzbtddZ1PmlTrPWU4OAlvlGP33xL7oOUs75KvT/ovb9
         362kqX/WLfAFsyEZJLaTRhFykuU7nLYDTBGKw8c/bDelIaYEMQf2s3vXtYAyZdFQ9d40
         YFvvoZu7IEMtO22j6PKfrBWrZ1FOT0fdNqMDEWt5aQUbA+RsjJQ3maFYKM539kyJoMhX
         sDarBDLZgRPb75eDRHTSHuChA1FWayVq3+Prmjx/dCAkKk/bIcf3y2NdTJA9xkCh+il3
         JRLvTH1+2o6YC3I4zIH1pulI86x2OABDAnRIJgNZH31m9LHy+mUA4x8fM8Lgkz3mPVam
         hT3w==
X-Gm-Message-State: APjAAAXbkSdA8fuvTR9Wv2wf2oiGUy5OwWl9YQR9YW1bOCFCu3lwHFk8
        hDCJ2F7T4hYUEp+DJTkZ+5nyzKGAJwMH8O42YhxJ
X-Google-Smtp-Source: APXvYqw8ZYz6bJtWDDIaCJjMbjay/iNhxqxPgsO4pWGU6Q5UKxZyhwRKfDnVHdkIyWHHIdBRAenOs1EpEIaRmrnVg08=
X-Received: by 2002:a5e:8403:: with SMTP id h3mr6452604ioj.159.1552768264733;
 Sat, 16 Mar 2019 13:31:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:661c:0:0:0:0:0 with HTTP; Sat, 16 Mar 2019 13:31:04
 -0700 (PDT)
From:   Richard Hipp <drh@sqlite.org>
Date:   Sat, 16 Mar 2019 16:31:04 -0400
X-Google-Sender-Auth: yBaNQ9BDdo0ydjq85cYD-_HOkd8
Message-ID: <CALwJ=MzrqPUNw=jc0NRtaJaJG+ErXNb577JNSN66GiGY4UFtRw@mail.gmail.com>
Subject: git-fast-import yields huge packfile
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to transform a repository from another VCS into a Git
repository using "git fast-import".  It appears to work, but the
resulting Git repository is huge relative to the original - 18 times
larger. Most of the space seems to be taken up by a single large
packfile.  That packfile is about 967 MB which is about 1/4th the
total uncompressed size of all 41785 distinct Blobs in the original
repository.  The source VCS is able to compress this down to 52 MB by
comparison.

Maybe I'm doing something wrong with the fast-import stream that is
defeating Git's attempts at delta compression....

Are there any utility programs available for analyzing packfiles so
that I try to figure out where the inefficiencies are cropping up, so
that I can try to address them?

Anybody have any suggestions on what I should be looking for?

If anyone would care to see this oversized packfile and perhaps offer
suggestions on how I can make it more space-efficient, it can be
cloned from https://github.com/drhsqlite/fossil-mirror.git - at least
for now - surely I will delete that repo and regenerate it once I
figure out this problem.

-- 
D. Richard Hipp
drh@sqlite.org
