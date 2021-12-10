Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC2C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbhLJMea (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbhLJMe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86422C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so14670582wrn.6
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktPXuwmomsQoVoLpdE5uBZPdjll7LKe8ikENoOgeyDQ=;
        b=fhl9OQeEHxaEuoFXPSCSOrhl+VWyxAUPn6rHcZDeAtGBVe5K89NXroWFpWpZP37m1b
         8uH/fz77ABJ21S3fuojweOFjOSZql3CTftoLWbKwbxSbtASSrIKPZKOuUTLzo94S3kbL
         vRcnzNKSyiQqdxcqvRWNjZkZspzxRzqBMGvHl+sCX9Rr06dFR7+9FPnpv5rQFvj/J6jr
         +3hE4DnxrEKa6QkDYkgz0olJ3McxC0P6b1DWkB3cIURUDvlSik/UrXm0xMe2p78D7zA4
         ma/0rEzBGPn+346JN+J0VpRMKqFlrImzWo7SmO9RikKGq4A69tXH1aIk/qujP9Lmjc5V
         5Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktPXuwmomsQoVoLpdE5uBZPdjll7LKe8ikENoOgeyDQ=;
        b=s96XYOI+VQ00LqFazQdyl3NRcT4Kk4XPLK8oZ7lxovmlppH8Sr0okGE3Zpc6TydVnW
         pQxYSBLg1AVI7pYQCoEGxtFD1tSLlUF09miVjns10kooKTdU9JquDydEZM1oRw+v7Za3
         ng2AvJIRuKnPvxXbAnZDq6YXn5N4U/xlxXe7TwTTSvHBYAL0ADM1Vmdo+3vc+bL6ztLc
         FH1UewGxhJvNTXytb2eJFNUQQjSC19lQ7vyT5YMxM3D0QzB+6bBYGXMhjld6iKxUVqwZ
         PNj7f/5uWdtrrlHTB96IkAlatpY3rQO0iulDz8qRZE8Q2uUVedfJehctwqViEnbAOa94
         YTFg==
X-Gm-Message-State: AOAM530LEP+wTrEPYgnmtlZs0Jc73F/pcnzJRXN/e7owJdCK5RMYIxRx
        X58vXftLQsKj0FZYM59ekhZik9Uh3yFouw==
X-Google-Smtp-Source: ABdhPJwdMMG6TH2AIAJDj/mE3Ccii3+8qw9sgOW1y78rOH2cRcpMl+g+zEvZcwcSSIkGo9tLsElSog==
X-Received: by 2002:adf:e2c5:: with SMTP id d5mr13819315wrj.338.1639139450842;
        Fri, 10 Dec 2021 04:30:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm11898982wmq.38.2021.12.10.04.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:30:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 5/5] range-diff: fix integer overflow & segfault on cost[i + n * j]
Date:   Fri, 10 Dec 2021 13:30:42 +0100
Message-Id: <RFC-patch-v2-5.5-9194965635a-20211210T122901Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com> <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

in preceding commits the "column_count" and the "int*"'s we malloc()
were changed to track their length with a size_t, so we're able to
track as many "cost" items as malloc() will give us.

But we'd still segfault on relatively large range comparisons,
e.g. this would segfault:

    git -P range-diff --creation-factor=50 origin/master...git-for-windows/main

The reason for that is that we'd still use integer types to compute an
array index into the "cost" array, which would overflow. The result of
a signed overflow in C is undefined, but on my system it'll result in
a negative number, and a prompt segfault as we'll try to access a
negative array index.

Luckily we used the COST() macro in linear-assignment.c already for
all of these lookups, and in a preceding commit we renamed "n" in
"range-diff.c"'s get_correspondences() to "column_count" in
preparation for using it here.

So let's use it for the three occurrences of "cost" indexing in
range-diff.c, and have the COST() macro itself do overflow checking
with st_mult() and st_add(). Due to the cast to "size_t" from "int"
we'll avoid the segfault, and will end up correctly pointing to the
relevant "int *".

It's not important that we use the new cost_offset() inline function
here, we could also use the st_*() macros inline. By using it we'll
get a more meaningful backtrace in a debugger to the relevant
addition/multiplication line if we end up calling die() here.

It's still possible for us to overflow even with this change, that's
because the iteration variables (such as "i" and "j" in this diff
context are all "int"), even if we changed those to "size_t" or
"intmax_t" (not trivial, as we depend on them being negative in some
places) the underlying "struct string_list"'s "nr" member is an
"unsigned int", which would eventually overflow.

However the danger of that overflow isn't as great, as we were
overflowing on "i + column_count * j" before this change, it'll
require a much bigger range for us to have an integer overflow on the
number of commits we're processing.

We're unlikely to encounter a 2-4 billion commit history on 32 bit
platforms. Even if we did one of the types in the underlying object
machinery would probably overflow before we overflowed here. So let's
punt that for now. If we're ever going to solve that issue [1] to
change the "struct string_list"'s "nr" member to a "size_t" might be a
good start.

1. https://lore.kernel.org/git/RFC-patch-01.10-7c929096381-20211209T191653Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c |  2 --
 linear-assignment.h | 17 +++++++++++++++++
 range-diff.c        |  6 +++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index 1f8329701a0..88d15c2ad32 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -6,8 +6,6 @@
 #include "cache.h"
 #include "linear-assignment.h"
 
-#define COST(column, row) cost[(column) + column_count * (row)]
-
 static void columns_reduction(size_t column_count, size_t row_count,
 			      int *cost,
 			      int *column2row, int *row2column,
diff --git a/linear-assignment.h b/linear-assignment.h
index 9ff055baac1..5f8bcedc2c5 100644
--- a/linear-assignment.h
+++ b/linear-assignment.h
@@ -17,6 +17,23 @@ void compute_assignment(size_t column_count, size_t row_count,
 			int *cost,
 			int *column2row, int *row2column);
 
+/**
+ * Get an overflow-proof offset into the "cost" array.
+ */
+static inline size_t cost_offset(const size_t column,
+				 const size_t column_count, const size_t row)
+{
+	const size_t a = st_mult(column_count, row);
+	const size_t b = st_add(column, a);
+
+	return b;
+}
+
+/**
+ * Convenience macro for doing the cost[] lookup using cost_offset().
+ */
+#define COST(column, row) cost[cost_offset((column), (column_count), (row))]
+
 /* The maximal cost in the cost matrix (to prevent integer overflows). */
 #define COST_MAX (1<<16)
 
diff --git a/range-diff.c b/range-diff.c
index b2e7db2c954..b4f015213af 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -328,13 +328,13 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 				c = diffsize(a_util->diff, b_util->diff);
 			else
 				c = COST_MAX;
-			cost[i + column_count * j] = c;
+			COST(i, j) = c;
 		}
 
 		c = a_util->matching < 0 ?
 			a_util->diffsize * creation_factor / 100 : COST_MAX;
 		for (j = b->nr; j < column_count; j++)
-			cost[i + column_count * j] = c;
+			COST(i, j) = c;
 	}
 
 	for (j = 0; j < b->nr; j++) {
@@ -343,7 +343,7 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 		c = util->matching < 0 ?
 			util->diffsize * creation_factor / 100 : COST_MAX;
 		for (i = a->nr; i < column_count; i++)
-			cost[i + column_count * j] = c;
+			COST(i, j) = c;
 	}
 
 	if (column_count > 1)
-- 
2.34.1.932.g36842105b61

