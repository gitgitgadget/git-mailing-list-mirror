Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25CC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 03:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378330AbhLCDwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378236AbhLCDwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 22:52:00 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E139BC061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 19:48:36 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p65so2177017iof.3
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41ir+GcIh+wG62xFtfYu57AlTtSOUsE8ghvzNhmfP2I=;
        b=olPVtef5l+7dCFj0onXXsu+1FaZ5JZprRra9i+Ff4dMTXz7urK2Hux0s36qCmOsjZt
         2B0IT+crfgB2juDZ33HEURJ6FSTThOPu3bi4jVnUV7H7gY+Q7o2YhQPvyGL+3y6NC5oq
         ePfDUHmsYw97eE8iQMbkIvvixs86Uqsr7WtVSL8Cc5PvepGtIETmjNU3Ti4kQQo8N+Un
         mn+Lc8SO5CSjtjJnzRmnn8SjevzGmxJhM7QPMhHttSY3fvo4COD+cLFBSsppUzpSUVeI
         +wIQRMJbdO9136w3Mp8QECbdBqPiMd5VsncQMrSBC9y+7xlKTXT2iRepx3Zb0RNNKZhK
         LmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=41ir+GcIh+wG62xFtfYu57AlTtSOUsE8ghvzNhmfP2I=;
        b=8L5G/e1vMNDZi7YCyGyJO6Bh9+0iwdWWXaW3A5c7S+D+Ru2jRClyNRkixpUixOHiEe
         kNjxvQjZwxS/bGo6f72ZPg5eANhnXdbvKrStwwKOOFj6z0ZiHVqeNMN1CsYU9XquHig+
         1JJfUxzNXPgit52i23imtj48TsDnyLatjf4JZtvsSqJ3pC4Y8pc6p5C8DQ+xiB4ZQOxx
         awwwBwolyfMQmtarTcP53bRuFqtIoQByDAHwZyVHybV51sG+43hPoAAIM6O5wgYapdDV
         +u+AXboIEX5Yz1oQUqKj5DGnO70VwxOWcW6Q33rMtMGNTNoGYbYuQwOMDa455+zDXsLr
         jGKA==
X-Gm-Message-State: AOAM532SHvluA7YZKtaLSO1I5/Buc4HG+JMyWpHW0pXgvYHxXYDfl8eJ
        9rT5hBM8jLljgqGRn4gKkFrpLWXBJv1jSQ==
X-Google-Smtp-Source: ABdhPJwx7OoMKfm0xQy3/ej4BjshtZsOUjd9iQq1coTOYZrOirxK397i4rdLlS5Rg8jsw21dCnPIKw==
X-Received: by 2002:a6b:2bc3:: with SMTP id r186mr18501488ior.167.1638503314889;
        Thu, 02 Dec 2021 19:48:34 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id x2sm975639ilv.65.2021.12.02.19.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 19:48:34 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] worktree: fix incorrectly-ordered messages on Windows
Date:   Thu,  2 Dec 2021 22:44:18 -0500
Message-Id: <20211203034420.47447-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes a problem in which a chatty "Preparing worktree"
message and a subsequent fatal error message appear in the wrong order
on Microsoft Windows, which may confuse readers into thinking that the
operation somehow succeeded despite the error.

Unlike the original RFC attempt[*] to fix this problem at a low level in
a generalized fashion, patch [1/2] localizes the fix to git-worktree
itself by making it conform to common Git practice of issuing chatty
messages to stderr rather than to stdout as is currently the case.

Patch [2/2] is just a drive-by fix for a minor documentation problem I
noticed along the way.

[*]: https://lore.kernel.org/git/20211130043946.19987-1-sunshine@sunshineco.com/

Eric Sunshine (2):
  worktree: send "chatty" messages to stderr
  git-worktree.txt: add missing `-v` to synopsis for `worktree list`

 Documentation/git-worktree.txt |  2 +-
 builtin/worktree.c             | 14 +++++++-------
 t/t2401-worktree-prune.sh      | 14 +++++++-------
 t/t2402-worktree-list.sh       |  2 +-
 t/t2406-worktree-repair.sh     | 30 ++++++++++++------------------
 5 files changed, 28 insertions(+), 34 deletions(-)

-- 
2.34.1.173.g76aa8bc2d0

