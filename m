Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133A3C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhLJMeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhLJMeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25EC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so14636781wrd.9
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9or/f/rmpVLqiwJM6wWdepb0Atx0O3zYtM6kOFcBPE=;
        b=ZkJZrLZQKEsNCtmhlJ6kN9xZkjJIK8+87W3pQ0ISgU/6BzML0Iocs4WnvFd7lPwS+K
         n74/FPsYAy9NCWDWpd73YP61XVE8WqRyx1jouWxP1dPNNRbkL5B747Ixz20R1ceAe0Cn
         LYQVlelhlKE+jAtKVSRioQUzo48dxUUZkF4hpVtMlM9N8ZL3rkBJkV2TyhD2MBfJCa+q
         OzdBOlIOh7DE2Q3QquVH5XY9neymwXRiqi0dusaQgYoFAJG7mzT0u/wSOlJ/Qy806Gbm
         6MCZneKrFZDY4dJD1SDJYOcS0WLf2QhNW5X03IUlJveCZucZls+xjBExXIqQqtDTwHvf
         uKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9or/f/rmpVLqiwJM6wWdepb0Atx0O3zYtM6kOFcBPE=;
        b=KZqZvyVXzIgeNMGMLuiOkKFOp1zQsikwEYtQcd+yQX82ZlhR33V2RVd5I6yRAnmjgm
         9+/NV+joFItDx/nULaAXGS+Rszmv8qs1L6bYp7nrx80C7UdPT5ujm5Ui8mDPRRPaBJ0+
         /wPBGBDsZNj7kQmpxxpkrPucKzFUCnZRalKR3wCxTBEy4Yg23fJo9vy5xFP/xFCA1wip
         lbxeWAVxWLV4goa4MjtzVHeBkwm9tYrbpfLpOmhW3bKRDrmsI9SDxJGTbaU0vGSMW0M4
         ogEjBiTWunUBWWUylg9QNyYZEHv1E2Dnthvs3220lT2s4seATXArZbib8TpdmsUiao+M
         DrNA==
X-Gm-Message-State: AOAM530NsEhPxv8pFqr+yCO44GfINsA9FKaDsOfYg2Fa0U3TuV/Ryxqr
        w204JN945GQqNoLxvUgzXkbCpv7nSdU7cQ==
X-Google-Smtp-Source: ABdhPJzTOxqKzUm7444W/SDopLifSCmkmVV6qTeOWsIddUTGHSmHZO1k5gJzIVlGJroX5BEJg78nkA==
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr14473304wry.306.1639139446382;
        Fri, 10 Dec 2021 04:30:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm11898982wmq.38.2021.12.10.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:30:45 -0800 (PST)
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
Subject: [RFC PATCH v2 0/5] range-diff: fix segfault due to integer overflow
Date:   Fri, 10 Dec 2021 13:30:37 +0100
Message-Id: <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now a much smaller and hopefully more sensible fix for an overflow in
range-diff, thanks a lot to Jeff King for comments on the previous
(bad) direction in v1.

Ævar Arnfjörð Bjarmason (5):
  range-diff: zero out elements in "cost" first
  linear-assignment.c: split up compute_assignment() function
  linear-assignment.c: take "size_t", not "int" for *_count
  range-diff.c: rename "n" to "column_count" in get_correspondences()
  range-diff: fix integer overflow & segfault on cost[i + n * j]

 linear-assignment.c | 110 +++++++++++++++++++++++++++++++-------------
 linear-assignment.h |  20 +++++++-
 range-diff.c        |  25 +++++-----
 3 files changed, 107 insertions(+), 48 deletions(-)

