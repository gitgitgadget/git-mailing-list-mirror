Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98CC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B144233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgLPOv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgLPOv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:51:29 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5DC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:50:48 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p14so13568160qke.6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+EzkB1YsgR5/chzrEZv8bLI4SHqBeqM9sDsIVXTFcE=;
        b=p/Lzg2HD09M8TK36OYr1oSp79arHRNVGtN5C15b4XzWmdr+HPcZ1jRC58oPS3fCE63
         54v4xVbOjRmumn50u+rI5YddlRQxdqZrtqTIfCZ4NQcRamBDTioV9VjRTTFivN/lxvPm
         VDcbW/moDe4PBhHoQGPqmN6S3py/aNzInWq54ACNvTvr7DbWpmn1LhgeXyjETvy+FW0F
         dZDDoh8OQzWHewcO7FIB4PIdk0QPeCf+Gh87gKM12AL0KvMy27QwD0MZSwq/Wq6dczfC
         2hk7iOURwJArnz55eE1/A81w/rMEc0dYcp3kH7J1U6KyruNpJo9xbJZl3ZpqkJCpKI2s
         3Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+EzkB1YsgR5/chzrEZv8bLI4SHqBeqM9sDsIVXTFcE=;
        b=gJg/aX2G0fSzAjwdIuBPbTqe3L+uyZNuQg0LszcubDG9i3X4U9jygf4g+mFu6KGE1q
         /oN4jvc7OkNbIRs82Ozlcov8LUBDo0AJ1B4ZY86JnxD7hYs+xB31C3NAcyKtzsaew9Oh
         zmCZjmt+TmVaVDBATB4h8bE26/Yo4+ORyeVxtycrLa6nGwIqwM4xV1LZjMfPcJPmQtW6
         Sr2W2rMpke8HZNxqYprVZtsJZnq4j9Ls+ElGldMDFHL5N7r7NtNCaUikhviKnB9s5RrM
         GdOWZYg3zT7jTSvriOCKPNIF8dYGp4fK1B9/my+NjbVzW5U4QhepKdrgLyVKtL2sF2vv
         bcCQ==
X-Gm-Message-State: AOAM530Lfqwy29d6ilJgHhFVBMpfRP/zeOQfIvcu+gH8TOJNZfzLUpD8
        bqHZLGmAHL3zjVUpkIDxfPvYvgTDBnzRSg==
X-Google-Smtp-Source: ABdhPJxMAngAq+wvB/GbDtOOUnXqmdt3o0CkSf7jDsAc3w3oG7iK3PQ3v/iffo1chiyNeT+ihoEH3Q==
X-Received: by 2002:a37:9001:: with SMTP id s1mr39543062qkd.193.1608130247520;
        Wed, 16 Dec 2020 06:50:47 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:50:46 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: [PATCH v5 0/9] Parallel Checkout (part I)
Date:   Wed, 16 Dec 2020 11:50:29 -0300
Message-Id: <cover.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous rounds got many great suggestions about patches 1 to 10,
but not as many comments on the latter patches. Christian commented that
patches 10 and 11 are too long/complex, making the overall series harder
to review. So he suggested that I eject patches 10 to 19, and send them
later in a separated part. This will hopefully make the series easier to
review and move forward. (I also hope to include a desing doc in part 2
to make those two bigger patches more digestible.)

