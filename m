Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F138960EE2
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJTSmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJTSmS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC6C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso5768947wmn.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNghlNJxKqBOHiQ37C7Dh9wT3uAgUbH23RD4mVlUI9U=;
        b=CEj2ySC/n9HXqG3cQsrUTJqiQECx3mL646ASrzXlNM2A6i43MxFWaKzXNVib553Gxo
         SenDIiWGzc4sysUHc9ziebzOsTyja8g5tEVpwhSK1l+VUKskZrooHFuX3WwlXGrDwEFn
         OuEr4cVnYMICRfDoUkLAhNGA0eY//3BUCZ5Xl4ZK5HJIHka1GONbV6HsFEU43BepeBAn
         JVMuxZqKdF1CM/SiWGegNLMaUoMPG0ijxlR0xjyVcZj1YgIuFuslFAyORsQIG+LL48xP
         qMt4NmdziF8k0XqJ5saCXZch5KeCnf6WSkgKANLXiP5YNLNEznlc6pkfCxBXImjTYmff
         bHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNghlNJxKqBOHiQ37C7Dh9wT3uAgUbH23RD4mVlUI9U=;
        b=EtUQHTyRzfDsaZhoVdOa7uTN+fwQPPnC9WCwGSwZbEUg5ArmkFo5H7olgWn+IGwjjs
         bQKKByeHuZ6e0ZSdPHIXrT7Jv1noryFbMCOZTYJR4CJuj2lJgyceLsS/SP7NcnEXEj6M
         BsO++rrzzk28FYtJN7WNqTq/iA8GpJzgp2rKNIyHj0lQvUivjgUHwtf2eIyQrgY9wlIg
         eCwkB6fUcG31qtGWDHURAb/U84sK94s4cyCboHj+A6TZe3aAYrObqhoPTXFY5qN2Uyyq
         83Seo+CjxPz4nIaSOHMDkU7e63Em+JtGLxFx5Erh1+bC4Tfc9oGmwxxx5tDQckASjzSk
         pEaw==
X-Gm-Message-State: AOAM5325njlOBndhdxVOK4rbWgrd8236UwJi9gf3n9zm7IGWa3x6cYZb
        ST2WMIasr3AEGDK5JzpvUYz8b78nCBuzxA==
X-Google-Smtp-Source: ABdhPJzfMOogTVSTKpQDL+SQwXbWFt14qmR8ChVWZNA7tE0sW7N/9G6uzl29uWsjrrnAJMcPVh0dWw==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr1075772wmc.132.1634755201599;
        Wed, 20 Oct 2021 11:40:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Date:   Wed, 20 Oct 2021 20:39:51 +0200
Message-Id: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based off an off-hand comment I made about making the
cmdlist.sh faster, in the meantime much of the same methods are
already cooking in "next" for the "lint-docs" target.

See 7/8 for the main performance numbers, along the way I stole some
patches from Johannes Sixt who'd worked on optimizing the script
before, which compliment this new method of generating this file by
piggy-backing more on GNU make for managing a dependency graph for us.

1. https://lore.kernel.org/git/87r1gqxqxn.fsf@evledraar.gmail.com/

Johannes Sixt (2):
  generate-cmdlist.sh: spawn fewer processes
  generate-cmdlist.sh: replace for loop by printf's auto-repeat feature

Ævar Arnfjörð Bjarmason (6):
  command-list.txt: sort with "LC_ALL=C sort"
  generate-cmdlist.sh: trivial whitespace change
  generate-cmdlist.sh: don't call get_categories() from category_list()
  generate-cmdlist.sh: run "grep | sort", not "sort | grep"
  Makefile: stop having command-list.h depend on a wildcard
  Makefile: assert correct generate-cmdlist.sh output

 .gitignore          |  1 +
 Makefile            | 57 ++++++++++++++++++++++++++++++++++++++++-----
 command-list.txt    | 20 ++++++++--------
 generate-cmdlist.sh | 53 ++++++++++++++++++++++++++++-------------
 help.c              |  3 ---
 5 files changed, 99 insertions(+), 35 deletions(-)

-- 
2.33.1.1338.g20da966911a

