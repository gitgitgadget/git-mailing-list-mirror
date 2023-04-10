Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F9C77B6F
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDJWxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjDJWxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:32 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA701BFD
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54ee9ad5eb3so121540377b3.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167210; x=1683759210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1fFUZEnhk8mc5WSf+cuRlV1BkCsAwGZhwQWdDsFwOs=;
        b=i9TJZDDOg74Myuw64w8iV9zxuDPO7L4tJYdLnT9PSGwj2EMpEMgzXMJKfIGmM8d3EY
         ruND0E+A6H2ffLRf4RQpOjFyslP/lgnkbPyd9qthBx4C6qXwyjFawu3m0qUv39tC14Qp
         k3uTSQQkT1ketjhnKgWqjiNngIbAb6T1N8/Yz/UBdcyh4qnCETlug43kpp9dauPbnIGp
         IH3watLmCs3IyZItJvGGXTSHquqeTNnxfAhSl1vEVrmCaHL8xvP7kPnIKtH7d0nUzLF0
         AnI4GS/xoRR02SzDYFcnl80nGkxCds5JWOjvlOYVApRxypzY03RM0vQL8+521gV2XXym
         pt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167210; x=1683759210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1fFUZEnhk8mc5WSf+cuRlV1BkCsAwGZhwQWdDsFwOs=;
        b=zmmRjy9lXmyGHdpKqGN8aWHnO1YOSwUixxt+pRemloEW5F0824r9zkhFUXc3Llw8o/
         cAPB6cSx7taxbDge4OYTjiLkCLp8Yq9ZC7KOcNf8GY/ywDvBIFUb3AbRXQAdmd3Bm/is
         td2eoJZOmaBtdY7djvJcElFzl6VZcJcN5AfWEDYs4ZoHtttK0sVzrgnTJAuCTbaUBky6
         H9OHk/Il0SbYmOSELtBdqkkcIdQWZTG2QQOGfIJs5mC4KYvPcL19aGqKl4b7U5ZmMf0W
         DNhVBiQFlwTfeXl5qG4FNsiHhnodr5G3O9ZyjlXqHgyWS+1LJFUMQu/XZSWjdEdHuqdX
         irHw==
X-Gm-Message-State: AAQBX9cfPD6N9Xa2ug8C6F6IhpJV5WLUi25T5D7Wrj4vvwN7pP+aqYDh
        e/5k8zNjsTeC/7lkTMxaMSGXOmJMHaeBNS9RGqB62A==
X-Google-Smtp-Source: AKy350ayKKtnZDo40XCJ5x4kvL5m0jmmIA+krKvTtEx6FxqkD9OTNlmErpsPsnAkeZkARBN8PCv2Wg==
X-Received: by 2002:a0d:ca86:0:b0:546:aa9:8e42 with SMTP id m128-20020a0dca86000000b005460aa98e42mr6740230ywd.7.1681167210163;
        Mon, 10 Apr 2023 15:53:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v189-20020a8148c6000000b0054d8263d642sm1824719ywa.113.2023.04.10.15.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:29 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] t5325: mark as leak-free
Message-ID: <affb5e2574bc1072d8f4ab8e3dccde7a5a39e725.1681166596.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test is leak-free as of the previous commit, so let's mark it as
such to ensure we don't regress and introduce a leak in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5325-reverse-index.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index d042d26f2b..48c14d8576 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='on-disk reverse index'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The below tests want control over the 'pack.writeReverseIndex' setting
-- 
2.40.0.323.g9c80379958

