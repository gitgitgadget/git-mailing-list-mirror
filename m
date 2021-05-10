Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C5FC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188936143B
	for <git@archiver.kernel.org>; Mon, 10 May 2021 20:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhEJUCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 16:02:51 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:54560 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhEJUCu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 16:02:50 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:15f:f3a5:290d:714a:246e:6fba])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 9B640461158;
        Mon, 10 May 2021 22:01:09 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1620676871; bh=t9Kt51NFcGzV8vDjlp9S0TbK5nfwmL8qhR+VEP+oAbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g9TsvmZfl5Jc8fG9DPna8nSUyQFiPJXJP+3dq1xKTS8vzVFVzyE4QGVzBk8KLqwmk
         v5VNefA4VeDLnbr75b/kH+KYQs3x+psXMsyg0RvZUtdu4KFo4CE2PpFcNP6PX69Jv6
         oFL+mIQut90snjqQUhaLWEUtzlJj6qHC+YEu62pE=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>, lilinchao@oschina.cn,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v2 0/1] maintenance: fix two memory leaks
Date:   Mon, 10 May 2021 21:59:08 +0200
Message-Id: <20210510195909.621534-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509221613.474887-1-lenaic@lhuard.fr>
References: <20210509221613.474887-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Thank you for the code review.

I’ve moved the `strbuf_release(&line);` closer to the last point where
`line` is used.

And I’ve included Junio’s patch to address the missing
`free(local_path)` when `hold_lock_file_for_update()<0`.

Lénaïc Huard (1):
  maintenance: fix two memory leaks

 builtin/gc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.31.1

