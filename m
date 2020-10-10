Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF5C433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CF820795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecCCepPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgJJW4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgJJS4B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 14:56:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A1C0613BD
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 11:56:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so11144839wmh.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9Vh9JspTRPWqKqfpfLy0C4ZHDDp2SRIIL68sApYSuc=;
        b=ecCCepPUE9GxMm6YSOziIINnZXoG00w5OwqsmXpEc7P1rbVeDN203AcINXRLhp2OvG
         i1wzFtOXrsXFyWIwUnUwbWM64MC1/jC+koFiZYbizxeHhynYeevQW1bG1V0QVNkd0ZpO
         8zYFuqPmZbRkDpBMpat/E90ps6X6/KnGnuxEVghWzOmxb/zI8tpPk5HSWjBAUy/58LDD
         FWfjK1PUIJnfCBA3Dw6LwoSDghzqLldNtR5r65R1pNlM/bysnxxMuR/ad4gvu/QTE1LG
         yTsjTVuC4tmgjFuYiaSStHmXZ+sHDPpSfZpE6TKo4ZZBcIV5Rr66PqZyEbQU0F6uYsQP
         bMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9Vh9JspTRPWqKqfpfLy0C4ZHDDp2SRIIL68sApYSuc=;
        b=UvVYiOCjIxdmZVgqIqwOsWdX3AN9xI+hdsK99ir9ArWlqzCePpmI+BSYlOONEbk/zz
         N94LMhL7gcwuyCxHkEmhxJDOCtW6TGnTgfOett5YhWKKe1DLNrHihimsnUJrup6F0HvH
         ck4PlNoJIEQrWldwBExQ5SXgp7umab0QfeKgMguR9VgY1AJ3cwTqNzr+c/0j6zYn9QpK
         p/1SCSxd2a874l1fhdebyTwv5eXMXDOm6uyPEEehZ7PNHglPFSDcENJtnxvjkbJhGaCD
         3XXZylHzXpuY06mKycybJFo708wZKcEh1AyilrppRJJNsbii7313MTMulD4r6qBXT8M8
         VJ5w==
X-Gm-Message-State: AOAM532PLC8cd7nybwp3Uwml5SYabDdfx8rIzimGcIuZ9K4IbpoAPJLg
        zDXNvTtbI/8meOcH0izPn6FWqYzmYmMpvg==
X-Google-Smtp-Source: ABdhPJzLSIv24WmWxAMdON/g4SzbroQg/8JWErED/svz6DYBfYn28XNNWKbi0I9x75IiReCwPCah3g==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr3877821wmi.175.1602356159522;
        Sat, 10 Oct 2020 11:55:59 -0700 (PDT)
Received: from contrib-buster.auto1.local ([79.140.120.253])
        by smtp.gmail.com with ESMTPSA id u5sm19620325wru.63.2020.10.10.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 11:55:58 -0700 (PDT)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 0/1] Teach "worktree list" to annotate locked worktrees 
Date:   Sat, 10 Oct 2020 18:55:20 +0000
Message-Id: <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.253.gc238dab514
In-Reply-To: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
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
a worktree or would know how use "git worktree remove -f -f <path>"
to force a worktree removal.

The output of the "worktree list" command becomes:

  $ git worktree list
  /path/to/main             abc123 [master]
  /path/to/worktree         456def [brancha]
  /path/to/locked-worktree  123abc (detached HEAD) locked

Changes since v1:

  * Drooped the parenthesis in "(locked)" to reduce the noise and allow
    easier extensions of more annotations design proposed in [2].
  * Rewrite of the commit message with a much better one
  * Simplification of the test added to `t2402` with only caring about
    the "locked" annotation at the end of the "worktree list" output.

[2]: https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/

Thank you Junio C Hamano and Eric Sunshine for the detailed review and
helping with this patch.

Rafael Silva (1):
  worktree: teach `list` to annotate locked worktree

 Documentation/git-worktree.txt |  3 ++-
 builtin/worktree.c             |  5 ++++-
 t/t2402-worktree-list.sh       | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.29.0.rc0.253.gc238dab514

