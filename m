Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D936BC433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874F52078A
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQuL3/Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJKKM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKKM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 06:12:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A4C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 03:12:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a72so3784062wme.5
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vZmbCjH56S2ZZ50icWNGCIbjTMWtDuMp5PS9Q2Er0Rk=;
        b=jQuL3/BfISLZf6OOHXYbzacEcWj2u34G28m2eg6abkjnUdmYJ95Aw8enMLBRWignvy
         5dskh9QS7sYjLBHIwvioNDcGuk3esJ6wWU/WRpLDYBDAa+5/hZ/Fny2nLbkz2ET88faU
         op9RupVcgOVCBzQnEzB1AMtim/WEY4giLBEzEoeerqhM40PZgyuAVKJ5dtdJh9KufM/A
         G3ziysF2YM+xdKFGdN0q2rK+F8+d/i3FT+0jGmb0XO3oG7OBTJFUh9ptiThp0dzjksXX
         FA3CgVRKlM5/LFJbO95ruzNwkvYxmmrHIYOIOwjlWS6bMBLttfa5uZWhsOd6by66cHzQ
         dEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vZmbCjH56S2ZZ50icWNGCIbjTMWtDuMp5PS9Q2Er0Rk=;
        b=j3ya+/l5NXxuYIDzfx04gQ9AqwRLiQvAuY6bpriAGykNCavvsR2XlSswvZ/ex5rLr+
         e9mVwPsO+G8giggw/IukwiHgrbfKs7bfEN/Y1obZQiDIH56o7j4SbK4yjxaC1bAijl81
         VJFvhjZ3ga05dLg7JfbuRH2QcbXuvf8HZ7Lrj8OFheQSayck9TWQfQcKUfFJK3gCTqPm
         GNnvqKxwN6htb80GsR7N8VnWmaO2f2JpS4zceR3MJj6Y8av3CqBRtTM5cYBOMXgvs2K0
         EEnAUfpSb85Qs1YA63kJmEV0jqemFIYMkxuMMucRTaPKpRbcmbH+9O34SotH+6PwCqNo
         YhmA==
X-Gm-Message-State: AOAM533oePC2YKw8t5IUj/7HkWH+d4X66KSV3uK+aw3amKbYKT12swXF
        +SO8vCNcPsN9LpGNQ7bgZyHF1SmBlxM4AQ==
X-Google-Smtp-Source: ABdhPJxd7WB2skQiAD7h1VtZABYE1O3zX9sRP5wE45eYwLzjSyl4ZO6lbXK2tH0aQ1OsisoOVYxGpg==
X-Received: by 2002:a1c:40d5:: with SMTP id n204mr6091718wma.148.1602411144844;
        Sun, 11 Oct 2020 03:12:24 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.120.253])
        by smtp.gmail.com with ESMTPSA id f8sm7363093wrw.85.2020.10.11.03.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:12:24 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 0/1] Teach "worktree list" to annotate locked worktrees
Date:   Sun, 11 Oct 2020 10:11:51 +0000
Message-Id: <20201011101152.5291-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.253.gc238dab514
In-Reply-To: <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
References: <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch introduces a new information on the "git worktree list"
command output to annotate when a worktree is locked with a "locked" text.

The intent is to improve the user experience as the "git worktree remove"
refuses to remove a locked worktree. By adding the "locked" annotation
to the "git worktree list" command, the user would not attempt to remove
a worktree or would know to use "git worktree remove -f -f <path>"
to force a worktree removal.

The output of the "worktree list" command becomes:

  $ git worktree list
  /path/to/main             abc123 [master]
  /path/to/worktree         456def [brancha]
  /path/to/locked-worktree  123abc (detached HEAD) locked

Changes since v2:

  * Regexes used to test the "locked" anotation are anchored and space is added
    between the worktree path and OID hex string to avoid false-positives and
    to ensure there is space between the worktree path and the OID.  

Changes since v1:

  * Drooped the parenthesis in "(locked)" to reduce the noise and allow
    easier extensions of more annotations design proposed in [2].
  * Rewrite of the commit message with a much better one.
  * Simplification of the test added to `t2402` with only caring about
    the "locked" annotation at the end of the "worktree list" output.

[2]: https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/

Thank you Junio C Hamano and Eric Sunshine for the detailed review
and helping with this patch.

Rafael Silva (1):
  worktree: teach `list` to annotate locked worktree

 Documentation/git-worktree.txt |  3 ++-
 builtin/worktree.c             |  5 ++++-
 t/t2402-worktree-list.sh       | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.29.0.rc0.253.gc238dab514

