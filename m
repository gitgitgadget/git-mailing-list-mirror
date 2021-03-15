Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15CBC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B30D64E49
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCOHzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhCOHzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:55:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A36C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u18so14859391plc.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnDMvTZmmsh3j5QM0BXmAXTqXWplRHKbVyYCrx6N1x0=;
        b=WwIGPU3L7WkVcHUajiM859nIMUgYd0GOb5L+xR385skXcU+cOqY1Cku3UDnIfbRvUf
         n/0kWCLQEwFwuGcHI4Nd6fvydEP160dTzWRxs4uPmwZ0tR7tzfI7k5JEgo+QTkw8expy
         C9PO1mZQlB5MseZS5ulclhM3SFlVTcqqbDZ/zGwkfixHvOf7wnuAm3l+Uiiga6BpKJZy
         tn2jmwRLTdWdcyMPbipi+e9FwoPydtxlCtFEVqQp7pLdKOTstRsUg152TZNqcOvrvM8O
         1J+1H0svMSFy9C3FWKu+U2MIiUTR8mMBA3iMY4Y7g7H8EcR+NHXMgYKps+MSWmgYjDs5
         zdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnDMvTZmmsh3j5QM0BXmAXTqXWplRHKbVyYCrx6N1x0=;
        b=gUXFkNi+9aiq4xU7ojgtEn8RSN6KCVHHhuY1CkxxwtUEYBUO6L4FsXS7GdSVrrFqY1
         pEMsJ9uzKUfm539WSSvDD5dGyah6oGRMAf33/bMWYQit6AMe4SyrfnEYb/4nJvwzlNaC
         mcSxsBuoYA0K4Zm8RVBiCJerioFyKmBDCTRbbAseZL5mrkiHpU4+oOYYGKdFFGNjr8w0
         wuRIisnjbudCaMOyzsVts8HVeKrI6FYEn1u7cLuKVDMCJ36ey44tN9cEAoXESYmy7zoy
         tpWA+UEDHBatbGUNE/TOfWKpMEu9ZMqRD715zw/wu5qFHvcFyj0VCdAmKDfid0MlJhdJ
         ANmg==
X-Gm-Message-State: AOAM533ntewH8ISbvJKrAYyi3tHJK+60FoSjzs823q9FSwhXLzls4+aV
        yMFOpQSiqHbdrnSr7FLAO4O97L7ePQ0tUw==
X-Google-Smtp-Source: ABdhPJwicpOXg7FSsG/wlUQXvQo9FWmSfYE2/jnqjThXjBvECrxIpv/RKwcg21tVve52VCw3SucDGg==
X-Received: by 2002:a17:90b:ece:: with SMTP id gz14mr11688750pjb.192.1615794910882;
        Mon, 15 Mar 2021 00:55:10 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:55:10 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v6 0/6][Outreachy] commit: Implementation of "amend!" commit
Date:   Mon, 15 Mar 2021 13:24:30 +0530
Message-Id: <20210315075435.18229-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series teaches `git commit --fixup` to create "amend!" commit
as an alternative that works with `git rebase --autosquash`. It allows to
fixup both the content and the commit message of the specified commit.
Here we add two suboptions to the `--fixup`, first `amend` suboption that
creates an "amend!" commit. It takes the staged changes and also allows to
edit the commit message of the commit we are fixing.
Example usuage:
git commit --fixup=amend:<commit>

Secondly, `reword` suboption that creates an empty "amend!" commit i.e it
ignores the staged changes and only allows to reword/edit the commit message
of the commit we are fixing. `--fixup=reword:<commit>` is a short-hand of
`--fixup=amend:<commit> --only`.
Example usuage:
git commit --fixup=reword:<commit>

** This work is rebased on the top of cm/rebase-i-updates.

