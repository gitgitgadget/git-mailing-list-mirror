Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9941F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfIEWEy (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:04:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45057 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIEWEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:04:53 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so8210886iog.12
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lm/oOyJxo4sD2lsNjJchhlM9RZZKvUo04X4bWsG0Cx8=;
        b=cABmxg4r6bOzJxgF2SV3Tjl3kGW8dU1SIjpP0wtviy+CmPh68CklEOrDfCZZcTcWiE
         WatKReHQgdVbNId4HNa1saJvt+LIy6HxYggCHeMxpXdz5IbQ3VRLhNoRFnMc1adj1kyH
         b+r6DihRxPmpN1v3xpBcVEMXWxJYO/HCThsJBzPRxwur0AwkGyePiOndm9YXVJSeaKlc
         TJtiSySFaqIbPGiBgnpOjTuHQgEh7g+3PJeAH51w7EvrLbt/CbgoE7ogWkI3AN/7+igr
         /gxFVu8ivBZdBOn1oY2XopGJhJaV10kLu3s38eox89hZxGsWYFdP1kkPstDgK4xM2Ro3
         BBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lm/oOyJxo4sD2lsNjJchhlM9RZZKvUo04X4bWsG0Cx8=;
        b=izueFHe/QHpufULEYIh34G1I+w+DuFkpIC40Qv7QY7YQCMgAboviw0DbN6LVKns0rV
         uUr+avU7xvQVbBG9alPmik8hWqpqxVYxuclmOaQ+W0WJ4hR9RoHC9W8MWJlSWyxoiX67
         AsnvV6duFvVDxLVB5wExi7b0FPN5W2joMCgVMxUKHHM+d2JotDidEOAcPWU8XZHnd4p3
         N/Rt2xiavz6LD1+AKHcQQrtsyM8Vd4oCkJTguYXm8pJcq3NfQ4/YuoEdoWA7xJyB8Bie
         9aK2bdQWif1gVKlVPy8RHrJA87mjigzwH/BchIsGGPDLZbkTjofzjZxyXYkJMGrXNVRR
         Zlbw==
X-Gm-Message-State: APjAAAXtb0Sm5ny7eAN38pBcXkpmOcgFz1VxJL//ilrcG098U8zFyjyF
        tt7sSFaUf81ySQChwJ/cVCL8l+Kv6olYGw==
X-Google-Smtp-Source: APXvYqysQviJMC8GAUbyHOi+3qN0nx4ARDA/6KWAfQ+zi6xU6pptrOajyXlHSOqqjpu1l+QbaFpl+w==
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr3856998ion.229.1567721092649;
        Thu, 05 Sep 2019 15:04:52 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:3c19:faad:a3bb:990d])
        by smtp.gmail.com with ESMTPSA id f7sm2589496ioc.31.2019.09.05.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:04:52 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:04:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, peff@peff.net
Subject: [PATCH 0/3] commit-graph: harden against various corruptions
Message-ID: <cover.1567720960.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This patch series is a polished version of a series I posed in [1],
based on the subsequent discussion starting in [2]. It hardens the 'git
commit-graph write' code to handle two new types of object corruption
that previously resulted in a SIGSEGV, which are:

  - a commit which lists a parent that does not exist, or is corrupt

  - a commit which lists a corrupt tree, or omits the 'tree ' line
    entirely.

The series goes as follows: first, we introduce failing tests that
demonstrate the above two cases, then subsequent commits to fix each of
them in turn.

When reviewing this series, it is worth keeping in mind that this is
really only applying a band-aid to get around a quirk of the object
parsing code, which is graciously described by Peff in more detail in
[3].

Thanks in advance for your review. I'll deploy this in the meantime to
GitHub's fork and report back on the success in the next "What's
Cooking".

Thanks,
Taylor

[1]: https://public-inbox.org/git/34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com/
[2]: https://public-inbox.org/git/20190904030456.GA28836@sigill.intra.peff.net/
[3]: https://public-inbox.org/git/20190905064723.GC21450@sigill.intra.peff.net/

Taylor Blau (3):
  t/t5318: introduce failing 'git commit-graph write' tests
  commit-graph.c: handle commit parsing errors
  commit-graph.c: handle corrupt/missing trees

 commit-graph.c          | 11 +++++++++--
 commit.c                |  3 ++-
 t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

--
2.23.0
