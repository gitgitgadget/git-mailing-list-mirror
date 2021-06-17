Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A0C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840D1613CA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFQK7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhFQK7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:59:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B773C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:57:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so1387653wmb.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkmuGQnsOouCyWp0A2PTli2jwdTOHihCuMMViwrxorE=;
        b=bGLdZ9h0ZSw5VtcbYyZ2KTN8OK0SQVc6HRr5DHf5Rsx4ULDWLfKMuxqWirTqgTgGYu
         Lrlo75r2eaLJGmHfgEDT0VNr46RrpoG+B4Bo1I/iSSycP2GfmLB2DgHkeZVPT12fNr3C
         JpZIbrzaNyIF34sIIy/ZolH/PKc9cCFcmi9xDh/Pf3NU7QI6i+YlTU4vkgB3emzT/LQQ
         ASVUiNeMmYf9+nAnQ7Z7xsa6eOL1LvmGmNXJt1GtctK35sxFlBUWdXgdi4yVJOc5lesm
         4hAc7vqyWfz6I4549t4z+odLRA0MmrdidIHgL0n2UYZMEO/hQc6Csvaa/LhJi/sEFanp
         B7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkmuGQnsOouCyWp0A2PTli2jwdTOHihCuMMViwrxorE=;
        b=jzJqNUY59rTfBuqoNZGe6Z48FsfWYDY6QaFNIcRXigdMYHyOMJU9QtLcaAGfGtBuF8
         UcMVcVFLQkJtEOfmLVAXqXa3ldl7tlG87/2INxXJwHyN8EYOCoN1DHWqaxBQUpzaF9Jl
         yMmQ6WTkCvQpeOEne/KbwWP3jmoolR+6pxR3uYZQcHJPOBALLh7TBfHXAT2ahgSwAH+N
         YM2NNaAGZuJnbs58Sac+UthsvhiRsCHJPNDXf4btQu8/NfK/vG3Bp5U+/vQICyZI0irK
         RM/MXCDofnr8BmJRGf3kwt2QSIykSEQe88Q5JJ6id1v3307R5BVJICzYrNgdYAJQEfc2
         3c5g==
X-Gm-Message-State: AOAM530nyu0a/qPv7AQeKtGmcg5VuOs5zwjFce4R4iGZyrKLYqWvai2Y
        CeHRCPPB2dG4iZUHPVyLgIeNcqEBWjn49A==
X-Google-Smtp-Source: ABdhPJw8wRc+cZDw9lGZcS3G4emf+keere2skjdQ8/disbIVFGDcNO27Y7iSIEA7N//GHlhqtCg8wA==
X-Received: by 2002:a05:600c:ad2:: with SMTP id c18mr4290093wmr.93.1623927464408;
        Thu, 17 Jun 2021 03:57:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k5sm4897948wmk.11.2021.06.17.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:57:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] pack-objects: use revision.c's --stdin parsing
Date:   Thu, 17 Jun 2021 12:57:33 +0200
Message-Id: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of
https://lore.kernel.org/git/cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com/

Fixes whitespace issues in v1, and uses the named enums I added
instead of their implicit values in the documentation. I also
conflated BREAK and CONTINUE in that same explanation.

Ævar Arnfjörð Bjarmason (4):
  upload-pack: run is_repository_shallow() before setup_revisions()
  revision.h: unify "disable_stdin" and "read_from_stdin"
  pack-objects.c: do stdin parsing via revision.c's API
  pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS

 builtin/am.c           |  4 +--
 builtin/blame.c        |  2 +-
 builtin/diff-tree.c    |  2 +-
 builtin/pack-objects.c | 64 +++++++++++++++++++---------------------
 builtin/rev-list.c     |  2 +-
 revision.c             | 35 +++++++++++++++++++---
 revision.h             | 66 ++++++++++++++++++++++++++++++++++++++----
 sequencer.c            |  4 +--
 8 files changed, 129 insertions(+), 50 deletions(-)

Range-diff against v1:
1:  c56a302e09 = 1:  6a8b20a7cf upload-pack: run is_repository_shallow() before setup_revisions()
2:  002e0f1cf7 = 2:  d88b2c0410 revision.h: unify "disable_stdin" and "read_from_stdin"
3:  1a9eb26587 ! 3:  d433d7b24a pack-objects.c: do stdin parsing via revision.c's API
    @@ revision.c: static void read_revisions_from_stdin(struct rev_info *revs,
     +			int do_break = 0;
     +			enum rev_info_stdin_line ret = revs->handle_stdin_line(
     +				revs, &sb, revs->stdin_line_priv);
    -+	
    ++
     +			switch (ret) {
     +			case REV_INFO_STDIN_LINE_PROCESS:
     +				break;
    @@ revision.h: struct rev_info {
     +	 * When reading from stdin (see "stdin_handling" above) define
     +	 * a handle_stdin_line function to consume the lines.
     +	 *
    -+	 * - Return 0 to continue revision.c's normal processing of the
    -+	 *   line (after possibly munging the provided strbuf).
    ++	 * - Return REV_INFO_STDIN_LINE_PROCESS to continue
    ++	 *   revision.c's normal processing of the line (after
    ++	 *   possibly munging the provided strbuf).
     +	 *
    -+	 * - Return 1 to indicate that the line is fully processed,
    -+         *   moving onto the next line (if any)
    ++	 * - Return REV_INFO_STDIN_LINE_BREAK to process no further
    ++	 *   lines, or anything further from the current line (just
    ++	 *   like REV_INFO_STDIN_LINE_CONTINUE).
     +	 *
    -+	 * - Return 2 to process no further lines.
    ++	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
    ++	 *   line is fully processed, moving onto the next line (if
    ++	 *   any)
     +	 *
     +	 * Use the "stdin_line_priv" to optionally pass your own data
     +	 * around.
4:  15a3a5d047 ! 4:  e59a06c314 pack-objects.c: make use of REV_INFO_STDIN_LINE_PROCESS
    @@ revision.c: static void read_revisions_from_stdin(struct rev_info *revs,
     
      ## revision.h ##
     @@ revision.h: struct rev_info {
    - 	 * - Return 0 to continue revision.c's normal processing of the
    - 	 *   line (after possibly munging the provided strbuf).
    + 	 *   revision.c's normal processing of the line (after
    + 	 *   possibly munging the provided strbuf).
      	 *
     +	 *   Change "revarg_flags" to affect the subsequent handling
     +	 *   in handle_revision_arg()
     +	 *
    - 	 * - Return 1 to indicate that the line is fully processed,
    -          *   moving onto the next line (if any)
    + 	 * - Return REV_INFO_STDIN_LINE_BREAK to process no further
    + 	 *   lines, or anything further from the current line (just
    + 	 *   like REV_INFO_STDIN_LINE_CONTINUE).
    + 	 *
    + 	 * - Return REV_INFO_STDIN_LINE_CONTINUE to indicate that the
    ++	 *
    ++	 * - Return REV_INFO_STDIN_LINE_BREAK to indicate that the
    + 	 *   line is fully processed, moving onto the next line (if
    + 	 *   any)
      	 *
     @@ revision.h: struct rev_info {
      	 * around.
-- 
2.32.0.571.gdba276db2c

