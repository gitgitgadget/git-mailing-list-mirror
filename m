Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF9C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBBA206DA
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtsC5E6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHCFhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgHCFhP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 01:37:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85579C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 22:37:15 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z3so19899154ilh.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 22:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhBtMbnWXCoHRf5jrUPHgyA8uYh7PPhMpLzfgyc33D4=;
        b=WtsC5E6V8O9/HZCYG4089E9JETb3A0uoz6xp6DtrGxYxUTRAXbJBuN6bDHj6zEZOr/
         pnJST7u3Unxi0yPxoxrStdZ+LcKREBSETG4zenI/IfFZllOKZ8d9vyCFbzCQFWoYL+eP
         LW8dyjsqbSfUJaYJN0vQ2T0ncwVHVE+2KoQ4TROLn6+fhJ5hrFK+5n0qs2MaeQCxyePj
         9qSVwpmcfUUDrEDoYVPKZkIe2RmpoPVnMrGES2sqIOMI4NcOb/N7gk/6Ih0sgOsuvo+R
         1sk5kBMO2JF2rWwrSYe+C3dctjKlh10auiVMzV0YFduwBKpXfj3KRqRvlTmJuOPVI+JF
         bn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vhBtMbnWXCoHRf5jrUPHgyA8uYh7PPhMpLzfgyc33D4=;
        b=cL+0nYVg2EHVwQu3HASdUp4OALKDjjsHuHI5/X7XeUKt0YGYTWFXbI87sNvk654hbc
         5yjht9kYlJ5TzYxlzStdPFUaMuCpby+jrHIK3J5cJ/LSQynaMAx9v4fP+lUteOsophzW
         j6ZVDAjE8sQfWxJoA6ipftX2qJ8UVX5jYRVrU9D2GCZC21Zu+P454qQ3Yie0MVHhH+d+
         zFPEdo14A5Fal0ARgKhvxUp0DpHmweMGAGjHTLs90UkrEIiAMzGxtDao6SWyOwQzJWww
         LrYtYVmmiCLHxorYp+RCRZBhLyUz+9gXHawkERkdfw2fZVLyPG8W9NlQrEX+zkLhzGt+
         AsiA==
X-Gm-Message-State: AOAM533yi+9Q2UL/dirArkHAzSMJTMLnu0mRx2fs/uAtIy+wy8T8X2qN
        zVPCGnvwYxC3PRxL3bohihFHmjtWoQ8=
X-Google-Smtp-Source: ABdhPJypqWlbzfXqVbS6PY5RP3IhK2BRHNrJ6E2DYy9gHPSrSq1PYUJEPenLkpan+tdlgcqcKBf8Ww==
X-Received: by 2002:a92:1b42:: with SMTP id b63mr16078818ilb.76.1596433034054;
        Sun, 02 Aug 2020 22:37:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r6sm8183114iod.7.2020.08.02.22.37.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:37:13 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/4] git-worktree documentation cleanups
Date:   Mon,  3 Aug 2020 01:36:08 -0400
Message-Id: <20200803053612.50095-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some problems I ran across in the git-worktree
documentation while working on another worktree-related topic. Since
these fixes are distinct from that topic, I'm submitting them
separately.

Eric Sunshine (4):
  git-worktree.txt: employ fixed-width typeface consistently
  git-worktree.txt: consistently use term "working tree"
  git-worktree.txt: fix minor grammatical issues
  git-worktree.txt: make start of new sentence more obvious

 Documentation/git-worktree.txt | 96 +++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

-- 
2.28.0.236.gb10cc79966

