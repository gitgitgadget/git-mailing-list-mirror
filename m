Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C812C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjECSvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjECSuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BDF59F9
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8a3f1961so58965957b3.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139837; x=1685731837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLUhuF6uOKYAoZSfwaPr08LEFMr3AKQHlQqMsgFWks=;
        b=DrHSgOIj0Be9dpzC/5DWSd4PBqFtIVDyDH2MEbKeOnGlu8R6YfEJAT2fP3wcjuZOr8
         7ELAGcAnk8RJ5x8OMnd/kPCuCBVr6VnKHpi9/oTylc67JVZdGQHTE0jegTePf9aVI59m
         Jqb/fAn5s5jxN9+qsCV1DzoPGZBeBkNrHBZN2fUGXIRLgJFgweM0+31HflPcPAyfHm3P
         08erTMSKvt7fnmwI4Sgx873G5Ssf293H9GXiLkByfxaZ6aeT+hxZAs0cz4tPpaHMcEMO
         44dk1+f4plSqDBlLdNxR/QifsYDlJkKQpzbVvOQ9PAxsdI/zUisL2NhTSJu3hldmva0E
         RSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139837; x=1685731837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dLUhuF6uOKYAoZSfwaPr08LEFMr3AKQHlQqMsgFWks=;
        b=W1B+lZBB7DiitYQrbQ4nfZ4EZPvg4z4fp/dVki9xHfqpYUvvK5zkEVNov9QwoEvQ45
         53eFbXUK/Zc/hoUWaHQbptuylIjWwIT98tvTeeWeNppuVRzUJVOgVweGD59XJx10zcvS
         2mkdkg8njvczsw/kIjrZ3dYe5Fh22ZrrCULGYcKfZdC+gKrOM1/vxGK3/YVKmfJ0twtq
         gnM7erv6jrAmFIxqkCh5O/wokeUoqnnTg1FbF/YEGRGumVItvfilFMWMjYAeFb/Jrlr/
         yyMCjwykZShWPubpD7WIALeOLvwwwMODE0TQMAldXLDX0oml0kxs/957ejW+0qFQuzDU
         UN4w==
X-Gm-Message-State: AC+VfDxuSFJQ00jg8HoLNtQRJgS6kb/LQ6lX8xWyhx2YNEJOiKp00DOn
        eZInE3jx4MidfPKB8rMIUKbV2luAZJW1g6+6K9iezzuEfQrHOp4BVZdZRUq5oFwiS9eOqIea145
        8Vznt7q7FdxW6MKwHaJWbs/CAZKlGhUDNgRf0+/UFsoRukils5GhrcJKFi0gf0NRljg==
X-Google-Smtp-Source: ACHHUZ47JXOUwrc31FUbgpu+v1TH63WJTPMuOXoFgmB4AFCayJ5c1Ubtvwwez+2h2NTZ6eGa1ZfY8Rjeqls1EYY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ca4a:0:b0:555:cce6:1bd2 with SMTP id
 y10-20020a81ca4a000000b00555cce61bd2mr13478492ywk.0.1683139837608; Wed, 03
 May 2023 11:50:37 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:25 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-1-calvinwan@google.com>
Subject: [PATCH v2 1/7] strbuf: clarify API boundary
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf, as a generic and widely used structure across the codebase,
should be limited as a libary to only interact with primitives. Add
documentation so future functions can be appropriately be placed. Older
functions that do not follow this boundary should eventually be moved or
refactored.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..c856253216 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -5,7 +5,11 @@ struct string_list;
 
 /**
  * strbuf's are meant to be used with all the usual C string and memory
- * APIs. Given that the length of the buffer is known, it's often better to
+ * APIs. The objects that this API interacts with in this file should be 
+ * limited to other primitives, however, there are older functions in here 
+ * that should eventually be moved out or refactored. 
+ * 
+ * Given that the length of the buffer is known, it's often better to
  * use the mem* functions than a str* one (memchr vs. strchr e.g.).
  * Though, one has to be careful about the fact that str* functions often
  * stop on NULs and that strbufs may have embedded NULs.
-- 
2.40.1.521.gf1e218fcd8-goog

