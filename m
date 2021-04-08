Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D8C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 09:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A826113A
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 09:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhDHJQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 05:16:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6CAC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 02:15:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so2807687pjb.2
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qHh2UHULQBunwyQ2slEKQsEz9qA1lx0WKErqJDPDmg=;
        b=ctM9tZfNlOmvU3HtHdHWjqyqs0VUaFFw/nD4uVPO2O5nvDEqHirxjiRMDH1TLQxV47
         DMoEpMTtc3PLRJFSlXJAmz9aelPqmi2rCzOC+VZ3zWYhYtpdkIQnHB7Jzo8TLuPQ+vuD
         E5aDEJ07PuTt0DYNg4yIPz4iObhM5/bxn6Dhaw2WsM4xlEIj69A5ngdFv3FWOwB5xGZy
         +k/mA+plygxrmGnV0FZjwiNVc08qiTgFbKwR6GSGUJPJUbRCup7UPzz0VTisaCJSg2cQ
         imGhy0fLrLyQSg/2OSywa0EbRvzCq/GEMp3NIbTTWr9Tcmrm5mv7375qGk8alhdIufUt
         TUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qHh2UHULQBunwyQ2slEKQsEz9qA1lx0WKErqJDPDmg=;
        b=BfsZ1vNGU9kgVLIOFKpaq9vmC5CPxl9lG0zBX1SLJPMSZJyqUAdoSZ0iGGjX9pQL8F
         FymnrXIGqtspgnc1tsV1R3xFFJZEk3SkmTqsbwPvqwn4c9vf33YoRmbYheA2r1vhQP9i
         guL/fbIrad7Y3azw40RWFXdQnFkbWI0pYb+slP6BzGu8bKakST7NGQJ30lhqOVwuIG/A
         0133uSaDlMDBOkcD49STNXgWoHpUxe85OlmSYQOOd6AT4Jv0Zszou86ur2ryJWGukx7i
         KCNFlZraTM8rV5vkww+YAU/+9r+9LZ225qLinz4KbfBvypllGBV5HOIwJdMYAelunqSk
         EVlA==
X-Gm-Message-State: AOAM533STuZ5zWgl6xXI+Bkgtf1F7loeJt6RBABRPpUuHecWcztrdI5C
        wNaRoXnCAz+4Zv8W3Ew6pbEANq/0X6EiHVcv
X-Google-Smtp-Source: ABdhPJyvSQWM+l3TcYZBbLKbkfVlHIlIgpbHMjTtSVDt+lL/hijSZ8zfDJCiuKhwk5JcHL6q2FsZPg==
X-Received: by 2002:a17:902:bd41:b029:e6:933a:f3ef with SMTP id b1-20020a170902bd41b02900e6933af3efmr6815229plx.19.1617873349116;
        Thu, 08 Apr 2021 02:15:49 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.157])
        by smtp.gmail.com with ESMTPSA id p5sm23323094pfq.56.2021.04.08.02.15.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Apr 2021 02:15:48 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>, gitster@pobox.com,
        avarab@gmail.com, j6t@kdbg.org, phillip.wood123@gmail.com
Subject: [GSoC][PATCH v3 0/1] userdiff: add support for scheme
Date:   Thu,  8 Apr 2021 14:44:42 +0530
Message-Id: <20210408091442.22740-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210403131612.97194-1-raykar.ath@gmail.com>
References: <20210403131612.97194-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 - Add word regex to support for R7RS identifiers that allow for special
   characters between vertical lines, such as |foo bar baz|.
   - Change t4034 to include the above case.

Atharva Raykar (1):
  userdiff: add support for Scheme

 Documentation/gitattributes.txt    |  2 ++
 t/t4018-diff-funcname.sh           |  1 +
 t/t4018/scheme-class               |  7 +++++++
 t/t4018/scheme-def                 |  4 ++++
 t/t4018/scheme-def-variant         |  4 ++++
 t/t4018/scheme-define-slash-public |  7 +++++++
 t/t4018/scheme-define-syntax       |  8 ++++++++
 t/t4018/scheme-define-variant      |  4 ++++
 t/t4018/scheme-library             | 11 +++++++++++
 t/t4018/scheme-local-define        |  4 ++++
 t/t4018/scheme-module              |  6 ++++++
 t/t4018/scheme-top-level-define    |  4 ++++
 t/t4018/scheme-user-defined-define |  6 ++++++
 t/t4034-diff-words.sh              |  1 +
 t/t4034/scheme/expect              | 11 +++++++++++
 t/t4034/scheme/post                |  6 ++++++
 t/t4034/scheme/pre                 |  6 ++++++
 userdiff.c                         |  9 +++++++++
 18 files changed, 101 insertions(+)
 create mode 100644 t/t4018/scheme-class
 create mode 100644 t/t4018/scheme-def
 create mode 100644 t/t4018/scheme-def-variant
 create mode 100644 t/t4018/scheme-define-slash-public
 create mode 100644 t/t4018/scheme-define-syntax
 create mode 100644 t/t4018/scheme-define-variant
 create mode 100644 t/t4018/scheme-library
 create mode 100644 t/t4018/scheme-local-define
 create mode 100644 t/t4018/scheme-module
 create mode 100644 t/t4018/scheme-top-level-define
 create mode 100644 t/t4018/scheme-user-defined-define
 create mode 100644 t/t4034/scheme/expect
 create mode 100644 t/t4034/scheme/post
 create mode 100644 t/t4034/scheme/pre

-- 
2.31.1