Range-diff against v1:
 1:  7c929096381 <  -:  ----------- string-list API: change "nr" and "alloc" to "size_t"
 2:  bd7d014c531 <  -:  ----------- range-diff.c: don't use st_mult() for signed "int"
 3:  183418f1223 <  -:  ----------- range-diff.c: use "size_t" to refer to "struct string_list"'s "nr"
 4:  fe9dcb2d453 !  1:  068c203adc6 range-diff: zero out elements in "cost" first
    @@ linear-assignment.c: void compute_assignment(int column_count, int row_count, in
      ## range-diff.c ##
     @@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
      	int *cost, c, *a2b, *b2a;
    - 	size_t i, j;
    + 	int i, j;
      
     -	ALLOC_ARRAY(cost, st_mult(n, n));
     -	ALLOC_ARRAY(a2b, n);
 5:  0e1e2d107cd =  2:  2233872545e linear-assignment.c: split up compute_assignment() function
 6:  9b697720e00 =  3:  580b76c0759 linear-assignment.c: take "size_t", not "int" for *_count
10:  46395080b64 !  4:  f8bbe1954fc linear-assignment.c: use "intmax_t" instead of "int"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    linear-assignment.c: use "intmax_t" instead of "int"
    +    range-diff.c: rename "n" to "column_count" in get_correspondences()
     
    -    Change the "int" type used by compute_assignment() to "intmax_t". On
    -    64 bit systems this changes the overflow "die" added in the preceding
    -    commit (which before that was a segfault) to something that merely
    -    takes a very long time and a lot of memory to run.
    -
    -    On my relatively beefy system this completes:
    -
    -        git -P range-diff --creation-factor=50 origin/master...git-for-windows/main
    -
    -    In around 300 seconds, with a reported max RSS of just under 18GB, but
    -    it does give you correct results for all ~50k commitsin that range.
    +    In preparation for using the COST macro in linear-assignment.c rename
    +    the "n" variable, it assumes that the "n" in "a + n * b" is named
    +    "column_count".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## linear-assignment.c ##
    -@@
    - #include "linear-assignment.h"
    - #include "compat/gnulib/intprops.h"
    - 
    --static inline int cost_index(int *cost, int a, int b, int c)
    -+static inline intmax_t cost_index(intmax_t *cost, intmax_t a, intmax_t b, intmax_t c)
    - {
    --	int r;
    -+	intmax_t r;
    - 
    - 	if (INT_MULTIPLY_WRAPV(a, c, &r))
    --		die(_("integer overflow in cost[%d + %d * %d] multiplication"), b, a, c);
    -+		die(_("integer overflow in cost[%"PRIuMAX" + %"PRIuMAX" * %"PRIuMAX"] multiplication"), b, a, c);
    - 	if (INT_ADD_WRAPV(b, r, &r))
    --		die(_("integer overflow in cost[%d + ((%d * %d) = %d)] addition"), b, a, c, r);
    -+		die(_("integer overflow in cost[%"PRIuMAX" + ((%"PRIuMAX" * %"PRIuMAX") = %"PRIuMAX")] addition"), b, a, c, r);
    - 
    - 	return r;
    - }
    -@@ linear-assignment.c: static inline int cost_index(int *cost, int a, int b, int c)
    - #define COST(column, row) cost[cost_index(cost, column_count, column, row)]
    - 
    - static void columns_reduction(size_t column_count, size_t row_count,
    --			      int *cost,
    --			      int *column2row, int *row2column,
    --			      int *v)
    -+			      intmax_t *cost,
    -+			      intmax_t *column2row, intmax_t *row2column,
    -+			      intmax_t *v)
    - {
    --	int i, j;
    -+	intmax_t i, j;
    - 
    - 	/* column reduction */
    - 	for (j = column_count - 1; j >= 0; j--) {
    --		int i1 = 0;
    -+		intmax_t i1 = 0;
    - 
    - 		for (i = 1; i < row_count; i++)
    - 			if (COST(j, i1) > COST(j, i))
    -@@ linear-assignment.c: static void columns_reduction(size_t column_count, size_t row_count,
    - }
    - 
    - static void reduction_transfer(size_t column_count, size_t row_count,
    --			       int *cost,
    --			       int *free_row, int *free_count,
    --			       int *column2row, int *row2column,
    --			       int *v)
    -+			       intmax_t *cost,
    -+			       intmax_t *free_row, intmax_t *free_count,
    -+			       intmax_t *column2row, intmax_t *row2column,
    -+			       intmax_t *v)
    - {
    --	int i, j;
    -+	intmax_t i, j;
    - 
    - 	/* reduction transfer */
    - 	for (i = 0; i < row_count; i++) {
    --		int j1 = row2column[i];
    -+		intmax_t j1 = row2column[i];
    - 		if (j1 == -1)
    - 			free_row[(*free_count)++] = i;
    - 		else if (j1 < -1)
    - 			row2column[i] = -2 - j1;
    - 		else {
    --			int min = COST(!j1, i) - v[!j1];
    -+			intmax_t min = COST(!j1, i) - v[!j1];
    - 			for (j = 1; j < column_count; j++)
    - 				if (j != j1 && min > COST(j, i) - v[j])
    - 					min = COST(j, i) - v[j];
    -@@ linear-assignment.c: static void reduction_transfer(size_t column_count, size_t row_count,
    - }
    - 
    - static void augmenting_row_reduction(size_t column_count,
    --				     int *cost,
    --				     int *column2row, int *row2column,
    --				     int *free_row, int *free_count, int *saved_free_count,
    --				     int *v)
    -+				     intmax_t *cost,
    -+				     intmax_t *column2row, intmax_t *row2column,
    -+				     intmax_t *free_row, intmax_t *free_count, intmax_t *saved_free_count,
    -+				     intmax_t *v)
    - {
    - 	int phase;
    - 
    - 	/* augmenting row reduction */
    - 	for (phase = 0; phase < 2; phase++) {
    --		int i;
    --		int k = 0;
    -+		intmax_t i;
    -+		intmax_t k = 0;
    - 
    - 		*saved_free_count = *free_count;
    - 		*free_count = 0;
    - 		while (k < *saved_free_count) {
    --			int j;
    --			int u1, u2;
    --			int j1 = 0, j2, i0;
    -+			intmax_t j;
    -+			intmax_t u1, u2;
    -+			intmax_t j1 = 0, j2, i0;
    - 
    - 			i = free_row[k++];
    - 			u1 = COST(j1, i) - v[j1];
    - 			j2 = -1;
    --			u2 = INT_MAX;
    -+			u2 = INTMAX_MAX;
    - 			for (j = 1; j < column_count; j++) {
    --				int c = COST(j, i) - v[j];
    -+				intmax_t c = COST(j, i) - v[j];
    - 				if (u2 > c) {
    - 					if (u1 < c) {
    - 						u2 = c;
    -@@ linear-assignment.c: static void augmenting_row_reduction(size_t column_count,
    - }
    - 
    - static void augmentation(size_t column_count,
    --			 int *cost,
    --			 int *column2row, int *row2column,
    --			 int *free_row, int free_count,
    --			 int *v)
    -+			 intmax_t *cost,
    -+			 intmax_t *column2row, intmax_t *row2column,
    -+			 intmax_t *free_row, intmax_t free_count,
    -+			 intmax_t *v)
    - {
    --	int i, j;
    --	int *d;
    --	int *pred, *col;
    --	int saved_free_count;
    -+	intmax_t i, j;
    -+	intmax_t *d;
    -+	intmax_t *pred, *col;
    -+	intmax_t saved_free_count;
    - 
    - 	/* augmentation */
    - 	saved_free_count = free_count;
    -@@ linear-assignment.c: static void augmentation(size_t column_count,
    - 	ALLOC_ARRAY(pred, column_count);
    - 	ALLOC_ARRAY(col, column_count);
    - 	for (free_count = 0; free_count < saved_free_count; free_count++) {
    --		int i1 = free_row[free_count], low = 0, up = 0, last, k;
    --		int min, c, u1;
    -+		intmax_t i1 = free_row[free_count], low = 0, up = 0, last, k;
    -+		intmax_t min, c, u1;
    - 
    - 		for (j = 0; j < column_count; j++) {
    - 			d[j] = COST(j, i1) - v[j];
    -@@ linear-assignment.c: static void augmentation(size_t column_count,
    - 
    - 			/* scan a row */
    - 			do {
    --				int j1 = col[low++];
    -+				intmax_t j1 = col[low++];
    - 
    - 				i = column2row[j1];
    - 				u1 = COST(j1, i) - v[j1] - min;
    -@@ linear-assignment.c: static void augmentation(size_t column_count,
    - update:
    - 		/* updating of the column pieces */
    - 		for (k = 0; k < last; k++) {
    --			int j1 = col[k];
    -+			intmax_t j1 = col[k];
    - 			v[j1] += d[j1] - min;
    - 		}
    - 
    - 		/* augmentation */
    - 		do {
    - 			if (j < 0)
    --				BUG("negative j: %d", j);
    -+				BUG("negative j: %"PRIuMAX, j);
    - 			i = pred[j];
    - 			column2row[j] = i;
    - 			SWAP(j, row2column[i]);
    -@@ linear-assignment.c: static void augmentation(size_t column_count,
    -  * i is `cost[j + column_count * i].
    -  */
    - void compute_assignment(size_t column_count, size_t row_count,
    --			int *cost,
    --			int *column2row, int *row2column)
    -+			intmax_t *cost,
    -+			intmax_t *column2row, intmax_t *row2column)
    - {
    --	int *v;
    --	int *free_row, free_count = 0, saved_free_count;
    -+	intmax_t *v;
    -+	intmax_t *free_row, free_count = 0, saved_free_count;
    - 
    - 	assert(column_count > 1);
    --	memset(column2row, -1, sizeof(int) * column_count);
    --	memset(row2column, -1, sizeof(int) * row_count);
    -+	memset(column2row, -1, sizeof(intmax_t) * column_count);
    -+	memset(row2column, -1, sizeof(intmax_t) * row_count);
    - 	ALLOC_ARRAY(v, column_count);
    - 
    - 	columns_reduction(column_count, row_count, cost, column2row,
    -
    - ## linear-assignment.h ##
    -@@
    -  * row_count).
    -  */
    - void compute_assignment(size_t column_count, size_t row_count,
    --			int *cost,
    --			int *column2row, int *row2column);
    --
    --/* The maximal cost in the cost matrix (to prevent integer overflows). */
    --#define COST_MAX (1<<16)
    --
    -+			intmax_t *cost,
    -+			intmax_t *column2row, intmax_t *row2column);
    - #endif
    -
      ## range-diff.c ##
     @@ range-diff.c: static int diffsize(const char *a, const char *b)
    - 		return count;
    - 
    - 	error(_("failed to generate diff"));
    --	return COST_MAX;
    -+	return INT_MAX;
    - }
    - 
      static void get_correspondences(struct string_list *a, struct string_list *b,
      				int creation_factor)
      {
    - 	size_t n = st_add(a->nr, b->nr);
    --	int *cost, c, *a2b, *b2a;
    -+	intmax_t *cost, c, *a2b, *b2a;
    - 	size_t i, j;
    - 
    - 	CALLOC_ARRAY(cost, st_mult(n, n));
    - 	CALLOC_ARRAY(a2b, n);
    - 	CALLOC_ARRAY(b2a, n);
    +-	int n = a->nr + b->nr;
    ++	int column_count = st_add(a->nr, b->nr);
    + 	int *cost, c, *a2b, *b2a;
    + 	int i, j;
    + 
    +-	CALLOC_ARRAY(cost, st_mult(n, n));
    +-	CALLOC_ARRAY(a2b, n);
    +-	CALLOC_ARRAY(b2a, n);
    ++	CALLOC_ARRAY(cost, st_mult(column_count, column_count));
    ++	CALLOC_ARRAY(a2b, column_count);
    ++	CALLOC_ARRAY(b2a, column_count);
      
    -+
      	for (i = 0; i < a->nr; i++) {
      		struct patch_util *a_util = a->items[i].util;
    - 
     @@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
    - 			else if (a_util->matching < 0 && b_util->matching < 0)
      				c = diffsize(a_util->diff, b_util->diff);
      			else
    --				c = COST_MAX;
    -+				c = INT_MAX;
    - 			cost[i + n * j] = c;
    + 				c = COST_MAX;
    +-			cost[i + n * j] = c;
    ++			cost[i + column_count * j] = c;
      		}
      
      		c = a_util->matching < 0 ?
    --			a_util->diffsize * creation_factor / 100 : COST_MAX;
    -+			a_util->diffsize * creation_factor / 100 : INT_MAX;
    - 		for (j = b->nr; j < n; j++)
    - 			cost[i + n * j] = c;
    + 			a_util->diffsize * creation_factor / 100 : COST_MAX;
    +-		for (j = b->nr; j < n; j++)
    +-			cost[i + n * j] = c;
    ++		for (j = b->nr; j < column_count; j++)
    ++			cost[i + column_count * j] = c;
      	}
    + 
    + 	for (j = 0; j < b->nr; j++) {
     @@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
    - 		struct patch_util *util = b->items[j].util;
      
      		c = util->matching < 0 ?
    --			util->diffsize * creation_factor / 100 : COST_MAX;
    -+			util->diffsize * creation_factor / 100 : INT_MAX;
    - 		for (i = a->nr; i < n; i++)
    - 			cost[i + n * j] = c;
    + 			util->diffsize * creation_factor / 100 : COST_MAX;
    +-		for (i = a->nr; i < n; i++)
    +-			cost[i + n * j] = c;
    ++		for (i = a->nr; i < column_count; i++)
    ++			cost[i + column_count * j] = c;
      	}
    + 
    +-	if (n > 1)
    +-		compute_assignment(n, n, cost, a2b, b2a);
    ++	if (column_count > 1)
    ++		compute_assignment(column_count, column_count, cost, a2b, b2a);
    + 
    + 	for (i = 0; i < a->nr; i++)
    + 		if (a2b[i] >= 0 && a2b[i] < b->nr) {
 7:  a82771413f7 !  5:  9194965635a linear-assignment.c: convert a macro to a "static inline" function
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    linear-assignment.c: convert a macro to a "static inline" function
    +    range-diff: fix integer overflow & segfault on cost[i + n * j]
     
    -    Change the COST() macro to be a "static inline" function. On GCC this
    -    makes no difference in performance, but this improves the readability
    -    of the function. In a subsequent commit we'll make use of this to
    -    extend this function with overflow detection.
    +    in preceding commits the "column_count" and the "int*"'s we malloc()
    +    were changed to track their length with a size_t, so we're able to
    +    track as many "cost" items as malloc() will give us.
    +
    +    But we'd still segfault on relatively large range comparisons,
    +    e.g. this would segfault:
    +
    +        git -P range-diff --creation-factor=50 origin/master...git-for-windows/main
    +
    +    The reason for that is that we'd still use integer types to compute an
    +    array index into the "cost" array, which would overflow. The result of
    +    a signed overflow in C is undefined, but on my system it'll result in
    +    a negative number, and a prompt segfault as we'll try to access a
    +    negative array index.
    +
    +    Luckily we used the COST() macro in linear-assignment.c already for
    +    all of these lookups, and in a preceding commit we renamed "n" in
    +    "range-diff.c"'s get_correspondences() to "column_count" in
    +    preparation for using it here.
    +
    +    So let's use it for the three occurrences of "cost" indexing in
    +    range-diff.c, and have the COST() macro itself do overflow checking
    +    with st_mult() and st_add(). Due to the cast to "size_t" from "int"
    +    we'll avoid the segfault, and will end up correctly pointing to the
    +    relevant "int *".
    +
    +    It's not important that we use the new cost_offset() inline function
    +    here, we could also use the st_*() macros inline. By using it we'll
    +    get a more meaningful backtrace in a debugger to the relevant
    +    addition/multiplication line if we end up calling die() here.
    +
    +    It's still possible for us to overflow even with this change, that's
    +    because the iteration variables (such as "i" and "j" in this diff
    +    context are all "int"), even if we changed those to "size_t" or
    +    "intmax_t" (not trivial, as we depend on them being negative in some
    +    places) the underlying "struct string_list"'s "nr" member is an
    +    "unsigned int", which would eventually overflow.
    +
    +    However the danger of that overflow isn't as great, as we were
    +    overflowing on "i + column_count * j" before this change, it'll
    +    require a much bigger range for us to have an integer overflow on the
    +    number of commits we're processing.
    +
    +    We're unlikely to encounter a 2-4 billion commit history on 32 bit
    +    platforms. Even if we did one of the types in the underlying object
    +    machinery would probably overflow before we overflowed here. So let's
    +    punt that for now. If we're ever going to solve that issue [1] to
    +    change the "struct string_list"'s "nr" member to a "size_t" might be a
    +    good start.
    +
    +    1. https://lore.kernel.org/git/RFC-patch-01.10-7c929096381-20211209T191653Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ linear-assignment.c
      #include "linear-assignment.h"
      
     -#define COST(column, row) cost[(column) + column_count * (row)]
    -+static inline int cost_index(int *cost, int a, int b, int c)
    +-
    + static void columns_reduction(size_t column_count, size_t row_count,
    + 			      int *cost,
    + 			      int *column2row, int *row2column,
    +
    + ## linear-assignment.h ##
    +@@ linear-assignment.h: void compute_assignment(size_t column_count, size_t row_count,
    + 			int *cost,
    + 			int *column2row, int *row2column);
    + 
    ++/**
    ++ * Get an overflow-proof offset into the "cost" array.
    ++ */
    ++static inline size_t cost_offset(const size_t column,
    ++				 const size_t column_count, const size_t row)
     +{
    -+	int r;
    ++	const size_t a = st_mult(column_count, row);
    ++	const size_t b = st_add(column, a);
     +
    -+	r = b + a * c;
    -+
    -+	return r;
    ++	return b;
     +}
     +
    -+#define COST(column, row) cost[cost_index(cost, column_count, column, row)]
    ++/**
    ++ * Convenience macro for doing the cost[] lookup using cost_offset().
    ++ */
    ++#define COST(column, row) cost[cost_offset((column), (column_count), (row))]
    ++
    + /* The maximal cost in the cost matrix (to prevent integer overflows). */
    + #define COST_MAX (1<<16)
      
    - static void columns_reduction(size_t column_count, size_t row_count,
    - 			      int *cost,
    +
    + ## range-diff.c ##
    +@@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
    + 				c = diffsize(a_util->diff, b_util->diff);
    + 			else
    + 				c = COST_MAX;
    +-			cost[i + column_count * j] = c;
    ++			COST(i, j) = c;
    + 		}
    + 
    + 		c = a_util->matching < 0 ?
    + 			a_util->diffsize * creation_factor / 100 : COST_MAX;
    + 		for (j = b->nr; j < column_count; j++)
    +-			cost[i + column_count * j] = c;
    ++			COST(i, j) = c;
    + 	}
    + 
    + 	for (j = 0; j < b->nr; j++) {
    +@@ range-diff.c: static void get_correspondences(struct string_list *a, struct string_list *b,
    + 		c = util->matching < 0 ?
    + 			util->diffsize * creation_factor / 100 : COST_MAX;
    + 		for (i = a->nr; i < column_count; i++)
    +-			cost[i + column_count * j] = c;
    ++			COST(i, j) = c;
    + 	}
    + 
    + 	if (column_count > 1)
 8:  794d494bedd <  -:  ----------- linear-assignment.c: detect signed add/mul on GCC and Clang
 9:  2026b4bff90 <  -:  ----------- linear-assignment.c: add and use intprops.h from Gnulib
-- 
2.34.1.932.g36842105b61

