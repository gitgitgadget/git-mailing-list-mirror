Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CBC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 22:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhLDWzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 17:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhLDWzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 17:55:06 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE7C061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 14:51:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m9so8523360iop.0
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nenXaATeYcU8pZdfmDstGQ9jc/D4/fch+jLqR1+3Sr8=;
        b=lZHT9sEMOl1L1TgIsrfpWNY1blwzQJV3yosRyoVXyaOR6kPIPwUpGUAD8+GF3Japy0
         7bnoh9LOWfaOdfyZWnEjmWYYO+Vqtp6RXnwJlgtTIe8g9VE5tWMCbd34DmarjCKrvz/f
         8xRr42/cyByW4UvDyu7Qan4NtNTzIDRpjgdb3E1maQqBFjxc524fJcyxo23g0GFl3Nvy
         xNcc8gaeBQbcz4tM0o8WcYgHumdTNd3iWNLe+jL60RmTOA5EERfSud/hyqORLqQ1J7BV
         qWKkulTPBDAaoWusIW3bG83RQ/XZT/uV9PB5SEL0418TK3XtWbN+pgBbEOm3FeQtLaMT
         VFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nenXaATeYcU8pZdfmDstGQ9jc/D4/fch+jLqR1+3Sr8=;
        b=bC83fW7MeBg1gxR9wqVHnXyUrrxNgMtU1NUpu3pipTO8247keiAKJ4lz0bUjz6ZXap
         OpA87nmSn+AgezFf+2Cj0XWoNmC2Qzlo6ih13YxJCz3OOlYPRBdph0lW6+e2eoKEdVn0
         1HdT7PnMdjVNsEQFm/CiDuw7b4WA5KhuM4qP64zy0Lp9cHByXGhzxu4xIBRnJxlLuLvg
         sO/XIrek+5Kma72qsb6I9KDEy6/2VFC7WQo4QKWNyZQ5mcRgsgv4Hk/hZvm4OSr3ua+y
         zhy8xtiMjovLJRc8FWFsgDH1H8+lXF0Sqa0am+6W5D0QjDRhDclUfVpZWP1UtecqRtpM
         JUDg==
X-Gm-Message-State: AOAM531VYPyFZkis6Wjbm8XVLbzMy+Em43+kN38UdefqPLOyy65kX940
        3lasbQyiVCzhRptY3eLAxEWcpS0aNCLYfg==
X-Google-Smtp-Source: ABdhPJzhoxGEBfkc3fDKc+L3x5hTTPzgWDYRFbME+O81r87pp+2lfrELihlImG9XefV2n3n7nQiK2w==
X-Received: by 2002:a05:6602:1484:: with SMTP id a4mr25934150iow.35.1638658299585;
        Sat, 04 Dec 2021 14:51:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j8sm4363047ilu.64.2021.12.04.14.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 14:51:39 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:51:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com
Subject: [PATCH] packfile: make `close_pack_revindex()` static
Message-ID: <dad2b73c84f1c1575a6bce04a449ee1236680b10.1638658219.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since its definition in 2f4ba2a867 (packfile: prepare for the existence
of '*.rev' files, 2021-01-25), the only caller of
`close_pack_revindex()` was within packfile.c.

Thus there is no need for this to be exposed via packfile.h, and instead
can remain static within packfile.c's compilation unit. While we're
here, move the function's opening brace onto its own line.

Noticed-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed by Ramsay in a separate thread[1], because the two
style/organization fixes here were propagated into the new cruft pack
code.

[1]: https://lore.kernel.org/git/ec008905-5e04-944d-f164-d52a622f0531@ramsayjones.plus.com/

 packfile.c | 3 ++-
 packfile.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6423d77faa..c38e749eb5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -324,7 +324,8 @@ void close_pack_index(struct packed_git *p)
 	}
 }

-void close_pack_revindex(struct packed_git *p) {
+static void close_pack_revindex(struct packed_git *p)
+{
 	if (!p->revindex_map)
 		return;

diff --git a/packfile.h b/packfile.h
index 186146779d..a3f6723857 100644
--- a/packfile.h
+++ b/packfile.h
@@ -90,7 +90,6 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);

 unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 void close_pack_windows(struct packed_git *);
-void close_pack_revindex(struct packed_git *);
 void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
--
2.34.1.25.gb3157a20e6