So this part is now composed only of the 9 preparatory patches, which
mainly focus on: (1) adding the 'struct conv_attrs' parameter to some
convert.c and entry.c functions (to avoid re-loading the attributes
during parallel checkout); and (2) making some functions public (for
parallel-checkout.c's later use).

Changes since v4:

General:
- Removed "[matheus.bernardino: ...]" lines from patches 1 to 4.
- Ejected patches 10 to 19, which will now be sent in part 2.

Patch 2:
- Fixed typo on commit message (s/on a index/on an index/).
- Added "_ca" to convert_to_working_tree_internal()'s name.

Patch 4:
- Reworded patch title for better clarity, as suggested by Christian.

Patch 5:
- Mentioned about moving a checkout_entry() comment from entry.c to
  entry.h in the patch's message.

Patch 7:
- Make patch's title more explicit and reworded message for clarity.

Patch 8:
- Fixed the last call to write_entry() in checkout_entry(): it should
  pass 'ca', not NULL.

Patch 9:
- Defined checkout_entry() -- which is now a wrapper to
  checkout_entry_ca() -- as a static inline function instead of a macro.
- Shortened patch's title.

Note: to see the big picture where these patches should fit in, please
check the previous round with the complete series:
https://lore.kernel.org/git/cover.1604521275.git.matheus.bernardino@usp.br/


Jeff Hostetler (4):
  convert: make convert_attrs() and convert structs public
  convert: add [async_]convert_to_working_tree_ca() variants
  convert: add get_stream_filter_ca() variant
  convert: add classification for conv_attrs struct

Matheus Tavares (5):
  entry: extract a header file for entry.c functions
  entry: make fstat_output() and read_blob_entry() public
  entry: extract update_ce_after_write() from write_entry()
  entry: move conv_attrs lookup up to checkout_entry()
  entry: add checkout_entry_ca() taking preloaded conv_attrs

 apply.c                  |   1 +
 builtin/checkout-index.c |   1 +
 builtin/checkout.c       |   1 +
 builtin/difftool.c       |   1 +
 cache.h                  |  24 -------
 convert.c                | 143 ++++++++++++++++++++-------------------
 convert.h                |  96 +++++++++++++++++++++++---
 entry.c                  |  85 +++++++++++++----------
 entry.h                  |  59 ++++++++++++++++
 unpack-trees.c           |   1 +
 10 files changed, 275 insertions(+), 137 deletions(-)
 create mode 100644 entry.h

Range-diff against v4:
 1:  2726f6dc05 !  1:  fa04185237 convert: make convert_attrs() and convert structs public
    @@ Commit message
         convert_crlf_action, which is more appropriate for the global namespace.
     
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    [matheus.bernardino: squash and reword msg]
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## convert.c ##
 2:  fc03417592 !  2:  2d3c1dc0a1 convert: add [async_]convert_to_working_tree_ca() variants
    @@ Commit message
     
         Separate the attribute gathering from the actual conversion by adding
         _ca() variants of the conversion functions. These variants receive a
    -    precomputed 'struct conv_attrs', not relying, thus, on a index state.
    +    precomputed 'struct conv_attrs', not relying, thus, on an index state.
         They will be used in a future patch adding parallel checkout support,
         for two reasons:
     
    @@ Commit message
           it for the main process, anyway.
     
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    [matheus.bernardino: squash, remove one function definition and reword]
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## convert.c ##
    @@ convert.c: void convert_to_git_filter_fd(const struct index_state *istate,
      }
      
     -static int convert_to_working_tree_internal(const struct index_state *istate,
    -+static int convert_to_working_tree_internal(const struct conv_attrs *ca,
    - 					    const char *path, const char *src,
    - 					    size_t len, struct strbuf *dst,
    - 					    int normalizing,
    -@@ convert.c: static int convert_to_working_tree_internal(const struct index_state *istate,
    - 					    struct delayed_checkout *dco)
    +-					    const char *path, const char *src,
    +-					    size_t len, struct strbuf *dst,
    +-					    int normalizing,
    +-					    const struct checkout_metadata *meta,
    +-					    struct delayed_checkout *dco)
    ++static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
    ++					       const char *path, const char *src,
    ++					       size_t len, struct strbuf *dst,
    ++					       int normalizing,
    ++					       const struct checkout_metadata *meta,
    ++					       struct delayed_checkout *dco)
      {
      	int ret = 0, ret_filter = 0;
     -	struct conv_attrs ca;
    @@ convert.c: static int convert_to_working_tree_internal(const struct index_state
     +				     void *dco)
      {
     -	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
    -+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, dco);
    ++	return convert_to_working_tree_ca_internal(ca, path, src, len, dst, 0,
    ++						   meta, dco);
      }
      
     -int convert_to_working_tree(const struct index_state *istate,
    @@ convert.c: static int convert_to_working_tree_internal(const struct index_state
     +			       const struct checkout_metadata *meta)
      {
     -	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
    -+	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, NULL);
    ++	return convert_to_working_tree_ca_internal(ca, path, src, len, dst, 0,
    ++						   meta, NULL);
      }
      
      int renormalize_buffer(const struct index_state *istate, const char *path,
    @@ convert.c: static int convert_to_working_tree_internal(const struct index_state
     +	int ret;
     +
     +	convert_attrs(istate, &ca, path);
    -+	ret = convert_to_working_tree_internal(&ca, path, src, len, dst, 1, NULL, NULL);
    ++	ret = convert_to_working_tree_ca_internal(&ca, path, src, len, dst, 1,
    ++						  NULL, NULL);
      	if (ret) {
      		src = dst->buf;
      		len = dst->len;
 3:  8ce20f1031 !  3:  8af17f6a9b convert: add get_stream_filter_ca() variant
    @@ Commit message
         attributes struct as a parameter.
     
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    [matheus.bernardino: move header comment to ca() variant and reword msg]
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## convert.c ##
 4:  aa1eb461f4 !  4:  f829e2e08f convert: add conv_attrs classification
    @@ Metadata
     Author: Jeff Hostetler <jeffhost@microsoft.com>
     
      ## Commit message ##
    -    convert: add conv_attrs classification
    +    convert: add classification for conv_attrs struct
     
         Create `enum conv_attrs_classification` to express the different ways
         that attributes are handled for a blob during checkout.
    @@ Commit message
         classifying logic is the same).
     
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    [matheus.bernardino: use classification in get_stream_filter_ca()]
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## convert.c ##
 5:  cb3dea224b !  5:  934ead9519 entry: extract a header file for entry.c functions
    @@ Commit message
         reside in cache.h. Although not many, they contribute to the size of
         cache.h and, when changed, cause the unnecessary recompilation of
         modules that don't really use these functions. So let's move them to a
    -    new entry.h header.
    +    new entry.h header. While at it let's also move a comment related to
    +    checkout_entry() from entry.c to entry.h as it's more useful to describe
    +    the function there.
     
         Original-patch-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
 6:  46ed6274d7 =  6:  da6d1d7624 entry: make fstat_output() and read_blob_entry() public
 7:  a0479d02ff !  7:  def654606d entry: extract cache_entry update from write_entry()
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    entry: extract cache_entry update from write_entry()
    +    entry: extract update_ce_after_write() from write_entry()
     
    -    This code will be used by the parallel checkout functions, outside
    -    entry.c, so extract it to a public function.
    +    The code that updates the in-memory index information after an entry is
    +    written currently resides in write_entry(). Extract it to a public
    +    function so that it can be called by the parallel checkout functions,
    +    outside entry.c, in a later patch.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
 8:  5c993cc27f !  8:  fbde901518 entry: move conv_attrs lookup up to checkout_entry()
    @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state
     +		ca = &ca_buf;
     +	}
     +
    -+	return write_entry(ce, path.buf, NULL, state, 0);
    ++	return write_entry(ce, path.buf, ca, state, 0);
      }
      
      void unlink_entry(const struct cache_entry *ce)
 9:  aa635bda21 !  9:  0556d32e8c entry: add checkout_entry_ca() which takes preloaded conv_attrs
    @@ Metadata
     Author: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## Commit message ##
    -    entry: add checkout_entry_ca() which takes preloaded conv_attrs
    +    entry: add checkout_entry_ca() taking preloaded conv_attrs
     
         The parallel checkout machinery will call checkout_entry() for entries
         that could not be written in parallel due to path collisions. At this
    @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state
      		convert_attrs(state->istate, &ca_buf, ce->name);
      		ca = &ca_buf;
      	}
    - 
    --	return write_entry(ce, path.buf, NULL, state, 0);
    -+	return write_entry(ce, path.buf, ca, state, 0);
    - }
    - 
    - void unlink_entry(const struct cache_entry *ce)
     
      ## entry.h ##
     @@ entry.h: struct checkout {
    @@ entry.h: struct checkout {
       */
     -int checkout_entry(struct cache_entry *ce, const struct checkout *state,
     -		   char *topath, int *nr_checkouts);
    -+#define checkout_entry(ce, state, topath, nr_checkouts) \
    -+		checkout_entry_ca(ce, NULL, state, topath, nr_checkouts)
     +int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
     +		      const struct checkout *state, char *topath,
     +		      int *nr_checkouts);
    ++static inline int checkout_entry(struct cache_entry *ce,
    ++				 const struct checkout *state, char *topath,
    ++				 int *nr_checkouts)
    ++{
    ++	return checkout_entry_ca(ce, NULL, state, topath, nr_checkouts);
    ++}
      
      void enable_delayed_checkout(struct checkout *state);
      int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
10:  bc8447cd9c <  -:  ---------- unpack-trees: add basic support for parallel checkout
11:  815137685a <  -:  ---------- parallel-checkout: make it truly parallel
12:  2b42621582 <  -:  ---------- parallel-checkout: support progress displaying
13:  960116579a <  -:  ---------- make_transient_cache_entry(): optionally alloc from mem_pool
14:  fb9f2f580c <  -:  ---------- builtin/checkout.c: complete parallel checkout support
15:  a844451e58 <  -:  ---------- checkout-index: add parallel checkout support
16:  3733857ffa <  -:  ---------- parallel-checkout: add tests for basic operations
17:  c8a2974f81 <  -:  ---------- parallel-checkout: add tests related to clone collisions
18:  86fccd57d5 <  -:  ---------- parallel-checkout: add tests related to .gitattributes
19:  7f3e23cc38 <  -:  ---------- ci: run test round with parallel-checkout enabled
-- 
2.29.2

