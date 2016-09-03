Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0231FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 03:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbcICDbg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 23:31:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35600 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbcICDbf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 23:31:35 -0400
Received: by mail-pa0-f49.google.com with SMTP id hb8so45587051pac.2
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=odPmxweOH8j45NaJdmB3YBTtud4Nuw6UDTespigmGbI=;
        b=Q4fm72V8rQXIZ4nTHUKtMt8pgx4Kqhf24Ja1jzbQVxFFJveq2XMzk2crHngD29ueXL
         Pxq4iRUtLOAOd4GntRICWwHb/7Jot0jRTUoZ496rVmtRUBltZxC/uDnxYJGGaU5oUZMu
         2ZUTeEn4SR7onaL0x0z0SkB4pUJxeAHXEe3qKhpEYrevQmVm5AF4WpFI61L5LaAMOAqP
         r9IO6rhLv3H37y884ntURcgPjaYULf1haJIHAU4QUIKkBz+XHlxTtG6ZJDD/QLdaDbXq
         2RYJRYDJuCiccOJlopKwcoh1u9JDtzHUxG8JP9R3+LBWVV6YBmM6VKuDUNOsBJYHEleM
         hTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=odPmxweOH8j45NaJdmB3YBTtud4Nuw6UDTespigmGbI=;
        b=e9cZyTSrDCsfAHSNszOtNMpOMEivGtzmWY2ufnAOBvDYJ4MlW4KMcn4JFro4VkYDtd
         +CRpZ7nYq1JDtpPvFn1T0CEvaIFIBAhqcFZbUWNTi8VGjJs8Gnj2Mo1AdB6XIeI7GhIc
         goOjxrmF1YCTKSkXYl+Qy/+WQ0/XSCRvS7f0VOJLq4qAkcnwwRXoEJe2MHxyRGcunVAh
         0HbJuj8+1bMjQmAGcFlkI0fS5zlDHtmEtcvHCIcQgcQQrI61PQmvjenEIs6mRHGl9ap1
         SkrlH4HZHpno/X4FaxCkEkFwtVub6WhBohixPP06QVtgtiYU9WWRyLTIQJzuBhBbixSd
         D/VA==
X-Gm-Message-State: AE9vXwPQ1xwe6xhyUcuHOPRQPXfFep1z3OhuoBkQy3hq0FBiBIUk6DCkjWIDwztGIVF9jU0e
X-Received: by 10.66.144.200 with SMTP id so8mr41868512pab.94.1472873492497;
        Fri, 02 Sep 2016 20:31:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29f6:f946:ae72:afdc])
        by smtp.gmail.com with ESMTPSA id bx9sm17844608pab.17.2016.09.02.20.31.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 20:31:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/2] Color moved code differently
Date:   Fri,  2 Sep 2016 20:31:18 -0700
Message-Id: <20160903033120.20511-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc2.23.gf336a1a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When moving code (e.g. a function is moved to another part of the file or
to a different file), the review process is different than reviewing new
code. When reviewing moved code we are only interested in the diff as
where there are differences in the moved code, e.g. namespace changes.

However the inner part of these moved texts should not change.
To aid a developer reviewing such code, we'll color pure moved stuff
differently.

A line is colored differently if that line and the surroundign 2 lines
appear as-is in the opposite part of the diff.

Example:
http://i.imgur.com/ay84q0q.png

Or apply these patches and 
    git show e28eae3184b26d3cf3293e69403babb5c575342c
    git show bc9204d4ef6e0672389fdfb0d398fa9a39dba3d5
    git show 8465541e8ce8eaf16e66ab847086779768c18f2d

The code quality sucks though, hence RFC.

Thanks,
Stefan

Stefan Beller (2):
  diff.c: emit duplicate lines with a different color
  WIP xdiff: markup duplicates differently

 diff.c        |  26 ++++++++++++
 diff.h        |   4 +-
 xdiff/xdiff.h |   1 +
 xdiff/xemit.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 156 insertions(+), 3 deletions(-)

-- 
2.10.0.rc2.23.gf336a1a.dirty

