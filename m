Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D6C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFF520782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="zTUSq2wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgKDUdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUdb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:31 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7351C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:30 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id r12so848637qvq.13
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsbDbkAA39Xe6lID0QN2zsbA+6ML6QIJS0Mg/dgq+kc=;
        b=zTUSq2wLlo0D51PgbjuamZx4gg0dUZ//Z4v9MxjlLdZQvTT0VHWNkPF58Hq2lCR2CF
         DuxyJvzOP51K6VNtJYcIRtoYewPwWrE9kghT46f0JDUZ/oaJncLmm5f3SNmHMLAiujxB
         NTNc0SuZ5XCQrKudQyyRwKyeFvryFnRFq4/KE5k32tJcZf/3rkR9nl/3TzaLaML5wjnr
         fk4CUNdFve8ncRKWlIcPCm+SkL9t09IYHTkZrTH3UQBUtJFPY5CdOInZVeisgSqONh28
         jSxobAdeYJLm3x6mIE6XErgo/VEYIflMs5DfRVOSds+jDhAFFjyPcS0W0ub56jqPSga8
         myXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsbDbkAA39Xe6lID0QN2zsbA+6ML6QIJS0Mg/dgq+kc=;
        b=VOBw5pUEbcCMUiq3DnrWd1neGTm2lDkO9yzfw5Zc5SQJZH8Pw6AxlDRkidy6J6QpHf
         Z/xECdAUcLKbRxtz8rPZGbinDmrLx3GVrv/6r6yXw6CnLsUgY5APh1yg+LeYgiCJP8se
         IeZy4jXBEVWyiM6HbTpalMxigM+RN4GyMKOp5C5LmQrY2N19fo3OBO7LNh/l8W2+sFAQ
         t3TOmGbfu1T8rMmKRJm1UVZOu4jTg03GRmCRe9hkPTlZtCOr97FWm/kW6hDnWFdqW3n+
         9Hy+4AmAII+S5Yp1qTKU0Cu4UHSBERdKNQ6P/RfJ1HZ7YpHcRzQ2so06e++HJrHIY58t
         vkpg==
X-Gm-Message-State: AOAM532KfpWft4f0+2yejhOoAo7zrleaASGQ3fDDqzMkKjJKczCZQFML
        hpEmM+zIdYeK0//5J41yAz0oUz+17mBoyg==
X-Google-Smtp-Source: ABdhPJyXd1NWWKqSn8+IRZvd06A6EGDFZbTqJjIknI/D9yUad9watFTf5ve/5/q6cmz2KndmTm6qSQ==
X-Received: by 2002:a0c:fa50:: with SMTP id k16mr5165120qvo.41.1604522009058;
        Wed, 04 Nov 2020 12:33:29 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:28 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 00/19] Parallel Checkout (part I)
Date:   Wed,  4 Nov 2020 17:32:59 -0300
Message-Id: <cover.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

Patch 1:
  - Renamed 'enum crlf_action' to 'enum convert_crlf_action', since it's
    now public and the latter suits better the global namespace.

Patch 2:
  - Implemented the regular [async_]convert_to_working_tree() functions
    as thin wrappers around the new _ca() variants.

Patches 5 and 6:
  - Properly added blank lines to separate declaration blocks in entry.h.

Patch 8:
  - Used a `struct conv_attrs ca_buf` (together with the `ca` pointer)
    to avoid the early return in checkout_entry() when
    S_ISREG(ce->ce_mode). I think this makes the patch a little easier
    to parse and also simplifies the next patch.

Patch 10:
  - Removed explicit zero initialization of the static struct parallel_checkout.
  - Removed the check_leading_dirs() function, which had a quite generic
    name, and integrated the code into write_pc_item().

    Note: for this change, I used the find_last_dir_sep() helper, which
    is slightly slower since it doesn't take the path's length, and
    thus, it has to iterate the whole string. Alternatively, We could
    add an strbuf_find_last_dir_sep() variant which takes an strbuf and
    starts the search from the end, to save some iterations per path.
    But this snippet will be removed in part 2, so I thought it wouldn't
    be worth adding a new helper now.

  - Rephrased comment about the has_dirs_only_path() call in workers, for
    better clarity.

- Changed all unnecessary uses of ++pre_increment in the series to
  post_increment++ (patches 10 and 11).


