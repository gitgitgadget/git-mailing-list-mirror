Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C49FC4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 03:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjAAD7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 22:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjAAD7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 22:59:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D610BE
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 19:59:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so25290109pjj.4
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 19:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRQuY36SZIKCIAcydlQHFaBeluSiDr7eTS5biVdUxE4=;
        b=qlroBoOkObL/f+EEhCUYwPk+0uMeRBYvMUUrNfSx567zCXWcAaEWgdZtX93pMrUitS
         8ySwGaoKURF4eivATM7Ey6JFa6UjsufT0SPPXwrmF/6nnTsPgTf+zuXG+UUXTsL2RRiI
         0OfA45nTKkZ6lrFU1ds46sJ0moC6WGFsWe5zxllRoLwHAZ89ksSphECT7cIAOBZCwfrx
         nWrUl41NN4Zb5XQdoGpOlBwP/QIpA2gOauaSKeApfDvOUkQq/Ob77gwx3p/WivHgJCK5
         BEkdbPB+G5+H/BLTKvZu+yUBj+X3SQJu0lTgk2VaqJ1fPWQokBsL8hEKVWIrtf7mGcD9
         zI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRQuY36SZIKCIAcydlQHFaBeluSiDr7eTS5biVdUxE4=;
        b=L2TxrR21B6lBeCtE7k8b5ADFeoeKMSZ5RA1Y+5oen20V3SKitWr6irvFbsAVUOsm2/
         ZF6dVd751MDR194CsWUrMac4xRWleDluazWJKC2ZExHDn0/IUoI7kcsjoFtUrwf1/z7V
         8+ir8IjWMh/KM+jaxsX7eyxlcbWoHojdC4t+YYUF+ZWYChBRryy7SR2/WM2EgOvnTCsF
         qNycX+70s6C6J18Vh09zDFWtC6mDNxUmcvc1yirsIGxdkz+LbESObybIYo8OVv9nFQqM
         lkzK3hfzHNZj3UAzAxaehj12tE7kc0t79eG7CmaJ0KoBhZN8z8NHMEgp+TcdZJ0vgIiQ
         olqA==
X-Gm-Message-State: AFqh2kqfYaYkBmwXVDQdv08N/P3qUH/NOSvoPmVvjOD9WIDTCXy0LRlk
        H2mERj7uGH9uUfNx15f3RQE=
X-Google-Smtp-Source: AMrXdXutsCyONBRUWYAdMTXGfpm3lHOfKyzAs74WQR/zHbPe+cOG5WXK+wjgi7OIna+hYjcxwoVfpA==
X-Received: by 2002:a17:902:efc4:b0:192:85f2:49d with SMTP id ja4-20020a170902efc400b0019285f2049dmr21561794plb.18.1672545584099;
        Sat, 31 Dec 2022 19:59:44 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0018f69009f3esm845499plg.284.2022.12.31.19.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 19:59:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] do full type check in COPY_ARRAY and MOVE_ARRAY
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
        <f3b9e9be-06ef-3773-a496-da5e479f9d49@web.de>
        <xmqq8rinhs7t.fsf@gitster.g>
Date:   Sun, 01 Jan 2023 12:59:43 +0900
In-Reply-To: <xmqq8rinhs7t.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        01 Jan 2023 12:03:02 +0900")
Message-ID: <xmqqsfguhplc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  I think what you ideally want to enforce is that
> typeof(dst) is exactly typeof(src), or typeof(src) sans constness
> (i.e. you can populate non-const array from a const template)?

IOW, I am wondering if something like this is an improvement.

 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/git-compat-util.h w/git-compat-util.h
index a76d0526f7..be435615f0 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -97,8 +97,13 @@ struct strbuf;
 # define BARF_UNLESS_AN_ARRAY(arr)						\
 	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(arr), \
 							   __typeof__(&(arr)[0])))
+# define ARRAYS_COPYABLE_OR_ZERO(src,dst) \
+	(BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(__typeof__(src), \
+							    __typeof__(dst))) + \
+			      (0 ? *(dst) = *(src) : 0))
 #else
 # define BARF_UNLESS_AN_ARRAY(arr) 0
+# define ARRAYS_COPYABLE_OR_ZERO(src,dst) (0 ? *(dst) = *(src) : 0))
 #endif
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
