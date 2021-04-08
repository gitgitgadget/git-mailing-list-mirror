Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ADAC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9977D610F8
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 16:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhDHQR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhDHQRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 12:17:25 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690BC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 09:17:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x9so1820812qto.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3H+pJkiV0fqdpuHr/Dx8jjPp3gyFEYRx5re2FyHI/A=;
        b=KC4eX807NJumMWtuxHFMkdAiDLlqT8UaIoAmFjiv/MQQHu5Ukleo2eqfoFIF88DYaM
         z8es4valC/n80vzAJiiJqRHvbOI0wwIv+zC+guzJz4CnuygP3z6DJdYvGofkscX1r02U
         dFa1EKxIZoe4DZlig5qnXevtF+GGwBPvsxv9+AUgNeW3St2hWo2x3w4H11SadYrBYOS4
         pRsPwQM2b6n2AFf/IudCnEMQVjUa/RL4dt9F4m2I/1i+2RC8h3uopoYrwP2ZO6gbmf3S
         EY+A1Q3rVWKvLr3UkKF8PFQhFp62R2SEzDkJHZieoFmNjoLOvYOXrb/faYGyJhftuadb
         TxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3H+pJkiV0fqdpuHr/Dx8jjPp3gyFEYRx5re2FyHI/A=;
        b=SZTW72miffKr7KJpuGPnxLeMnpQxnwsb3KLQ6jTKXMPWOQasNE4laUxO0PjcojZn19
         nuxR71mqQr/w8Ak8utHFxOZS3iCYfST6g2PKa4AtHwTqSltXwLGQvTuF5BfwAN9WtBt7
         S8VkdLkT42JdHAvFzm5pfShMDhKO9rISIwnUoIWzudNvKtLaRwZBtgjhjMSZ6TXZZXyJ
         +aALK0HOtOeLOVlT7wmSxV73naHYoW3IiZ9Sqaz9AoCxtTnb5rMhwUbmY8OxKGyPgA/y
         GcAgZEfMF4RKTyZ3i04Y0u+QXBj6KcKTkNoD8c3tCKQezRBMxo1ok7su6GcClTlqEfTL
         rOKg==
X-Gm-Message-State: AOAM5338WOldYtM9GR1tFIwf/U+X9x0zc60cr501VwMmVY9vhQ0Ikm21
        0tI7bpvTMlVN0+cM86YPrszoBHLNjB/awg==
X-Google-Smtp-Source: ABdhPJwP9ZixzXGGMcSnWlGi4deV+o9/9sUEQVmcU5VjRsDZTU6u91hc+1LVmmqKsIcvummsTmJCAw==
X-Received: by 2002:a05:622a:14c:: with SMTP id v12mr8121049qtw.46.1617898631942;
        Thu, 08 Apr 2021 09:17:11 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id d18sm18087369qtd.85.2021.04.08.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:17:11 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com
Subject: [PATCH v2 0/5] Parallel Checkout (part 2)
Date:   Thu,  8 Apr 2021 13:16:59 -0300
Message-Id: <cover.1617893234.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616015337.git.matheus.bernardino@usp.br>
References: <cover.1616015337.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the next step in the parallel checkout implementation. As
mt/parallel-checkout-part-1 is now on master, this round is based
directly on master.

Changes since v1:

Patch 1:
- Fixed misleading sentence in commit message which said that
  parallel-checkout can smudge entries in parallel (it can only run
  internal filters in parallel).
- On write_pc_item_to_fd(), moved `newsize` declaration down to the
  scope where it is actually used and removed the initialization. 
- Also on write_pc_item_to_fd(), rephrased error message on
  read_blob_entry() to avoid mentioning 'sha1' and 'object file', which
  might not be the case there.
- Fixed typo at handle_results(): s/it's/its/.
- Added comment to 'struct parallel_checkout' to clarify what data we
  later refer as the "parallel checkout queue".
- Quoted paths in error messages.

Patch 2:
- Renamed checkout--helper to checkout--worker.
- Used packet_read() instead of packet_line_read() in both main process
  and workers. packet_line_read() is not suitable for binary data as it
  chomps a trailing newline (which could actually be part of the
  payload).
- Added check for checkout items that cannot be sent in one single
  pkt-line. (Such items are very unlikely to appear in practice, but we
  cannot ignore them.)
- Replaced macro that checks the pc_item_result size received from
  workers with an inline function.
- At parse_and_save_result(), separated one BUG() that guards two
  different conditions into two BUG()s, to help debugging.