Jeff Hostetler (4):
  convert: make convert_attrs() and convert structs public
  convert: add [async_]convert_to_working_tree_ca() variants
  convert: add get_stream_filter_ca() variant
  convert: add conv_attrs classification

Matheus Tavares (15):
  entry: extract a header file for entry.c functions
  entry: make fstat_output() and read_blob_entry() public
  entry: extract cache_entry update from write_entry()
  entry: move conv_attrs lookup up to checkout_entry()
  entry: add checkout_entry_ca() which takes preloaded conv_attrs
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: support progress displaying
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: add tests for basic operations
  parallel-checkout: add tests related to clone collisions
  parallel-checkout: add tests related to .gitattributes
  ci: run test round with parallel-checkout enabled

 .gitignore                              |   1 +
 Documentation/config/checkout.txt       |  21 +
 Makefile                                |   2 +
 apply.c                                 |   1 +
 builtin.h                               |   1 +
 builtin/checkout--helper.c              | 142 ++++++
 builtin/checkout-index.c                |  22 +-
 builtin/checkout.c                      |  21 +-
 builtin/difftool.c                      |   3 +-
 cache.h                                 |  34 +-
 ci/run-build-and-tests.sh               |   1 +
 convert.c                               | 130 ++---
 convert.h                               |  96 +++-
 entry.c                                 | 102 ++--
 entry.h                                 |  55 +++
 git.c                                   |   2 +
 parallel-checkout.c                     | 632 ++++++++++++++++++++++++
 parallel-checkout.h                     | 103 ++++
 read-cache.c                            |  12 +-
 t/README                                |   4 +
 t/lib-encoding.sh                       |  25 +
 t/lib-parallel-checkout.sh              |  46 ++
 t/t0028-working-tree-encoding.sh        |  25 +-
 t/t2080-parallel-checkout-basics.sh     | 170 +++++++
 t/t2081-parallel-checkout-collisions.sh |  98 ++++
 t/t2082-parallel-checkout-attributes.sh | 174 +++++++
 unpack-trees.c                          |  22 +-
 27 files changed, 1766 insertions(+), 179 deletions(-)
 create mode 100644 builtin/checkout--helper.c
 create mode 100644 entry.h
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h
 create mode 100644 t/lib-encoding.sh
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh
 create mode 100755 t/t2081-parallel-checkout-collisions.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

