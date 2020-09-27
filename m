Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09155C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A947B2389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3nrCvnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgI0NQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0NQG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:06 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F09C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:06 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b22so7971354lfs.13
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B82T1uHvDQa7yKhO6+4361tfXXn0HhOP6XbfPPUMFyg=;
        b=R3nrCvnbbRLwnCjlLfwB2iiILzfWgT0iGJyW88MKrD+YNcKk1/XxyeZ5uzrIiTn6My
         cqb5+oBGRI3xQyFo3AK/AAB0wCRnPFuaPxQiCAosw8P/DpJiRAFlmk+Hba9G0QEE2jyW
         VPkqdr4DGqPz/EWyF/dxWuGrSbFrlZwHK8mW3i5A//CHK0jsKs7flPdiD2zobQZVPf1J
         46bP3/17pyCNvwhkZxnVMnIe9/j79MVwF3Qvyd49v4L6Li5Rx3V5WLgmJMEEvlY1CYuM
         vlH1g+lG2QuMcUcmCxd2MQ/LCZcG0O5HAvKWR3oFflel22dr/hy2zLFcPnJuxx1uLr1V
         Zlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B82T1uHvDQa7yKhO6+4361tfXXn0HhOP6XbfPPUMFyg=;
        b=M7DVNuuXnJwbM5Ibx/W4z24oqmsDyoGoyh4dcuny8idJ9FaPylT5UKM5j/HWy394HE
         8roKqdMguABZATLL+9cAnM21V9di9YsCtEDmqKHQH9O/43on0F5bNUOXh7GonD1FnlRv
         DHTIQGq6rZ7EAIfljMqoN/6L3NbGLbNZ5gMmT/LQ/2g1Yx2xDtIo3D0kJwZCDNdHNmwb
         inwY3nLPPL4JvpHl0QOJN35SVVdtao9BixWPR0kT1Tz2HW+/Nje7gm5tCWothxii90mm
         U1W7n8Lpg15SPFVMvf9ZLL/pd1Oj15eZSD85rRSlaw/MGW+LSLhhKI+nFkh1KcxzVHw5
         zaLw==
X-Gm-Message-State: AOAM53055dEH09JgwSf5rNZvDJx4gA70dpPJ7efXx7DXVR4eRvEfZdGb
        Ru8VdY1oab3y6S1dfTMzajhwUVlLdds=
X-Google-Smtp-Source: ABdhPJwHuP9+XHjR+L3hoP5pjys3GqV8YfsYFd2BM9hTmbXGcNaVWGUPIFbZtBI1/cZNvcXMxLbNHw==
X-Received: by 2002:a19:4186:: with SMTP id o128mr2681731lfa.297.1601212564287;
        Sun, 27 Sep 2020 06:16:04 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:03 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/7] various wt-status/worktree cleanups
Date:   Sun, 27 Sep 2020 15:15:40 +0200
Message-Id: <cover.1600281350.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a belated update of my series to clean up wt-status.c and
worktree.c a bit.

The buggy fourth patch has been removed and replaced with one that
inlines `worktree_ref()` into its only caller. Thanks Eric for spotting
my initial bug and for the very helpful discussion.

The final patch, "worktree: simplify search for unique worktree" is no
longer. It felt like it was quite subjective whether it was a
"simplification", so let's not spend reviewer quality time on it.

Martin Ågren (7):
  wt-status: replace sha1 mentions with oid
  wt-status: print to s->fp, not stdout
  wt-status: introduce wt_status_state_free_buffers()
  worktree: inline `worktree_ref()` into its only caller
  worktree: update renamed variable in comment
  worktree: rename copy-pasted variable
  worktree: use skip_prefix to parse target

 worktree.h   |  7 -----
 wt-status.h  |  7 +++++
 ref-filter.c |  4 +--
 worktree.c   | 46 ++++++++++++++-----------------
 wt-status.c  | 76 ++++++++++++++++++++++++++++++----------------------
 5 files changed, 72 insertions(+), 68 deletions(-)

Range-diff against v1:
1:  734ea28eff = 1:  734ea28eff wt-status: replace sha1 mentions with oid
2:  7ada884d7c = 2:  7ada884d7c wt-status: print to s->fp, not stdout
3:  c08fed5a01 = 3:  c08fed5a01 wt-status: introduce wt_status_state_free_buffers()
4:  58a2469cc1 < -:  ---------- worktree: drop useless call to strbuf_reset
-:  ---------- > 4:  c4825f461e worktree: inline `worktree_ref()` into its only caller
5:  9c1e321fbc = 5:  dbbc57cd83 worktree: update renamed variable in comment
6:  6d913ea3e0 = 6:  70e6cea331 worktree: rename copy-pasted variable
7:  872dc384c5 = 7:  f8fbee6234 worktree: use skip_prefix to parse target
8:  8383c246f8 < -:  ---------- worktree: simplify search for unique worktree
-- 
2.28.0.277.g9b3c35fffd