- Suppressed error messages for finish_command() errors that don't
  come from a signal death. Such errors are already reported by the
  worker itself, so there is no need to repeat ourselves.
- Ignored SIGPIPE when writing to workers so that we can get an EPIPE
  in the pkt-line machinery and die() with an error message instead of
  nothing.

Patch 3:
- Used `static const int` instead of #define for the default parallel
  checkout config values.

Patch 5:
- Fixed typos in design doc.
- Clarified which types of filters can be applied in parallel.
- Improved wording on the 'sequential implementation' section. In
  particular, avoided using the term "layers" to refer to the sub-steps.
- Clarified sentence about the streaming interface and how it affects
  some of the steps performed by the workers.
- Clarified that the main process only removes files with --force.

Additionally, the error() and die() messages from the previous round
were mostly not marked for translation, but there were 3 strings that
were accidentally marked. I'm not sure whether parallel-checkout
messages should be translated or not, since it's a low-level machinery
that can be used by both porcelain and plumbing commands. But because
entry.c's messages are not localized, and parallel-checkout is kind of
an extension of it, I decided to remove the three last _() occurrences
in this round.


Matheus Tavares (5):
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: add configuration options
  parallel-checkout: support progress displaying
  parallel-checkout: add design documentation

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   1 +
 Documentation/config/checkout.txt             |  21 +
 Documentation/technical/parallel-checkout.txt | 268 +++++++
 Makefile                                      |   2 +
 builtin.h                                     |   1 +
 builtin/checkout--worker.c                    | 145 ++++
 entry.c                                       |  17 +-
 git.c                                         |   2 +
 parallel-checkout.c                           | 658 ++++++++++++++++++
 parallel-checkout.h                           | 111 +++
 unpack-trees.c                                |  19 +-
 12 files changed, 1241 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/parallel-checkout.txt
 create mode 100644 builtin/checkout--worker.c
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

Range-diff against v1:
1:  a3383042e2 ! 1:  0506ac7159 unpack-trees: add basic support for parallel checkout
    @@ Commit message
         unpack-trees: add basic support for parallel checkout
     
         This new interface allows us to enqueue some of the entries being
    -    checked out to later uncompress, smudge, and write them in parallel. For
    -    now, the parallel checkout machinery is enabled by default and there is
    -    no user configuration, but run_parallel_checkout() just writes the
    -    queued entries in sequence (without spawning additional workers). The
    -    next patch will actually implement the parallelism and, later, we will
    -    make it configurable.
    +    checked out to later uncompress them, apply in-process filters, and
    +    write out the files in parallel. For now, the parallel checkout
    +    machinery is enabled by default and there is no user configuration, but
    +    run_parallel_checkout() just writes the queued entries in sequence
    +    (without spawning additional workers). The next patch will actually
    +    implement the parallelism and, later, we will make it configurable.
     
         Note that, to avoid potential data races, not all entries are eligible
         for parallel checkout. Also, paths that collide on disk (e.g.
    @@ parallel-checkout.c (new)
     +
     +struct parallel_checkout {
     +	enum pc_status status;
    -+	struct parallel_checkout_item *items;
    ++	struct parallel_checkout_item *items; /* The parallel checkout queue. */
     +	size_t nr, alloc;
     +};
     +
    @@ parallel-checkout.c (new)
     +			 *
     +			 * Instead, let's pay the overhead only once, now, and
     +			 * call checkout_entry_ca() again for this file, to
    -+			 * have it's stat() data stored in the index. This also
    ++			 * have its stat() data stored in the index. This also
     +			 * has the benefit of adding this entry and its
     +			 * colliding pair to the collision report message.
     +			 * Additionally, this overwriting behavior is consistent
    @@ parallel-checkout.c (new)
     +	}
     +
     +	if (have_pending)
    -+		error(_("parallel checkout finished with pending entries"));
    ++		error("parallel checkout finished with pending entries");
     +
     +	return ret;
     +}
    @@ parallel-checkout.c (new)
     +static int reset_fd(int fd, const char *path)
     +{
     +	if (lseek(fd, 0, SEEK_SET) != 0)
    -+		return error_errno("failed to rewind descriptor of %s", path);
    ++		return error_errno("failed to rewind descriptor of '%s'", path);
     +	if (ftruncate(fd, 0))
    -+		return error_errno("failed to truncate file %s", path);
    ++		return error_errno("failed to truncate file '%s'", path);
     +	return 0;
     +}
     +
    @@ parallel-checkout.c (new)
     +	struct strbuf buf = STRBUF_INIT;
     +	char *new_blob;
     +	unsigned long size;
    -+	size_t newsize = 0;
     +	ssize_t wrote;
     +
     +	/* Sanity check */
    @@ parallel-checkout.c (new)
     +
     +	new_blob = read_blob_entry(pc_item->ce, &size);
     +	if (!new_blob)
    -+		return error("unable to read sha1 file of %s (%s)", path,
    -+			     oid_to_hex(&pc_item->ce->oid));
    ++		return error("cannot read object %s '%s'",
    ++			     oid_to_hex(&pc_item->ce->oid), path);
     +
     +	/*
     +	 * checkout metadata is used to give context for external process
    @@ parallel-checkout.c (new)
     +					 new_blob, size, &buf, NULL);
     +
     +	if (ret) {
    ++		size_t newsize;
     +		free(new_blob);
     +		new_blob = strbuf_detach(&buf, &newsize);
     +		size = newsize;
    @@ parallel-checkout.c (new)
     +	wrote = write_in_full(fd, new_blob, size);
     +	free(new_blob);
     +	if (wrote < 0)
    -+		return error("unable to write file %s", path);
    ++		return error("unable to write file '%s'", path);
     +
     +	return 0;
     +}
    @@ parallel-checkout.c (new)
     +			 */
     +			pc_item->status = PC_ITEM_COLLIDED;
     +		} else {
    -+			error_errno("failed to open file %s", path.buf);
    ++			error_errno("failed to open file '%s'", path.buf);
     +			pc_item->status = PC_ITEM_FAILED;
     +		}
     +		goto out;
    @@ parallel-checkout.c (new)
     +	fstat_done = fstat_checkout_output(fd, state, &pc_item->st);
     +
     +	if (close_and_clear(&fd)) {
    -+		error_errno("unable to close file %s", path.buf);
    ++		error_errno("unable to close file '%s'", path.buf);
     +		pc_item->status = PC_ITEM_FAILED;
     +		goto out;
     +	}
     +
     +	if (state->refresh_cache && !fstat_done && lstat(path.buf, &pc_item->st) < 0) {
    -+		error_errno("unable to stat just-written file %s",  path.buf);
    ++		error_errno("unable to stat just-written file '%s'",  path.buf);
     +		pc_item->status = PC_ITEM_FAILED;
     +		goto out;
     +	}