Range-diff against v3:
 1:  dfc3e0fd62 !  1:  2726f6dc05 convert: make convert_attrs() and convert structs public
    @@ Commit message
         Move convert_attrs() declaration from convert.c to convert.h, together
         with the conv_attrs struct and the crlf_action enum. This function and
         the data structures will be used outside convert.c in the upcoming
    -    parallel checkout implementation.
    +    parallel checkout implementation. Note that crlf_action is renamed to
    +    convert_crlf_action, which is more appropriate for the global namespace.
     
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
         [matheus.bernardino: squash and reword msg]
    @@ convert.c
      struct text_stat {
      	/* NUL, CR, LF and CRLF counts */
      	unsigned nul, lonecr, lonelf, crlf;
    +@@ convert.c: static int text_eol_is_crlf(void)
    + 	return 0;
    + }
    + 
    +-static enum eol output_eol(enum crlf_action crlf_action)
    ++static enum eol output_eol(enum convert_crlf_action crlf_action)
    + {
    + 	switch (crlf_action) {
    + 	case CRLF_BINARY:
    +@@ convert.c: static int has_crlf_in_index(const struct index_state *istate, const char *path)
    + }
    + 
    + static int will_convert_lf_to_crlf(struct text_stat *stats,
    +-				   enum crlf_action crlf_action)
    ++				   enum convert_crlf_action crlf_action)
    + {
    + 	if (output_eol(crlf_action) != EOL_CRLF)
    + 		return 0;
    +@@ convert.c: static int encode_to_worktree(const char *path, const char *src, size_t src_len,
    + static int crlf_to_git(const struct index_state *istate,
    + 		       const char *path, const char *src, size_t len,
    + 		       struct strbuf *buf,
    +-		       enum crlf_action crlf_action, int conv_flags)
    ++		       enum convert_crlf_action crlf_action, int conv_flags)
    + {
    + 	struct text_stat stats;
    + 	char *dst;
    +@@ convert.c: static int crlf_to_git(const struct index_state *istate,
    + 	return 1;
    + }
    + 
    +-static int crlf_to_worktree(const char *src, size_t len,
    +-			    struct strbuf *buf, enum crlf_action crlf_action)
    ++static int crlf_to_worktree(const char *src, size_t len, struct strbuf *buf,
    ++			    enum convert_crlf_action crlf_action)
    + {
    + 	char *to_free = NULL;
    + 	struct text_stat stats;
    +@@ convert.c: static const char *git_path_check_encoding(struct attr_check_item *check)
    + 	return value;
    + }
    + 
    +-static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
    ++static enum convert_crlf_action git_path_check_crlf(struct attr_check_item *check)
    + {
    + 	const char *value = check->value;
    + 
     @@ convert.c: static int git_path_check_ident(struct attr_check_item *check)
      	return !!ATTR_TRUE(value);
      }
    @@ convert.c: static int git_path_check_ident(struct attr_check_item *check)
      
     
      ## convert.h ##
    -@@ convert.h: enum eol {
    - #endif
    +@@ convert.h: struct checkout_metadata {
    + 	struct object_id blob;
      };
      
    -+enum crlf_action {
    ++enum convert_crlf_action {
     +	CRLF_UNDEFINED,
     +	CRLF_BINARY,
     +	CRLF_TEXT,
    @@ convert.h: enum eol {
     +
     +struct conv_attrs {
     +	struct convert_driver *drv;
    -+	enum crlf_action attr_action; /* What attr says */
    -+	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
    ++	enum convert_crlf_action attr_action; /* What attr says */
    ++	enum convert_crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
     +	int ident;
     +	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
     +};
     +
    - enum ce_delay_state {
    - 	CE_NO_DELAY = 0,
    - 	CE_CAN_DELAY = 1,
    -@@ convert.h: void convert_to_git_filter_fd(const struct index_state *istate,
    - int would_convert_to_git_filter_fd(const struct index_state *istate,
    - 				   const char *path);
    - 
     +void convert_attrs(const struct index_state *istate,
     +		   struct conv_attrs *ca, const char *path);
     +
    - /*
    -  * Initialize the checkout metadata with the given values.  Any argument may be
    -  * NULL if it is not applicable.  The treeish should be a commit if that is
    + extern enum eol core_eol;
    + extern char *check_roundtrip_encoding;
    + const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 2:  c5fbd1e16d !  2:  fc03417592 convert: add [async_]convert_to_working_tree_ca() variants
    @@ convert.c: static int convert_to_working_tree_internal(const struct index_state
      
      	return ret | ret_filter;
      }
    -@@ convert.c: int async_convert_to_working_tree(const struct index_state *istate,
    - 				  const struct checkout_metadata *meta,
    - 				  void *dco)
    - {
    --	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
    -+	struct conv_attrs ca;
    -+	convert_attrs(istate, &ca, path);
    -+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, dco);
    - }
      
    - int convert_to_working_tree(const struct index_state *istate,
    -@@ convert.c: int convert_to_working_tree(const struct index_state *istate,
    - 			    size_t len, struct strbuf *dst,
    - 			    const struct checkout_metadata *meta)
    - {
    --	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
    -+	struct conv_attrs ca;
    -+	convert_attrs(istate, &ca, path);
    -+	return convert_to_working_tree_internal(&ca, path, src, len, dst, 0, meta, NULL);
    -+}
    -+
    +-int async_convert_to_working_tree(const struct index_state *istate,
    +-				  const char *path, const char *src,
    +-				  size_t len, struct strbuf *dst,
    +-				  const struct checkout_metadata *meta,
    +-				  void *dco)
     +int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
     +				     const char *path, const char *src,
     +				     size_t len, struct strbuf *dst,
     +				     const struct checkout_metadata *meta,
     +				     void *dco)
    -+{
    + {
    +-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
     +	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, dco);
    -+}
    -+
    + }
    + 
    +-int convert_to_working_tree(const struct index_state *istate,
    +-			    const char *path, const char *src,
    +-			    size_t len, struct strbuf *dst,
    +-			    const struct checkout_metadata *meta)
     +int convert_to_working_tree_ca(const struct conv_attrs *ca,
     +			       const char *path, const char *src,
     +			       size_t len, struct strbuf *dst,
     +			       const struct checkout_metadata *meta)
    -+{
    + {
    +-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
     +	return convert_to_working_tree_internal(ca, path, src, len, dst, 0, meta, NULL);
      }
      
    @@ convert.c: int convert_to_working_tree(const struct index_state *istate,
      		len = dst->len;
     
      ## convert.h ##
    -@@ convert.h: int convert_to_working_tree(const struct index_state *istate,
    - 			    const char *path, const char *src,
    - 			    size_t len, struct strbuf *dst,
    - 			    const struct checkout_metadata *meta);
    +@@ convert.h: const char *get_convert_attr_ascii(const struct index_state *istate,
    + int convert_to_git(const struct index_state *istate,
    + 		   const char *path, const char *src, size_t len,
    + 		   struct strbuf *dst, int conv_flags);
    +-int convert_to_working_tree(const struct index_state *istate,
    +-			    const char *path, const char *src,
    +-			    size_t len, struct strbuf *dst,
    +-			    const struct checkout_metadata *meta);
    +-int async_convert_to_working_tree(const struct index_state *istate,
    +-				  const char *path, const char *src,
    +-				  size_t len, struct strbuf *dst,
    +-				  const struct checkout_metadata *meta,
    +-				  void *dco);
     +int convert_to_working_tree_ca(const struct conv_attrs *ca,
     +			       const char *path, const char *src,
     +			       size_t len, struct strbuf *dst,
     +			       const struct checkout_metadata *meta);
    - int async_convert_to_working_tree(const struct index_state *istate,
    - 				  const char *path, const char *src,
    - 				  size_t len, struct strbuf *dst,
    - 				  const struct checkout_metadata *meta,
    - 				  void *dco);
     +int async_convert_to_working_tree_ca(const struct conv_attrs *ca,
     +				     const char *path, const char *src,
     +				     size_t len, struct strbuf *dst,
     +				     const struct checkout_metadata *meta,
     +				     void *dco);
    ++static inline int convert_to_working_tree(const struct index_state *istate,
    ++					  const char *path, const char *src,
    ++					  size_t len, struct strbuf *dst,
    ++					  const struct checkout_metadata *meta)
    ++{
    ++	struct conv_attrs ca;
    ++	convert_attrs(istate, &ca, path);
    ++	return convert_to_working_tree_ca(&ca, path, src, len, dst, meta);
    ++}
    ++static inline int async_convert_to_working_tree(const struct index_state *istate,
    ++						const char *path, const char *src,
    ++						size_t len, struct strbuf *dst,
    ++						const struct checkout_metadata *meta,
    ++						void *dco)
    ++{
    ++	struct conv_attrs ca;
    ++	convert_attrs(istate, &ca, path);
    ++	return async_convert_to_working_tree_ca(&ca, path, src, len, dst, meta, dco);
    ++}
      int async_query_available_blobs(const char *cmd,
      				struct string_list *available_paths);
      int renormalize_buffer(const struct index_state *istate,
 3:  c77b16f694 =  3:  8ce20f1031 convert: add get_stream_filter_ca() variant
 4:  18c3f4247e =  4:  aa1eb461f4 convert: add conv_attrs classification
 5:  2caa2c4345 !  5:  cb3dea224b entry: extract a header file for entry.c functions
    @@ entry.h (new)
     +#define CHECKOUT_INIT { NULL, "" }
     +
     +#define TEMPORARY_FILENAME_LENGTH 25
    -+
     +/*
     + * Write the contents from ce out to the working tree.
     + *
    @@ entry.h (new)
     + */
     +int checkout_entry(struct cache_entry *ce, const struct checkout *state,
     +		   char *topath, int *nr_checkouts);
    ++
     +void enable_delayed_checkout(struct checkout *state);
     +int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
    ++
     +/*
     + * Unlink the last component and schedule the leading directories for
     + * removal, such that empty directories get removed.
 6:  bfa52df9e2 !  6:  46ed6274d7 entry: make fstat_output() and read_blob_entry() public
    @@ entry.c: static int write_entry(struct cache_entry *ce,
     
      ## entry.h ##
     @@ entry.h: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
    -  * removal, such that empty directories get removed.
       */
      void unlink_entry(const struct cache_entry *ce);
    + 
     +void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
     +int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
    - 
    ++
      #endif /* ENTRY_H */
 7:  91ef17f533 !  7:  a0479d02ff entry: extract cache_entry update from write_entry()
    @@ entry.c: static int write_entry(struct cache_entry *ce,
      	return 0;
     
      ## entry.h ##
    -@@ entry.h: int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
    - void unlink_entry(const struct cache_entry *ce);
    +@@ entry.h: void unlink_entry(const struct cache_entry *ce);
    + 
      void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
      int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
     +void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 8:  81e03baab1 !  8:  5c993cc27f entry: move conv_attrs lookup up to checkout_entry()
    @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state
      {
      	static struct strbuf path = STRBUF_INIT;
      	struct stat st;
    -+	struct conv_attrs ca;
    ++	struct conv_attrs ca_buf, *ca = NULL;
      
      	if (ce->ce_flags & CE_WT_REMOVE) {
      		if (topath)
    @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state
     -		return write_entry(ce, topath, state, 1);
     +	if (topath) {
     +		if (S_ISREG(ce->ce_mode)) {
    -+			convert_attrs(state->istate, &ca, ce->name);
    -+			return write_entry(ce, topath, &ca, state, 1);
    ++			convert_attrs(state->istate, &ca_buf, ce->name);
    ++			ca = &ca_buf;
     +		}
    -+		return write_entry(ce, topath, NULL, state, 1);
    ++		return write_entry(ce, topath, ca, state, 1);
     +	}
      
      	strbuf_reset(&path);
    @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state
     -	return write_entry(ce, path.buf, state, 0);
     +
     +	if (S_ISREG(ce->ce_mode)) {
    -+		convert_attrs(state->istate, &ca, ce->name);
    -+		return write_entry(ce, path.buf, &ca, state, 0);
    ++		convert_attrs(state->istate, &ca_buf, ce->name);
    ++		ca = &ca_buf;
     +	}
     +
     +	return write_entry(ce, path.buf, NULL, state, 0);
 9:  e1b886f823 !  9:  aa635bda21 entry: add checkout_entry_ca() which takes preloaded conv_attrs
    @@ entry.c: static void mark_colliding_entries(const struct checkout *state,
      {
      	static struct strbuf path = STRBUF_INIT;
      	struct stat st;
    --	struct conv_attrs ca;
    +-	struct conv_attrs ca_buf, *ca = NULL;
     +	struct conv_attrs ca_buf;
      
      	if (ce->ce_flags & CE_WT_REMOVE) {
    @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state
      
      	if (topath) {
     -		if (S_ISREG(ce->ce_mode)) {
    --			convert_attrs(state->istate, &ca, ce->name);
    --			return write_entry(ce, topath, &ca, state, 1);
     +		if (S_ISREG(ce->ce_mode) && !ca) {
    -+			convert_attrs(state->istate, &ca_buf, ce->name);
    -+			ca = &ca_buf;
    + 			convert_attrs(state->istate, &ca_buf, ce->name);
    + 			ca = &ca_buf;
      		}
    --		return write_entry(ce, topath, NULL, state, 1);
    -+		return write_entry(ce, topath, ca, state, 1);
    - 	}
    - 
    - 	strbuf_reset(&path);
     @@ entry.c: int checkout_entry(struct cache_entry *ce, const struct checkout *state,
      	if (nr_checkouts)
      		(*nr_checkouts)++;
      
     -	if (S_ISREG(ce->ce_mode)) {
    --		convert_attrs(state->istate, &ca, ce->name);
    --		return write_entry(ce, path.buf, &ca, state, 0);
     +	if (S_ISREG(ce->ce_mode) && !ca) {
    -+		convert_attrs(state->istate, &ca_buf, ce->name);
    -+		ca = &ca_buf;
    + 		convert_attrs(state->istate, &ca_buf, ce->name);
    + 		ca = &ca_buf;
      	}
      
     -	return write_entry(ce, path.buf, NULL, state, 0);
    @@ entry.h: struct checkout {
     +int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
     +		      const struct checkout *state, char *topath,
     +		      int *nr_checkouts);
    -+
    + 
      void enable_delayed_checkout(struct checkout *state);
      int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
    - /*
10:  2bdc13664e ! 10:  bc8447cd9c unpack-trees: add basic support for parallel checkout
    @@ parallel-checkout.c (new)
     +	size_t nr, alloc;
     +};
     +
    -+static struct parallel_checkout parallel_checkout = { 0 };
    ++static struct parallel_checkout parallel_checkout;
     +
     +enum pc_status parallel_checkout_status(void)
     +{
    @@ parallel-checkout.c (new)
     +	 * stat() data, so that they can be found by mark_colliding_entries(),
     +	 * in the next loop, when necessary.
     +	 */
    -+	for (i = 0; i < parallel_checkout.nr; ++i) {
    ++	for (i = 0; i < parallel_checkout.nr; i++) {
     +		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
     +		if (pc_item->status == PC_ITEM_WRITTEN)
     +			update_ce_after_write(state, pc_item->ce, &pc_item->st);
     +	}
     +
    -+	for (i = 0; i < parallel_checkout.nr; ++i) {
    ++	for (i = 0; i < parallel_checkout.nr; i++) {
     +		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
     +
     +		switch(pc_item->status) {
    @@ parallel-checkout.c (new)
     +	return ret;
     +}
     +
    -+static int check_leading_dirs(const char *path, int len, int prefix_len)
    -+{
    -+	const char *slash = path + len;
    -+
    -+	while (slash > path && *slash != '/')
    -+		slash--;
    -+
    -+	return has_dirs_only_path(path, slash - path, prefix_len);
    -+}
    -+
     +static void write_pc_item(struct parallel_checkout_item *pc_item,
     +			  struct checkout *state)
     +{
     +	unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
     +	int fd = -1, fstat_done = 0;
     +	struct strbuf path = STRBUF_INIT;
    ++	const char *dir_sep;
     +
     +	strbuf_add(&path, state->base_dir, state->base_dir_len);
     +	strbuf_add(&path, pc_item->ce->name, pc_item->ce->ce_namelen);
     +
    ++	dir_sep = find_last_dir_sep(path.buf);
    ++
     +	/*
    -+	 * At this point, leading dirs should have already been created. But if
    -+	 * a symlink being checked out has collided with one of the dirs, due to
    -+	 * file system folding rules, it's possible that the dirs are no longer
    -+	 * present. So we have to check again, and report any path collisions.
    ++	 * The leading dirs should have been already created by now. But, in
    ++	 * case of path collisions, one of the dirs could have been replaced by
    ++	 * a symlink (checked out after we enqueued this entry for parallel
    ++	 * checkout). Thus, we must check the leading dirs again.
     +	 */
    -+	if (!check_leading_dirs(path.buf, path.len, state->base_dir_len)) {
    ++	if (dir_sep && !has_dirs_only_path(path.buf, dir_sep - path.buf,
    ++					   state->base_dir_len)) {
     +		pc_item->status = PC_ITEM_COLLIDED;
     +		goto out;
     +	}
    @@ parallel-checkout.c (new)
     +			 * Errors which probably represent a path collision.
     +			 * Suppress the error message and mark the item to be
     +			 * retried later, sequentially. ENOTDIR and ENOENT are
    -+			 * also interesting, but check_leading_dirs() should
    -+			 * have already caught these cases.
    ++			 * also interesting, but the above has_dirs_only_path()
    ++			 * call should have already caught these cases.
     +			 */
     +			pc_item->status = PC_ITEM_COLLIDED;
     +		} else {
    @@ parallel-checkout.c (new)
     +{
     +	size_t i;
     +
    -+	for (i = 0; i < parallel_checkout.nr; ++i)
    ++	for (i = 0; i < parallel_checkout.nr; i++)
     +		write_pc_item(&parallel_checkout.items[i], state);
     +}
     +
11:  096e543fd2 ! 11:  815137685a parallel-checkout: make it truly parallel
    @@ builtin/checkout--helper.c (new)
     +		packet_to_pc_item(line, len, &items[nr++]);
     +	}
     +
    -+	for (i = 0; i < nr; ++i) {
    ++	for (i = 0; i < nr; i++) {
     +		struct parallel_checkout_item *pc_item = &items[i];
     +		write_pc_item(pc_item, state);
     +		report_result(pc_item);
    @@ parallel-checkout.c: static int write_pc_item_to_fd(struct parallel_checkout_ite
      	 */
      	ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
      					 new_blob, size, &buf, NULL);
    -@@ parallel-checkout.c: static int check_leading_dirs(const char *path, int len, int prefix_len)
    - 	return has_dirs_only_path(path, slash - path, prefix_len);
    +@@ parallel-checkout.c: static int close_and_clear(int *fd)
    + 	return ret;
      }
      
     -static void write_pc_item(struct parallel_checkout_item *pc_item,
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +static void send_batch(int fd, size_t start, size_t nr)
     +{
     +	size_t i;
    -+	for (i = 0; i < nr; ++i)
    ++	for (i = 0; i < nr; i++)
     +		send_one_item(fd, &parallel_checkout.items[start + i]);
     +	packet_flush(fd);
     +}
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +
     +	ALLOC_ARRAY(workers, num_workers);
     +
    -+	for (i = 0; i < num_workers; ++i) {
    ++	for (i = 0; i < num_workers; i++) {
     +		struct child_process *cp = &workers[i].cp;
     +
     +		child_process_init(cp);
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +	base_batch_size = parallel_checkout.nr / num_workers;
     +	workers_with_one_extra_item = parallel_checkout.nr % num_workers;
     +
    -+	for (i = 0; i < num_workers; ++i) {
    ++	for (i = 0; i < num_workers; i++) {
     +		struct pc_worker *worker = &workers[i];
     +		size_t batch_size = base_batch_size;
     +
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +	 * Close pipes before calling finish_command() to let the workers
     +	 * exit asynchronously and avoid spending extra time on wait().
     +	 */
    -+	for (i = 0; i < num_workers; ++i) {
    ++	for (i = 0; i < num_workers; i++) {
     +		struct child_process *cp = &workers[i].cp;
     +		if (cp->in >= 0)
     +			close(cp->in);
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +			close(cp->out);
     +	}
     +
    -+	for (i = 0; i < num_workers; ++i) {
    ++	for (i = 0; i < num_workers; i++) {
     +		if (finish_command(&workers[i].cp))
     +			error(_("checkout worker %d finished with error"), i);
     +	}
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +	struct pollfd *pfds;
     +
     +	CALLOC_ARRAY(pfds, num_workers);
    -+	for (i = 0; i < num_workers; ++i) {
    ++	for (i = 0; i < num_workers; i++) {
     +		pfds[i].fd = workers[i].cp.out;
     +		pfds[i].events = POLLIN;
     +	}
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +			die_errno("failed to poll checkout workers");
     +		}
     +
    -+		for (i = 0; i < num_workers && nr > 0; ++i) {
    ++		for (i = 0; i < num_workers && nr > 0; i++) {
     +			struct pc_worker *worker = &workers[i];
     +			struct pollfd *pfd = &pfds[i];
     +
    @@ parallel-checkout.h: void init_parallel_checkout(void);
     +	size_t id;
     +	struct object_id oid;
     +	unsigned int ce_mode;
    -+	enum crlf_action crlf_action;
    ++	enum convert_crlf_action crlf_action;
     +	int ident;
     +	size_t working_tree_encoding_len;
     +	size_t name_len;
12:  9cfeb4821c ! 12:  2b42621582 parallel-checkout: support progress displaying
    @@ parallel-checkout.c: struct parallel_checkout {
     +	unsigned int *progress_cnt;
      };
      
    - static struct parallel_checkout parallel_checkout = { 0 };
    + static struct parallel_checkout parallel_checkout;
     @@ parallel-checkout.c: int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
      	return 0;
      }
    @@ parallel-checkout.c: static void write_items_sequentially(struct checkout *state
      {
      	size_t i;
      
    --	for (i = 0; i < parallel_checkout.nr; ++i)
    +-	for (i = 0; i < parallel_checkout.nr; i++)
     -		write_pc_item(&parallel_checkout.items[i], state);
    -+	for (i = 0; i < parallel_checkout.nr; ++i) {
    ++	for (i = 0; i < parallel_checkout.nr; i++) {
     +		struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
     +		write_pc_item(pc_item, state);
     +		if (pc_item->status != PC_ITEM_COLLIDED)
13:  da99b671e6 = 13:  960116579a make_transient_cache_entry(): optionally alloc from mem_pool
14:  d3d561754a = 14:  fb9f2f580c builtin/checkout.c: complete parallel checkout support
15:  ee34c6e149 = 15:  a844451e58 checkout-index: add parallel checkout support
16:  05299a3cc0 = 16:  3733857ffa parallel-checkout: add tests for basic operations
17:  3d140dcacb = 17:  c8a2974f81 parallel-checkout: add tests related to clone collisions
18:  b26f676cae = 18:  86fccd57d5 parallel-checkout: add tests related to .gitattributes
19:  641c61f9b6 = 19:  7f3e23cc38 ci: run test round with parallel-checkout enabled
-- 
2.28.0

