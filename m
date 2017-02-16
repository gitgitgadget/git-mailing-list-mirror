Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E921FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbdBPV6h (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:58:37 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35086 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPV6g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:58:36 -0500
Received: by mail-lf0-f48.google.com with SMTP id z127so14617584lfa.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pX64iFSvwG3DwFbulRMUJ1nd513Tu5ebQjzWquBp1S4=;
        b=cuhLG+8OpNCgVQGDKF+cS/k7PV7t6ppF++Y9chJHmQ08L3Eus/76YkNViuIjTgFVRx
         o3Q96TrXVgoCHwOl4u7Hfpc0V5l1R4TJpbKERn18fBAjwMzGb4K/hkR+wcaPQzv5u7tH
         2tGsPkwUXwvx1LTp40DwDvXkSCaK/kFsGAgrwltsHYfIQ9xTLQQyt6iaNTRCVaNtEHMM
         FIREYACGrDws2uMTwqXG+B5a5BbUenmFWF+lokiVG4v3J8E8Wx5lzHae/5vRqIMCfmhp
         Q8amXGGLuINQJsz60QSloHxfofgw/B1Svk1RpiLX0eXWs9JeFKKJYByRTEeq3QyGRcl3
         H3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pX64iFSvwG3DwFbulRMUJ1nd513Tu5ebQjzWquBp1S4=;
        b=P71Wtqp9IBv19TU+HD8joF62pALFNzdT88aw/3igqY1cjpop5BNYTiegl1tjjEGSs1
         xUTDTOwI8xwd/9gMBgA1X7zlUaBuuIZksoQixMZapZsmN4nwr3NAbnxOIRs+yi8DScwo
         6yoeuyrTc6KvplREUgjHYxpKfTjwA+eBP16A+JYr98XQtnnx5pVeNNHutd5lj/c3725n
         6WhXWSJ9c0qgd9wAvokgDi+/IV/LqDItdk9o2HeRflr7FMc6Id1m78aBltxXK1A9x26B
         PSfkLBWhQpU392W4cQYB2FlC/wu0+liYWY1UOJEU83i0D880EX18w+BZjGnGXj38TDsT
         BwTA==
X-Gm-Message-State: AMke39mp571Kpmkb1TLlEZPdo1juEwPe0jOVPCt4V7oNo60wJumSbOvMhuw6UhnX+5iIICWNxqAvGCZoXPlNLQ==
X-Received: by 10.25.16.158 with SMTP id 30mr1349098lfq.119.1487282315036;
 Thu, 16 Feb 2017 13:58:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Thu, 16 Feb 2017 13:58:14 -0800 (PST)
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Thu, 16 Feb 2017 13:58:14 -0800
Message-ID: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com>
Subject: There are too many unreachable loose objects
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Whenever I run "git push --force(-with-lease)" I get a variation of

Counting objects: 187, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (126/126), done.
Writing objects: 100% (187/187), 21.35 KiB | 0 bytes/s, done.
Total 187 (delta 78), reused 71 (delta 20)
warning: There are too many unreachable loose objects; run 'git prune'
to remove them.
To git@git.company.com:project.git
 + 51338ea...b0ebe39 my-branch -> my-branch (forced update)

So I'll run "git prune" and, for good measure, "git gc" (which even
includes "git prune"?). The first seems to do nothing, the latter does
its thing.

And then the next time (which could be a few minutes later) I get the
same warning. My branches aren't that big, the largest ever had 40-ish
commits. So abandoning a few dozen commits should not lead to this
warning, I would think.

What am I doing wrong?

Cheers,
Hilco
