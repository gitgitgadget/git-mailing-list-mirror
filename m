Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC6C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjB0SvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 13:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjB0SvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 13:51:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF1241D2
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 10:51:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so11155555pjh.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 10:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOrVFewkPKt8hjq1jPvSrYzOCQ+brusyEHGX1hu5pGk=;
        b=IYBGyM8ojmj2KUvxBfkY5GxZ8KBmM3TZVYcvkIjrLJi3gpKLsY5jOxSGcVUPe/F/7k
         u1sHXNwfgZq6HOGnwSseGAaeWDHYmKkckf9f1xXqqGjJ7JQ0uEzLBW9pKeVfCnsD5Mp8
         8ELN/Kpk7Uf/ScNmzEU1YwqOlaXKlKev7Ox0uwT4u4kgjFUEw4ltr3axuly1kiupD7D3
         cYS9rA86g8ZHXywYkhcxXIdaUn6SflhUHOA18uyDhbQutf3jMysvuucd+XhVotofeejk
         xoZIjNGLJLF2ifrn6OWV3mRZ2oV7UyDYzVu26J+NJPDuaKEm0sb/vzVn+iq3fs3ECYW9
         fbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOrVFewkPKt8hjq1jPvSrYzOCQ+brusyEHGX1hu5pGk=;
        b=yhgUu3SWPrruiYy7s7Me6+QXB1KpucwNb7sipDzR/raCuU31cNWZHAOKiStBjNnULZ
         kFa2gwVF3ydrd1p7UAGtWuhzwgV+7fiukmopHlQmL+r7yCQ8ZVmuSYfFEBdMtXWQDEms
         gzImfdNtWJqIJ9orCFzhqwB+XEl+xMvpxBs8kCutZI03l4qdTxXMYxQ3yfocfxuoMYd6
         Cr+/Y0GULZK+PiHeg4hGutD5AuDUOKmZxh0Oe2dntDRbDOiq9PYLwB6WYfEGMXDv5QY3
         cMqehn8Z9JW1J25fUK03z9TlCfex1K6BWptL5PlqJWzahkenF911UHQ1p/Pxn7nsdQx0
         JnjA==
X-Gm-Message-State: AO0yUKXe3AB8mClnZqaFPyMkNStSfoSjKwvfCXxt5rYj8+6dLbEPybCf
        ftuC7JGNkj2WpLNua8H0sbk=
X-Google-Smtp-Source: AK7set+RWWw5IKKdAll1jJahLb0VXWqpmkzIERUMhQWJydgedj0PY91rUcYziZ7qSm6XnMqrb9RAXQ==
X-Received: by 2002:a17:902:d4c4:b0:19b:dbf7:f9ca with SMTP id o4-20020a170902d4c400b0019bdbf7f9camr44947plg.0.1677523872750;
        Mon, 27 Feb 2023 10:51:12 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902b58700b0019c2b1c4db1sm4920750pls.239.2023.02.27.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:51:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, Shuqi Liang <cheskaqiqi@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] check-attr: integrate with sparse-index
References: <20230227050543.218294-1-cheskaqiqi@gmail.com>
        <20230227050543.218294-2-cheskaqiqi@gmail.com>
        <315e70e0-ac1f-2f19-f1cc-6b8b24ffb1fc@github.com>
        <cd7b9a2f-4f52-9da8-19c3-2c5cda7b8160@github.com>
Date:   Mon, 27 Feb 2023 10:51:12 -0800
In-Reply-To: <cd7b9a2f-4f52-9da8-19c3-2c5cda7b8160@github.com> (Derrick
        Stolee's message of "Mon, 27 Feb 2023 12:57:32 -0500")
Message-ID: <xmqqedqbt00v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Victoria is right that it is helpful to first establish test coverage of
> the builtin for correctness reasons before making this change. It helps to
> add tests for cases that would require expanding the sparse index, such as
> checking the attributes for paths outside of the sparse-checkout cone.
>
> Once the correctness tests are in place, you can then make this change to
> the builtin and add the tests that check ensure_not_expanded, since the
> change at that point is _only_ that we are allowing the builtin to
> operate upon the sparse index without expanding it immediately after read.
>
> A good example of this "final step" is [1], which updates the builtin for
> 'git diff' as well as adding _only_ the ensure_not_expanded tests.

Thanks for a detailed help.
