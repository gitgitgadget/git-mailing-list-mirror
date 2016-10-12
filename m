Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CF6215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933430AbcJLXk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:40:28 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35412 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932370AbcJLXk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:40:26 -0400
Received: by mail-pf0-f182.google.com with SMTP id s8so25440175pfj.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y9SaIGgNO3jfUvo1XO9hq+u6LGsnYqVjog9r+M23ROM=;
        b=JqEbIwAatFIvKtP2itxlgRsZ72VsfvGEp/QG4+eOo+XbiejuCTumC2vjXLnJzpXiSa
         0GbjIA7I6ZB5TojPQkFgwcp+V04+1H3m9B5arIPZVx2+gzXa0VpBlgZ1OGp+gLyjK8Lv
         cBzdbFiX+ExWb6JhhhAUU8QFFlXOCQ7jqEvCF0yZUuY9XKc0WSR5Nk2aJ5/UTGZ3xjE4
         mVIi8VwQEMOtu5otn5Sr3r6aiPSZGQ+HDukYlDyIzjEoLjZf/IjKS5HsHhYyWVz3U0kJ
         oNymsoqlFG5Qb4i0ly5ThzqyT+F9JvxAlWmIiy0XqaK59Ird9t9ZMNl2EUEsiSGSKN81
         K7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y9SaIGgNO3jfUvo1XO9hq+u6LGsnYqVjog9r+M23ROM=;
        b=aWQ2Prxto75ORklUJEyW6XJ5j4gguzE0FSrdDfjLdP2yzjk1a9DeuWCtjzk6fhZbPp
         8IfvXzkpOWhhvJQGdzfRENfm6tW8Xn8Fj5lt4vgiQbewqdtuiC2gDRVrK9qBf+7SlXYw
         q4IkkK4RVUXw+kQAzLDKsX+5GKui0AUN8VQETuwgDkMq6g5IIsdoXDxowZ8XUZuL1Ggf
         sA8q6vrBZzRVtTfvmZ4/c/ULT9XrGQ5SwHbulObNhZAej880gMyBIR/YNbkEOkBwDGqI
         rriZ1T5Ldo3fXAhB3vn1cdWUaWt3sNNB0YBnFe7dJ+GQCC4FNWZr20dClPiuBLVS5ebj
         JUJA==
X-Gm-Message-State: AA6/9Rnj/DU51ijQEjlk2YriCn+6lanHLBqH4IyG5zqwPpFkEFd9HCeB6Q9H5sPmClgC8q63
X-Received: by 10.99.61.11 with SMTP id k11mr4604006pga.139.1476315625472;
        Wed, 12 Oct 2016 16:40:25 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id k67sm14294945pfb.86.2016.10.12.16.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Oct 2016 16:40:24 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com
Subject: [PATCH v2 0/6] allow non-trailers and multiple-line trailers
Date:   Wed, 12 Oct 2016 16:40:15 -0700
Message-Id: <cover.1476314576.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Peff, for the pointer to list.h. Using list.h does simplify the
code by a similar amount to switching it to a singly-linked list, so I
have done that (replacing my earlier "trailer: use singly-linked list,
not doubly" patch). Another advantage is that I no longer need to change
the algorithm, making for a smaller patch.

(There are some quirks resulting from list.h implementing a circular
list, like needing to pass "head" as a sentinel when iterating from the
middle of the list, but those are minor, and my original singly-linked
list implementation had quirks too anyway like needing to pass a pointer
to the next pointer.)

Updates:
 (-> 1/6)
 - Added separate patch for const correctness changes
 (1/5 -> 2/6)
 - Dropped singly-linked list patch, instead replacing existing
   doubly-linked list implementation with list.h
 (5/5 -> 6/6)
 - Used "char *" instead of "struct strbuf"
 - Modified test slightly to test whitespace at beginning of line

Jonathan Tan (6):
  trailer: improve const correctness
  trailer: use list.h for doubly-linked list
  trailer: streamline trailer item create and add
  trailer: make args have their own struct
  trailer: allow non-trailers in trailer block
  trailer: support values folded to multiple lines

 Documentation/git-interpret-trailers.txt |  10 +-
 t/t7513-interpret-trailers.sh            | 174 ++++++++++
 trailer.c                                | 538 +++++++++++++++----------------
 3 files changed, 444 insertions(+), 278 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

