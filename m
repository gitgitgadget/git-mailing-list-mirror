Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45685C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 18:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDKSid (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDKSib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 14:38:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1804C1C
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:38:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 194-20020a6301cb000000b00513c951ff2bso10044614pgb.10
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681238307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYuG191stHnWZDqJs6f4kzEth646R+4g49aSxqhAcQ0=;
        b=tjGhGSk8SdNbSqZPQ0NbrAMrS9FZJJIYQXfRiFPGk1FpV35dwjP9XYuJ4cSgbyp6c9
         vf5XVpFX00IH0ea/XFNtwh9IfS1RXu4nyDu8/mA3PwzRNIrIoRoHTaruqt3WABT0xOlm
         QbKkA24+5FFNmlTTm0yTMZwSZT8iNbEUd0PFFvMM+Irz4Y98k9Je4DmJowZzRYuD5Z8E
         vLzdHkMqBXnvU+WonkNCxjAKaU0Sf1Qeni2bk5KnIpf9MRMyr8a3JfUvpjtHh71gf55T
         r1jLUI9bKioD2ayTkJZWChD6npQXv9nlGirqK3FWGTYHBoc919ZhvTl6CbEaDYIU8NLR
         tKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYuG191stHnWZDqJs6f4kzEth646R+4g49aSxqhAcQ0=;
        b=7RcADsF9egMfJ5RqlTi+EFIwPIG1WL6hSSel1zDzixbBsN38kbQgAlAoKyswHDyRbB
         ilnpi6Tr4L6sVzdsbahMa3UbaaM1A5GGSdWKlUycWjl7Uov1tOjyYs8WLX3zYiAbcR5g
         1bRd3PzcCjWHGiA2KkZyJZ9ymQDLLYFTFvRC/pT7trMBvVkhnyoOFug6gRgmrjwlZH/a
         AJfdmdP0//qtBG/9uuOxiIsMFEkZimPU5yDAbEsiNMUiBtb9/4sFOePVzPm72t+n34uI
         1uBxYfkwbUb8tlCRLPBgNE0dp9XmGGQlrTZW/qN2p3CmrfwlBC4EuDWj4fkJiXAe/c2N
         VsDw==
X-Gm-Message-State: AAQBX9e29KAY4adUGIg2vY4pNTE2FYajk3sGdr+L2y4U8TXWmfTamvNv
        4arPZgrTPXQfNfbd5f6p7u6OL3QmGoic3g==
X-Google-Smtp-Source: AKy350Z8cUUBrMTCRsQhMIgySpexwVnJQwDoVESh2Hh0tVPCTP6GYSxSmFAJhiU+6CP3NBVEm4CVlKmH6Mm3HA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:7c9:0:b0:513:90ed:3c22 with SMTP id
 192-20020a6307c9000000b0051390ed3c22mr52989pgh.2.1681238307635; Tue, 11 Apr
 2023 11:38:27 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:38:25 -0700
In-Reply-To: <xmqqmt3e9wab.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
 <pull.1488.v3.git.git.1681232918484.gitgitgadget@gmail.com> <xmqqmt3e9wab.fsf@gitster.g>
Message-ID: <kl6lr0sqjmce.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3] clone: error specifically with --local and symlinked objects
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What I locally have, which is an amended version of v2, and this one
> differ like so:
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index ae2db8535a..b42231758c 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -335,7 +335,6 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		if (errno == ENOTDIR) {
>  			int saved_errno = errno;
>  			struct stat st;
> -
>  			if (!lstat(src->buf, &st) && S_ISLNK(st.st_mode))
>  				die(_("'%s' is a symlink, refusing to clone with --local"),
>  				    src->buf);
>
> So I'll keep my copy.

Ah, sharp eye. Sounds good.
