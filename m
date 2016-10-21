Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995AE20229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755960AbcJURzK (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:10 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36550 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755499AbcJURzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:09 -0400
Received: by mail-pf0-f174.google.com with SMTP id e6so60469217pfk.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LzbvBaP7g17BrDgGf6QDbsFr7d3d8n8qStAgU8bns2A=;
        b=LPu1gofZqiUTWVcPKm7uf2yFYCSXTJkc/mQckeP4QPo+v2eF4zaCrs4W8UDqATkxqj
         cpTq9J+qYcmmh/J0EelNRS7TCDElA6pQOY3JXGWbl5k95L7mYydDZ8UVBAP1yeacZWBk
         oZzMjpTlvnt7KTVYTLoTzOtXuJ2Sh5SpdfY6HNsNgQS91Rd8zA5JTStSYBiXtIpKI0z5
         xgXqOY/xNvsyw3jBA0MMIFkW2O74xnAe8zNaU1eRwpLRSEQma2ItWZ9M6IhmtBN4avm3
         UZ0GQekHVtm4+Rh37XyMm7JvdKizbbMdidAL6pvYZ3YllVSCZ0x0rJXrNpGDRJSx0dII
         BvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LzbvBaP7g17BrDgGf6QDbsFr7d3d8n8qStAgU8bns2A=;
        b=kMH0tSNI+/H5aHcIEaCocgYRZos9uQC5BjRvH327NrtGV2NkQ213mKyOgGa3/PXeSr
         trPxA+DuK9o3Qpq5s4Zvkx161GAA3JIkT/HR0ScBCzLs30Vbs7iZmiObIdydwhaMdyQ6
         nelZEFN2cptkTKY1jwnOROMEB+4gHo72NF+ptO4NQykxXx36KydI2tEOL3RHbKaD6vd8
         h1fJJOK7JCwBFeRrrpxSu6jrkhGujvOqAd0F+DRkCyjxjSHSF83LbhcuuJe8PaN5S1cr
         oGxYnmtz5VmL1Eup6I4OYHJzBwzToBkFkHlmTJ+90Lg+v9u4yPLsJ496kD8j/YDwB6/o
         ov9A==
X-Gm-Message-State: ABUngvc4xPRrw6ynLQhlAI8cvfFQGcAp2amO+b/zfNp3pFQrVohC9yc5370UGOQIsQwlahHG
X-Received: by 10.99.100.132 with SMTP id y126mr3032558pgb.67.1477072508633;
        Fri, 21 Oct 2016 10:55:08 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 0/8] allow non-trailers and multiple-line trailers
Date:   Fri, 21 Oct 2016 10:54:55 -0700
Message-Id: <cover.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've updated patch 5/8 to use strcspn and to pass in the list of
separators, meaning that we no longer accept '=' in file input (and also
updated its commit message accordingly).

We also discussed inlining find_separator, but after looking at the
code, I think that it is more convenient if find_separator returns -1
when there is no separator, because of the 3 times it is used (as
of 8/8), it is checked twice with '>= 1' (since both "no separator" and
"string begins with separator" are handled in the same way - treating
them as a non-trailer line). So I have left it as its own function.

No other updates.

Jonathan Tan (8):
  trailer: improve const correctness
  trailer: use list.h for doubly-linked list
  trailer: streamline trailer item create and add
  trailer: make args have their own struct
  trailer: clarify failure modes in parse_trailer
  trailer: allow non-trailers in trailer block
  trailer: forbid leading whitespace in trailers
  trailer: support values folded to multiple lines

 Documentation/git-interpret-trailers.txt |  14 +-
 t/t7513-interpret-trailers.sh            | 299 +++++++++++++++
 trailer.c                                | 620 +++++++++++++++++--------------
 3 files changed, 654 insertions(+), 279 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