Charvi Mendiratta (6):
  sequencer: export and rename subject_length()
  commit: add amend suboption to --fixup to create amend! commit
  commit: add a reword suboption to --fixup
  t7500: add tests for --fixup=[amend|reword] options
  t3437: use --fixup with options to create amend! commit
  doc/git-commit: add documentation for fixup=[amend|reword] options

 Documentation/git-commit.txt              |  45 +++++-
 Documentation/git-rebase.txt              |  21 +--
 builtin/commit.c                          | 122 +++++++++++++++--
 commit.c                                  |  14 ++
 commit.h                                  |   3 +
 sequencer.c                               |  16 +--
 t/t3437-rebase-fixup-options.sh           |  30 +---
 t/t7500-commit-template-squash-signoff.sh | 159 ++++++++++++++++++++++
 8 files changed, 342 insertions(+), 68 deletions(-)

Range-diff against v5:
-:  ---------- > 1:  a2e89540ec sequencer: export and rename subject_length()
1:  be2808a255 ! 2:  f3cdb3eb1e commit: add amend suboption to --fixup to create amend! commit
    @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
      		size_t merge_msg_start;

    -@@ builtin/commit.c: static void finalize_deferred_config(struct wt_status *s)
    - 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
    - }
    -
    -+/* returns the length of intial segment of alpha characters only */
    -+static size_t skip_suboption(char *fixup_message) {
    -+	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
    -+	return strspn(fixup_message, alphas);
    -+}
    -+
    - static int parse_and_validate_options(int argc, const char *argv[],
    - 				      const struct option *options,
    - 				      const char * const usage[],
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
      	if (force_author && renew_authorship)
      		die(_("Using both --reset-author and --author does not make sense"));
    @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
     +		 *
     +		 * Otherwise, we are dealing with --fixup=<commit>.
     +		 */
    -+		size_t len = skip_suboption(fixup_message);
    -+		if (len && fixup_message[len] == ':') {
    -+			fixup_message[len++] = '\0';
    -+			fixup_commit = fixup_message + len;
    ++		char *p = fixup_message;
    ++		while (isalpha(*p))
    ++			p++;
    ++		if (p > fixup_message && *p == ':') {
    ++			*p = '\0';
    ++			fixup_commit = p + 1;
     +			if (!strcmp("amend", fixup_message)) {
     +				fixup_prefix = "amend";
     +				allow_empty = 1;
2:  f6217338c1 ! 3:  ded339706f commit: add a reword suboption to --fixup
    @@ builtin/commit.c: static void finalize_deferred_config(struct wt_status *s)
     +		die(_("reword option of --fixup is mutually exclusive with --patch/--interactive/--all/--include/--only"));
     +}
     +
    - /* returns the length of intial segment of alpha characters only */
    - static size_t skip_suboption(char *fixup_message) {
    - 	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
    + static int parse_and_validate_options(int argc, const char *argv[],
    + 				      const struct option *options,
    + 				      const char * const usage[],
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
      		 * We limit --fixup's suboptions to only alpha characters.
      		 * If the first character after a run of alpha is colon,
    @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      		 * Otherwise, we are dealing with --fixup=<commit>.
      		 */
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
    - 		if (len && fixup_message[len] == ':') {
    - 			fixup_message[len++] = '\0';
    - 			fixup_commit = fixup_message + len;
    + 		if (p > fixup_message && *p == ':') {
    + 			*p = '\0';
    + 			fixup_commit = p + 1;
     -			if (!strcmp("amend", fixup_message)) {
     +			if (!strcmp("amend", fixup_message) ||
     +			    !strcmp("reword", fixup_message)) {
3:  1a127dc0b3 = 4:  ec6f3d5d7d t7500: add tests for --fixup=[amend|reword] options
4:  be6f4fa0d1 = 5:  148087b133 t3437: use --fixup with options to create amend! commit
5:  79c098df2c ! 6:  2b750d305e doc/git-commit: add documentation for fixup=[amend|reword] options
    @@ Commit message

         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
--
2.29.0.rc1

