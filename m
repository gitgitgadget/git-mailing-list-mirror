Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB0920970
	for <e@80x24.org>; Tue, 11 Apr 2017 23:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbdDKXts (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 19:49:48 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34011 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbdDKXts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 19:49:48 -0400
Received: by mail-pg0-f54.google.com with SMTP id 21so5760806pgg.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JB/Gaj5EEaDjVWol6c0G1xTP9M9PlMPw6rvRLuqflqY=;
        b=V+JHELagp1kRo/7evlU8DQOc44jnA5FuyYBAlEcs8Pavg9Ij7x2fSwfNUz9Q0/0aQe
         mzJU6n5piybtIjWWO5wxVNs+gCaoVRZ94fVVo8klMjZMBxneHMZOn0ATJDBh6RnWEte5
         vtjVwkZ7iUn63ZVzn2LJ8tVD77LAl0mOtu9auiA/MKUaEwAhMA3CGO6ERWIIY+yB2x3/
         iiyHjU7iNV5ZAbGg6/uf4PgZcW2yU21G/9O+upcOqOJGZRMGiH7WmrfxcyFWW44k3/ol
         YbvhZjBUUlMBa7v4JBlffW6bd2Z+PpLzSeay1yFjT3Gxpk/Y0qlhZo97SDFRruX4Fe4h
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JB/Gaj5EEaDjVWol6c0G1xTP9M9PlMPw6rvRLuqflqY=;
        b=dwpyqw35JQGZrF4uXv5uWCrQmo0TdnL6VKlXdg3WA4HZr9FcxHjvb1m9+oPtrUeWpX
         EULB8oxuH+9L2kKWpxbZivREVjy+mHgf0BU+1eFnv25mGUA4IB0J+b0eDEg2V7PT9ZR6
         4oK0Q1kXtdn7mCjS5E5Oz2xqh/WixIi7ChEEInZB/+Txqw3QL+3cMeoHBH1ECOrf7Pnt
         4LAtN/gA4V60HMo+7lMg99QETbG+JeEGX3r5y9X92G++MLAHHU/+2wrY54QqBtJdXXAj
         SGI0Dw4iutDWKIhx0tcgR9Zgd3e9wGHgv3c95ywq1tcQ5gib0NwVpuwnS03VtkE8iXol
         sgCQ==
X-Gm-Message-State: AN3rC/4Mnu+2O/z1RQleoB9hrvVUcVKOk+pBj4R6mn7a9bv1+NW3P7VySUxRAfwm+j7GGut/
X-Received: by 10.84.238.198 with SMTP id l6mr25442040pln.95.1491954587293;
        Tue, 11 Apr 2017 16:49:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:118b:650f:9c66:86dd])
        by smtp.gmail.com with ESMTPSA id e76sm32468085pfk.75.2017.04.11.16.49.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 16:49:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] recursive submodules: git-reset!
Date:   Tue, 11 Apr 2017 16:49:19 -0700
Message-Id: <20170411234923.1860-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the BIG one has landed, e394fa01d6 (Merge branch
'sb/checkout-recurse-submodules', 2017-03-28), you would expect that
teaching to recurse into submodules is easy for all the remaining 
working tree manipulations?

It turns out it is. See the last patch how we teach git-reset to recurse
into submodules.

However when thinking more about what git-reset is expected to do,
I added tests and some fixes for them (patch 2+3).

patch 1 is a correctness thing, required for patch 3.

Thanks,
Stefan

Stefan Beller (4):
  entry.c: submodule recursing: respect force flag correctly
  submodule.c: uninitialized submodules are ignored in recursive
    commands
  submodule.c: harden submodule_move_head against broken submodules
  builtin/reset: add --recurse-submodules switch

 builtin/reset.c            | 30 ++++++++++++++++++++++++++++++
 entry.c                    |  8 ++++----
 submodule.c                | 20 ++++++++++++++++++++
 t/lib-submodule-update.sh  | 24 +++++++++++++++++++++---
 t/t7112-reset-submodule.sh |  8 ++++++++
 unpack-trees.c             |  7 ++++++-
 6 files changed, 89 insertions(+), 8 deletions(-)

-- 
2.12.2.603.g7b28dc31ba

