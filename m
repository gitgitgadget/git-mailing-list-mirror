Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179FCC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DD8619E5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 15:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhJBPjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 11:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhJBPjB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 11:39:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27BC0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 08:37:15 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so15609054otu.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6hieFz3sTHjMEhHUiCZmjV9/PCK/oz1Dd+ZvcPniak=;
        b=qO/gWqRAXf659N+b317YP6myP6HCgjOEa6dAx8/cu5dtWeUy/tQyTCmvjD3W8fmXlA
         vuEDIePInIegzqvqTOCBegQX+P4XD+AyZTQhTNj6t2vf7lql8V8bT9m4P2JcejiL5R8S
         KmQHQIrZjgdbG6A4YqTxBXMinV4DnZyvLOBJMf/z8teJ6TTZaM8HFYjh1ScAvaLaYEnO
         esCOpcy5b2GrFw+EFpPX0n759lkKhmN59S+tRzgtHzDTry/TXjQrg0kilp4kLuF3i+J/
         slSW5BjHUL9OtQXz85ZmHAmvImM5/gsVWMJybYpwioBqfJ6+Hcb8Hl+FA9wM5cpQ+ERN
         OZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6hieFz3sTHjMEhHUiCZmjV9/PCK/oz1Dd+ZvcPniak=;
        b=bDG93Fk18jlHXWfsSQS1SUpNmzgQr8cSFfObcDu9fN+Yy0gfKSrELaa4SHlwP0MewT
         JLerlSTG3SINv4JrddRGyrCZyoc3cxhyo5jZGgnnwYbT/ef8K9kteaMP4Fk6fT9qjMhz
         gUtDcjVKcHsXbvOzX/UcqUXJ+dsTqlgh9DaNcqyoUaBLT3r5l6GLoTsNhUeDUfSxgGYo
         Wpt2IQMy70SlhyHwocuACzb888/ledPbWcNGXme9WkrucKtw3UvNQbl2wpoA+XGuzRDs
         BTzsY14h/0dt+vsiRA8UDQ4UAopD5qfNgkeormqL9wSorZI17MB3UUBD3pAPWv2nHboQ
         mA8w==
X-Gm-Message-State: AOAM532uv2/IBLd5ISmFe2Ofh0Uid2HbS9kD3lsZgksOk8lddE+k7+Nt
        kVp0c2O0kDDesrr8tCWSSfg9ScTAPxzv7Q==
X-Google-Smtp-Source: ABdhPJwtlXUa4Nh69CZr3PDw+OPbpOESdpUXIOO7Kq6bOwfSjOlkjhjILXwJHUatfGxELbmU0ek3OQ==
X-Received: by 2002:a05:6830:2805:: with SMTP id w5mr3125623otu.248.1633189034098;
        Sat, 02 Oct 2021 08:37:14 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r188sm1719987oie.7.2021.10.02.08.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Oct 2021 08:37:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 0/2] protect git from a rogue editor
Date:   Sat,  2 Oct 2021 08:36:52 -0700
Message-Id: <20211002153654.52443-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following series, expands git's terminal support to allow for
saving/restoring its settings around an EDITOR call.

The rationale is better documented in multiple tickets for Windows
users that had found themselves with a difficult to read output after
doing a commit (either directly or while running a rebase), because
they were using Windows Terminal and vi (the default).

It is also useful in POSIX systems which before this series will have
to reset their terminals, if (for example) vi got killed while editing
a commit message.

Posted as an RFC, because I suspect it might need additional changes
to support Windows < 10 and because I wanted to add a patch that at
least renames the "hconin" variable and maybe fix some spurious errors,
or even add some logic to prevent the reset if the terminal wasn't
messed with.

Carlo Marcelo Arenas Belón (2):
  terminal: teach git how to save/restore its terminal settings
  editor: save and reset terminal after calling EDITOR

 compat/terminal.c | 72 ++++++++++++++++++++++++++++++++++++++---------
 compat/terminal.h |  3 ++
 editor.c          |  4 +++
 3 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.33.0.955.gee03ddbf0e

