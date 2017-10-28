Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F681FBF4
	for <e@80x24.org>; Sat, 28 Oct 2017 00:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdJ1AoX (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 20:44:23 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:47258 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdJ1AoW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 20:44:22 -0400
Received: by mail-io0-f177.google.com with SMTP id h70so16169303ioi.4
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ujksFRmrTD/EBaYIuZlpB08MJBqKUef10KDAQvTGqLU=;
        b=er9DH+LI3+eAK5uU3XdaOFmxV1gj6p+Zq+HbCVub5cPKZLbZwVmjdL9JJAIFMqY8pz
         W9n/55ROIRzL0XU6AZx+tDHU93dM86pL5yV9/NFHmyevPQMGGGPZ1o/6QtPR72yKZZun
         3FcBQA95bLxh3hxhdRWEesigPaNHvKfYTS8//HBwFGgJs7gcCICbE6AC6lkV/8F657FQ
         IinX01tNubXIB+0+hozhjWo0vB+jqQfS/LgxNhnYMcWYvIhYk1fX9PcwgqTpNnnKsjN0
         lnT1x93JAq1A2Z11aLi5MWuk/0F4Q5n7ACKMIfDLTnaaWccSDCn+gIr/6gEhaJPITsri
         fsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ujksFRmrTD/EBaYIuZlpB08MJBqKUef10KDAQvTGqLU=;
        b=q23bw+q660qG9GC6smVFMkIvjZEVdjWmaaSWCurHXrOKzVNux5+uBQRXwJWAdNuAvy
         OwpDvsFniqsAH9odJ62H/uXQ3am9LcQBm6Q5LLmfVTn3EwVlpE3b1boegnf7z82gqjAh
         arJTrJrkvXKjAKM2Ij53ueC0Ix6KstWamlBNPfrcUmxfgg94NvfZ9/Ai40zVYMFdPPwo
         RYtQYhThxeYcoIh1Nyz7xtXheR2wBNnxm+StNs297dJbqSs2xq2z1dwcog8dozi+bQi4
         7Xz0gz/X1x5N7QygHKBRj1sh3OnYVwaqf4bjKmFGrF9WxzM7lxs/n4mwP9xtAHcG8L/A
         Bcvg==
X-Gm-Message-State: AMCzsaWthk60nqoVLcPmk6pbLfTxjJcxzZJynxgxgLjoYPxuP3G8FJBh
        A42r9+QI48GRuETD4PMofwO/dlY9MBc=
X-Google-Smtp-Source: ABhQp+Suv/n7Yp3R+MIWqkChAn5brqbPpSIMeMdhqsR/2L5ahgZddyhfLOrJ3yZbWxaDLJotGXOLBA==
X-Received: by 10.36.209.2 with SMTP id w2mr2944718itg.130.1509151461341;
        Fri, 27 Oct 2017 17:44:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:1da7:34ee:3ff4:f700])
        by smtp.gmail.com with ESMTPSA id 194sm1639262ito.20.2017.10.27.17.44.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Oct 2017 17:44:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/3] git-describe <blob> ?
Date:   Fri, 27 Oct 2017 17:44:15 -0700
Message-Id: <20171028004419.10139-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Occasionally a user is given an object hash from a blob as an error message
or other output (e.g. [1]).

It would be useful to get a further description of such a blob, such as
the (commit, path) tuple where this blob was introduced.

This implements the answer in builtin/describe, but I am not sure if that
is the right place. (One office mate argued it could be a "reverse-blame"
that tells you all the trees/commits where the blob is referenced from).

This is RFC for other reasons as well: tests, docs missing.

Any feedback welcome,

thanks,
Stefan

[1] https://stackoverflow.com/questions/10622179/how-to-find-identify-large-files-commits-in-git-history

Stefan Beller (3):
  list-objects.c: factor out traverse_trees_and_blobs
  revision.h: introduce blob/tree walking in order of the commits
  builtin/describe: describe blobs

 builtin/describe.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 list-objects.c     | 48 +++++++++++++++++++++++++++-----------------
 revision.h         |  3 ++-
 3 files changed, 86 insertions(+), 23 deletions(-)

-- 
2.15.0.rc2.443.gfcc3b81c0a

