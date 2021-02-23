Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA241C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A757A64DAF
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhBWGkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhBWGjz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:39:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6106CC061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:15 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u26so2215931pfn.6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XJA+ZQQcBc0NzPXomRUH+0310tMa7x0RVoPmzuZxy8=;
        b=MnmMfwQLQk27KSEvQVnv5Cd/3KkAxf6ul+6/8SJIGRYNLmgrxz907sfbgh9plDPhmi
         rE7bx4nKjRSTAovy7PxI9SvAWuQIZK2jlGy8PoBvv4eTYQfGaVj7pktbFQCkStFXtLyZ
         r8xKoK9bcuMCQtDG5vnqXPcioqr74HdEWPW/6Q6bOI7rk9RqtgPE0XY13wxMcG05CJBj
         mouOQhvt2y1YGG+sl1rTY9ell1Ne8wctLrSnrvLHr09MWyTF83IJmWgOP3B6w9i4uitv
         vf3IK5BmbkMSF22nkkVTGKQasYUs9ifH7Pat8Rh6j24JVTZyne5d3LJ/emOnmGfqWsk3
         NL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XJA+ZQQcBc0NzPXomRUH+0310tMa7x0RVoPmzuZxy8=;
        b=el92BV1SS2n3Wje9GQHr5+xlbaX9l1VbCyCqUZpvIROnHOSW8g8+D+PZbNle5WIpLV
         9tMHpXcPPqPkjdwY9cpNQwH6Zhl+3adXcqg+COg4qqQTUQR4Ne/kBVQKrz6BhudYvsZt
         CfMejOD6623J1BegiJJIhEYk9jZKx8cksEbXSUcgfVdcQCxgfkxz2DIuVMp+xHQ4hp3N
         IUGFiPgyTX9aGScuUELcGvcfDpSSokgA+LyILrdxa57Yk7T0N/8d478zbR+NFe95RXBh
         cWds2LTP3az7kF75kE9Dz0pF7dtrqQY+J+Qc2n7mm/0FPoQtSQFl0K1TGkqWxepbN0Pv
         LAxQ==
X-Gm-Message-State: AOAM532X1+uZtmLs+tTLLVXH1wo88zx0YA75LtWx8imcvjpFeNEa+Hlh
        EGhhv2YqFYPCn+l1EC7XMxPJVG6RgQg=
X-Google-Smtp-Source: ABdhPJwzxP/GRpCci9H9/ci3tglxWGZBF1UkB54AZjz22Bx8r+pCrYeNj0/FDmpWW2tlx23PTstOQQ==
X-Received: by 2002:a63:4708:: with SMTP id u8mr11331620pga.102.1614062354633;
        Mon, 22 Feb 2021 22:39:14 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j1sm21355055pfr.78.2021.02.22.22.39.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:39:13 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] docs: misc cleanup
Date:   Mon, 22 Feb 2021 22:39:05 -0800
Message-Id: <cover.1614062288.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a couple of documentation fixes that I noticed in passing today.
Nothing too controversial.

This branch is based on 'maint'.

Denton Liu (3):
  i18n.txt: camel case and monospace "i18n.commitEncoding"
  git-cat-file.txt: monospace args and placeholders
  git-cat-file.txt: remove references to "sha1"

 Documentation/git-cat-file.txt | 52 +++++++++++++++++-----------------
 Documentation/i18n.txt         |  2 +-
 2 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.30.0.478.g8a0d178c01

