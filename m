Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C518C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002CF610FB
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhGTQZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhGTQYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2020C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c12so8763039wrt.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M66o8jlMvL4PeeUtekVFtRg/hRORM9wxMnGQIcXA8eM=;
        b=Arz4Fd5yHi5jHIijws3ptHHK85Dd/hr+aFhZYWv2rEMEE0ng3RcxO3hOqm8OUbpUvS
         dh8ZuqQpRM7SQ5xp3946Z4VFWyPPR2PWv2cFYLzzwX1tMKjvkG57LRyx36hPCQNwqqZs
         KKj7Quj+MN95fsdJAP19c76Hvxu9yDrbdE3hy9O4wpKINaZV1he9fX3Y0+4l+LQ0zHtp
         vUSpfGmwvEPkgV6xxYb73psgAJ9EEAE1dAMZMW+DeM3sUQr8V8NewAMPy15N3RkkxdAX
         eMglOkJyjiJPbvpkP58QmieJ1+gndR8q5ogU/rAHCmOq9eVRj9DeVOZXDvlhzmJsWa9G
         nI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M66o8jlMvL4PeeUtekVFtRg/hRORM9wxMnGQIcXA8eM=;
        b=mooFkXxlteFBZoIysPC2pfa3oL++ypBSiTzkpDEedvHnA56+ToI6nq0lKTaqUH/xqX
         R+1Y59Qrn1mE20SephPnbGwo7H1AJckS0VbhuEvPyKvdExZPk4Uim/cT/tUHi+9pvUU2
         5zLQa/QMVch/wFKMyrep61dsT9uXZqfuSS7W/8q8yo0hpCNESGY8FkQby6HuE1yMtxBc
         xNCe3IpfeNvLb68O+tCI9+XYOtf++9EzOR0zaK/FKW2NBA25V/cC0nFxOwK3SIpPZ1Eq
         w5s0kwAMXj03//V3d6frspV/5voPlfDG6hJ6kWh7gvb98fjIvmoJE9dD50uqs9uoYDmF
         N7Rw==
X-Gm-Message-State: AOAM530XQK/bmMUNoQl/57tfRolrgkH+vJLfYN22Twscu3i/7qURtp0Q
        whn6FxV9c3CjwHl0XRrCOhiXAsMkhfk=
X-Google-Smtp-Source: ABdhPJxrYmEmh/IcZ1k6JBAA2NKCmHgQ3m72Volgs21uhjitUI7YHi77S9D2h4nyccgacWyef0kYFg==
X-Received: by 2002:adf:de92:: with SMTP id w18mr37475763wrl.42.1626800689429;
        Tue, 20 Jul 2021 10:04:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm24349522wrt.61.2021.07.20.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:04:49 -0700 (PDT)
Message-Id: <f1167669848563cbdd09dc90898edeff5ff59b2c.1626800686.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:22 +0000
Subject: [PATCH 02/26] init-db: set the_repository->hash_algo early on
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
gitgitgadget