2:  fca797698c ! 2:  0d65b517bd parallel-checkout: make it truly parallel
    @@ .gitignore
      /git-check-mailmap
      /git-check-ref-format
      /git-checkout
    -+/git-checkout--helper
    ++/git-checkout--worker
      /git-checkout-index
      /git-cherry
      /git-cherry-pick
    @@ Makefile: BUILTIN_OBJS += builtin/check-attr.o
      BUILTIN_OBJS += builtin/check-ignore.o
      BUILTIN_OBJS += builtin/check-mailmap.o
      BUILTIN_OBJS += builtin/check-ref-format.o
    -+BUILTIN_OBJS += builtin/checkout--helper.o
    ++BUILTIN_OBJS += builtin/checkout--worker.o
      BUILTIN_OBJS += builtin/checkout-index.o
      BUILTIN_OBJS += builtin/checkout.o
      BUILTIN_OBJS += builtin/clean.o
    @@ builtin.h: int cmd_bugreport(int argc, const char **argv, const char *prefix);
      int cmd_bundle(int argc, const char **argv, const char *prefix);
      int cmd_cat_file(int argc, const char **argv, const char *prefix);
      int cmd_checkout(int argc, const char **argv, const char *prefix);
    -+int cmd_checkout__helper(int argc, const char **argv, const char *prefix);
    ++int cmd_checkout__worker(int argc, const char **argv, const char *prefix);
      int cmd_checkout_index(int argc, const char **argv, const char *prefix);
      int cmd_check_attr(int argc, const char **argv, const char *prefix);
      int cmd_check_ignore(int argc, const char **argv, const char *prefix);
     
    - ## builtin/checkout--helper.c (new) ##
    + ## builtin/checkout--worker.c (new) ##
     @@
     +#include "builtin.h"
     +#include "config.h"
    @@ builtin/checkout--helper.c (new)
     +#include "parse-options.h"
     +#include "pkt-line.h"
     +
    -+static void packet_to_pc_item(char *line, int len,
    ++static void packet_to_pc_item(const char *buffer, int len,
     +			      struct parallel_checkout_item *pc_item)
     +{
    -+	struct pc_item_fixed_portion *fixed_portion;
    -+	char *encoding, *variant;
    ++	const struct pc_item_fixed_portion *fixed_portion;
    ++	const char *variant;
    ++	char *encoding;
     +
     +	if (len < sizeof(struct pc_item_fixed_portion))
     +		BUG("checkout worker received too short item (got %dB, exp %dB)",
     +		    len, (int)sizeof(struct pc_item_fixed_portion));
     +
    -+	fixed_portion = (struct pc_item_fixed_portion *)line;
    ++	fixed_portion = (struct pc_item_fixed_portion *)buffer;
     +
     +	if (len - sizeof(struct pc_item_fixed_portion) !=
     +		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
     +		BUG("checkout worker received corrupted item");
     +
    -+	variant = line + sizeof(struct pc_item_fixed_portion);
    ++	variant = buffer + sizeof(struct pc_item_fixed_portion);
     +
     +	/*
     +	 * Note: the main process uses zero length to communicate that the
    @@ builtin/checkout--helper.c (new)
     +	size_t i, nr = 0, alloc = 0;
     +
     +	while (1) {
    -+		int len;
    -+		char *line = packet_read_line(0, &len);
    ++		int len = packet_read(0, NULL, NULL, packet_buffer,
    ++				      sizeof(packet_buffer), 0);
     +
    -+		if (!line)
    ++		if (len < 0)
    ++			BUG("packet_read() returned negative value");
    ++		else if (!len)
     +			break;
     +
     +		ALLOC_GROW(items, nr + 1, alloc);
    -+		packet_to_pc_item(line, len, &items[nr++]);
    ++		packet_to_pc_item(packet_buffer, len, &items[nr++]);
     +	}
     +
     +	for (i = 0; i < nr; i++) {
    @@ builtin/checkout--helper.c (new)
     +	free(items);
     +}
     +
    -+static const char * const checkout_helper_usage[] = {
    -+	N_("git checkout--helper [<options>]"),
    ++static const char * const checkout_worker_usage[] = {
    ++	N_("git checkout--worker [<options>]"),
     +	NULL
     +};
     +
    -+int cmd_checkout__helper(int argc, const char **argv, const char *prefix)
    ++int cmd_checkout__worker(int argc, const char **argv, const char *prefix)
     +{
     +	struct checkout state = CHECKOUT_INIT;
    -+	struct option checkout_helper_options[] = {
    ++	struct option checkout_worker_options[] = {
     +		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
     +			N_("when creating files, prepend <string>")),
     +		OPT_END()
     +	};
     +
     +	if (argc == 2 && !strcmp(argv[1], "-h"))
    -+		usage_with_options(checkout_helper_usage,
    -+				   checkout_helper_options);
    ++		usage_with_options(checkout_worker_usage,
    ++				   checkout_worker_options);
     +
     +	git_config(git_default_config, NULL);
    -+	argc = parse_options(argc, argv, prefix, checkout_helper_options,
    -+			     checkout_helper_usage, 0);
    ++	argc = parse_options(argc, argv, prefix, checkout_worker_options,
    ++			     checkout_worker_usage, 0);
     +	if (argc > 0)
    -+		usage_with_options(checkout_helper_usage, checkout_helper_options);
    ++		usage_with_options(checkout_worker_usage, checkout_worker_options);
     +
     +	if (state.base_dir)
     +		state.base_dir_len = strlen(state.base_dir);
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
      	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
      	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
    -+	{ "checkout--helper", cmd_checkout__helper,
    ++	{ "checkout--worker", cmd_checkout__worker,
     +		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
      	{ "checkout-index", cmd_checkout_index,
      		RUN_SETUP | NEED_WORK_TREE},
    @@ parallel-checkout.c
      #include "parallel-checkout.h"
     +#include "pkt-line.h"
     +#include "run-command.h"
    ++#include "sigchain.h"
      #include "streaming.h"
      
     -enum pc_item_status {
    @@ parallel-checkout.c
      };
      
      struct parallel_checkout {
    +@@ parallel-checkout.c: static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
    + 					     const struct conv_attrs *ca)
    + {
    + 	enum conv_attrs_classification c;
    ++	size_t packed_item_size;
    + 
    + 	/*
    + 	 * Symlinks cannot be checked out in parallel as, in case of path
    +@@ parallel-checkout.c: static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
    + 	if (!S_ISREG(ce->ce_mode))
    + 		return 0;
    + 
    ++	packed_item_size = sizeof(struct pc_item_fixed_portion) + ce->ce_namelen +
    ++		(ca->working_tree_encoding ? strlen(ca->working_tree_encoding) : 0);
    ++
    ++	/*
    ++	 * The amount of data we send to the workers per checkout item is
    ++	 * typically small (75~300B). So unless we find an insanely huge path
    ++	 * of 64KB, we should never reach the 65KB limit of one pkt-line. If
    ++	 * that does happen, we let the sequential code handle the item.
    ++	 */
    ++	if (packed_item_size > LARGE_PACKET_DATA_MAX)
    ++		return 0;
    ++
    + 	c = classify_conv_attrs(ca);
    + 	switch (c) {
    + 	case CA_CLASS_INCORE:
     @@ parallel-checkout.c: int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
      	ALLOC_GROW(parallel_checkout.items, parallel_checkout.nr + 1,
      		   parallel_checkout.alloc);
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +	size_t working_tree_encoding_len = working_tree_encoding ?
     +					   strlen(working_tree_encoding) : 0;
     +
    ++	/*
    ++	 * Any changes in the calculation of the message size must also be made
    ++	 * in is_eligible_for_parallel_checkout().
    ++	 */
     +	len_data = sizeof(struct pc_item_fixed_portion) + name_len +
     +		   working_tree_encoding_len;
     +
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +static void send_batch(int fd, size_t start, size_t nr)
     +{
     +	size_t i;
    ++	sigchain_push(SIGPIPE, SIG_IGN);
     +	for (i = 0; i < nr; i++)
     +		send_one_item(fd, &parallel_checkout.items[start + i]);
     +	packet_flush(fd);
    ++	sigchain_pop(SIGPIPE);
     +}
     +
     +static struct pc_worker *setup_workers(struct checkout *state, int num_workers)
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +		cp->in = -1;
     +		cp->out = -1;
     +		cp->clean_on_exit = 1;
    -+		strvec_push(&cp->args, "checkout--helper");
    ++		strvec_push(&cp->args, "checkout--worker");
     +		if (state->base_dir_len)
     +			strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
     +		if (start_command(cp))
    -+			die(_("failed to spawn checkout worker"));
    ++			die("failed to spawn checkout worker");
     +	}
     +
     +	base_batch_size = parallel_checkout.nr / num_workers;
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +	}
     +
     +	for (i = 0; i < num_workers; i++) {
    -+		if (finish_command(&workers[i].cp))
    -+			error(_("checkout worker %d finished with error"), i);
    ++		int rc = finish_command(&workers[i].cp);
    ++		if (rc > 128) {
    ++			/*
    ++			 * For a normal non-zero exit, the worker should have
    ++			 * already printed something useful to stderr. But a
    ++			 * death by signal should be mentioned to the user.
    ++			 */
    ++			error("checkout worker %d died of signal %d", i, rc - 128);
    ++		}
     +	}
     +
     +	free(workers);
     +}
     +
    -+#define ASSERT_PC_ITEM_RESULT_SIZE(got, exp) \
    -+{ \
    -+	if (got != exp) \
    -+		BUG("corrupted result from checkout worker (got %dB, exp %dB)", \
    -+		    got, exp); \
    -+} while(0)
    ++static inline void assert_pc_item_result_size(int got, int exp)
    ++{
    ++	if (got != exp)
    ++		BUG("wrong result size from checkout worker (got %dB, exp %dB)",
    ++		    got, exp);
    ++}
     +
    -+static void parse_and_save_result(const char *line, int len,
    ++static void parse_and_save_result(const char *buffer, int len,
     +				  struct pc_worker *worker)
     +{
     +	struct pc_item_result *res;
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +	struct stat *st = NULL;
     +
     +	if (len < PC_ITEM_RESULT_BASE_SIZE)
    -+		BUG("too short result from checkout worker (got %dB, exp %dB)",
    ++		BUG("too short result from checkout worker (got %dB, exp >=%dB)",
     +		    len, (int)PC_ITEM_RESULT_BASE_SIZE);
     +
    -+	res = (struct pc_item_result *)line;
    ++	res = (struct pc_item_result *)buffer;
     +
     +	/*
     +	 * Worker should send either the full result struct on success, or
     +	 * just the base (i.e. no stat data), otherwise.
     +	 */
     +	if (res->status == PC_ITEM_WRITTEN) {
    -+		ASSERT_PC_ITEM_RESULT_SIZE(len, (int)sizeof(struct pc_item_result));
    ++		assert_pc_item_result_size(len, (int)sizeof(struct pc_item_result));
     +		st = &res->st;
     +	} else {
    -+		ASSERT_PC_ITEM_RESULT_SIZE(len, (int)PC_ITEM_RESULT_BASE_SIZE);
    ++		assert_pc_item_result_size(len, (int)PC_ITEM_RESULT_BASE_SIZE);
     +	}
     +
    -+	if (!worker->nr_items_to_complete || res->id != worker->next_item_to_complete)
    -+		BUG("checkout worker sent unexpected item id");
    ++	if (!worker->nr_items_to_complete)
    ++		BUG("received result from supposedly finished checkout worker");
    ++	if (res->id != worker->next_item_to_complete)
    ++		BUG("unexpected item id from checkout worker (got %"PRIuMAX", exp %"PRIuMAX")",
    ++		    (uintmax_t)res->id, (uintmax_t)worker->next_item_to_complete);
     +
     +	worker->next_item_to_complete++;
     +	worker->nr_items_to_complete--;
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +		pc_item->st = *st;
     +}
     +
    -+
     +static void gather_results_from_workers(struct pc_worker *workers,
     +					int num_workers)
     +{
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +				continue;
     +
     +			if (pfd->revents & POLLIN) {
    -+				int len;
    -+				const char *line = packet_read_line(pfd->fd, &len);
    ++				int len = packet_read(pfd->fd, NULL, NULL,
    ++						      packet_buffer,
    ++						      sizeof(packet_buffer), 0);
     +
    -+				if (!line) {
    ++				if (len < 0) {
    ++					BUG("packet_read() returned negative value");
    ++				} else if (!len) {
     +					pfd->fd = -1;
     +					active_workers--;
     +				} else {
    -+					parse_and_save_result(line, len, worker);
    ++					parse_and_save_result(packet_buffer,
    ++							      len, worker);
     +				}
     +			} else if (pfd->revents & POLLHUP) {
     +				pfd->fd = -1;
     +				active_workers--;
     +			} else if (pfd->revents & (POLLNVAL | POLLERR)) {
    -+				die(_("error polling from checkout worker"));
    ++				die("error polling from checkout worker");
     +			}
     +
     +			nr--;
    @@ parallel-checkout.c: static void write_items_sequentially(struct checkout *state
      		write_pc_item(&parallel_checkout.items[i], state);
      }
      
    -+#define DEFAULT_NUM_WORKERS 2
    ++static const int DEFAULT_NUM_WORKERS = 2;
     +
      int run_parallel_checkout(struct checkout *state)
      {
    @@ parallel-checkout.h: int enqueue_checkout(struct cache_entry *ce, struct conv_at
      int run_parallel_checkout(struct checkout *state);
      
     +/****************************************************************
    -+ * Interface with checkout--helper
    ++ * Interface with checkout--worker
     + ****************************************************************/
     +
     +enum pc_item_status {
3:  8c83e92445 ! 3:  6ea057f9c5 parallel-checkout: add configuration options
    @@ Commit message
         checkout showed to be beneficial. This time, we compared the runtime of
         a `git checkout -f`, with and without parallelism, after randomly
         removing an increasing number of files from the Linux working tree. The
    -    "sequential fallback" column bellow corresponds to the executions where
    +    "sequential fallback" column below corresponds to the executions where
         checkout.workers was 10 but checkout.thresholdForParallelism was equal
         to the number of to-be-updated files plus one (so that we end up writing
         sequentially). Each test case was sampled 15 times, and each sample had
    @@ parallel-checkout.c
      #include "parallel-checkout.h"
      #include "pkt-line.h"
      #include "run-command.h"
    + #include "sigchain.h"
      #include "streaming.h"
     +#include "thread-utils.h"
      
    @@ parallel-checkout.c: enum pc_status parallel_checkout_status(void)
      	return parallel_checkout.status;
      }
      
    -+#define DEFAULT_THRESHOLD_FOR_PARALLELISM 100
    ++static const int DEFAULT_THRESHOLD_FOR_PARALLELISM = 100;
    ++static const int DEFAULT_NUM_WORKERS = 1;
     +
     +void get_parallel_checkout_configs(int *num_workers, int *threshold)
     +{
     +	if (git_config_get_int("checkout.workers", num_workers))
    -+		*num_workers = 1;
    ++		*num_workers = DEFAULT_NUM_WORKERS;
     +	else if (*num_workers < 1)
     +		*num_workers = online_cpus();
     +
    @@ parallel-checkout.c: static void write_items_sequentially(struct checkout *state
      		write_pc_item(&parallel_checkout.items[i], state);
      }
      
    --#define DEFAULT_NUM_WORKERS 2
    +-static const int DEFAULT_NUM_WORKERS = 2;
     -
     -int run_parallel_checkout(struct checkout *state)
     +int run_parallel_checkout(struct checkout *state, int num_workers, int threshold)
    @@ parallel-checkout.h: void init_parallel_checkout(void);
     +int run_parallel_checkout(struct checkout *state, int num_workers, int threshold);
      
      /****************************************************************
    -  * Interface with checkout--helper
    +  * Interface with checkout--worker
     
      ## unpack-trees.c ##
     @@ unpack-trees.c: static int check_updates(struct unpack_trees_options *o,
4:  f7432e15dd ! 4:  0ac4bee67e parallel-checkout: support progress displaying
    @@ parallel-checkout.c
      #include "pkt-line.h"
     +#include "progress.h"
      #include "run-command.h"
    + #include "sigchain.h"
      #include "streaming.h"
    - #include "thread-utils.h"
     @@ parallel-checkout.c: struct parallel_checkout {
      	enum pc_status status;
    - 	struct parallel_checkout_item *items;
    + 	struct parallel_checkout_item *items; /* The parallel checkout queue. */
      	size_t nr, alloc;
     +	struct progress *progress;
     +	unsigned int *progress_cnt;
    @@ parallel-checkout.c: static int handle_results(struct checkout *state)
      			break;
      		case PC_ITEM_PENDING:
      			have_pending = 1;
    -@@ parallel-checkout.c: static void parse_and_save_result(const char *line, int len,
    +@@ parallel-checkout.c: static void parse_and_save_result(const char *buffer, int len,
      	pc_item->status = res->status;
      	if (st)
      		pc_item->st = *st;
    @@ parallel-checkout.c: static void parse_and_save_result(const char *line, int len
     +		advance_progress_meter();
      }
      
    - 
    + static void gather_results_from_workers(struct pc_worker *workers,
     @@ parallel-checkout.c: static void write_items_sequentially(struct checkout *state)
      {
      	size_t i;
    @@ parallel-checkout.h: void init_parallel_checkout(void);
     +			  struct progress *progress, unsigned int *progress_cnt);
      
      /****************************************************************
    -  * Interface with checkout--helper
    +  * Interface with checkout--worker
     
      ## unpack-trees.c ##
     @@ unpack-trees.c: static int check_updates(struct unpack_trees_options *o,
5:  0592740ec1 ! 5:  087f8bdf35 parallel-checkout: add design documentation
    @@ Documentation/technical/parallel-checkout.txt (new)
     +==============================
     +
     +The "Parallel Checkout" feature attempts to use multiple processes to
    -+parallelize the work of uncompressing, smudging, and writing blobs
    -+during a checkout operation. It can be used by all checkout-related
    -+commands, such as `clone`, `checkout`, `reset`, `sparse-checkout`, and
    -+others.
    ++parallelize the work of uncompressing the blobs, applying in-core
    ++filters, and writing the resulting contents to the working tree during a
    ++checkout operation. It can be used by all checkout-related commands,
    ++such as `clone`, `checkout`, `reset`, `sparse-checkout`, and others.
     +
     +These commands share the following basic structure:
     +
    @@ Documentation/technical/parallel-checkout.txt (new)
     +-------------------------
     +
     +For the purposes of discussion here, the current sequential
    -+implementation of Step 3 has 3 layers:
    ++implementation of Step 3 is divided in 3 parts, each one implemented in
    ++its own function:
     +
     +* Step 3a: `unpack-trees.c:check_updates()` contains a series of
     +  sequential loops iterating over the `cache_entry`'s array. The main
    -+  loop in this function calls the next layer for each of the
    ++  loop in this function calls the Step 3b function for each of the
     +  to-be-updated entries.
     +
     +* Step 3b: `entry.c:checkout_entry()` examines the existing working tree
     +  for file conflicts, collisions, and unsaved changes. It removes files
    -+  and create leading directories as necessary. It calls the next layer
    -+  for each entry to be written.
    ++  and creates leading directories as necessary. It calls the Step 3c
    ++  function for each entry to be written.
     +
     +* Step 3c: `entry.c:write_entry()` loads the blob into memory, smudges
     +  it if necessary, creates the file in the working tree, writes the
    @@ Documentation/technical/parallel-checkout.txt (new)
     +----------------------
     +
     +Parallel checkout alters the aforementioned Step 3 to use multiple
    -+`checkout--helper` background processes to distribute the work. The
    ++`checkout--worker` background processes to distribute the work. The
     +long-running worker processes are controlled by the foreground Git
     +command using the existing run-command API.
     +
    @@ Documentation/technical/parallel-checkout.txt (new)
     +~~~~~~~~
     +
     +Step 3b is only slightly altered; for each entry to be checked out, the
    -+main process:
    ++main process performs the following steps:
     +
    -+* M1: Checks whether there is any untracked or unclean file in the
    -+  working tree which would be overwritten by this entry, and decides
    ++* M1: Check whether there is any untracked or unclean file in the
    ++  working tree which would be overwritten by this entry, and decide
     +  whether to proceed (removing the file(s)) or not.
     +
    -+* M2: Creates the leading directories.
    ++* M2: Create the leading directories.
     +
    -+* M3: Loads the conversion attributes for the entry's path.
    ++* M3: Load the conversion attributes for the entry's path.
     +
    -+* M4: Checks, based on the entry's type and conversion attributes,
    ++* M4: Check, based on the entry's type and conversion attributes,
     +  whether the entry is eligible for parallel checkout (more on this
    -+  later). If it is eligible, enqueues the entry and the loaded
    -+  attributes to later write the entry in parallel. If not, writes the
    ++  later). If it is eligible, enqueue the entry and the loaded
    ++  attributes to later write the entry in parallel. If not, write the
     +  entry right away, using the default sequential code.
     +
     +Note: we save the conversion attributes associated with each entry
    @@ Documentation/technical/parallel-checkout.txt (new)
     +* W3: Loads the blob into memory (inflating and delta reconstructing
     +  it).
     +
    -+* W4: Filters the blob.
    ++* W4: Applies any required in-process filter, like end-of-line
    ++  conversion and re-encoding.
     +
     +* W5: Writes the result to the file descriptor opened at W2.
     +
    @@ Documentation/technical/parallel-checkout.txt (new)
     +  the result back to the main process, together with the end status of
     +  the operation and the item's identification number.
     +
    -+Note that steps W3 to W5 might actually be performed together, using the
    -+streaming interface.
    ++Note that, when possible, steps W3 to W5 are delegated to the streaming
    ++machinery, removing the need to keep the entire blob in memory.
     +
    -+Also note that the workers *never* remove any files. As mentioned
    -+earlier, it is the responsibility of the main process to remove any
    -+files that block the checkout operation (or abort it). This is crucial
    -+to avoid race conditions and also to properly detect path collisions at
    -+Step W1.
    ++Also note that the workers *never* remove any file. As mentioned
    ++earlier, it is the responsibility of the main process to remove any file
    ++that blocks the checkout operation (or abort if removing the file(s)
    ++would cause data loss and the user didn't ask to `--force`). This is
    ++crucial to avoid race conditions and also to properly detect path
    ++collisions at Step W1.
     +
     +After the workers finish writing the items and sending back the required
     +information, the main process handles the results in two steps:
    @@ Documentation/technical/parallel-checkout.txt (new)
     +deals with files that were already present in the working tree before
     +checkout. Basically, it checks if the path that it wants to write
     +already exists on disk, makes sure the existing file doesn't have
    -+unsaved data, and then overwrite it. (To be more pedantic: it deletes
    ++unsaved data, and then overwrites it. (To be more pedantic: it deletes
     +the existing file and creates the new one.) So, if there are multiple
     +colliding files to be checked out, the sequential code will write each
     +one of them but only the last will actually survive on disk.
    @@ Documentation/technical/parallel-checkout.txt (new)
     +remove all files that prevent this entry from being written (before
     +enqueueing it). This includes any non-directory file in the leading path
     +of the entry. Later, when a worker gets assigned the entry, it looks
    -+again for the non-directories files and for an already existent file at
    ++again for the non-directories files and for an already existing file at
     +the entry's path. If any of these checks finds something, the worker
     +knows that there was a path collision.
     +
    @@ Documentation/technical/parallel-checkout.txt (new)
     +postpone the return of some filtered blobs. The delayed checkout queue
     +and the parallel checkout queue are not compatible and should remain
     +separated.
    +++
    ++Note: regular files that only require internal filters, like end-of-line
    ++conversion and re-encoding, are eligible for parallel checkout.
     +
     +Ineligible entries are checked out by the classic sequential codepath
     +*before* spawning workers.
     +
     +Note: submodules's files are also eligible for parallel checkout (as
    -+long as they don't fall into the two excluding categories mentioned
    ++long as they don't fall into any of the excluding categories mentioned
     +above). But since each submodule is checked out in its own child
     +process, we don't mix the superproject's and the submodules' files in
     +the same parallel checkout process or queue.
-- 
2.30.1

