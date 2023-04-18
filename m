Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C504C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDRTU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjDRTUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:20:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0838CD31D
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u13so30315069ybu.5
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845540; x=1684437540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EksJ/pNVG6zsm55qBvZhvabtvs5lTXMOs4ak1ZA04Cs=;
        b=1oQ44qqpU78Q+VLxRltA2u3zxFSu9ffOU5RwcutaNJ1etWVGXjkxysMKtxv2Gc1J52
         flCG2ZaWdVTFXWjW+YPd7ojq0tNnHZgvG585q7LiOoFjbk9py/UMnenG4x3xG8MKICWN
         oXONnKEQT7EF0s/VWzREQjX1mf/jaqn9MMcorDrsUNFO4k11EG8injaOHWcGUx3tItqZ
         5TJmKrNk7Q0mm/j0XgZ6oRGxiG4lVLrDECvJDllSBQDQbQg6GQwc7iIwRrcJMdBo02B7
         SpZFDph0wfC7ykCXkvLa32sAPBdw+SVM6+pJXuKZQ5bfOU/ZFEN3KA9D5Ar1f7lT7AJn
         8HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845540; x=1684437540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EksJ/pNVG6zsm55qBvZhvabtvs5lTXMOs4ak1ZA04Cs=;
        b=Uaj1M/ZxYGtu2u1OYqsLjC8Q4571b27Y6ggt8yUwKISRm0WBMEy50k6QB/0SVasv8O
         QfHJSQ3UU5dpAb5auvrzr6BFbccLLzkYDWMWU+RDgxZST2YjK9xZtY4GXO1qqkbWC+Ek
         yvL0xLRL9hRhTZKxm62Pd2UlsymmoxZXbV2knxdElYepw9/KpE2TRLZS6ASkO/isVPFD
         mDSORIt7JaE3xuVI6+RHbJbyUg11X688MWl2ayn0FMo7y7EwXi40kOnXe8DR4AEB/86X
         A9oaG0t3ggmpBoqT8CJH0FTuyfH1bIIWnEHeS/Wp3bdJNa0Zxib89b7UxL//Vrb0XWJX
         AoeQ==
X-Gm-Message-State: AAQBX9fIYcMO4QU60eNKlyZbf7clfIdNXkePi4Mm/M5hX8qpf49o+fhT
        Fk5jneMDgiayk4q4iSmM5oUgZvTEWSozEkS/sV6MEw==
X-Google-Smtp-Source: AKy350a64LSnB+BFfJTrM+gNxAnO6CoS5yjixOts4u6s3Q/dgVqobwoImjZevLYU7dlW/o4eXVkHEw==
X-Received: by 2002:a25:2707:0:b0:b93:a1bc:a326 with SMTP id n7-20020a252707000000b00b93a1bca326mr5373723ybn.23.1681845540545;
        Tue, 18 Apr 2023 12:19:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 65-20020a810744000000b00552df52450csm1625673ywh.88.2023.04.18.12.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:19:00 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] banned.h: mark `strtok()` as banned
Message-ID: <56d2318a6d0aa17e2d56cd7d7e755adae89f8d99.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`strtok_r()` is reentrant, but `strtok()` is not, meaning that using it
is not thread-safe.

`strtok()` has a couple of drawbacks that make it undesirable to have
any new instances. In addition to being thread-unsafe, it also
encourages confusing data flows, where `strtok()` may be called from
multiple functions with its first argument as NULL, making it unclear
from the immediate context which string is being tokenized.

Now that we have removed all instances of `strtok()` from the tree,
let's ban `strtok()` to avoid introducing new ones in the future. If new
callers should arise, they can either use:

  - `string_list_split_in_place()`,
  - `string_list_split_in_place_multi()`, or
  - `strtok_r()`.

Callers are encouraged to use either of the string_list functions when
appropriate over `strtok_r()`, since the latter suffers from the same
confusing data-flow problem as `strtok()` does.

But callers may prefer `strtok_r()` when the number of tokens in a given
string is unknown, and they want to split and process them one at a
time, so `strtok_r()` is left off the banned.h list.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 banned.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/banned.h b/banned.h
index 6ccf46bc19..dd43ab3178 100644
--- a/banned.h
+++ b/banned.h
@@ -18,6 +18,8 @@
 #define strncpy(x,y,n) BANNED(strncpy)
 #undef strncat
 #define strncat(x,y,n) BANNED(strncat)
+#undef strtok
+#define strtok(x,y) BANNED(strtok)
 
 #undef sprintf
 #undef vsprintf
-- 
2.40.0.358.g56d2318a6d
