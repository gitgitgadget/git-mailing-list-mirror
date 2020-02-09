Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE7DC35242
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C8A21741
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 00:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgBIAxQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 8 Feb 2020 19:53:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40720 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgBIAxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 19:53:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so3249033wru.7
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 16:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JR7Abp55JsinKQNmpec6Sz9m0lXv+pxJfIb4Wthykms=;
        b=A5BQbNIcgwloP6hhKbuGPDa//96SwAYNhwP55XkJetSmxczz46zne0YvgUztBDbozH
         /0uzoIZolaJ1l+RI2t/rxVWx0JbP7Qy5YiymevdDzrfF7OO7NR3be3RxBxrD1pEWJHSM
         /WBE/4ayNq/7HLHenfcnS1/nAod//A1T3LsyvO536LBJLa5rr0stX8+pXOQtPjL6NTuN
         Ed/kz9aTyh/ktmrBU8oubcftqwDmOpLJrtdfi0DuH/nuT2b7o73uqCZ71DKC7bWPJYbu
         LTiapNCLuzHBeqgMsJ0uwTSIqQud6VElRQNXym+PPm1n368pcoKIgfoRZr3ZEbcvjHfl
         VAqQ==
X-Gm-Message-State: APjAAAU4e3iPQHy4FkLTL9SO27zxc9MTr8juzsae7/ja+uP/xXrCWdwq
        Lm+ExiqXHNH43xj8il9Qy2eF31Nwy/7O09N6BTkoEA==
X-Google-Smtp-Source: APXvYqwxgDaXOE7/OOw3JBLMhYiAi7Xq79PGMIip/FHme6zJNNCgIhXWKThuK3LYezmH83clVLlypNuGHGVv5sQ7B4U=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr7979525wrr.226.1581209594306;
 Sat, 08 Feb 2020 16:53:14 -0800 (PST)
MIME-Version: 1.0
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
In-Reply-To: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Feb 2020 19:53:03 -0500
Message-ID: <CAPig+cRmzHEQPhTzHrqqS9So63pJqQVGa1kGoWARmGU_0tn0_A@mail.gmail.com>
Subject: Re: [PATCH] strbuf: add and use strbuf_insertstr()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 8, 2020 at 2:57 PM René Scharfe <l.s.r@web.de> wrote:
> Add a function for inserting a C string into a strbuf.  Use it
> throughout the source to get rid of magic string length constants and
> explicit strlen() calls.
>
> Like strbuf_addstr(), implement it as an inline function to avoid the
> implicit strlen() calls to cause runtime overhead.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> diff --git a/notes-utils.c b/notes-utils.c
> @@ -52,7 +52,7 @@ void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
> -       strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
> +       strbuf_insertstr(&buf, 0, "notes: "); /* commit message starts at index 7 */

Is there a reason to retain the comment which talks about magic number 7?
