Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB77C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1366100A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhEKGr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEKGr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:47:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5229C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 23:46:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k19so15367221pfu.5
        for <git@vger.kernel.org>; Mon, 10 May 2021 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7tlIgwtOlt1PRKWKzJYbOQGO+DXxHXXp+47V9o/Di0=;
        b=u0mUCMrizaV0e2cYw2wKPaXBmHedR+h9YCHFfxiWAuopRk2/Ph5b+/AbWco6nsOETb
         M8igyJ6I8yqlQoOhyPc6eVblUXhTQWcx6TKdSYLan+G3NtQ6u6SwGGta54JVUxFintuR
         93lm4IbUSb45feWAN7BL2wxcZLAreUyeHBMVDnkrsUI0EPqPdIBDjReDib73PqJL/Ff2
         i+cr7PqdA5a9mycv+IR0G3F8fpaXrnfcNijwQtfHh6IjD0M3FkW+4j+uAJbb3CDzbS4I
         6Q1jzGFi/wwM/ogCNAQmGuJfQvjuBWy6Pkg8kYw0KQZPAMZtFYAfuzmmweRaiYVNe40Q
         zNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7tlIgwtOlt1PRKWKzJYbOQGO+DXxHXXp+47V9o/Di0=;
        b=TQKioKPZdhkjoULzLYi+pM+kcOeEJdQ6ZjJKEWbFuOXyn/PslVNwXDHk8MwsCksiPr
         2358Wl1RGlgGsnx7b7xFboFusN1kP8D6E9upMYPI0e0K9A0lT4upM5IiWCb+8iW9wIXD
         F8TWqkfuUSP8fZessY2T1fesa4eBUyYrjQOjYbFuzviJL+uck9EBcGKM6nJCdisVg8A6
         fc7s93S9lCBYeXCD/NmoysjrkwFRE4/Wo1FXTgTQfBDRk7Ri9NTYr23HniEds+DcZQUQ
         k5U9rT1xQXuGNUxw01P8rW/BDObqmjKx0f1CyyduGDYTrW3mdAuEo9E59GlZXrrTACzX
         7kLQ==
X-Gm-Message-State: AOAM530yuEwtCFYvWgD+uQC9FDNlOEz/oz1I6+ruvFXtOlM5o/JvBaGU
        DuIfsRG2E/RgfC520y5Cymo=
X-Google-Smtp-Source: ABdhPJw1VpswobkTp0DC/ZQVA5aiXwF7eFjKEJ3Y54KPoEac5D2ohpp8Ho2OQzPwdoAz3wpeebiXSg==
X-Received: by 2002:a63:5158:: with SMTP id r24mr4824098pgl.41.1620715581194;
        Mon, 10 May 2021 23:46:21 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.91])
        by smtp.gmail.com with ESMTPSA id cv24sm13771533pjb.7.2021.05.10.23.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 May 2021 23:46:20 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v2] packfile-uri.txt: fix blobPackfileUri description
Date:   Tue, 11 May 2021 14:45:54 +0800
Message-Id: <20210511064554.59924-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g1f2fb5c85f.dirty
In-Reply-To: <xmqq4kffy224.fsf@gitster.g>
References: <xmqq4kffy224.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
and the correct format also can be seen in t5702.

Jonathan Tan <jonathantanmy@google.com> writes:

>As for the commit message, limit the title to 50 characters or fewer if
>possible. Maybe something like "packfile-uri.txt: fix blobPackfileUri
>description" or something like that.

Thanks for mention this, "packfile-uri.txt: fix blobPackfileUri
description" is good and meets the "50 characters" requirement. So the
title is modified. 

>Also in the commit message, maybe mention that the correct format can be
>seen in t5702.

Because I am implementing another patch[1] about supporting the commit
object in packfile-uri, I noticed the `configure_exclusion` function in
t5702, which is now mentioned in the commit message.

[1]https://public-inbox.org/git/20210507021140.31372-1-dyroneteng@gmail.com

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..1eb525fe76 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -35,13 +35,14 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
 at least so that we can test the client.
 
 This is the implementation: a feature, marked experimental, that allows the
-server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
-<uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. As noted in "Future work" below, the
-server can evolve in the future to support excluding other objects (or other
-implementations of servers could be made that support excluding other objects)
-without needing a protocol change, so clients should not expect that packfiles
-downloaded in this way only contain single blobs.
+server to be configured by one or more `uploadpack.blobPackfileUri=
+<object-hash> <pack-hash> <uri>` entries. Whenever the list of objects to be
+sent is assembled, all such blobs are excluded, replaced with URIs. As noted
+in "Future work" below, the server can evolve in the future to support
+excluding other objects (or other implementations of servers could be made
+that support excluding other objects) without needing a protocol change, so
+clients should not expect that packfiles downloaded in this way only contain
+single blobs.
 
 Client design
 -------------
-- 
2.31.1.443.g1f2fb5c85f.dirty

