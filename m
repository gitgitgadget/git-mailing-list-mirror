Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AEAC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D6F2053B
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc/ViXir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbgEMSFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:09 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359EAC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:09 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id r3so191938qve.1
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKo2bGP26kDJ17+Tdx5X/rzy2WkB25LhjqX9lB1eXR8=;
        b=Vc/ViXirqf+p/EyExVMPG5Yf5PVQT0NreN92jgNWkbJ07C+2gROT82J2u0QEWXFNct
         wwsrRn2zBs8Z0Y9i32V1c38XWFAVA7WJbc0vFYolyz9I9mtnrAK0zxitvzUKENTH+2NZ
         Gh4W1jOOR8dEeQUQ2S972nmiNA5EIG5KNv2Z1sboIwq/t6VGa+FsuHXbyoLA0tdeG9vn
         1o7h4+A6usFSCBzosSySCMC2oK3SMF77m+IvMuPMVJjH4AQfk1xen0580yDB0sEO+Ycj
         a+uQXomR6QtCOx66+XCRF0m8ptDVjfqvhRHCZ8QGdq4t98uHTRJ/KnHjeRNIdnaR7ziY
         2o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKo2bGP26kDJ17+Tdx5X/rzy2WkB25LhjqX9lB1eXR8=;
        b=KQFsQghai7QRa+x8xVEdkMSNyTiSGSQ+avvVJI61ERkRpEMY6/Zwj8VBnA9/iYp/JO
         fNl9/pDBasOLl7XoHG238JCt6/BHju3M6FbuBXXL3nDGGIBpuAkOfPQC+Hf94rnyH4HN
         /aAPsAc4UY3+mJtNAMrWmmw+6aPzRWdSyDnzt7wVxyeDkMi+NICN0yteF+okyNIqCAHG
         oEm8ow1675whxEOUMp0iypeTh3z2xqqEIJEFcB5etidz5liqee685I+pTgEaDLrzkqAd
         nxYiECuOrJ7PvjAnNbqIsr1Cv3senJXiovwAYPx9Sa1SGwp3W6sLkCOROKpAQuEVIDoq
         xwxg==
X-Gm-Message-State: AOAM5323njaZR7mytMdV9l4GrFYRzcwcAigvrF9KK6M3wUazB1m7u8ff
        rt5i0WC5bk3nAjrIsy7Rcd6VHvrB
X-Google-Smtp-Source: ABdhPJzCcW11lyW7sBa8z+YMcdTsa1sDiDtI+arrbSShBBRRR9fD+Lou7H6kbUMxlY4TFfBdhH/H9w==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr916590qvx.104.1589393107855;
        Wed, 13 May 2020 11:05:07 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 0/6] remote-curl: partial fix for a deadlock with stateless rpc
Date:   Wed, 13 May 2020 14:04:52 -0400
Message-Id: <cover.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following command hangs forever:

	$ git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012
	Cloning into 'git'...

This occurs because the --shallow-since arg is incorrect and the server
dies early. However, remote-curl does not realise that the server
errored out and just faithfully forwards the packets to fetch-pack
before waiting on more input from fetch-pack. Meanwhile, fetch-pack
keeps reading as it still expects more input. As a result, the processes
deadlock. Original analysis by Peff:
https://lore.kernel.org/git/20200328154936.GA1217052@coredump.intra.peff.net/

This isn't a full fix as it may still be possible to deadlock, as
described in the last commit message. However, this patch is probably
better than nothing as it fixes the reported bug. I've been working on
the proper reframing fix on-and-off for the past while but it seems
considerably more complicated so it'll probably take a while for me to
get it to a ready state.

Denton Liu (6):
  remote-curl: fix typo
  remote-curl: remove label indentation
  transport: combine common cases with a fallthrough
  pkt-line: extern packet_length()
  remote-curl: error on incomplete packet
  remote-curl: ensure last packet is a flush

 pkt-line.c             |  2 +-
 pkt-line.h             |  5 ++++
 remote-curl.c          | 58 +++++++++++++++++++++++++++++++++++++++---
 t/t5702-protocol-v2.sh | 17 +++++++++++++
 transport.c            | 10 +++-----
 5 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.26.2.706.g87896c9627

