Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500CDC432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDCF6138F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhHWMNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhHWMNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:13:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4FFC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z9so25894932wrh.10
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5F5TEmHxs6RIOtn9DQqRYOJS6h+sCAVcFhV1byydoZA=;
        b=cyvPKB1eV21tyqJg32WrmguudXqFScea3kWaw9AM+w5v21lvUpianCyWS3Xm57czQ5
         PosvUGdE9fEucNhNwWvjOLDAGN82gQPMb38aa7z3dRlg4uH2AP28kGIIGxhtiEI0oAux
         NG0t/U5JbFuyZaQlpo4RH+fQ3a+xl80Ev5Xw67ZvJzTL/UGJlaO5Uy4b006CPpZp28Y5
         yUKYqK4Rp3OzAEgPjkQxuNBIHQUDvbov6PDSXb/sK6tRdaFPwZDd/+sNXYT6k2lGW3qr
         VC9udzgD20RkZWvM/uizSEWNCWvdDQIKJV0RnuFSf2rax2NpbIpBHoJsjvHRey+dWdSE
         OBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5F5TEmHxs6RIOtn9DQqRYOJS6h+sCAVcFhV1byydoZA=;
        b=rpxRPNO4yIavMH+qqP4hacJNEf0Vhe2fVtPPxaV4I/Ir85brHA71N7Tl9dYVzKl3Ig
         rvhr5tzeSxNNzjApFHp/K3a/ssEt5R2ZOzubhOYrZfhX9AWJ2Fym5XD79vXfP+MfRRDO
         dwZJsK9fjp41rsKtxDWLktU5knPf4oQuNTu2Im+9j7+DukQWjMtEj1vUKmsVmcVp+xNB
         MuvJafK99iizReieLQzZyl6t64Xtc9ngV3O1I3OvteQj3SmUM0MCGoPJl39YcfU7XWCZ
         U0Xb1nCJ8w19KKMWq0XHYJRW76V9OcEwvy14nsuELZX9r+JQJRqXLyhSoijmplkWF9by
         q/gQ==
X-Gm-Message-State: AOAM530iN9I5FddiXPhcBrxLEFJ8To5Iwo9qWN4tdXfQY0efLlB8d2tZ
        7jG5Lorb66vJw6fRFVt+6Z4KEG0gad3wu0I9
X-Google-Smtp-Source: ABdhPJxQItWqTKApNltB0mvH2yhV8pDb7tOBvAWTYUdhEhyKZB/pYNBdcLU7fF4XNRTHby6/nCiktg==
X-Received: by 2002:a5d:456d:: with SMTP id a13mr13360786wrc.364.1629720776743;
        Mon, 23 Aug 2021 05:12:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:12:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 02/28] init-db: set the_repository->hash_algo early on
Date:   Mon, 23 Aug 2021 14:12:13 +0200
Message-Id: <patch-v4-02.28-2fb0fb20282-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable backend needs to know the hash algorithm for writing the
initialization hash table.

The initial reftable contains a symref HEAD => "main" (or "master"), which is
agnostic to the size of hash value, but this is an exceptional circumstance, and
the reftable library does not cater to this exception. It insists that all
tables in the stack have a consistent format ID for the hash algorithm.

Call set_repo_hash_algo directly after calling validate_hash_algorithm() (which
reads $GIT_DEFAULT_HASH).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/init-db.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2167796ff2a..c2f03f6018e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -425,6 +425,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
+	/*
+	 * At this point, the_repository we have in-core does not look
+	 * anything like one that we would see initialized in an already
+	 * working repository after calling setup_git_directory().
+	 *
+	 * Calling repository.c::initialize_the_repository() may have
+	 * prepared the .index .objects and .parsed_objects members, but
+	 * other members like .gitdir, .commondir, etc. have not been
+	 * initialized.
+	 *
+	 * Many API functions assume they are working with the_repository
+	 * that has sensibly been initialized, but because we haven't
+	 * really read from an existing repository, we need to hand-craft
+	 * the necessary members of the structure to get out of this
+	 * chicken-and-egg situation.
+	 *
+	 * For now, we update the hash algorithm member to what the
+	 * validate_hash_algorithm() call decided for us.
+	 */
+	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+
 	reinit = create_default_files(template_dir, original_git_dir,
 				      initial_branch, &repo_fmt,
 				      flags & INIT_DB_QUIET);
-- 
2.33.0.662.gbaddc25a55e

